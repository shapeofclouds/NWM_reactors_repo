output$vacanciesPlot <- renderPlot({validate(
  need(nrow(vacancies_plot())>0, "No data to show for these selections")
)
  if(input$percent_vacancies == "Percentage") {
    percentFlag = TRUE
  } else {
    percentFlag = FALSE
  }
  
  plotMainBar(df_abs = vacancies_plot(), 
              df_perc = vacancies_plot(), 
              x="Level", 
              xLables = levelLabelsOffset,
              percentFlag = percentFlag,
              fillCol = "darkblue", 
              abLabel = "Workforce/FTEs", 
              percLabel = "Percentage of total", 
              plotTitle = "Vacancies") +
    bar_theme
})

output$vacanciesPlot_stacked <- renderPlot({validate(
  need(nrow(vacancies_plot_time_open())>0, "No data to show for these selections")
)
  if(input$percent_vacancies == "Percentage") {
    percentFlag = TRUE
  } else {
    percentFlag = FALSE
  }
  
  plotMainBar(df_abs = vacancies_plot_time_open(), 
              df_perc = vacancies_plot_time_open(), 
              x="Level", 
              xLables = levelLabelsOffset,
              percentFlag = percentFlag,
              fillCol = c("darkblue", "darkgreen"), 
              abLabel = "Workforce/FTEs", 
              percLabel = "Percentage of total", 
              plotTitle = "Vacancies",
              fill_var = "Time_open",
              stack = TRUE) +
    bar_theme
})

output$vacanciesPlot_ratio <- renderPlot({validate(
  need(nrow(vacancies_plot_long_to_short())>0, "No data to show for these selections")
)
  
  plotMainBar(df_abs = vacancies_plot_long_to_short(), 
              df_perc = vacancies_plot_long_to_short(), 
              x="Level", 
              xLables = levelLabelsOffset,
              percentFlag = TRUE,
              fillCol = "darkslategrey", 
              abLabel = "Workforce/FTEs", 
              percLabel = "Percentage open gtr 6 months", 
              plotTitle = "Long to Short Vacancies",
              fill_var = "",
              stack = FALSE) +
    bar_theme
})
