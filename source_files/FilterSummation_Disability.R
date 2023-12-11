##Disability Filter and Summation####
#  
source("./source_files/SeriesFilter.R", local = TRUE)


disability_region <- reactive ({
  
  EDI_char <- EDI_long %>%
    filter(CharacteristicGroup == "Disability") #this could be exported to SeriesFilter
  
  seriesFilter(EDI_char, 
              llrc_sel = "All", #EDI not currently segmented by LLRC
              gender_sel="All",
              sector_sel = "All", #input$sector_edi, 
              region_sel = "All") #input$region_edi)
  })


disability_plot <- reactive({ 
   disability_region() %>%
    summarise(value = sum(NumberInGroup), .by = c(Characteristic, GrandTotal)) %>%
    mutate(value_perc = value/sum(value)) %>%
    mutate(Characteristic = reorder(Characteristic, -value))
  
  
  
})

 # edi_plot <- reactive({  #Summarise all
 #   ediData_summed() %>%
 #     summarise(value = sum(value), .by = c(Characteristic, GrandTotal, value_perc, value))
 # })
# 
# edi_plot_RCT <- reactive({ #Summarise but preserve RCT
#   ediData_summed() %>%
#     summarise(value = sum(value), .by = c(edi, GrandTotal, value_perc, RCT, value))
# })
# 
# #  reactive({glimpse(edi_plot_RCT_STEM_Status)})
# edi_plot_STEM <- reactive({ #Summarise but preserve STEM
#   ediData_summed() %>%
#     summarise(value = sum(value), .by = c(edi, GrandTotal, value_perc, STEM_Status, value))
# })