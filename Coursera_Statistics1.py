
# Importing required libraries :
import pandas as pd
import numpy as np
import matplotlib.pyplot as plt

#Data Exploration Phase :
# Reading the data set (source is kaggle):
dataprofession = pd.read_csv("/Users/maheshg/Library/CloudStorage/OneDrive-Microsoft365/Sample Datasets Kaggle/Partially Cleaned Salary Dataset.csv")
#viewing the first head of the dataprofession again this is random list, because we did not mention any filter in the header
print(dataprofession.head(10))

#Getting the descriptive Stats from the raw dataset :
dataprofession.describe()
print(dataprofession.describe())

dataprofession.salary = "{:e}".format(110102)
float_number = float(dataprofession.salary)

# dataprofession["Salary"] = dataprofession.salary

print(dataprofession.describe())

#Result and Evaluation of Data Professionals :
result_mean = np.mean(dataprofession["Salary"])
print(result_mean)

#Median Value of the salary for Data Professions in India
result_median = np.median(dataprofession["Salary"])
print(result_median)

#Minimum Value of the Salary for Data Profession in India
result_minimum= np.min(dataprofession["Salary"])
print(result_minimum)

#Maximum Value of the Salary for Data Professionals in India:
result_maximum = np.max(dataprofession["Salary"])
print(result_maximum)

#Computing the Standard Deviation of the Salary for Data Professionals :
result_standard_deviation = np.std(dataprofession["Salary"], ddof=1)
print(result_standard_deviation)


