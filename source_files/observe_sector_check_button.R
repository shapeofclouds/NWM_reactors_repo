observe({
  if (input$sector_check > 0) {
    if (input$sector_check %% 2 == 0){
      updateCheckboxGroupInput(session=session, 
                               inputId="sector_category",
                               choices = Sector_list,
                               selected = Sector_list)
      
    } else {
      updateCheckboxGroupInput(session=session, 
                               inputId="sector_category",
                               choices = Sector_list,
                               selected = c())
      
    }}
})