library("tidyverse")

scenario_w <- read_csv("./scenario_w.csv")
defaultAttrition <- read_csv("./defaultAttrition.csv")

#ind <- match(scenario_w$LLRC, defaultAttrition$LLRC)
#scenario_w[ind, 2] <- defaultAttrition[2]

scenario_w <- scenario_w %>%
  rows_update( defaultAttrition, unmatched = "ignore", by = "LLRC") %>%
  mutate(attrition_rate_comp = 1 - attrition_rate)
  
