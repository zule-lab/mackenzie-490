source("3-RScripts/packages.R")

failure_data <- read.csv("2-Cleaned_data/failure_data_V4.csv")

failure_data2<- failure_data %>% 
  mutate(active_days = as.numeric(active_days),                                   #R initially interpreted active days column as categorical so we switched it to numerical so the model would be happy
         distance_to_trail_exp = exp(distance_to_trail))                                                           #after converting blanks and unknowns we dropped NAs

#we are taking our dataset and excluding all blanks in column ac,                             #we are taking our dataset and excluding all unknowns in column active days

mean(failure_data2$vertical_complexity, na.rm = TRUE)
mean(failure_data2$distance_to_trail_exp, na.rm = TRUE)

failure_data2["smallstems_ha"][is.na(failure_data2["smallstems_ha"])] <- 24012.7949
failure_data2["nest_height"][is.na(failure_data2["nest_height"])] <- 2.1339025
failure_data2["canopy_cover"][is.na(failure_data2["canopy_cover"])] <- 6.59408108
failure_data2["coverage"][is.na(failure_data2["coverage"])] <- 2.19444444
failure_data2["vertical_complexity"][is.na(failure_data2["vertical_complexity"])] <- 2.076923
failure_data2["distance_to_trail_exp"][is.na(failure_data2["distance_to_trail_exp"])] <- 2.486415

#replacing all the NAa with averages


failure_data_mod <- failure_data2 %>%
  mutate_if(is.numeric, .funs = list(s = ~as.numeric(scale(.x)))) %>%
  mutate(date_failed = as.Date(date_failed, "%d/%m/%Y"),
         doy = yday(date_failed),
         doy_s = as.numeric(scale(doy)))


saveRDS(failure_data_mod, "4-Output/failure_data_mod.RDS")

mod <- lmer(active_days_s ~ coverage_s + canopy_cover_s + vertical_complexity_s + 
            smallstems_ha_s + distance_to_trail_exp_s + doy_s + (1|site)
            + (1|species), data = failure_data_mod)

plot(mod)                                                                         #this tests linearity of our model, everything checks out 




#not working: 
#modtable <- tidy(mod)
#modtable
#dwplot(mod) + theme_classic()

check_model(mod)

visreg(mod, "smallstems_ha")
visreg(mod, "canopy_cover")
visreg(mod, "distance_to_trail_exp")
visreg(mod, "date_failed")


qqnorm(resid(mod))
qqline(resid(mod))


summary(mod)

tab_model(mod, show.se = TRUE, 
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




pre <- predictions(mod, newdata = datagrid(active_days_s = c(-3, 3), 
                                           doy_s = c(-3, 3),
                                           species = unique))


doy_plot <- plot_predictions(mod, condition = c("doy_s", "species"), rug = T) + 
  geom_point(data = failure_data_mod, aes(x = doy_s, color = species, y = active_days_s))

# extract plot breaks on x and y axes
atx <- c(as.numeric(na.omit(layer_scales(doy_plot)$x$break_positions())))
aty <- c(as.numeric(na.omit(layer_scales(doy_plot)$y$break_positions())))

# unscale axis labels for interpretation
doy_plot +
  scale_x_continuous(breaks = atx,
                     labels = round(atx * sd(failure_data_mod$doy) + mean(failure_data_mod$doy), 0),
                     name = "Day of Year")  +
  scale_y_continuous(name = "Active Days", 
                     breaks = aty,
                     labels = round(aty * sd(failure_data_mod$active_days) + mean(failure_data_mod$active_days), 0)) 


plot_predictions(mod, condition = c("doy_s", "species"), rug = T) + 
  geom_point(data = failure_data_mod, aes(x = doy_s, y = active_days_s, colour = species))


####not by species####

doy_plot <- plot_predictions(mod, condition = c("doy_s"), rug = T)  
  # geom_point(data = failure_data_mod, aes(x = doy_s, y = active_days_s))

# extract plot breaks on x and y axes
atx <- c(as.numeric(na.omit(layer_scales(doy_plot)$x$break_positions())))
aty <- c(as.numeric(na.omit(layer_scales(doy_plot)$y$break_positions())))

# unscale axis labels for interpretation
doy_plot +
  scale_x_continuous(breaks = atx,
                     labels = round(atx * sd(failure_data_mod$doy) + mean(failure_data_mod$doy), 0),
                     name = "Day of Year")  +
  scale_y_continuous(name = "Active Days", 
                     breaks = aty,
                     labels = round(aty * sd(failure_data_mod$active_days) + mean(failure_data_mod$active_days), 0)) 





max(failure_data2$coverage) - min(var(failure_data2$coverage) )
max(failure_data2$canopy_cover) - min(failure_data2$canopy_cover) 
max(failure_data2$vertical_complexity) - min(failure_data2$vertical_complexity) 
max(failure_data2$smallstems_ha) - min(failure_data2$smallstems_ha) 


sd(failure_data2$coverage)
sd(failure_data2$canopy_cover)
sd(failure_data2$vertical_complexity) 
sd(failure_data2$smallstems_ha) 
