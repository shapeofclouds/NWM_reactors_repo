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
  
   plot_df_units  <- reactive({
   #  df_units <- df_units()
     df_units %>%
        mutate(civils = input$civ_peak * input$civ_width * sqrt(2*pi) * 
                 dsn(time, xi=input$civ_pos, omega =input$civ_width , alpha = input$civ_skew)) %>% 
       mutate(civils = input$civ_peak/max(civils)*civils) %>%#, input$civ_width)) %>%
       mutate(MEH = input$meh_peak * input$meh_width * sqrt(2*pi) * 
                dsn(time, xi=input$meh_pos, omega =input$meh_width , alpha = input$meh_skew)) %>% 
       mutate(MEH = input$meh_peak/max(MEH)*MEH) %>%
       mutate(operations = sigmoid(time, input$operations_limit, input$operations_pos, input$operations_width)) %>%
       mutate(workforce = civils + MEH + operations) %>%
      pivot_longer(cols = c(civils, MEH, workforce, operations), names_to = "discipline", values_to = "value") 
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


