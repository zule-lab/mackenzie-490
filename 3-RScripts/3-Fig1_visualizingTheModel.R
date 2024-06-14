#This script is the code for the figure that visualizes the model, showing the effect of DOY on the number of active days 

#packages used: merDeriv, marginaleffects, lubridate

#making a data set of 'predictions'

pre <- predictions(mod, newdata = datagrid(active_days_s = c(-3, 3), 
                                           doy_s = c(-3, 3),
                                           species = unique))


doy_plot <- plot_predictions(mod, condition = c("doy_s", "species"), rug = T) + 
  geom_point(data = failure_data_mod, aes(x = doy_s, color = species, y = active_days_s))

# extract plot breaks on x and y axes
atx <- c(as.numeric(na.omit(layer_scales(doy_plot)$x$break_positions())))
aty <- c(as.numeric(na.omit(layer_scales(doy_plot)$y$break_positions())))

# unscale axis labels for interpretation
model_fig <- doy_plot +
  scale_x_continuous(breaks = atx,
                     labels = round(atx * sd(failure_data_mod$doy) + mean(failure_data_mod$doy), 0),
                     name = "Day of Year")  +
  scale_y_continuous(name = "Active Days", 
                     breaks = aty,
                     labels = round(aty * sd(failure_data_mod$active_days) + mean(failure_data_mod$active_days), 0)) 

model_fig


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

ggsave(model_fig, 
       filename = "model_fig1.pdf",
       path = "4-Output",
       device = "pdf",
       height = 6, width = 5, units = "in")





