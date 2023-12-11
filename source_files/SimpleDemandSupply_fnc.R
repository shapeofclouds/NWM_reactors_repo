SimpleDemandSupply <- function(demand, supply, r) {
  ##Function to create current workforce forward projection
  #supply <- 0
  #supply[1]=demand[1]
  
  for(i in seq_along(demand)) {
    if (i>1) {
      supply[i] = supply[i-1] * (1-r)
    }
  }
  return(supply)
}