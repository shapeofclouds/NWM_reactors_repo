##Training Filter and Summation####

TrainingData <- Trainees_long %>%
  dplyr::rename(value = Trainees)

#write_csv(TrainingData, "./data/training_long.csv")

training_region <- reactive ({seriesFilter(TrainingData,
                                           llrc_sel = input$llrc_training,
                                           gender_sel = input$gender_training,
                                           sector_sel = input$sector_training,
                                           region_sel = input$region_training, code_type = "Qualification")})

trainingData_summed <- reactive({
  training_region() %>%
    summarise(value = sum(value), .by = c(Level, Qualification, GrandTotal)) %>%
    mutate(value_perc = value/GrandTotal)
})

training_plot <- reactive({  #Summarise all
  trainingData_summed() %>%
    summarise(value = sum(value), .by = c(Level, Qualification, GrandTotal, value_perc, value))
})

training_plot_RCT <- reactive({ #Summarise but preserve RCT
  trainingData_summed() %>%
    summarise(value = sum(value), .by = c(Level, GrandTotal, value_perc, `Sub-sector`, value))
})

#  reactive({glimpse(level_plot_RCT_STEM_Status)})
training_plot_STEM <- reactive({ #Summarise but preserve STEM
  trainingData_summed() %>%
    summarise(value = sum(value), .by = c(Level, GrandTotal, value_perc, STEM_status, value))
})
