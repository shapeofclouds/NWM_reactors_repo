observe({
  if (input$organisation_check > 0) {
    if (input$organisation_check %% 2 == 0){
      updateCheckboxGroupInput(session=session, 
                               inputId="organisation_category",
                               choices = OrganisationOrder,
                               selected = OrganisationOrder)
      
    } else {
      updateCheckboxGroupInput(session=session, 
                               inputId="organisation_category",
                               choices = OrganisationOrder,
                               selected = c())
      
    }}
})