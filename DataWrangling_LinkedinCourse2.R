library(tidyverse)

coal <- read_csv('http://594442.youcanlearnit.net/coal.csv', skip = 2)
glimpse(coal)

colnames(coal)[1] <- 'region'

summary(coal)

?pivot_longer

coal_long <- pivot_longer(coal,!region, names_to = 'year', values_to = 'coal_consumption')

glimpse(coal_long)

coal_long <- coal_long %>%
  mutate(year = as.integer(year))

summary(coal_long)

unique(coal_long$region)

noncountries <- c('North America','Central & South America','Antartica','Europe','Eurasia',
                  'MiddleEast','Africa','Asia&Oceania','World')

coal_region <- coal_long %>%
  filter(region %in% noncountries)

coal_country <- coal_long %>%
  filter(!region %in% noncountries)

unique(coal_region$region)


#############Understanding Water Quality###########

library(lubridate)
water <- read_csv('http://594442.youcanlearnit.net/austinwater.csv')

glimpse(water)

water <- water %>%
  select(SITE_NAME,SITE_TYPE,SAMPLE_DATE,PARAM_TYPE,PARAMETER,RESULT,UNIT)

water <- water %>%
  rename(siteName= SITE_NAME,siteType=SITE_TYPE, sampleDate = SAMPLE_DATE, 
         parametertype = PARAM_TYPE, parameter = PARAMETER, result = RESULT, unit = UNIT)

glimpse(water)

unique(water$parameter)

water %>%
  filter(str_detect(parameter,'PH')) %>%
  select(parameter) %>%
  unique()

unique(water$parametertype)

filtered_water<-water %>%
  filter(parametertype == 'Alkalinity/Hardness/pH' |
           parametertype == 'Conventionals')

glimpse(filtered_water)

unique(filtered_water$parameter)

filtered_water <- water %>%
  filter(parameter == 'PH' | parameter == 'WATER TEMPERATURE')

glimpse(filtered_water)

summary(filtered_water)

filtered_water <- filtered_water %>%
  mutate(siteType = as.factor(siteType),
         parametertype = as.factor(parametertype),
         parameter = as.factor(parameter),
         unit = as.factor(unit))

summary(filtered_water)

filtered_water $ sampleDate

filtered_water <- filtered_water %>%
  mutate(sampleDate = mdy_hms(sampleDate))

summary(filtered_water)

filtered_water %>% filter(unit == 'Feet')

filtered_water <- filtered_water %>%
  mutate(unit = recode(unit,'Feet'='Deg. Fahrenheit'))

summary(filtered_water)

filtered_water <- filtered_water %>%
  filter(!unit == 'MG/L')

summary(filtered_water)

filtered_water <- filtered_water %>%
  mutate(unit = droplevels(unit))

summary(filtered_water)

ggplot(filtered_water, mapping =  aes(x = sampleDate, y= result)) +
  geom_point()

filtered_water <- filtered_water %>%
  filter(result <= 1000000)

summary(filtered_water)


filtered_water <- filtered_water %>%
  filter(result <= 1000)

summary(filtered_water)

ggplot(data = filtered_water, mapping = aes(x = unit, y = result)) + 
  geom_boxplot()

filtered_water <- filtered_water %>%
  mutate(unit = as.character(unit)) %>%
  mutate(unit = ifelse((unit =='Deg.Celsius' & result >=60), 'Deg.Fahrenheit', unit)) %>%
  mutate(unit = as.factor(unit))

ggplot(data = filtered_water, mapping = aes(x = unit, y = result)) + 
  geom_boxplot()

