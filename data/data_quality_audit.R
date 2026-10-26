library(readr)
library(here)
setwd(here())
getwd() 
FEMA_SVI_data <- read_csv(here
("data/processed/master_FEMA_SVI_data.csv"))
View(FEMA_SVI_data)

dim(FEMA_SVI_data)
#2080 rows, 25 different columns/variables
str(FEMA_SVI_data)
#dateOfloss is date class
#ratedFloodZone and COUNTY are character class
#all other data is numeric
range(FEMA_SVI_data$dateOfLoss, na.rm = TRUE)
#dates are from September 25th, 2024 to September 30th, 2024
summary(FEMA_SVI_data)
table(summary(FEMA_SVI_data))

sum(is.na(FEMA_SVI_data))
#total amount of NA is 986
colSums(is.na(FEMA_SVI_data))
#majority of NA's are located in the building Damage Amount column

sum(duplicated(FEMA_SVI_data))
#there are 0 duplicated rows

sum(FEMA_SVI_data < 0, na.rm = TRUE)
#there are no negative or implausible values


