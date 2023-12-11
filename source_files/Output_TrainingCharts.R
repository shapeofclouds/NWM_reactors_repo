output$trainingPlot <- renderPlot({validate(
  need(nrow(training_plot())>0, "No data to show for these selections")
)
  if(input$percent_training == "Percentage") {
    percentFlag = TRUE
  } else {
    percentFlag = FALSE
  }
  
  plotMainBar(df_abs = training_plot(), 
              df_perc = training_plot(), 
              x="Level", 
              xLables = trainingLevels,
              percentFlag = percentFlag,
              fillCol = "darkblue", 
              abLabel = "Workforce/FTEs", 
              percLabel = "Percentage of total", 
              plotTitle = "Training") +
    bar_theme
})