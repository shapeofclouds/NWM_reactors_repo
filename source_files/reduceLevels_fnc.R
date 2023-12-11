reduceLevels <- function(inputData) {
  outputData <- inputData %>%
    # a row number needs to be introduced to avoid a duplication problem 
    #that results in Levelx variables being produced as lists which can't be added
    group_by(LLRC, Site, Year, Level) %>%
    mutate(row = row_number()) %>%
    
    pivot_wider(names_from = Level, values_from = Value) %>%
    mutate(L12 = Level1+Level2) %>%
    mutate(L34 = Level3+Level4) %>%
    mutate(L56 = Level5+Level6) %>%
    mutate(L78 = Level7+Level8) %>%
    select(-(Level1:Level8), -row) %>%
    pivot_longer(L12:L78, names_to = "Level", values_to = "Value") %>%
    as.data.frame()
  
  return(outputData)
  
}