##Current Age Filter and Summation####
#  AgeData <- Age_long


AgeData <- Age_long %>%
  dplyr::rename(Age = Age.Band) %>%
  mutate(value = if_else(is.na(value), 0, value))

age_region <- reactive ({seriesFilter(AgeData, 
                                      llrc_sel = input$llrc_age, 
                                      gender_sel = input$gender_age, 
                                      sector_sel = input$sector_age, 
                                      region_sel = input$region_age,
                                      code_type = "Low.Level.Resource.Code")})


AgeData_summed <- reactive({ 
  age_region() %>%
    summarise(value = sum(value), .by = c(Age, GrandTotal, Function, STEM_Status)) 
  
})

age_plot <- reactive({  #Summarise all
  AgeData_summed() %>%
    summarise(value = sum(value), .by = c(Age, GrandTotal,  value)) %>%
    mutate(value_perc = value/GrandTotal)
  
})

age_plot_RCT <- reactive({ #Summarise but preserve RCT
  AgeData_summed() %>%
    summarise(value = sum(value), .by = c(Age, GrandTotal,  Function, value)) %>%
    mutate(value_perc = value/GrandTotal)
})

#  reactive({glimpse(age_plot_RCT_STEM_Status)})
age_plot_STEM <- reactive({ #Summarise but preserve STEM
  AgeData_summed() %>%
    summarise(value = sum(value), .by = c(Age, GrandTotal,  STEM_Status, value)) %>%
    mutate(value_perc = value/GrandTotal)
})