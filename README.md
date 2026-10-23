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



