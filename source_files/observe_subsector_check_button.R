observe({
  if (input$subsector_check > 0) {
    if (input$subsector_check %% 2 == 0){
      updateCheckboxGroupInput(session=session, 
                               inputId="subsector_category",
                               choices = Subsector_list,
                               selected = Subsector_list)
      
    } else {
      updateCheckboxGroupInput(session=session, 
                               inputId="subsector_category",
                               choices = Subsector_list,
                               selected = c())
      
    }}
})