level.df <- Level_long
temp <- level.df
temp$Year <- firstYear

for (i in startYear:endYear) {
  
  level.df$Year <- i
  temp <- rbind(temp,level.df)
  
} 
supply.df <- temp %>%
  filter(Level != "SME") %>%
  group_by(Year, Low.Level.Resource.Code, Site, Function, Organisation, 
           `Sub-sector`, Region, STEM_Status, Level) %>%
  summarise(value = sum(value))
  
message("Finished Supply formation")