library("tidyverse")



findLevelAverages <- function(df) {
  
  df %>%
  group_by(Site, LLRC, Level) %>%
  summarise(LevelAbsSites=sum(Value), .groups="drop_last") %>%
  group_by(Site, LLRC) %>%
  mutate(LevelTotalSites = sum(LevelAbsSites)) %>%
  mutate(LevelFrac=LevelAbsSites/LevelTotalSites) %>%
  group_by(LLRC, Level) %>% #use general average for cases where data doesn't exist for a particular site
  mutate(LevelAbsAll = sum(LevelAbsSites)) %>%
  group_by(LLRC, Level) %>%
  mutate(LevelTotalAll = sum(LevelTotalSites)) %>%
  mutate(LevelFracAll=LevelAbsAll/LevelTotalAll) %>%
  as.data.frame()

}

reduceLevels <- function(inputData) {
  outputData <- inputData %>%
    # a row number needs to be introduced to avoid a duplication problem 
    #that results in Levelx variables being produced as lists which can't be added
    group_by(LLRC, Site, Year, Organisation, RCT, Level) %>%
    mutate(row = row_number()) %>%
    pivot_wider(names_from = Level, values_from = Value) %>%
    mutate(L12 = Level1+Level2) %>%
    mutate(L34 = Level3+Level4) %>%
    mutate(L56 = Level5+Level6) %>%
    mutate(L78 = Level7+Level8) %>%
    select(-(Level1:SME), -row) %>%
    pivot_longer(L12:L78, names_to = "Level", values_to = "Value") %>%
    as.data.frame()
  return(outputData)
  
}

##PAths####
pathData <- "./data/inputData"
pathMapping <- "./data/mapping"

##Input mapping files####
FuncMap_CSV <- "Resources4RNoTrades.csv"
OrgMap_CSV <- "OrgMapDefence2020NoSC_defence_reprofiled_ForMay25_2023.csv"

##Input correction files####
ExtrapolationMap_CSV <- "ExtrapolationFactors.csv"

##Input data files####
demand_CSV <- "StaffTrainees_Demand.csv"
current_CSV <- "StaffTrainees_Current.csv"

##Paths and files####
OrgMap_path <- paste(pathMapping,OrgMap_CSV, sep="/")
FuncMap_path <- paste(pathMapping,FuncMap_CSV, sep="/")
ExtrapMap_path <- paste(pathMapping, ExtrapolationMap_CSV, sep="/")
current_path <- paste(pathData,current_CSV, sep="/")
demand_path <- paste(pathData,demand_CSV, sep="/")

##Read in files
OrgMap_df <- read_csv(OrgMap_path)
FuncMap_df <- read_csv(FuncMap_path)
ExtrapFactors_df <- read_csv(ExtrapMap_path)
current_unfiltered <- read_csv(current_path)
demand_df <- read_csv(demand_path)

current_unfiltered <- merge(current_unfiltered, OrgMap_df)
current_unfiltered <- merge(current_unfiltered, FuncMap_df)


demand_df <- merge(demand_df, OrgMap_df)
demand_df <- merge(demand_df, FuncMap_df)

demand_df <- demand_df %>%
  arrange(demand_df, Year) %>%
  mutate(Value = replace_na(Value, 0))

## Extend Year range ####
demand_wide <- pivot_wider(demand_df, names_from = c(Year), values_from = Value)
demand_wide <- left_join(demand_wide, ExtrapFactors_df)
demand_wide <- demand_wide %>%
  mutate(Extrapolation_factor = replace_na(Extrapolation_factor, 1)) %>% ## keeps data in the even site is missing from extrapolation list
  relocate(Extrapolation_factor, .after=STEM_Status) 

for(i in 1:10) {  #Extrapolates out years for another 10 years
  last_vec <- demand_wide[ , ncol(demand_wide), drop = FALSE] 
  last_vec <- last_vec * demand_wide$Extrapolation_factor #Adjust falloff in extrapolation
  colName <- as.character(names(last_vec))
  newName <- as.character(as.numeric(colName) + 1) #
  new_vec <- dplyr::rename(last_vec, !!sym(newName):=!!sym(colName))
  demand_wide <- cbind(demand_wide, new_vec)
}

startYear <- min(demand_df$Year)
endYear <- max(demand_df$Year)

levelCoefficients <- findLevelAverages(current_unfiltered)  

