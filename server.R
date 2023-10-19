 #
# This is the server logic of a Shiny web application. You can run the
# application by clicking 'Run App' above.
#
# Find out more about building applications with Shiny here:
#
#    http://shiny.rstudio.com/
#

library(shiny)
library(tidyverse)
library(sn) #skewed normal library

source("./source_files/colours.R", local = TRUE)

font_themes <- theme(axis.title.x = element_text(size = 14), 
      axis.title.y = element_text(size = 14),
      axis.text.x = element_text(size = 14), 
      axis.text.y = element_text(size = 14))

time <- seq(-24, 72, 1)
df_units <- data.frame(time)

time <- seq(-12, 240, 1)
df_factory <- data.frame(time)


sigmoid <- Vectorize(function(x, limit, start,  width) {
  Q=0.5
  mu=0.5
  y = limit/(1+Q*exp(-width*(x-start))^mu)
  
})

inv_sigmoid <- Vectorize(function(x, limit, start,  width) {
  Q=0.5
  mu=0.5
  y = limit-limit/(1+Q*exp(-width*(x-start))^mu)
  
})

# Define server logic required to draw a histogram
server <- function(input, output, session) {
  
  observe({
    
   # civilsName1 <- sub(" ", "_", input$civilsName1)
   # print(civilsName1)
    #print(df_units_all())
    print(mehDataframe())
    
  })
  
   df_units_civils  <- reactive({
     
     
   #  df_units <- df_units()
     df_units %>%
        mutate(civils = input$civ_peak * input$civ_width * sqrt(2*pi) * 
                 dsn(time, xi=input$civ_pos, omega =input$civ_width , alpha = input$civ_skew)) %>% 
       mutate(civils = input$civ_peak/max(civils)*civils) })
   
   
   #%>%#, input$civ_width)) %>%
       
    #  mutate(!!sym(civilsName1) := civils*input$civilsRole1) %>%
       
    df_units_meh <-reactive({
      df_units %>%
       mutate(meh = input$meh_peak * input$meh_width * sqrt(2*pi) * 
                dsn(time, xi=input$meh_pos, omega =input$meh_width , alpha = input$meh_skew)) %>% 
       mutate(meh = input$meh_peak/max(meh)*meh) }) 
    
    df_units_operations <- reactive({
      df_units %>%
       mutate(operations = sigmoid(time, input$operations_limit, input$operations_pos, input$operations_width)) })
    
    df_units_all <- reactive({
      df1 <- df_units_civils() 
      
      df2 <- df_units_meh() %>%
        select(-time) 
      
      df3 <- df_units_operations() %>%
        select(-time)
      
      cbind(df1, df2, df3)
    })
       
    plot_df_units <- reactive({
      df_units_all() %>%  
        mutate(workforce = civils + meh + operations) %>%
        pivot_longer(cols = c(civils, meh, workforce, operations), names_to = "discipline", values_to = "value") 
    })
     #print(df_units)
     #return(df_units)
     
   
   civilsDataframe <- reactive({

     df <- df_units_civils()

     civilsName1 <- sub(" ", "_", input$civilsName1)
     civilsName2 <- sub(" ", "_", input$civilsName2)
     civilsName3 <- sub(" ", "_", input$civilsName3)
     civilsName4 <- sub(" ", "_", input$civilsName4)

     if (nchar(civilsName1)>0)  { #check a name exists
     df <- df %>%
       mutate(!!sym(civilsName1) := input$civilsRole1/100*civils) 
     }
     
     if (nchar(civilsName2)>0)  {
     df <- df %>%
       mutate(!!sym(civilsName2) := input$civilsRole2/100*civils) 
     }
     
     if (nchar(civilsName3)>0)  {
       df <- df %>%
         mutate(!!sym(civilsName3) := input$civilsRole3/100*civils) 
     }
     
     if (nchar(civilsName4)>0)  {
       df <- df %>%
         mutate(!!sym(civilsName4) := input$civilsRole4/100*civils) 
     }

     return(df)

   })
   
   
   mehDataframe <- reactive({
     
     df <- df_units_meh()
     
     mehName1 <- sub(" ", "_", input$mehName1)
     mehName2 <- sub(" ", "_", input$mehName2)
     mehName3 <- sub(" ", "_", input$mehName3)
     mehName4 <- sub(" ", "_", input$mehName4)
     
     if (nchar(mehName1)>0)  { #check a name exists
       df <- df %>%
         mutate(!!sym(mehName1) := input$mehRole1/100*meh) 
     }
     
     if (nchar(mehName2)>0)  {
       df <- df %>%
         mutate(!!sym(mehName2) := input$mehRole2/100*meh) 
     }
     
     if (nchar(mehName3)>0)  {
       df <- df %>%
         mutate(!!sym(mehName3) := input$mehRole3/100*meh) 
     }
     
     if (nchar(mehName4)>0)  {
       df <- df %>%
         mutate(!!sym(mehName4) := input$mehRole4/100*meh) 
     }
     
     return(df)
     
   })
   
   
   
   plot_df_factory  <- reactive({
     #  df_units <- df_units()
     df_factory %>%
       mutate(manufacturing = sigmoid(time, input$factory_limit, input$factory_pos, input$factory_width)) %>%
       pivot_longer(cols = c(manufacturing), names_to = "discipline", values_to = "value") 
   }) 
      #  order()
output$distPlot  <- renderPlot({
      ggplot(data = plot_df_units(), aes(x=time, y=value, color = discipline), group = discipline) + geom_line(size = 1.5) + 
    font_themes + ylab("Workforce") + xlab("Time/Months") + 
    scale_color_manual(values = colourMap)

    })



output$factoryPlot  <- renderPlot({
  ggplot(data = plot_df_factory(), aes(x=time, y=value, color = discipline), group = discipline) + geom_line(size = 1.5) + 
    font_themes + ylab("Workforce") + xlab("Time/Months") + #ylim(0, 1000) + 
    scale_color_manual(values = colourMap)
    })
        # generate bins based on input$bins from ui.R
}


