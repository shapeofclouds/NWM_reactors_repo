calcInflow <- function(rate, rateSupply, scenario_w, redeployment_coeff, useAttritionFile) {
  message("calcInflow called")
  compRate = 1-rate/100
  compRateSupply = 1-rateSupply/100
  startYear = 2023
  # df <- demand_supply_w %>%
  df <-  scenario_w() %>%
    
    # group_by(Year, LLRC, Level, Site, Region) %>% 
    # mutate(attrition = ifelse(Year == startYear, 1, compRate)) %>%
    # group_by(LLRC, Level, Site, Region) %>% 
    # mutate(cumattrition = cumprod(attrition)) %>% 
    # mutate(Supply = Supply_current * cumattrition) %>%
    
    group_by(Year, LLRC, Level, Site, Region, attrition_rate_comp) %>% 
    group_by(Year, LLRC, Level, attrition_rate_comp) %>% 
    
   # mutate(attrition = ifelse(Year == startYear, 1, compRate)) %>%
   # group_by(LLRC, Level, Site, Region) %>% 
   # mutate(cumattrition = cumprod(attrition)) %>% 
    mutate(Supply = Supply_current ) %>%
    
    # select(-attrition, -cumattrition) %>%
   # arrange(Site, LLRC, Level, Year) 
    arrange(Level, Site, Year,  LLRC)#%>%
  # as.data.frame()
 # print(df)
  
 df <-  calcAnnualRecruitment(df, redeployment_coeff, groupList, compRate, compRateSupply, useAttritionFile) %>%
    filter(Year >= startYear)
 # print(df)
  
  message("calcinflow finished")
  return(df)
}