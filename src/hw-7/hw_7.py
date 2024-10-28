from matplotlib import pyplot
import numpy
import pandas
import psycopg2

def part_a():
    # Part a
    thistuple = ("apple", "banana", "cherry")
    index_1 = thistuple[1]
    print(index_1)

def part_b():
    # Part b
    df = pandas.read_csv("train.csv")
    print(df.head(10))

def part_c():
    # Part c
    df = pandas.read_csv("train.csv")
    histogram = df['LoanAmount'].hist(bins=50)
    pyplot.show()

def part_d():
    # Part d
    df = pandas.read_csv("train.csv").replace(numpy.nan, None)

    password = input("Enter password: ")

    params = []
    with open("params.txt", "r") as file:
        for line in file:
            params.append(line.strip())

    db_params = {
        "dbname"    : params[0],
        "host"      : params[1],
        "user"      : params[2],
        "password"  : password,
        "port"      : params[3],
        "sslmode"   : params[4]
    }

    conn = psycopg2.connect(**db_params)
    cursor = conn.cursor()

    table_creation_statements = [
        """
        DROP TABLE IF EXISTS Loan;
        """,
        """
        CREATE TABLE Loan (
            loan_id TEXT PRIMARY KEY,
            gender VARCHAR(255),
            married BOOLEAN,
            dependents VARCHAR(255),
            education VARCHAR(255),
            self_employed BOOLEAN,
            applicant_income DECIMAL(17,2),
            coapplicant_income DECIMAL(17,2),
            loan_amount DECIMAL(17,2),
            loan_amount_term INT,
            credit_history INT,
            property_area VARCHAR(255),
            loan_status BOOLEAN
        );
        """
    ]

    for statement in table_creation_statements:
        cursor.execute(statement)

    conn.commit()

    for index, row in df.iterrows():

        # Gather booleans
        married = True if row["Married"] == "Yes" else False
        self_employed = True if row["Self_Employed"] == "Yes" else False
        loan_status = True if row["Loan_Status"] == "Y" else False

        cursor.execute(
            """
            INSERT INTO Loan (
                loan_id, 
                gender, 
                married, 
                dependents, 
                education, 
                self_employed, 
                applicant_income, 
                coapplicant_income, 
                loan_amount, 
                loan_amount_term, 
                credit_history, 
                property_area, 
                loan_status
            ) 
            Values (
                %s,
                %s,
                %s,
                %s,
                %s,
                %s,
                CAST (%s as DECIMAL),
                CAST (%s as DECIMAL),
                CAST (%s as DECIMAL),
                %s,
                %s,
                %s,
                %s
            );
            """
            ,
            (
                row["Loan_ID"],
                row["Gender"],
                married,
                row["Dependents"],
                row["Education"],
                self_employed,
                row["ApplicantIncome"],
                row["CoapplicantIncome"],
                row["LoanAmount"],
                row["Loan_Amount_Term"],
                row["Credit_History"],
                row["Property_Area"],
                loan_status
            )
        )

    cursor.execute("SELECT * FROM Loan;")
    cursor.fetchall()

    conn.commit()

    cursor.close()
    conn.close()