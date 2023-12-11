##AnnRecFnc - Calculation Annual Recruitment ####
AnnRecFnc<-function(demand, supply, redeployment_coeff, compRate, compRateSupply, attrition_rate_comp, useAttritionFile){
  
  annualRecruitment <- 0
  extSupply <-0
  totalSupply <-0
  
  if (demand[1]>supply[1]) {
    annualRecruitment[1] = demand[1]-supply[1]
  } else 
    {
    annualRecruitment[1] = 0
    }
  
  for(i in seq_along(demand)) 
  {
    if (i>1) 
      {
      extSupply <- annualRecruitment 
      
      if(useAttritionFile == TRUE) {
      
        supply[i] <- (supply[i-1] * attrition_rate_comp[i] + extSupply[i-1] * redeployment_coeff * compRateSupply) 
      
      } else {
      supply[i] <- (supply[i-1] * compRate + extSupply[i-1] * redeployment_coeff * compRateSupply) 
      }
      
      annualRecruitment[i] <- demand[i]-supply[i] 
      
      if (annualRecruitment[i]<0) 
        {
        annualRecruitment[i]=0
        }
      }
    }
  
  return(annualRecruitment)
}