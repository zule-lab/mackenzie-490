source("3-RScripts/packages.R")

failure_data3 <- readRDS("4-Output/failure_data3.RDS")
yewa <- subset(failure_data3, species == "yellow_warbler")

mod_yewa_df <- lmer(active_days ~ date_failed + (1|site), data = yewa)
summary(mod_yewa_df)

