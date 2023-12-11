observe({
  if (input$site_check > 0) {
    if (input$site_check %% 2 == 0){
      updateCheckboxGroupInput(session=session, 
                               inputId="site_category",
                               choices = Site_list,
                               selected = Site_list)
      
    } else {
      updateCheckboxGroupInput(session=session, 
                               inputId="site_category",
                               choices = Site_list,
                               selected = c())
      
    }}
})