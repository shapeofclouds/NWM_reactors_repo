
##dataGroupFilter####
if(input$dataGroupFilter == "LLRC") {
  temp <- temp %>%
    filter(LLRC %in% input$llrc_category)
  
} else if (input$dataGroupFilter == "HLRC") {
  temp <- temp %>%
    filter(HLRC %in% input$hlrc_category)
  
} else if (input$dataGroupFilter == "Function") {
  temp <- temp %>%
    filter(Function %in% input$function_category)
  
} else if (input$dataGroupFilter == "Region") {
  temp <- temp %>%
    filter(Region %in% input$region_category)
  
} else if (input$dataGroupFilter == "Status") {
  temp <- temp %>%
    filter(Status %in% input$status_category)
  
} else if (input$dataGroupFilter == "Sub-sector") {
  temp <- temp %>%
    filter(`Sub-sector` %in% input$subsector_category)
  
} else if (input$dataGroupFilter == "Sector") {
  temp <- temp %>%
    filter(Sector %in% input$sector_category)
  
} else if (input$dataGroupFilter == "Site") {
  temp <- temp %>%
    filter(Site %in% input$site_category)
  
} else if (input$dataGroupFilter == "Organisation") {
  temp <- temp %>%
    filter(Organisation %in% input$organisation_category)
  
} else if (input$dataGroupFilter == "None") {
  temp <- temp 
} 
  ##dataGroupFilter2####
  
  if(input$dataGroupFilter2 == "LLRC") {
    temp <- temp %>%
      filter(LLRC %in% input$llrc_category)
    
  } else if (input$dataGroupFilter2 == "HLRC") {
    temp <- temp %>%
      filter(HLRC %in% input$hlrc_category)
    
  } else if (input$dataGroupFilter2 == "Function") {
    temp <- temp %>%
      filter(Function %in% input$function_category)
    
  } else if (input$dataGroupFilter2 == "Region") {
    temp <- temp %>%
      filter(Region %in% input$region_category)
    
  } else if (input$dataGroupFilter2 == "Status") {
    temp <- temp %>%
      filter(Status %in% input$status_category)
    
  } else if (input$dataGroupFilter2 == "Sub-sector") {
    temp <- temp %>%
      filter(`Sub-sector` %in% input$subsector_category)
    
  } else if (input$dataGroupFilter2 == "Sector") {
    temp <- temp %>%
      filter(Sector %in% input$sector_category)
    
  } else if (input$dataGroupFilter2 == "Site") {
    temp <- temp %>%
      filter(Site %in% input$site_category)
    
  } else if (input$dataGroupFilter2 == "Organisation") {
    temp <- temp %>%
      filter(Organisation %in% input$organisation_category)
    
  } else if (input$dataGroupFilter2 == "None") {
    temp <- temp 
  
} else {temp} 