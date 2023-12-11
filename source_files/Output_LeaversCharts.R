##leavers Main Bar####
output$leaversPlot <- renderPlot({validate(
  need(nrow(levelLeavers_plot())>0, "No data to show for these selections")
)
  if(input$percent_leavers == "Percentage") {
    percentFlag = TRUE
  } else {
    percentFlag = FALSE
  }
  
  plotMainBar(df_abs = levelLeavers_plot(), 
              df_perc = levelLeavers_plot(), 
              x="Level", 
              xLables = levelLabelsOffset,
              percentFlag = percentFlag,
              fillCol = "darkred", 
              abLabel = "Workforce/FTEs", 
              percLabel = "Percentage of total", 
              plotTitle = "Leavers Level") +
    bar_theme
})

##leavers STEM####
output$leaversPlot_STEM <- renderPlot({
  validate(
    need(nrow(levelLeavers_plot_STEM())>0, "No data to show for these selections")
  )
  
  plotFacetBar(df = levelLeavers_plot_STEM(), 
               x="Level", 
               ncol=2, 
               xLables = levelLabelsOffsetAlt, 
               fillCol = blue, 
               yLabel="Workforce/FTEs",
               facetVar = "STEM_Status") +
    bar_theme_facet1
})

##leavers Function####
output$leaversPlot_RCT <- renderPlot({
  
  validate(
    need(nrow(levelLeavers_plot_RCT())>0, "No data to show for these selections")
  )
  
  plotFacetBar(df = levelLeavers_plot_RCT(), 
               x="Level", 
               ncol=3, 
               xLables = levelLabelsOffsetAlt, 
               fillCol = NULL, 
               yLabel="Workforce/FTEs",
               facetVar = "Function") +
    bar_theme_facet1 
  
})