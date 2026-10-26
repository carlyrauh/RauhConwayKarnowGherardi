# RauhConwayKarnowGherardi

# Project for Envi 712

Team Name: RauhConwayKarnowGherardi

Member List: Kassie Karnow, Carolina Conway, Carly Rauh, Luca Gherardi

Research Question(s): How are the approved FEMA disaster relief claims distributed across counties in NC impacted by Hurricane Helene? How does this correspond to the SVI map of socially vulnerable areas?

Intended Audience: County and state-level offices coordinating disaster relief, so that our data may inform their decisions about target areas for resources and support following natural disasters

Data access:
A filtered FEMA claims dataset from the FEMA website is uploaded onto github. Below is the code used to filter that data and can be reproduced on a personal device.

```{r}
#load packages 
library(tidyverse) 
library(fs)
library(dplyr)

#Get the box path, based on the operating system
current_os <- Sys.info()[["sysname"]]
if (current_os == "Darwin") {
  print("Running on a Mac")
  box_path = path_home("Library","CloudStorage","Box-Box","ENVIRON 712L-Students")
} else if (current_os == "Windows") {
  print("Running on a PC (Windows)")
  box_path = path_home("Box","ENVIRON 712L-Students")
} else if (current_os == "Linux") {
  print("Running on Linux; Box drive is not supported")
}

#Get FEMA data
FEMA_claims <- read.csv(
  path(box_path,"Data","Disasters","FEMA","NfipClaimsV3.csv"),
  stringsAsFactors = TRUE
  )

#Filter FEMA data for variables of interest and for Hurricane Helene, and NC
FEMA_claims_filtered <- FEMA_claims %>% filter(floodEvent == "Hurricane Helene", state == "NC") %>% 
  select(dateOfLoss, ratedFloodZone, numberOfFloorsInTheInsuredBuilding, amountPaidOnBuildingClaim, 
         amountPaidOnIncreasedCostOfComplianceClaim, totalBuildingInsuranceCoverage, buildingDamageAmount, 
         netBuildingPaymentAmount, buildingPropertyValue, numberOfUnits, countyCode)
      
#Creating CSV    
write.csv(FEMA_claims_filtered, "/Users/carlyrauh/Desktop/ENV_812/712_Lab/RauhConwayKarnowGherardi/FEMA_filtered.csv")
```


Data Dictionary: 

FEMA data variables: 
DateOfLoss- (datetime) Date of which water first entered the insured building. When time is not specified in the field, it will default to T00:00:00.000Z 

ratedFloodZone- (text) NFIP Flood Zone derived from the Flood Insurance Rate Map (FIRM) used to rate the insured property. 
  A - Special Flood with no Base Flood Elevation on FIRM; 
  AE, A1-A30 - Special Flood with Base Flood Elevation on FIRM; 
  A99 - Special Flood with Protection Zone; 
  AH, AHB* - Special Flood with Shallow Ponding; 
  AO, AOB* - Special Flood with Sheet Flow; 
  X, B - Moderate Flood from primary water source. Pockets of areas subject to drainage problems; 
  X, C - Minimal Flood from primary water source. Pockets of areas subject to drainage problems; 
  D - Possible Flood; 
  V - Velocity Flood with no Base Flood Elevation on FIRM; 
  VE, V1-V30 - Velocity Flood with Base Flood Elevation on FIRM; 
  AE, VE, X - New zone designations used on new maps starting January 1, 1986, in lieu of A1-A30, V1-V30, and B and C; 
  AR - A Special Flood Hazard Area that results from the decertification of a previously accredited flood protection system that is determined to be in the process of being restored to provide base flood protection; 
  AR Dual Zones - (AR/AE, AR/A1-A30, AR/AH, AR/AO, AR/A) Areas subject to flooding from failure of the flood protection system (Zone AR) which also overlap an existing Special Flood Hazard Area as a dual zone; 
  *AHB, AOB, ARE, ARH, ARO, and ARA are not risk zones shown on a map, but are acceptable values for rating purposes
  
numberOfFloorsInTheInsuredBuilding- (integer) Code that indicates the number of floors in the insured building. 
  1 = One floor; 
  2= Two floors; 
  3 = Three or more floors; 
  4 = Split-level; 
  5 = Manufactured (mobile) home or travel trailer on foundation; 
  6 = Townhouse/Rowhouse with three or more floors (RCBAP Low-rise only);
  
amountPaidOnBuildingClaim- (decimal) Dollar amount paid on the building claim. In some instances, a negative amount may appear which occurs when a check issued to a policy holder is not cashed and has to be re-issued

amountPaidOnIncreasedCostOfComplianceClaim- (decimal) ICC coverage is one of several flood insurance resources for policyholders who need additional help rebuilding after a flood. It provides up to $30,000 to help cover the cost of mitigation measures that will reduce the flood risk

totalBuildingInsuranceCoverage- (integer) 	Total Insurance Amount in whole dollars on the Building

buildingDamageAmount- (integer) The actual cash value amount of damage to a main property in whole dollars.

netBuildingPaymentAmount- (decimal) Net building payment amount made to insured in dollars. It is the amountPaidOnBuildingClaim minus any recovery amounts.

buildingPropertyValue- (integer) The actual cash value of the main building prior to any flooding event in whole dollars as estimated by an adjuster. Based on the initial policy provided by the WYO.

numberOfUnits- (integer) The number of residential and nonresidential units covered by the Condominium Master Policy

countyCode- (text) FIPS code uniquely identifying the primary County (e.g., 011 represents Broward County) associated with the project. Note, the County Code field may not reflect the individual county the property is located as projects can be associated with more than one county

SVI Variables: 
M_HH- (numeric) Households estimate MOE (margin of error), 2018-2022 ACS ( American Community Survey)

RPL_THEME1- (numeric) Percentile ranking for Socioeconomic Status theme summary  

RPL_THEME2- (numeric) Percentile ranking for Household Characteristics theme summary 

RPL_THEME3- (numeric) Percentile ranking for Racial and Ethnic Minority Status theme 

RPL_THEME4- (numeric) Percentile ranking for Housing Type/ Transportation theme 

RPL_THEMES- (numeric) Overall percentile ranking 
