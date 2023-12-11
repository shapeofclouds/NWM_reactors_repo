observe({
  if (input$status_check > 0) {
    if (input$status_check %% 2 == 0){
      updateCheckboxGroupInput(session=session, 
                               inputId="status_category",
                               choices = Status_list,
                               selected = Status_list)
      
    } else {
      updateCheckboxGroupInput(session=session, 
                               inputId="status_category",
                               choices = Status_list,
                               selected = c())
      
    }}
})