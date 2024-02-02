#species models were overfitted so I am separating it into different scripts investigating sig variables that popped out in the global model

source("3-RScripts/packages.R")

failure_data3 <- readRDS("4-Output/failure_data3.RDS")

noca <- subset(failure_data3, species == "cardinal ")
amro <- subset(failure_data3, species == "robin")
yewa <- subset(failure_data3, species == "yellow_warbler")
grca <- subset(failure_data3, species == "gray_catbird")

mod_robin <- lm(active_days ~ coverage + canopy_cover + vertical_complexity + 
                  smallstems_ha + distance_to_trail_exp + date_failed, data = amro)
summary(mod_robin)


mod_cardinal <- lm(active_days ~ coverage + canopy_cover + vertical_complexity + 
                     smallstems_ha + distance_to_trail_exp + date_failed, data = noca)
summary(mod_cardinal)


mod_yewa <- lm(active_days ~ coverage + canopy_cover + vertical_complexity + 
                 smallstems_ha + distance_to_trail_exp + date_failed, data = yewa)
summary(mod_yewa)


mod_grca <- lm(active_days ~ coverage + canopy_cover + vertical_complexity + 
                 smallstems_ha + distance_to_trail_exp + date_failed, data = grca)
summary(mod_grca)