temp <- levelCoefficients %>%
  group_by(Site, LLRC) %>%
  summarise(levTotal = sum(LevelFrac))

##Expand demand_ df dataframe to hold 8 levels. Each demand line value is split by the Level Co-efficients 
expDemand <- demand_df %>%
  group_by(LLRC, Site, Status, Year, Value, Organisation, RCT, `Sub-sector`, Region, Region2, STEM_Status, `Generic/Nuclear`) %>% 
  expand(Level = c("Level1", 
                   "Level2", 
                   "Level3", 
                   "Level4", 
                   "Level5", 
                   "Level6", 
                   "Level7", 
                   "Level8", 
                   "SME"))

demandLevel <- left_join(expDemand, levelCoefficients)
demandLevel[is.na(demandLevel)] = 0
demandLevel <- demandLevel %>%
#  group_by(LLRC, Site, Year) %>%
  mutate(flag = sum(LevelFrac)) %>%
  mutate(Value = ifelse(flag==1, (Value * LevelFrac), (Value * LevelFracAll))) %>%
  as.data.frame()

demandLevel <- select(demandLevel,Site, Year, LLRC, RCT, Level, Organisation,`Sub-sector`, Region, Region2, Value, Status, STEM_Status, `Generic/Nuclear`)

which(!grepl('^[0-9]',demandLevel[[7]])) 

demandLevel <- filter(demandLevel, Level != "SME")
 

##Reduce 8 Levels (produced for completeness) to 4
#demand4Level <- reduceLevels(demandLevel)

#demandLevel$SupplyDemand <- "Demand"

demandBind <- select(demandLevel, LLRC, Site, Year, Organisation, `Sub-sector`, Region, Region2, RCT, Level, Value, Status, STEM_Status, `Generic/Nuclear`)

demandBind <- demandBind %>%
  arrange(Year)


demandBind2020 <- filter(demandBind, Year==2020)


##Supply side####

supply_expanded <- current_unfiltered %>% 
  filter(Level != "SME") %>%
  group_by(LLRC, Site, RCT, Level, Organisation, `Sub-sector`, Region, Region2, `Generic/Nuclear`, STEM_Status) %>% 
  summarise(Value = sum(Value), .groups="drop_last") %>%
  group_by(LLRC, Site, RCT, Level, Value, Organisation, `Sub-sector`, Region, Region2, `Generic/Nuclear`, STEM_Status) %>% 
  expand(Year = startYear:endYear) %>%
  mutate(Value= if_else(is.na(Value), 0, Value))
  
#supply_expanded$SupplyDemand <- "Supply"

demandStatus <- unique(select(demandBind, Site, Year, Status))
supply_status <- left_join(supply_expanded, demandStatus)

write_csv(demandBind, "./data/demandBind.csv")
write_csv(supply_status, "./data/supply_status.csv")


AnnRecFnc<-function(demand, supply, rate_short, redeployment_coeff){
  
  rate_short_comp = 1 - rate_short/100
  annualRecruitment <- 0
  extSupply <-0
  totalSupply <-0
  
  if (demand[1]>supply[1]) {
    annualRecruitment[1] = demand[1]-supply[1]
  } else {
    annualRecruitment[1] = 0
  }
  
  for(i in seq_along(demand)) {
    if (i>1) {
      extSupply = cumsum(annualRecruitment)
      totalSupply[i] = (supply[i] * redeployment_coeff) + extSupply[i-1] * rate_short_comp^i
      annualRecruitment[i] = demand[i]-totalSupply[i]
      
      if (annualRecruitment[i]<0) {
        annualRecruitment[i]=0
      }
    }
  }
  # returnList <- list(annualRecruitment, totalSupply)
  return(annualRecruitment)
}

calcAnnualRecruitment <- function(df_wide, rate_short=1, redeployment_coeff = 1, groupList) {
  
  #df_wide <- pivot_wider(df_narrow, names_from = "SupplyDemand", values_from = Value, values_fill = 0)
  
  df_out<- df_wide %>%
      group_by(Site, Level, LLRC) %>%
    mutate(annualRecruitment = AnnRecFnc(Demand, Supply, rate_short, redeployment_coeff)) %>%
    as.data.frame()
  
  return(df_out)
}


demandBind_file <- read_csv("./data/demandBind.csv")
supply_status_file <- read_csv("./data/supply_status.csv")

startYear <- min(demandBind_file$Year)
#endYear <- max(demandBind$Year)


