from matplotlib import pyplot
import numpy
import pandas
import psycopg2

if __name__ == "__main__":

    # Number 1
    # Part a
    thistuple = ("apple", "banana", "cherry")
    df = pandas.read_csv("train.csv").replace(numpy.nan, None)

    # Part b
    print(df.head(10))

    # Part c
    histogram = df['LoanAmount'].hist(bins=50)
    pyplot.show()

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
