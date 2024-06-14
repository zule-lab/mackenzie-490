#In this script we run the global model

#Packages used: lme4, lmertest, visreg, dotwhisker, performance, sjPlot, sjmisc, sjlabelled


source("3-RScripts/0-packages.R")

#failure_data_mod data set has columns with original data, and the scaled, marked by column_s

failure_data_mod <- readRDS("4-Output/failure_data_mod.RDS")

#We used the scaled values to compute the model

mod <- lmer(active_days_s ~ coverage_s + canopy_cover_s + vertical_complexity_s + 
            smallstems_ha_s + distance_to_trail_exp_s + doy_s + (1|site)
            + (1|species), data = failure_data_mod)

#this tests linearity of our model, everything checks out

plot(mod)                                                                        
qqnorm(resid(mod))
qqline(resid(mod))
check_model(mod)

#We are looking at the relationships of different explanatory variables

visreg(mod, "smallstems_ha")
visreg(mod, "canopy_cover")
visreg(mod, "distance_to_trail_exp")
visreg(mod, "date_failed")



#Summary 

summary(mod)

summary_table <- tab_model(mod, show.se = TRUE, 
          pred.labels = c("Intercept", "Coverage", "Canopy Cover", "Vertical Complexity",
                          "1 m Vegetation Density", "Distance to Trail", 
                          "Day of Year"), 
          dv.labels = "Active Days",
          string.pred = "Coeffcient",
          string.ci = "CI (95%)",
          string.p = "P-Value",
          string.se = "SE",
    CSS = list(
    css.centeralign = 'text-align: left;')) 

ggsave(summary_table, 
       filename = "summary_table.pdf",
       path = "4-Output",
       device = "pdf",
       height = 6, width = 5, units = "in")



