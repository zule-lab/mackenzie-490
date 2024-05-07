source("3-RScripts/packages.R")

failure_data3 <- readRDS("4-Output/failure_data3.RDS")
grca <- subset(failure_data3, species == "gray_catbird")


mod_grca_df <- lmer(active_days ~  date_failed + (1|site), data = grca)
summary(mod_grca_df)

visreg(mod_grca_df, "date_failed")
