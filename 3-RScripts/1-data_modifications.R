#In this script I 'cleaned' the data 

#packages used: dplyr, tidyr


source("3-RScripts/0-packages.R")


failure_data <- read.csv("2-Cleaned_data/failure_data_V4.csv")

#the following script: 

#         3: the values for distance to trail in the input file had log-ed the distance to trail so we un-log-ed them to obtain the original values 

failure_data2<- failure_data %>% 
  mutate(distance_to_trail_exp = exp(distance_to_trail)) %>%                      
  drop_na(active_days) 

#for the veg surveys, we couldn't always get the data for each variable, so the blanks were replaces with the average of that variable across all sites

mean(failure_data2$vertical_complexity, na.rm = TRUE)
mean(failure_data2$distance_to_trail_exp, na.rm = TRUE)

failure_data2["smallstems_ha"][is.na(failure_data2["smallstems_ha"])] <- 24012.7949
failure_data2["nest_height"][is.na(failure_data2["nest_height"])] <- 2.1339025
failure_data2["canopy_cover"][is.na(failure_data2["canopy_cover"])] <- 6.59408108
failure_data2["coverage"][is.na(failure_data2["coverage"])] <- 2.19444444
failure_data2["vertical_complexity"][is.na(failure_data2["vertical_complexity"])] <- 2.076923
failure_data2["distance_to_trail_exp"][is.na(failure_data2["distance_to_trail_exp"])] <- 2.486415

#The following code scaled the data and mutated 'date' so that R understood it as a date, and then converting that to day of year (DOY) 

failure_data_mod <- failure_data2 %>%
  mutate_if(is.numeric, .funs = list(s = ~as.numeric(scale(.x)))) %>%
  mutate(date_failed = as.Date(date_failed, "%d/%m/%Y"),
         doy = yday(date_failed),
         doy_s = as.numeric(scale(doy)))

#saving this modified data set to use for model analysis

saveRDS(failure_data_mod, "4-Output/failure_data_mod.RDS")


