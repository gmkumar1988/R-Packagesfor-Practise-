import numpy as np
import pandas as pd
import matplotlib.pyplot as plt
from scipy import stats
import statsmodels.api as sm

#Data Exploration Phase :
# Reading the data set (source is kaggle):
dataprofession = pd.read_csv("/Users/maheshg/Library/CloudStorage/OneDrive-Microsoft365/Sample Datasets Kaggle/Partially Cleaned Salary Dataset.csv")
#viewing the first head of the dataprofession again this is random list, because we did not mention any filter in the header
print(dataprofession.head(10))

dataprofession.salary = "{:e}".format(110102)
float_number = float(dataprofession.salary)

##Computing the empirical Value and ensure whether this falls under 1/2/ 3 standard deviation
result_mean = np.mean(dataprofession["Salary"])
print("Value of the mean of data professionals salary in Bangalore is :" + str(result_mean))

result_std = np.std(dataprofession["Salary"])
print("Value of the standard deviation of data professionals salary in Bangalore is :" + str(result_std))

#1 Standard Deviation below the mean - Mean - (1*Standard Deviation)
single_below_standard_deviation = result_mean - (1*result_std)
print("Value of single standard deviation of data profession salary which has below the mean is : " + str(single_below_standard_deviation))

#2 1 Standard Deviation above the mean = Mean + (1*Standard Deviation)
single_above_standard_deviation = result_mean + (1*result_std)
print("Value of single standard deviation of data profession salary which has above the mean is : " + str(single_above_standard_deviation))

# Checking the upper limit and lower limit value of the data profession salary details
upper_limit = result_mean + 1 * result_std
print("the value of the upper limit value is :" + str(upper_limit))
lower_limit = result_mean - 1 * result_std
print("the value of the lower limit value is :" + str(lower_limit))

final_result = (((dataprofession['Salary'] >= lower_limit) &
 (dataprofession['Salary']<= upper_limit)).mean()) #this is 3 Standard Deviation
print("Final Conclusion of this case study will be using 3 standard deviation : " + str(final_result))

#computing the Z-Score value :
dataprofession['Z_Score'] = stats.zscore(dataprofession['Salary'])
# print(dataprofession['Z_Score'])
# print(dataprofession.describe())
print(dataprofession[(dataprofession['Z_Score'] >3 |(dataprofession['Z_Score'] <-3))])

