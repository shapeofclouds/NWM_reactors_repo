##Level Main Bar####
output$levelPlot <- renderPlot({validate(
  need(nrow(level_plot())>0, "No data to show for these selections")
)
  if(input$percent_level == "Percentage") {
    percentFlag = TRUE
  } else {
    percentFlag = FALSE
  }
  
  plotMainBar(df_abs = level_plot(), 
              df_perc = level_plot(), 
              x="Level", 
              xLables = levelLabelsOffset,
              percentFlag = percentFlag,
              fillCol = "darkgreen", 
              abLabel = "Workforce/FTEs", 
              percLabel = "Percentage of total", 
              plotTitle = "Level") +
    bar_theme
})

level_summary <- reactive ({level_plot() %>%
    group_by(Level) %>%
    summarise(value = sum(value))}) 


output$levelTable <- renderDT({DT::datatable(level_summary(), options = list(dom = 't'), rownames= FALSE) %>%
    formatRound(columns = 2, digits = 0)
    })

##Level STEM####
output$levelPlot_STEM <- renderPlot({
  validate(
    need(nrow(level_plot_STEM())>0, "No data to show for these selections")
  )
  
  plotFacetBar(df = level_plot_STEM(), 
               x="Level", 
               ncol=2, 
               xLables = levelLabelsOffsetAlt, 
               fillCol = blue, 
               yLabel="Workforce/FTEs",
               facetVar = "STEM_Status") +
    bar_theme_facet1
})



##Level Function####
output$levelPlot_RCT <- renderPlot({
  
  validate(
    need(nrow(level_plot_RCT())>0, "No data to show for these selections")
  )
  
  plotFacetBar(df = level_plot_RCT(), 
               x="Level", 
               ncol=3, 
               xLables = levelLabelsOffsetAlt, 
               fillCol = NULL, 
               yLabel="Workforce/FTEs",
               facetVar = "Function") +
    bar_theme_facet1 
  
})