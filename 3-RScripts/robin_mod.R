source("3-RScripts/packages.R")

failure_data3 <- readRDS("4-Output/failure_data3.RDS")
amro <- subset(failure_data3, species == "robin")

mod_robin_df <- lmer(active_days ~ date_failed + (1|site), data = amro)
summary(mod_robin_df)

visreg(mod_robin_df, "date_failed")

mod_robin_dist <- lmer(active_days ~ distance_to_trail_exp + (1|site), data = amro)
summary(mod_robin_dist)
#doesnt matter