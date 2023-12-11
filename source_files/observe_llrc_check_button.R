observe({
  if (input$llrc_check > 0) {
    if (input$llrc_check %% 2 == 0){
      updateCheckboxGroupInput(session=session, 
                               inputId="llrc_category",
                               choices = LLRC_list,
                               selected = LLRC_list)
      
    } else {
      updateCheckboxGroupInput(session=session, 
                               inputId="llrc_category",
                               choices = LLRC_list,
                               selected = c())
      
    }}
})