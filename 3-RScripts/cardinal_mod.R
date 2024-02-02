source("3-RScripts/packages.R")

failure_data3 <- readRDS("4-Output/failure_data3.RDS")

noca <- subset(failure_data3, species == "cardinal ")

mod_cardinal <- lm(active_days ~ coverage + canopy_cover + vertical_complexity + 
                     smallstems_ha + distance_to_trail_exp + date_failed, data = noca)
summary(mod_cardinal)