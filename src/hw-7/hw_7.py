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
    df['LoanAmount'].hist(bins=20)
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

        # Convert booleans and certain NaN values
        gender_val = row["Gender"]
        gender = gender_val if gender_val != None else "N/A"
        married = True if row["Married"] == "Yes" else False
        dependents_val = row["Dependents"]
        dependents = dependents_val if dependents_val != None else 0
        applic_income_val = row["ApplicantIncome"]
        applic_income = applic_income_val if applic_income_val != None else 0
        # Assume NULL coapplicant_income is a valid input
        loan_amount_val = row["LoanAmount"]
        loan_amount = loan_amount_val if loan_amount_val != None else 0
        # Assume NULL loan_amount_term is a valid input
        credit_hist_value = row["Credit_History"]
        credit_history = credit_hist_value if credit_hist_value != None else 0
        property_area_val = row["Property_Area"]
        property_area = property_area_val if property_area_val != None else "Other"
        self_employed = True if row["Self_Employed"] == "Yes" else False
        loan_status_val = row["Loan_Status"]

        # Assume NULL loan_status is a valid input
        if loan_status_val == "Y":
            loan_status = True
        elif loan_status_val == "N":
            loan_status = False
        else:
            loan_status = loan_status_val

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
                gender,
                married,
                dependents,
                row["Education"],
                self_employed,
                applic_income,
                row["CoapplicantIncome"],
                loan_amount,
                row["Loan_Amount_Term"],
                credit_history,
                property_area,
                loan_status
            )
        )

    cursor.execute("SELECT * FROM Loan;")
    cursor.fetchall()

    conn.commit()

    cursor.close()
    conn.close()