
OrgRegionMap <- read_csv("./mapping/OrgRegionMap.csv")
ResourcesMap <- read_csv("./mapping/Resources.csv")

Age <- Age_long %>%
  full_join(OrgRegionMap, by = c("Site")) %>%
  mutate(Region = if_else(is.na(Region), "No Region Mapped", Region)) %>%
  mutate(Organisation= if_else(is.na(Organisation), "No Organisation Mapped", Organisation)) %>%
  mutate(Sector = if_else(is.na(Sector), "No Sector Mapped", Sector)) %>%
  mutate(`Sub-sector` = if_else(is.na(`Sub-sector`), "No Sub-sector Mapped", `Sub-sector`)) %>%
  full_join(ResourcesMap, by = "Low.Level.Resource.Code") %>% 
  mutate(Function = if_else(is.na(Function), "No Function Mapped", Function))
#write_csv(Age, "./outputData/Age_long.csv")

#write_csv(Age_long, "./data/Age_long.csv")

EDI <- EDI_data %>%
  merge(OrgRegionMap, by = "Site") %>%
  mutate(Region = if_else(is.na(Region), "No Region Mapped", Region)) %>%
  mutate(Organisation= if_else(is.na(Organisation), "No Organisation Mapped", Organisation)) %>%
  mutate(Sector = if_else(is.na(Sector), "No Sector Mapped", Sector)) %>%
  mutate(`Sub-sector` = if_else(is.na(`Sub-sector`), "No Sub-sector Mapped", `Sub-sector`)) %>%
  dplyr::rename(siteWorkforce = value) %>%  #temporary. this should be corrected in collate_templates.R
  dplyr::rename(value = NumberInGroup)
#write_csv(EDI, "./outputData/EDI_long.csv")

# Ethnicity_long <- EDI_long %>%
#   filter(CharacteristicGroup == "Ethnicity")
# 
# Disability_long <- EDI_long %>%
#   filter(CharacteristicGroup == "Disability")
# 
# Sexuality_long <- EDI_long %>%
#   filter(CharacteristicGroup == "Sexuality")

Level <- Level_long %>%
  full_join(OrgRegionMap, by = "Site") %>%
  mutate(Region = if_else(is.na(Region), "No Region Mapped", Region)) %>%
  mutate(Organisation= if_else(is.na(Organisation), "No Organisation Mapped", Organisation)) %>%
  mutate(Sector = if_else(is.na(Sector), "No Sector Mapped", Sector)) %>%
  mutate(`Sub-sector` = if_else(is.na(`Sub-sector`), "No Sub-sector Mapped", `Sub-sector`)) %>%
  full_join(ResourcesMap, by = "Low.Level.Resource.Code") %>%
  mutate(Function = if_else(is.na(Function), "No Function Mapped", Function))
#write_csv(Level, "./outputData/level_long.csv")
#write_csv(Level_long, "./data/Level_long.csv")
# 
Demand <- ProgrammeDemand %>%
  dplyr::rename(Low.Level.Resource.Code = Programme.Demand) %>%
  filter(Low.Level.Resource.Code != "0") %>% #non-existant resource code filter
   full_join(OrgRegionMap, by = "Site") %>%
   mutate(Region = if_else(is.na(Region), "No Region Mapped", Region)) %>%
   mutate(Organisation= if_else(is.na(Organisation), "No Organisation Mapped", Organisation)) %>%
   mutate(Sector = if_else(is.na(Sector), "No Sector Mapped", Sector)) %>%
   mutate(`Sub-sector` = if_else(is.na(`Sub-sector`), "No Sub-sector Mapped", `Sub-sector`)) %>%
   full_join(ResourcesMap, by = "Low.Level.Resource.Code") %>%
   mutate(Function = if_else(is.na(Function), "No Function Mapped", Function))
