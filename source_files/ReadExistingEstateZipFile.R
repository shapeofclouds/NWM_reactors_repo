##Reading 2023 data####
library(tidyverse)

existing_estate_data_path_A <- "./data/inputData/existing_estate_A.zip" 
existing_estate_data_path_B <- "./data/inputData/existing_estate_B.zip" 
existing_estate_data_path_C <- "./data/inputData/existing_estate_C.zip"
existing_estate_data_path_NULL <- "./data/inputData/existing_estate_NULL.zip"
existing_estate_data_path_TEST <- "./data/inputData/existing_estate_TEST.zip"

existing_estate_data_zip_path <- "outputData/"
#OrgRegionMap <- read_csv("./data/mapping/OrgRegionMap.csv")
#ResourcesMap <- read_csv("./data/mapping/Resources.csv")


Age_long <- read_csv(unzip(existing_estate_data_path_A, paste0(existing_estate_data_zip_path, "Age_long.csv"), list = FALSE)) %>%
  filter(!is.na(Age.Band)) %>%
  mutate(Site = if_else(Site == "RR SMR existing - Midlands", "Rolls Royce Midlands", Site)) %>%
  mutate(Site = if_else(Site == "RR SMR - demand
 existing business North of UK", "Rolls Royce North West", Site))# 


EDI_long <- read_csv(unzip(existing_estate_data_path_A, paste0(existing_estate_data_zip_path, "edi.csv"), list = FALSE)) #%>%

Level_long <- read_csv(unzip(existing_estate_data_path_A, paste0(existing_estate_data_zip_path, "level_long.csv"), list = FALSE)) %>%
filter(!is.na(Level)) #%>%
 #  mutate(Site = if_else(Site == "RR SMR existing - Midlands", "Rolls Royce Midlands", Site)) %>%
 #  mutate(Site = if_else(Site == "RR SMR - demand
 # existing business North of UK", "Rolls Royce North West", Site))# # 

demandx <- read_csv(unzip(existing_estate_data_path_A, paste0(existing_estate_data_zip_path, "demandLevel.csv"), list = FALSE))%>%
  mutate(Site = if_else(Site == "RR SMR existing - Midlands", "Rolls Royce Midlands", Site)) %>%
  mutate(Site = if_else(Site == "RR SMR - demand
 existing business North of UK", "Rolls Royce North West", Site))#  #%>%

##Demand data (reduced to 4 levels) alternatives####
demand_reduced_A <- read_csv(unzip(existing_estate_data_path_A, paste0(existing_estate_data_zip_path, "demand_reduced.csv"), list = FALSE)) %>%
  filter(!(LLRC %in% c("Human Factors", "Manufacturing Engineers")))#%>%
#  mutate(Site = if_else(Site == "RR SMR existing - Midlands", "Rolls Royce Midlands", Site)) %>%
#  mutate(Site = if_else(Site == "RR SMR - demand
# existing business North of UK", "Rolls Royce North West", Site))#  #%>%


if(file.exists(existing_estate_data_path_B)) {
  print ("B file exists")
  demand_reduced_B <- read_csv(unzip(existing_estate_data_path_B, paste0(existing_estate_data_zip_path, "demand_reduced.csv"), list = FALSE))%>%
    filter(!(LLRC %in% c("Human Factors", "Manufacturing Engineers")))#%>%
} else {
  
  demand_reduced_B <- demand_reduced 
  print ("B file does not exist")
  
}

if(file.exists(existing_estate_data_path_C)) {
  print ("C file exists")
  demand_reduced_C <- read_csv(unzip(existing_estate_data_path_C, paste0(existing_estate_data_zip_path, "demand_reduced.csv"), list = FALSE))%>%
                                 filter(!(LLRC %in% c("Human Factors", "Manufacturing Engineers")))
                               #%>%
} else {
  
  demand_reduced_C <- demand_reduced 
  print ("C file does not exist")
  
}

if(file.exists(existing_estate_data_path_NULL)) {
  print ("NULL file exists")
  demand_reduced_NULL <- read_csv(unzip(existing_estate_data_path_NULL, paste0(existing_estate_data_zip_path, "demand_reduced.csv"), list = FALSE))
} else {
  
  demand_reduced_NULL <- demand_reduced 
  print ("NULL file does not exist")
  
}

if(file.exists(existing_estate_data_path_TEST)) {
  print ("TEST file exists")
  demand_reduced_TEST <- read_csv(unzip(existing_estate_data_path_TEST, paste0(existing_estate_data_zip_path, "demand_reduced.csv"), list = FALSE))
} else {
  
  demand_reduced_TEST <- demand_reduced 
  print ("TEST file does not exist")
  
}



#####


supply.df <- read_csv(unzip(existing_estate_data_path_A, paste0(existing_estate_data_zip_path, "supply.df.csv"), list = FALSE)) 

##Supply data (reduced to 4 levels) alternatives####
supply_reduced_A <- read_csv(unzip(existing_estate_data_path_A, paste0(existing_estate_data_zip_path, "supply_reduced.csv"), list = FALSE)) %>%
  filter(!(LLRC %in% c("Human Factors", "Manufacturing Engineers")))

if(file.exists(existing_estate_data_path_B)) {
  supply_reduced_B <- read_csv(unzip(existing_estate_data_path_B, paste0(existing_estate_data_zip_path, "supply_reduced.csv"), list = FALSE)) %>%
    filter(!(LLRC %in% c("Human Factors", "Manufacturing Engineers")))
} else {
  
  supply_reduced_B <- supply_reduced 
  
}

if(file.exists(existing_estate_data_path_C)) {
  supply_reduced_C <- read_csv(unzip(existing_estate_data_path_C, paste0(existing_estate_data_zip_path, "supply_reduced.csv"), list = FALSE)) %>%
    filter(!(LLRC %in% c("Human Factors", "Manufacturing Engineers")))
} else {
  
  supply_reduced_C <- supply_reduced 
  
}

if(file.exists(existing_estate_data_path_NULL)) {
  supply_reduced_NULL <- read_csv(unzip(existing_estate_data_path_NULL, paste0(existing_estate_data_zip_path, "supply_reduced.csv"), list = FALSE))
} else {
  
  supply_reduced_NULL <- supply_reduced 
  
}

if(file.exists(existing_estate_data_path_TEST)) {
  supply_reduced_TEST <- read_csv(unzip(existing_estate_data_path_TEST, paste0(existing_estate_data_zip_path, "supply_reduced.csv"), list = FALSE))
} else {
  
  supply_reduced_TEST <- supply_reduced 
  
}


# 
Leavers_Level_long <- read_csv(unzip(existing_estate_data_path_A, paste0(existing_estate_data_zip_path, "leavers_level.csv"), list = FALSE))  #%>%


# 
# Leavers_Age_long <- read_csv(unzip(existing_estate_data_path_A, paste0(existing_estate_data_zip_path, "leavers_age.csv"), list = FALSE))  %>%
#   merge(OrgRegionMap, by = "Site") %>%
#   mutate(Region = if_else(is.na(Region), "No Region Mapped", Region)) %>%
#   mutate(Organisation= if_else(is.na(Organisation), "No Organisation Mapped", Organisation)) %>%
#   mutate(Sector = if_else(is.na(Sector), "No Sector Mapped", Sector)) %>%
#   mutate(`Sub-sector` = if_else(is.na(`Sub-sector`), "No Sub-sector Mapped", `Sub-sector`)) %>%
#   merge(ResourcesMap, by = "Low.Level.Resource.Code") %>% 
#   mutate(Function = if_else(is.na(Function), "No Function Mapped", Function))
# 
# Recruitment_long <- read_csv(unzip(existing_estate_data_path_A, paste0(existing_estate_data_zip_path, "recruitment.csv"), list = FALSE)) %>%
#   merge(OrgRegionMap, by = "Site") %>%
#   mutate(Region = if_else(is.na(Region), "No Region Mapped", Region)) %>%
#   mutate(Organisation= if_else(is.na(Organisation), "No Organisation Mapped", Organisation)) %>%
#   mutate(Sector = if_else(is.na(Sector), "No Sector Mapped", Sector)) %>%
#   mutate(`Sub-sector` = if_else(is.na(`Sub-sector`), "No Sub-sector Mapped", `Sub-sector`)) %>%
#   merge(ResourcesMap, by = "Low.Level.Resource.Code") %>% 
#   mutate(Function = if_else(is.na(Function), "No Function Mapped", Function))
# 
Trainees_long <- read_csv(unzip(existing_estate_data_path_A, paste0(existing_estate_data_zip_path, "trainees.csv"), list = FALSE)) #%>%

# 
Vacancies_long <- read_csv(unzip(existing_estate_data_path_A, paste0(existing_estate_data_zip_path, "vacancies.csv"), list = FALSE)) %>%
   merge(Exisiting_Estate_Map, by = "Site") %>%
  mutate(Region = if_else(is.na(Region), "No Region Mapped", Region)) %>%
 mutate(Organisation= if_else(is.na(Organisation), "No Organisation Mapped", Organisation)) %>%
  mutate(Sector = if_else(is.na(Sector), "No Sector Mapped", Sector)) %>%
 mutate(`Sub-sector` = if_else(is.na(`Sub-sector`), "No Sub-sector Mapped", `Sub-sector`)) #%>%
 # merge(Resources, by = "Low.Level.Resource.Code") %>%
 # mutate(Function = if_else(is.na(Function), "No Function Mapped", Function))
message("Input files read")

f <- list.files(existing_estate_data_zip_path, include.dirs = F, full.names = T, recursive = T)

# remove the files
file.remove(f)
message("Input files deleted from temp directory outputData")

