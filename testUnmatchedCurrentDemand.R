library(tidyverse)

options(scipen = 999)

Exisiting_Estate_Map <- read_csv("./data/mapping/OrgRegionMap.csv")
source("./source_files/ReadExistingEstateZipFile.R", local = TRUE)

current_A_first_year <- supply_reduced_A %>%
  filter(Year == min(Year)) %>%
    group_by(Site, LLRC) %>%
    summarise(current_value =sum(value))

demand_A_first_year <- demand_reduced_A %>%
  filter(Year == min(Year)) %>%
  group_by(Site, LLRC) %>%
  summarise(demand_value =sum(value))

demand_A_summed <- demand_reduced_A %>%
  group_by(Site, LLRC) %>%
  summarise(demand_value =sum(value))

compared_first_year_unfiltered <- left_join(current_A_first_year, demand_A_first_year, by=c("Site", "LLRC")) 

compared_first_year <- left_join(current_A_first_year, demand_A_first_year, by=c("Site", "LLRC")) %>%
  filter(demand_value == 0 & current_value >0)

compared_summed <- left_join(current_A_first_year, demand_A_summed, by=c("Site", "LLRC")) %>%
  filter(demand_value == 0 & current_value >0)

compared_demand_zero_current <- left_join(current_A_first_year, demand_A_first_year, by=c("Site", "LLRC")) %>%
  filter(demand_value > 0 & current_value == 0)

compared_site <- compared_summed %>%
  group_by(Site) %>%
  summarise(current_value=sum(current_value)) %>%
  arrange(desc(current_value))

write_csv(compared_summed, "./CurrentZeroDemand_A.csv")
write_csv(compared_demand_zero_current, "DemandZeroCurrent_A.csv")

##B####

current_B_first_year <- supply_reduced_B %>%
  filter(Year == min(Year)) %>%
  group_by(Site, LLRC) %>%
  summarise(current_value =sum(value))

demand_B_first_year <- demand_reduced_B %>%
  filter(Year == min(Year)) %>%
  group_by(Site, LLRC) %>%
  summarise(demand_value =sum(value))

demand_B_summed <- demand_reduced_B %>%
  group_by(Site, LLRC) %>%
  summarise(demand_value =sum(value))

compared_first_year <- left_join(current_B_first_year, demand_B_first_year, by=c("Site", "LLRC")) %>%
  filter(demand_value == 0 & current_value >0)

compared_summed <- left_join(current_B_first_year, demand_B_summed, by=c("Site", "LLRC")) %>%
  filter(demand_value == 0 & current_value >0)

compared_demand_zero_current <- left_join(current_B_first_year, demand_B_first_year, by=c("Site", "LLRC")) %>%
  filter(demand_value > 0 & current_value == 0)

compared_site <- compared_summed %>%
  group_by(Site) %>%
  summarise(current_value=sum(current_value)) %>%
  arrange(desc(current_value))

write_csv(compared_summed, "./CurrentZeroDemand_B.csv")
write_csv(compared_demand_zero_current, "DemandZeroCurrent_B.csv")


##C####

current_C_first_year <- supply_reduced_C %>%
  filter(Year == min(Year)) %>%
  group_by(Site, LLRC) %>%
  summarise(current_value =sum(value))

demand_C_first_year <- demand_reduced_C %>%
  filter(Year == min(Year)) %>%
  group_by(Site, LLRC) %>%
  summarise(demand_value =sum(value))

demand_C_summed <- demand_reduced_C %>%
  group_by(Site, LLRC) %>%
  summarise(demand_value =sum(value))

compared_first_year <- left_join(current_C_first_year, demand_C_first_year, by=c("Site", "LLRC")) %>%
  filter(demand_value == 0 & current_value >0)

compared_summed <- left_join(current_C_first_year, demand_C_summed, by=c("Site", "LLRC")) %>%
  filter(demand_value == 0 & current_value >0)

compared_demand_zero_current <- left_join(current_C_first_year, demand_C_first_year, by=c("Site", "LLRC")) %>%
  filter(demand_value > 0 & current_value == 0)

compared_site <- compared_summed %>%
  group_by(Site) %>%
  summarise(current_value=sum(current_value)) %>%
  arrange(desc(current_value))

write_csv(compared_summed, "./CurrentZeroDemand_C.csv")
write_csv(compared_demand_zero_current, "DemandZeroCurrent_C.csv")

