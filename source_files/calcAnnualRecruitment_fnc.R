##calcAnnualRecruitment - Calls AnnRec####
calcAnnualRecruitment <- function(df_wide, redeployment_coeff, groupList, compRate, compRateSupply, useAttritionFile) {
  
  #df_wide <- pivot_wider(df_narrow, names_from = "SupplyDemand", values_from = Value, values_fill = 0)
  #message("calcAnnualRecruitment_fnc")
  #print(df_wide)
  message("Starting annrec calc")
  #write_csv(df_wide, "./df_wide.csv")
  start_time = Sys.time()
  
  df_out<- df_wide %>%
  #  group_by(Site, Region, Level, LLRC) %>%
    group_by(Region, Site, LLRC, Level, attrition_rate_comp) %>%
  #  group_by(LLRC, Level,  Site, Region, Year) %>%
   # group_by(LLRC, Level) %>%
  #  mutate(Demand = sum(Demand), Supply = sum(Supply))
 #   summarise(across(c(Demand, Supply), sum)) %>%
    arrange( LLRC, Level,  Site, Region, Year) %>%
  #  arrange(Region, Site, Level, LLRC, .by_group = TRUE ) %>%
  #  arrange(LLRC, Level) %>%
    mutate(annualRecruitment = AnnRecFnc(Demand, Supply, redeployment_coeff, compRate, compRateSupply, attrition_rate_comp, useAttritionFile)) %>%
    mutate(annualRecruitmentExpansion = AnnRecFnc(Demand, Supply, redeployment_coeff=1, compRate=1, compRateSupply=1, attrition_rate_comp, useAttritionFile)) %>%
    mutate(annualRecruitmentReplacement = annualRecruitment - annualRecruitmentExpansion) %>%
    as.data.frame()
  
  message("Finished annrec calc")
  #write_csv(df_out, "./df_out.csv")
  
  print(Sys.time() - start_time)
  #message("END calcAnnualRecruitment_fnc")
  return(df_out)
}