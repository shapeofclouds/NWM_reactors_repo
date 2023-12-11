observe({
  if (input$function_check > 0) {
    if (input$function_check %% 2 == 0){
      updateCheckboxGroupInput(session=session, 
                               inputId="function_category",
                               choices = Function_list,
                               selected = Function_list)
      
    } else {
      updateCheckboxGroupInput(session=session, 
                               inputId="function_category",
                               choices = Function_list,
                               selected = c())
      
    }}
})