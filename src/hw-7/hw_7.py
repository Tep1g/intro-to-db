from matplotlib import pyplot
import numpy
import pandas
import psycopg2

if __name__ == "__main__":

    # Number 1
    # Part a
    thistuple = ("apple", "banana", "cherry")
    df = pandas.read_csv("train.csv")

    # Part b
    print(df.head(10))

    # Part c
    histogram = df['LoanAmount'].hist(bins=50)
    pyplot.show()