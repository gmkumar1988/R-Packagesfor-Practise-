file.choose()

library(tidyverse)

attach(mtcars)
qplot(hp, mpg, data = mtcars)

CO2_tibble <- as_tibble(CO2)
print(CO2_tibble, n = Inf)

unique(CO2_tibble$Type)

inspections <- read_csv('http://594442.youcanlearnit.net/inspections.csv')

glimpse(inspections)

names <- c('ID','DBAName','AKAName','License','FacilityType','Risk','Address',
           'City','State','Zip','InspectionDate','InspectionType','Results',
           'Violations','Latitude','Longitude','Location')

inspections <- read_csv('http://594442.youcanlearnit.net/inspections.csv',
                        col_names = names)


inspections <- read_csv('http://594442.youcanlearnit.net/inspections.csv',
                        col_names = names, skip = 1)

glimpse(inspections)


######################################READ TSV####################

inpatient <- read_tsv('http://594442.youcanlearnit.net/inpatient.tsv')

glimpse(inpatient)

names <- c('DRG','ProviderID','Name','Address','City','State',
           'Zip','Region','Discharges','AverageCharges',
           'AverageTotalPayments','AverageMedicarePayments')

inpatient <- read_tsv('http://594442.youcanlearnit.net/inpatient.tsv',
                      col_names = names)

inpatient <- read_tsv('http://594442.youcanlearnit.net/inpatient.tsv',
                      col_names = names, skip = 1)

types <- 'cccccccciccc'

inpatient <- read_tsv('http://594442.youcanlearnit.net/inpatient.tsv',
                      col_names = names, skip = 1, col_types = types)

?read_delim

stoppages <- read_delim('http://594442.youcanlearnit.net/workstoppages.txt',
                        delim = '^')

glimpse(stoppages)

?read_fwf

names <- c('Name','Title','Department','Salary')

lengths <- c(32,50,24,NA)

widths <- fwf_widths(lengths, names)

employees <- read_fwf('http://594442.youcanlearnit.net/chicagoemployees.txt',
                      widths)

glimpse(employees)

library(readxl)

##file.choose()

breakfast <- read_excel("/Users/maheshg/Dropbox/Ex_Files_Data_Wrangling_in_R/Exercise Files/breakfast.xlsx",
                        skip = 5)
  
glimpse(breakfast)

names <- c('Year','FreeStudents','ReducedStudents','PaidStudents',
           'TotalStudents','Mealsserved','PercentFree')

breakfast <- read_excel("/Users/maheshg/Dropbox/Ex_Files_Data_Wrangling_in_R/Exercise Files/breakfast.xlsx",
                        skip = 5, col_names = names)

breakfast <- breakfast %>%
  mutate(FreeStudents = FreeStudents * 1000000,
         ReducedStudents = ReducedStudents * 1000000,
         PaidStudents = PaidStudents * 1000000,
         TotalStudents = TotalStudents * 1000000,
         Mealsserved = Mealsserved * 1000000,
         PercentFree = PercentFree / 100)

glimpse(breakfast)


#####################Data Transformation using Pivot############


pew <- read_csv('http://594442.youcanlearnit.net/pew.csv')

pew

?pivot_longer

pew.long <- pivot_longer(pew, !religion, names_to = 'income',
                         values_to = 'freq')

pew.long

weather <- read_csv('http://594442.youcanlearnit.net/mexicanweather.csv')

weather

weather.wide <- pivot_wider(weather, names_from = element,
                            values_from = value)

weather.wide

###########Converting Data Types#########

foulshots <- c(18,22,15,13,5)

sum(foulshots)

foulshots_strings <- c('18','22','15','13','5')

sum(foulshots_strings)

class(foulshots_strings)

foulshots_converted <- as.numeric(foulshots_strings)
sum(foulshots_converted)

is.numeric(foulshots_strings)
is.character(foulshots_strings)

library(lubridate)

weather <- weather %>%
  mutate(year = year(date), month=month(date),day = day(date))

yday('2018-04-01')


library(ggplot2)
ggplot(data = inpatient)+
  geom_histogram(mapping = aes(x = AverageCharges))

head(inpatient)

colnames(inpatient)

unlicensed <- inspections %>%
  filter(is.na(License))

licensed <- inspections %>%
  filter(!is.na(License))

badmath <- c(1,2,3,4/0, 0/0, NA)

is.na(badmath)

regional_inspections <- unite(inspections, Region, City, State, sep = ', ', remove = FALSE)

unique(regional_inspections$Region)
library(stringr)

regional_inspections %>%
  mutate(Region= str_to_upper(Region))

unique(regional_inspections$Region)

badchicagos <- c('CCHICAGO, IL' , 'CHCICAGO, IL', 'CHICAGOI, IL', 'CHICAGOCHICAGO, IL')

regional_inspections <- regional_inspections %>%
  mutate(Region = ifelse(Region %in% badchicagos, 'CHICAGO, IL', Region))

nachicagos <- c('NA, IL', 'NA, NA', 'INACTIVE, IL')

regional_inspections <- regional_inspections %>%
  mutate(Region = ifelse(Region %in% nachicagos, 'NA', Region))



