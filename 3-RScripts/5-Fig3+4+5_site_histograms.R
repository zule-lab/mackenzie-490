source("3-RScripts/packages.R")

failure_data2 <- readRDS("4-Output/failure_data2.RDS")


#TECHNOPARC

tech <- subset(failure_data2, site  == "technoparc")


tech_histogram <- ggplot(tech, aes(x=active_days, fill = species)) + 
  geom_histogram(aes (y = ..density..), binwidth = 1, color = "black", ) + labs(y= "Proportion", x = "Active Days") 
tech_histogram

ggplot(tech) +
  geom_histogram(aes(x = active_days, y = ..density..),
                 binwidth = 1, fill = "grey", color = "black") + labs(y= "Proportion", x = "Active Days") + ggtitle("Technoparc")


#BDL

bdl <- subset(failure_data2, site  == "bdl")


bdl_histogram <- ggplot(bdl, aes(x=active_days, fill = species)) + 
  geom_histogram(aes (y = ..density..), binwidth = 1, color = "black") + labs(y= "Proportion", x = "Active Days")

ggplot(bdl) +
  geom_histogram(aes(x = active_days, y = ..density..),
                 binwidth = 1, fill = "grey", color = "black") + labs(y= "Proportion", x = "Active Days") + ggtitle("Bois-de-Liesse")

bdl_histogram


#MBO 

stny <- subset(failure_data2, site  == "stny")

stny_histogram <- ggplot(bdl, aes(x=active_days, fill = species)) + 
  geom_histogram(aes (y = ..density..), binwidth = 1, color = "black") +
               labs(y= "Proportion", x = "Active Days")

stny_histogram

ggplot(stny) +
  geom_histogram(aes(x = active_days, y = ..density..),
                 binwidth = 1, fill = "grey", color = "black") + labs(y= "Proportion", x = "Active Days") + ggtitle("McGill Bird Observatory")
