source("3-RScripts/packages.R")

failure_data3 <- readRDS("4-Output/failure_data3.RDS")


noca <- subset(failure_data3, species == "cardinal ")

mod_cardinal_df <- lmer(active_days ~ date_failed + (1|site), data = noca)
summary(mod_cardinal_df)
#trend in date failed

visreg(mod_cardinal_df, "date_failed")


mod_cardinal_dist <- lmer(active_days ~ distance_to_trail_exp + (1|site), data = noca)
summary(mod_cardinal_dist)
#distance to trial doesnt matter




