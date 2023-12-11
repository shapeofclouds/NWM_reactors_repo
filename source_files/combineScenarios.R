library(tidyverse)

inflow <- read_csv("./data/post_processing/Inflow-RCT_1.csv") %>%
  group_by(Year, scenario, Type) %>%
  summarise(value = sum(value))

demand <- read_csv("./data/post_processing/Demand_Attrition-RCT_1.csv") %>%
  filter(SupplyDemand == "demand") %>%
  select(-SupplyDemand)