#write_csv(Demand, "./outputData/ProgrammeDemand.csv")
# write_csv(ProgrammeDemand_long, "./data/ProgDemand.csv")
# 
Leavers_Level <- Leavers_Level_long %>%
  merge(OrgRegionMap, by = "Site") %>%
  mutate(Region = if_else(is.na(Region), "No Region Mapped", Region)) %>%
  mutate(Organisation= if_else(is.na(Organisation), "No Organisation Mapped", Organisation)) %>%
  mutate(Sector = if_else(is.na(Sector), "No Sector Mapped", Sector)) %>%
  mutate(`Sub-sector` = if_else(is.na(`Sub-sector`), "No Sub-sector Mapped", `Sub-sector`)) %>%
  merge(ResourcesMap, by = "Low.Level.Resource.Code") %>%
  mutate(Function = if_else(is.na(Function), "No Function Mapped", Function))
#write_csv(Leavers_Level, "./outputData/leavers_level.csv")
#write_csv(Leavers_Level_long, "./LLL.csv")
# 
# Leavers_Age_long <- read_csv(unzip(existing_estate_data_path, paste0(existing_estate_data_zip_path, "leavers_age.csv"), list = FALSE))  %>%
#   merge(OrgRegionMap, by = "Site") %>%
#   mutate(Region = if_else(is.na(Region), "No Region Mapped", Region)) %>%
#   mutate(Organisation= if_else(is.na(Organisation), "No Organisation Mapped", Organisation)) %>%
#   mutate(Sector = if_else(is.na(Sector), "No Sector Mapped", Sector)) %>%
#   mutate(`Sub-sector` = if_else(is.na(`Sub-sector`), "No Sub-sector Mapped", `Sub-sector`)) %>%
#   merge(ResourcesMap, by = "Low.Level.Resource.Code") %>% 
#   mutate(Function = if_else(is.na(Function), "No Function Mapped", Function))
# 
# Recruitment_long <- read_csv(unzip(existing_estate_data_path, paste0(existing_estate_data_zip_path, "recruitment.csv"), list = FALSE)) %>%
#   merge(OrgRegionMap, by = "Site") %>%
#   mutate(Region = if_else(is.na(Region), "No Region Mapped", Region)) %>%
#   mutate(Organisation= if_else(is.na(Organisation), "No Organisation Mapped", Organisation)) %>%
#   mutate(Sector = if_else(is.na(Sector), "No Sector Mapped", Sector)) %>%
#   mutate(`Sub-sector` = if_else(is.na(`Sub-sector`), "No Sub-sector Mapped", `Sub-sector`)) %>%
#   merge(ResourcesMap, by = "Low.Level.Resource.Code") %>% 
#   mutate(Function = if_else(is.na(Function), "No Function Mapped", Function))
# 
trainees <- Trainees_long %>%
  merge(OrgRegionMap, by = "Site") %>%
  mutate(Region = if_else(is.na(Region), "No Region Mapped", Region)) %>%
  mutate(Organisation= if_else(is.na(Organisation), "No Organisation Mapped", Organisation)) %>%
  mutate(Sector = if_else(is.na(Sector), "No Sector Mapped", Sector)) %>%
  mutate(`Sub-sector` = if_else(is.na(`Sub-sector`), "No Sub-sector Mapped", `Sub-sector`))
#write_csv(trainees, "./outputData/trainees.csv")
#%>%
# merge(ResourcesMap, by = "Low.Level.Resource.Code") %>%
#  mutate(Function = if_else(is.na(Function), "No Function Mapped", Function))
# 
# Vacancies_long <- read_csv(unzip(existing_estate_data_path, paste0(existing_estate_data_zip_path, "vacancies.csv"), list = FALSE)) %>%
#   merge(OrgRegionMap, by = "Site") %>%
#   mutate(Region = if_else(is.na(Region), "No Region Mapped", Region)) %>%
#   mutate(Organisation= if_else(is.na(Organisation), "No Organisation Mapped", Organisation)) %>%
#   mutate(Sector = if_else(is.na(Sector), "No Sector Mapped", Sector)) %>%
#   mutate(`Sub-sector` = if_else(is.na(`Sub-sector`), "No Sub-sector Mapped", `Sub-sector`)) %>%
#   merge(ResourcesMap, by = "Low.Level.Resource.Code") %>% 
#   mutate(Function = if_else(is.na(Function), "No Function Mapped", Function))
