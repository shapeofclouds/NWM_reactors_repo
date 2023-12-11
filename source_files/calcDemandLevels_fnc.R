levelNames <- c("Level1" = "Level.1", 
                "Level2" = "Level.2", 
                "Level3" = "Level.3", 
                "Level4" = "Level.4", 
                "Level5" = "Level.5", 
                "Level6" = "Level.6", 
                "Level7" = "Level.7", 
                "Level8" = "Level.8", 
                "SME" = "SME")

Sites <- as.data.frame(unique(Level_long$Site))

levelAve <- Level_long %>%
  filter(Level != "SME") %>%
  group_by(Site, Low.Level.Resource.Code, Level) %>%
  summarise(LevelAbsSites=sum(value), .groups="drop_last") %>%
  group_by(Site, Low.Level.Resource.Code) %>%
  mutate(LevelTotalSites = sum(LevelAbsSites)) %>%
  mutate(LevelFrac=LevelAbsSites/LevelTotalSites) %>%
  group_by(Low.Level.Resource.Code, Level) %>% #use general average for cases where data doesn't exist for a particular site
  mutate(LevelAbsAll = sum(LevelAbsSites)) %>%
  group_by(Low.Level.Resource.Code, Level) %>%
  mutate(LevelTotalAll = sum(LevelTotalSites)) %>%
  mutate(LevelFracAll=LevelAbsAll/LevelTotalAll) %>%
  as.data.frame()

is.nan.data.frame <- function(x)
  do.call(cbind, lapply(x, is.nan))
levelAve[is.nan(levelAve)] <- 0


expDemand <- Demand %>%
  group_by(Low.Level.Resource.Code, Site, Status, Year, value, Organisation, Function, `Sub-sector`, Region) %>% 
  expand(Level = c("Level.1", 
                   "Level.2", 
                   "Level.3", 
                   "Level.4", 
                   "Level.5", 
                   "Level.6", 
                   "Level.7", 
                   "Level.8"))

demandLevel <- left_join(expDemand, levelAve)

demandLevel <- demandLevel %>%
  mutate(LevelAbsSites = ifelse(is.na(LevelAbsSites), 0, LevelAbsSites)) %>%
  mutate(LevelTotalSites = ifelse(is.na(LevelTotalSites), 0, LevelTotalSites)) %>%
  mutate(LevelFrac = ifelse(is.na(LevelFrac), 0, LevelFrac)) %>%
  mutate(LevelAbsAll = ifelse(is.na(LevelAbsAll), 0, LevelAbsAll)) %>%
  mutate(LevelTotalAll = ifelse(is.na(LevelTotalAll), 0, LevelTotalAll)) %>%
  mutate(LevelFracAll = ifelse(is.na(LevelFracAll), 0, LevelFracAll))

#demandLevel[is.na(demandLevel)] = 0
demandLevel <- demandLevel %>%
  group_by(Low.Level.Resource.Code, Site, Year) %>%
  mutate(flag =  sum(LevelFrac)) %>%
  mutate(ValueLevel = ifelse(flag==1, (value * LevelFrac), (value * LevelFracAll))) %>%
  as.data.frame()

demandLevel <- select(demandLevel,Site, Year, Low.Level.Resource.Code, Function, Level, Organisation,`Sub-sector`, Region, ValueLevel, Status) %>%
  dplyr::rename(any_of(levelNames))
