observe({
  if (input$region_check > 0) {
    if (input$region_check %% 2 == 0){
      updateCheckboxGroupInput(session=session, 
                               inputId="region_category",
                               choices = Region_list,
                               selected = Region_list)
      
    } else {
      updateCheckboxGroupInput(session=session, 
                               inputId="region_category",
                               choices = Region_list,
                               selected = c())
      
    }}
})