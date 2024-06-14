#In this script we are making a histogram of the proportion of nests that reach x number of active days 

#packages used: ggplot

source("3-RScripts/0-packages.R")

failure_data_mod <- readRDS("4-Output/failure_data_mod.RDS")



overall_histogram <- ggplot(failure_data2, aes(x=active_days)) + 
                   geom_histogram(aes (y = ..density..), binwidth = 1, color = "black",
                                  fill = "azure2") +labs(y= "Proportion", x = "Active Days")

overall_histogram


ggsave(overall_histogram, 
       filename = "Fig2_global_hist",
       path = "4-Output",
       device = "pdf",
       height = 6, width = 5, units = "in")