# supply_df <- supply_status %>%
#   arrange(Year) %>%
#   mutate(attrition = ifelse(Year == startYear, 1, compRate)) %>%
#   mutate(cumattrition = cumprod(attrition)) %>% 
#   mutate(Value = Value * cumattrition) %>%
#   select(-attrition, -cumattrition) %>%
#   arrange(Site) %>%
#   as.data.frame()


demand <- demandBind_file %>%
  group_by(Year, Level, Site, LLRC, RCT, `Sub-sector`, Organisation, Region) %>%
  summarise(Value = sum(Value)) %>%
  arrange(Site, LLRC, Level, Year) %>%
  ungroup()

# demand <- demand %>%
#   filter(Site == "Sellafield Limited" & LLRC == "Mechanical Engineers")


supply <- supply_status_file %>%
 group_by(Year, Level,  Site, LLRC, RCT, `Sub-sector`, Organisation, Region) %>%
  summarise(Value = sum(Value)) %>%
  arrange(Site, LLRC, Level, Year) %>%
  ungroup()

# supply <- supply %>%
#   filter(Site ==  "Sellafield Limited" & LLRC == "Mechanical Engineers")

# temp <- rbind(demand, supply) %>%
#   arrange(Site, LLRC, Level, SupplyDemand, Year) %>%
#   group_by(Site, LLRC, Level, SupplyDemand)
# 
# 
# data_df <- calcAnnualRecruitment(temp, rate_short = 0, redeployment_coeff = 1, groupList) %>%
#   filter(Year > startYear)

demand_w <- demand %>%
 # select(-SupplyDemand) %>%
  dplyr::rename(Demand = Value)

supply_w <- supply %>%
 # select(-SupplyDemand) %>%
  dplyr::rename(Supply_current = Value)

temp2 <- left_join(demand_w, supply_w, by = c("Year", "Site", "Level", "LLRC", "RCT", "Sub-sector", "Organisation", "Region"))

 global_start_time = Sys.time()
 
 rate <- 7.5
compRate = 1-rate/100

temp2 <- temp2 %>%
  group_by(LLRC, Site,  Level) %>% 
  mutate(attrition = ifelse(Year == startYear, 1, compRate)) %>%
  mutate(cumattrition = cumprod(attrition)) %>% 
  mutate(Supply = Supply_current * cumattrition) %>%
 # select(-attrition, -cumattrition) %>%
  arrange(Site, LLRC, Level, Year) %>%
  as.data.frame()

data_df <- calcAnnualRecruitment(temp2, rate_short = 0, redeployment_coeff = 1, groupList) %>%
  filter(Year > startYear)

global_end_time = Sys.time()

print(global_end_time - global_start_time)

p <- ggplot(data = data_df, aes(x=Year, y=annualRecruitment, fill = RCT)) + geom_bar(stat = "identity") +
 #stat_summary(aes(x= Year, y=Demand, group = 1, color = SupplyDemand), fun = "sum", colour = 'black', geom = 'line') +
 #stat_summary(aes(x= Year, y=Supply, group = 1, color = SupplyDemand), fun = "sum", colour = 'black', geom = 'line') +
 # scale_fill_manual(values = nssg_palette) +
#  facet_wrap(vars(RCT), labeller = labeller(RCT = RCTLabels2), scales='free_y', ncol = 3) +
  theme(legend.position = "none", 
        strip.text = element_text(size = 10), 
        axis.text = element_text(size = 10)) + ylab("Workforce /FTE") #+ ylim(0,6000) 
  #coord_cartesian(xlim = year_limits, ylim = c(0, y_max))
plot(p)

# df <- temp %>%
#   group_by(Year, SupplyDemand) %>%
#   summarise(Value = sum(Value)) %>%
#   arrange(SupplyDemand)
# 
# p <- ggplot(data = df, aes(x=Year, y=Value, fill = SupplyDemand)) + geom_line() +
#   # scale_fill_manual(values = nssg_palette) +
#   #  facet_wrap(vars(RCT), labeller = labeller(RCT = RCTLabels2), scales='free_y', ncol = 3) +
#   theme(legend.position = "none", 
#         strip.text = element_text(size = 10), 
#         axis.text = element_text(size = 10)) + ylab("Workforce /FTE") #+ ylim(0,6000) 
# #coord_cartesian(xlim = year_limits, ylim = c(0, y_max))
# plot(p)

 
