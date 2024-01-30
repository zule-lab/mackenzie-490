library(dplyr) 
library(forcats)
library(ggplot2)
library(esquisse)
library(mosaic)


failure_data <- read.csv("2-Cleaned_data/failure_data_V3.xlsx")

mod <- lm(dependent ~ independent, data = failure_data)

modtable <- tidy(mod)

saveRDS()

write.csv(modtable, 'output/failuremodel.csv')


#re-ordering the stages on the x-axis to follow the phenological order

failure_stagesR <- failure_data %>%  
  mutate(failure_stage = fct_relevel(failure_stage, 
                          "building", "laying ", "incubation", 
                          "nestling"))

View(failure_data) 

esquisser(failure_data) 

####failure stages by site####

#below function re-names the sites (labels it) 

site_labs <- c('Bois-de-Liesse', 'Stoneycroft', 'Technoparc')
names(site_labs) <- c('bdl', 'stny', 'technoparc')

failure_stages_by_site <- failure_stagesR %>%
  filter(!(failure_stage %in% "unknown")) %>%
  ggplot() +
  aes(x = failure_stage) +
  geom_bar(fill = "lightblue3") +
  labs(x = "Failure Stage ", y = "Count ") +
  scale_x_discrete(labels = c('Building','Laying','Incubation', 'Nestling'))+  #Changing the names for the stages 
  theme_bw() +
  theme(axis.text.x = element_text(angle = 45, hjust = 1)) + 
  facet_wrap(vars(site), labeller = labeller(site = site_labs)) + 
  theme(strip.text = element_text(size = 15, face="bold"))

print(failure_stages_by_site)

##ggsave(filename ="Stage_Site.png", plot = failure_stages_by_site, path = "C:/Users/mgues/OneDrive/Desktop/BIOL 490/Figures", width = 20, height = 10, device='tiff', dpi=600)



####failure stages by species####


species_labs <- c('Cardinal', 'Gray Catbird', 'Robin', 'Yellow Warbler')
names(species_labs) <- c('cardinal ', 'gray_catbird', 'robin', 'yellow_warbler')

failure_stages_by_species <- failure_stagesR %>%
  filter(!(failure_stage %in% "unknown")) %>%
  ggplot() +
  aes(x = failure_stage) +
  geom_bar(fill = "lightblue3") +
  labs(x = "Failure Stage ", y = "Count ") +
  scale_x_discrete(labels = c('Building','Laying','Incubation', 'Nestling'))+  #Changing the names for the stages 
  theme_bw() +
  facet_wrap(vars(species), labeller = labeller(species = species_labs))

print(failure_stages_by_species)

##ggsave(filename ="Stage_Species.png", plot = failure_stages_by_species, path = "C:/Users/mgues/OneDrive/Desktop/BIOL 490/Figures", width = 20, height = 10, device='tiff', dpi=600)


####failure day by species####


species_labs <- c('Cardinal', 'Gray Catbird', 'Robin', 'Yellow Warbler')
names(species_labs) <- c('cardinal ', 'gray_catbird', 'robin', 'yellow_warbler')




failure_data_t <- failure_data %>% 
  filter(failure_day != 'unknown' & failure_day != "") %>% #filtering out unknowns and blanks 
  mutate(failure_day = as.integer(failure_day)) #R didnt see this as a number, so we mutate failure day into an integer 

failure_day_by_species <- failure_data_t %>%
  ggplot() +
  aes(x = failure_day) +
  geom_bar(fill = "plum4") +
  labs(x = "Failure Day (number of days) ", y = "Count") +
  theme_bw() +
  facet_wrap(vars(species), labeller = labeller(species = species_labs))

print(failure_day_by_species)

##ggsave(filename ="Day_Species.png", plot = failure_day_by_species, path = "C:/Users/mgues/OneDrive/Desktop/BIOL 490/Figures", width = 20, height = 10, device='tiff', dpi=600)


####failure day by site ####

site_labs <- c('Bois-de-Liesse', 'Stoneycroft', 'Technoparc')
names(site_labs) <- c('bdl', 'stny', 'technoparc')

failure_data_t <- failure_data %>% 
  filter(failure_day != 'unknown' & failure_day != "") %>% #filtering out unknowns and blanks 
  mutate(failure_day = as.integer(failure_day)) #R didnt see this as a number, so we mutate failure day into an integer 

failure_day_by_site <- failure_data_t %>%
  ggplot() +
  aes(x = failure_day) +
  geom_bar(fill = "plum4") +
  labs(x = "Failure Day (number of days) ", y = "Count") +
  theme_bw() +
  facet_wrap(vars(site), labeller = labeller(site = site_labs)) 

failure_day_by_site

##ggsave(filename ="Day_Site.png", plot = failure_day_by_site, path = "C:/Users/mgues/OneDrive/Desktop/BIOL 490/Figures", width = 10, height = 5, device='tiff', dpi=600)


####reason of failure facet species####

reason_by_species <- ggplot(failure_data) +
  aes(x = species, fill = reason) +
  labs(x = "Species", y= "Count") +
  geom_bar() +
  theme(legend.position = "side", legend.title = "Reason for Failure") +
  scale_x_discrete( labels = c('Cardinal', 'Gray Catbird', 'Robin', 'Yellow Warbler')) + 
  scale_fill_manual(values = c(abandonment = "lightblue3",
                              predation = "pink3",
                               `unknown ` = "red4")) +
  theme_bw()

reason_by_species

