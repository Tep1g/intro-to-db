import numpy
import pandas
import matplotlib
import psycopg2

if __name__ == "__main__":

    # Number 1
    # Part a
    thistuple = ("apple", "banana", "cherry")
    df = pandas.read_csv("/home/luis.maria/Git/intro-to-db/src/hw-7/train.csv")

    # Part b
    print(df.head(10))

    # Part c
    print(df['LoanAmount'].hist(bins=50))