##calcScenarioDemand####
calcScenarioDemand <- function(timeLine) 
{
  
  startList <- unlist(select(timeLine, Start)) # select allows units to be excluded  
  reactorTypes <- unlist(select(timeLine, Type))
  region <- unlist(select(timeLine, Region))
  
  numReactors = length(startList)
  
  globalMin = min(unlist(startList))
  
  reactorList <- vector("list", numReactors) #initialise reactorList
  
 # browser()
  
  i <- 1
  while(i <= numReactors)
    {
    unit_id <- paste0("unit",i)
    
    df <- get(reactorTypes[i]) %>% # get the unit reactor dataframes
      mutate(Unit = unit_id, Type = reactorTypes[i], Region = region[i])
  
    reactorList[[i]] <- df
    #    print(reactorList[i])
    i <- i + 1
    

    
    }
  
  NA_replacement = list(role1=0, role2=0, role3=0, role4=0, role5=0, 
                        role6=0, role7=0, role8=0, role9=0, role10=0, 
                        role11=0, role12=0, role13=0, role14=0, role15=0, 
                        Status="Construction")
  
  columnNames <- c("Year_source", "time", "role1", "role2", "role3", "role4", "role5", 
                   "role6", "role7", "role8", "role9", "role10", 
                   "role11", "role12", "role13", "role14", "role15", 
                   "Status", "Unit", "Type")
  
  #create separate time vector to be offset by start date
  times <- lapply(reactorList, function(x) x[1]) 
  
  #function to turn months to fraction of a year and add offset
  offset <- function(a, b) 
    { 
    setNames(a/12 + b, "Year_source")
    }
  
  #add each element of the start list to every time element of every reactor dataframe
  offsetTimes <- map2(times,  startList, offset)
  
  endDates <- vector("list", numReactors)
  j=1
  for(u in offsetTimes) {
    endDates[j] <- max(u)
    j=j+1
  }
  #globalEnd <- max(unlist(endDates))
  globalEnd <- 2055 #overriding
  
  #re-attache time vector to each reactor dataframe 
  reactorList <- map2(offsetTimes, reactorList, cbind) 
  
  addTo <- function(x, ...) {

    localEnd <- max(x$Year_source) 
    timeInc <- as.numeric((x[nrow(x),1] - x[nrow(x)-1,1]))

    numRowsToAdd <- (globalEnd+1-localEnd)/timeInc

    rowToAdd <- data.frame(x[nrow(x), ])
    
    df = data.frame()
    for(j in 1:numRowsToAdd) 
      {
      rowToAdd$Year_source <- rowToAdd$Year_source + timeInc
      df = data.frame(bind_rows(df,rowToAdd))
      } 
    
    return(df)
  }
  
  extendOps <- function(x){
    
    df <- x %>%
      group_by(Level) %>%
      group_modify(addTo) 
    
    x <- bind_rows(x,df)
    
    return(x)
  }
  
  #message(reactorList)
  #print(reactorList)
  reactorList <- lapply(reactorList, extendOps)
  
  #form single reactor dataframe concatenated from individual instances
  NNB <- as.data.frame(do.call(rbind, reactorList))
  NNB <- select(NNB, -time) 
  NNB <- select(NNB, Year_source, Level, Unit, Type, Region, Status, everything())
  
  # message("NNB dataframe")
  # print(NNB)
  # write_csv(NNB, "./NNB.csv")
  
  #ensure that all the units cover the whole time range
  NNB <- NNB %>%
    complete(Year_source, Unit, Level, Type, Region, fill = NA_replacement) %>%
    mutate(Year_source = round(Year_source, digits = 3)) %>% # needed so that years don't misalign due to rounding differences
    pivot_longer(cols = 7:ncol(.), names_to ="Role", values_to = "value")
  
  #write_csv(NNB, "./NNB_longer.csv")

  message("NNB dataframe")
  if (nrow(NNB) == 0) 
    {
    message("empty dataframe")
    }
  
  return(NNB)
  
}