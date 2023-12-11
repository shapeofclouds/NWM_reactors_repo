##edi Main Bar####

output$ediPlot <- renderPlot({validate(
  need(nrow(edi_plot())>0, "No data to show for these selections")
)
  if(input$percent_edi == "Percentage") {
    percentFlag = TRUE
  } else {
    percentFlag = FALSE
  }
  
  plotMainBar(df_abs = edi_plot(), 
              df_perc = edi_plot(), 
              x="Characteristic", 
              xLables = ageLabelsOffset,
              percentFlag = percentFlag,
              fillCol = "darkblue", 
              abLabel = "Headcount", 
              percLabel = "Percentage of total", 
              plotTitle = "EDI") +
    bar_theme
})


##Age STEM ####
# output$agePlot_STEM <- renderPlot({
#   validate(
#     need(nrow(age_plot_STEM())>0, "No data to show for these selections")
#   )
#   
#   
#   plotFacetBar(df = age_plot_STEM(), 
#                x="Age", 
#                ncol=2, 
#                xLables = ageLabelsOffsetAlt, 
#                fillCol = gold, 
#                yLabel="Workforce/FTEs",
#                facetVar = "STEM_Status") + #can be NULL for single plot
#     bar_theme_facet1
# })
# 
# ##Age Functions####
# output$agePlot_RCT <- renderPlot({
#   
#   validate(
#     need(nrow(age_plot_RCT())>0, "No data to show for these selections")
#   )
#   
#   plotFacetBar(df = age_plot_RCT(), 
#                x="Age", 
#                ncol=3, 
#                xLables = ageLabelsOffsetAlt, 
#                fillCol = NULL, # NULL uses colour scale against facetVar
#                yLabel="Workforce/FTEs",
#                facetVar = "RCT") + #can be NULL for single plot
#     bar_theme_facet1
  # ggplot(age_plot_RCT(), aes(x=Age, y=Value, fill=RCT) ) + geom_bar(stat = "identity") +
  #   facet_wrap(~RCT, scales='free_y', ncol = 3) +
  #   scale_x_discrete(labels = ageLabelsOffset) + bar_theme_facet2 +
  #   ylab("Workforce/FTEs")
#})