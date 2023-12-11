library(tidyverse)

##AnnRecFnc - Calculation Annual Recruitment ####
AnnRecFnc<-function(demand, supply, redeployment_coeff, compRate){
  
  annualRecruitment <- 0
  extSupply <-0
  totalSupply <-0
  
  if (demand[1]>supply[1]) {
    annualRecruitment[1] = demand[1]-supply[1]
  } else {
    annualRecruitment[1] = 0
  }
  
  #supply[2] = supply[2] + annualRecruitment[1] #carry formward the first recruitment
  
  for(i in seq_along(demand)) {
    if (i>1) {
      extSupply <- annualRecruitment #cumsum(annualRecruitment)
      # totalSupply[i] = (supply[i] * redeployment_coeff) + extSupply[i-1] #* rate_short_comp^i
      # annualRecruitment[i] = demand[i]-totalSupply[i]
      
      #  message("extSupply")
      #  print(extSupply)
      
      supply[i] <- (supply[i-1]  + extSupply[i-1] * redeployment_coeff) * compRate  #* rate_short_comp^i
      annualRecruitment[i] <- demand[i]-supply[i] 
      
      if (annualRecruitment[i]<0) {
        annualRecruitment[i]=0
      }
    }
  }}
  
  ##calcAnnualRecruitment - Calls AnnRec####
  calcAnnualRecruitment <- function(df_wide, redeployment_coeff, groupList, compRate) {
    
    #df_wide <- pivot_wider(df_narrow, names_from = "SupplyDemand", values_from = Value, values_fill = 0)
    #message("calcAnnualRecruitment_fnc")
    #print(df_wide)
    df_out<- df_wide %>%
      #  group_by(Site, Region, Level, LLRC) %>%
      group_by(Region, Site, LLRC, Level) %>%
      #  group_by(LLRC, Level,  Site, Region, Year) %>%
      # group_by(LLRC, Level) %>%
      #  mutate(Demand = sum(Demand), Supply = sum(Supply))
      #   summarise(across(c(Demand, Supply), sum)) %>%
      arrange( LLRC, Level,  Site, Region, Year) %>%
      #  arrange(Region, Site, Level, LLRC, .by_group = TRUE ) %>%
      #  arrange(LLRC, Level) %>%
      mutate(annualRecruitment = AnnRecFnc(Demand, Supply, redeployment_coeff, compRate)) %>%
      as.data.frame()
    #message("END calcAnnualRecruitment_fnc")
    return(df_out)
  }
  
  calcInflow <- function(rate, scenario_w, redeployment_coeff) {
    message("calcInflow called")
    compRate = 1-rate/100
    startYear = 2023
    # df <- demand_supply_w %>%
    df <-  scenario_w() %>%
      
      # group_by(Year, LLRC, Level, Site, Region) %>% 
      # mutate(attrition = ifelse(Year == startYear, 1, compRate)) %>%
      # group_by(LLRC, Level, Site, Region) %>% 
      # mutate(cumattrition = cumprod(attrition)) %>% 
      # mutate(Supply = Supply_current * cumattrition) %>%
      
      group_by(Year, LLRC, Level, Site, Region) %>% 
      group_by(Year, LLRC, Level) %>% 
      
      # mutate(attrition = ifelse(Year == startYear, 1, compRate)) %>%
      # group_by(LLRC, Level, Site, Region) %>% 
      # mutate(cumattrition = cumprod(attrition)) %>% 
      mutate(Supply = Supply_current ) %>%
      
      # select(-attrition, -cumattrition) %>%
      # arrange(Site, LLRC, Level, Year) 
      arrange(Year,  LLRC, Level, Site)#%>%
    # as.data.frame()
    
    df <-  calcAnnualRecruitment(df, redeployment_coeff, groupList, compRate) %>%
      filter(Year >= startYear)
    # print(df)
    
    message("calcinflow finished")
    return(df)
  }
  
  
  
  df <- calcInflow(input$attrition, scenario_w, input$redeploy_coeff)