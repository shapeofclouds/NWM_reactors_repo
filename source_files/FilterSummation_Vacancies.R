##Vacancies Filter and Summation####

VacanciesData <- Vacancies_long 
CurrentData <- Level_long

write_csv(VacanciesData, "./data/Vacancies_long.csv")

vacancies_region <- reactive ({seriesFilter(VacanciesData,
                                           llrc_sel = input$llrc_vacancies,
                                           gender_sel = "All",
                                           sector_sel = input$sector_vacancies,
                                           region_sel = input$region_vacancies, 
                                           organisation_sel = input$organisation_vacancies,
                                           site_sel = input$site_vacancies,
                                           code_type = "Low.Level.Resource.Code")})

current_region <- reactive ({seriesFilter(CurrentData,
                                          llrc_sel = input$llrc_vacancies,
                                          gender_sel = "All",
                                          sector_sel = input$sector_vacancies,
                                          region_sel = input$region_vacancies, 
                                          organisation_sel = input$organisation_vacancies,
                                          site_sel = input$site_vacancies,
                                          code_type = "Low.Level.Resource.Code")})

current_vacancies_matched <- reactive({
  
  current_match <- current_region() %>%
    group_by(Site, Low.Level.Resource.Code, Level) %>%
    summarise(value = sum(value))
  
  vacancies_match <- vacancies_region() %>%
    group_by(Site, Low.Level.Resource.Code, Level) %>%
    summarise(value = sum(value)) #combine long and short vacancies

  current_vacancies_matched <- left_join(vacancies_match, current_match, by = c("Site","Low.Level.Resource.Code","Level")) #%>%
   
})

vacancy_fraction <- reactive({
  
  current_vacancies_matched() %>%
  group_by(Level) %>%
  mutate(value.x = sum(value.x), value.y = sum(value.y)) %>%
  mutate(value_fraction = value.x/value.y)
  
})

message("Vacancies Region") 


vacanciesData_summed <- reactive({
  vacancies_region() %>%
    summarise(value = sum(value), .by = c(Level, Time_open, GrandTotal)) %>%
    mutate(value_perc = value/GrandTotal)
})

vacancies_plot <- reactive({  #Summarise all
  vacanciesData_summed() %>%
    summarise(value = sum(value), .by = c(Level, Time_open, GrandTotal, value_perc, value))
})

vacancies_plot_time_open <- reactive({  #Summarise all
  vacancies_region()    %>%
    group_by(Site, Low.Level.Resource.Code, Level, Time_open, GrandTotal, value) %>%
    summarise(value = sum(value)) %>%
    mutate(value_perc = value/GrandTotal) 
})

vacancies_plot_long_to_short <- reactive({  #Summarise all
  vacancies_region()    %>%
    group_by(Level) %>%
    #summarise(value = sum(value)) %>%
    summarise(value_ratio = sum(value[Time_open == "long"])/sum(value)) %>%
    mutate(value_perc = if_else(is.na(value_ratio), 0, value_ratio))
})

total_vacancies <- reactive({  #Summarise all
  vacancies_region() %>%
    filter(Level != "SME") %>%
    summarise(value = sum(value))%>%
    mutate(across(value, round, 0)) %>%
    slice(1)#round to integer
})


  
vacancies_plot_RCT <- reactive({ #Summarise but preserve RCT
  vacanciesData_summed() %>%
    summarise(value = sum(value), .by = c(Level, GrandTotal,  Time_open, value_perc, `Sub-sector`, value))
})

#  reactive({glimpse(level_plot_RCT_STEM_Status)})
vacancies_plot_STEM <- reactive({ #Summarise but preserve STEM
  vacanciesData_summed() %>%
    summarise(value = sum(value), .by = c(Level, GrandTotal,  Time_open, value_perc, STEM_status, value))
})
