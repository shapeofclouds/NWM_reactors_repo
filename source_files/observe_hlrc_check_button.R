observe({
  if (input$hlrc_check > 0) {
    if (input$hlrc_check %% 2 == 0){
      updateCheckboxGroupInput(session=session, 
                               inputId="hlrc_category",
                               choices = HLRC_list,
                               selected = HLRC_list)
      
    } else {
      updateCheckboxGroupInput(session=session, 
                               inputId="hlrc_category",
                               choices = HLRC_list,
                               selected = c())
      
    }}
})