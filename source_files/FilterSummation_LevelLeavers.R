##Level Leavers filter and Summation####
Leavers_Level_long <- Leavers_Level_long %>%
  mutate(value = if_else(is.na(value), 0, value))

levelLeavers_region <- reactive ({seriesFilter(Leavers_Level_long, 
                                        llrc_sel = input$llrc_levelLeavers, 
                                        gender_sel = input$gender_levelLeavers, 
                                        sector_sel = input$sector_levelLeavers, 
                                        region_sel = input$region_levelLeavers)})

#write_csv(Leavers_Level_long, "./LLL.csv")

levelLeaversData_summed <- reactive({ 
  levelLeavers_region() %>%
    summarise(value = sum(value), .by = c(Level, GrandTotal, Function, STEM_Status)) %>%
    mutate(value_perc = value/GrandTotal)
})

levelLeavers_plot <- reactive({  #Summarise all
  levelLeaversData_summed() %>%
    summarise(value = sum(value), .by = c(Level, GrandTotal, value_perc, value))
})

levelLeavers_plot_RCT <- reactive({ #Summarise but preserve RCT
  levelLeaversData_summed() %>%
    summarise(value = sum(value), .by = c(Level, GrandTotal, value_perc, Function, value))
})

levelLeavers_plot_STEM <- reactive({ #Summarise but preserve STEM
  levelLeaversData_summed() %>%
    summarise(value = sum(value), .by = c(Level, GrandTotal, value_perc, STEM_Status, value))
})