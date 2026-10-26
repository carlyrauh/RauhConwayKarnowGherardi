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



library(dplyr)
library(ggplot2)


tencounties_highest_claims <- c(37021, 37111, 37089, 37011, 37021,37115, 37009, 
                       37161, 37087, 37189)

FEMA_claims_data_filtered %>%
  filter(countyCode %in% tencounties_highest_claims) %>%
  ggplot(aes(x = factor(countyCode),y = buildingDamageAmount,
             color = factor(countyCode))) + geom_point(alpha = 0.5) +
  labs(title = "Building Damage Amount by Top 10 County Codes FEMA Claim",
    x = "FIPS County Code", y = "Building Damage Amount ($)",
    color = "County Code") + theme_classic() +
    scale_color_discrete(labels = c(                                              #allows me to assign name to each code in legend
    "37021 = Buncombe",
    "37111 = Mcdowell",
    "37089 = Henderson",
    "37011 = Avery",
    "37009 = Ashe",
    "37115 = Madison",
    "37023 = Burke",
    "37161 = Rutherford",
    "37087 = Haywood",
    "37189 = Watauga")) + coord_cartesian(ylim = c(0, 2000000))

#excluded the outlier of the top claim value of 52840990 (Buncombe) to not smudge all other data points
#this table shows that our dataset includes a sufficient amount points for each of the top counties affected by Hurricane Helene
#limitations/quality concerns of our data might include a handful of NA values throughout the dataset, and some outlier values that are excluded from figures to enhance the rest of the data




