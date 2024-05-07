source("3-RScripts/packages.R")

failure_data2 <- readRDS("4-Output/failure_data2.RDS")



overall_histogram <- ggplot(failure_data2, aes(x=active_days)) + 
                   geom_histogram(aes (y = ..density..), binwidth = 1, color = "black",
                                  fill = "azure2") +labs(y= "Proportion", x = "Active Days")

overall_histogram
