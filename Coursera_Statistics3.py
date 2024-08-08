import numpy as np
import pandas as pd
import matplotlib.pyplot as plt
from scipy import  stats
import statsmodels.api as sm

education_districtwise = pd.read_csv("/Users/maheshg/Library/CloudStorage/OneDrive-Microsoft365/Sample Datasets Kaggle/Global_Education.csv")
education_districtwise = education_districtwise.dropna()
education_districtwise.head(10)