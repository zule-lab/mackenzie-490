source("3-RScripts/packages.R")


failure_data <- read.csv("2-Cleaned_data/failure_data_V4.csv")

failure_data2<- failure_data %>% 
  mutate(active_days = na_if(active_days, ""),                                    #we are taking our dataset and excluding all blanks in column active days
         active_days = na_if(active_days, "unknown"),                             #we are taking our dataset and excluding all unknowns in column active days
         active_days = as.numeric(active_days),                                   #R initially interpreted active days column as categorical so we switched it to numerical so the model would be happy
         distance_to_trail_exp = exp(distance_to_trail)) %>%                      #the data chloe gave me was log-ed so we exponentialed it to return it to its original value
  drop_na(active_days)                                                          #after converting blanks and unknowns we dropped NAs

mean(failure_data2$vertical_complexity, na.rm = TRUE)
mean(failure_data2$distance_to_trail_exp, na.rm = TRUE)

failure_data2["smallstems_ha"][is.na(failure_data2["smallstems_ha"])] <- 24012.7949
failure_data2["nest_height"][is.na(failure_data2["nest_height"])] <- 2.1339025
failure_data2["canopy_cover"][is.na(failure_data2["canopy_cover"])] <- 6.59408108
failure_data2["coverage"][is.na(failure_data2["coverage"])] <- 2.19444444
failure_data2["vertical_complexity"][is.na(failure_data2["vertical_complexity"])] <- 2.076923
failure_data2["distance_to_trail_exp"][is.na(failure_data2["distance_to_trail_exp"])] <- 2.486415
#replacing all the NAa with averages


failure_data3 <- failure_data2 %>%
  mutate_if(is.numeric,~as.numeric(scale(.x))) %>%
  mutate(date_failed = as.Date(date_failed, "%d/%m/%Y")) #data scaled 

#This df was saved as failure_dataV6 in cleaned data folder 