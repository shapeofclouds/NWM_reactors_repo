##Level filter and Summation####
LevelData <- Level_long %>%
  mutate(value = if_else(is.na(value), 0, value))

level_region <- reactive ({seriesFilter(LevelData, 
                                        llrc_sel = input$llrc_level, 
                                        gender_sel = input$gender_level, 
                                        sector_sel = input$sector_level, 
                                        region_sel = input$region_level,
                                        function_sel = input$function_level,
                                        organisation_sel = input$organisation_level,
                                        code_type = "Low.Level.Resource.Code")})

levelData_summed <- reactive({ 
  level_region() %>%
    summarise(value = sum(value), .by = c(Level, GrandTotal, Function, STEM_Status)) %>%
    mutate(value_perc = value/GrandTotal)
})

level_plot <- reactive({  #Summarise all
  levelData_summed() %>%
    summarise(value = sum(value), .by = c(Level, GrandTotal, value_perc, value))
})

level_plot_RCT <- reactive({ #Summarise but preserve RCT
  levelData_summed() %>%
    summarise(value = sum(value), .by = c(Level, GrandTotal, value_perc, Function, value))
})

#  reactive({glimpse(level_plot_RCT_STEM_Status)})
level_plot_STEM <- reactive({ #Summarise but preserve STEM
  levelData_summed() %>%
    summarise(value = sum(value), .by = c(Level, GrandTotal, value_perc, STEM_Status, value))
})