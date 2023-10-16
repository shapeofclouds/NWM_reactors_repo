#
# This is the user-interface definition of a Shiny web application. You can
# run the application by clicking 'Run App' above.
#
# Find out more about building applications with Shiny here:
#
#    http://shiny.rstudio.com/
#

library(shiny)

source("./source_files/colours.R", local = TRUE)



# Define UI for application that draws a histogram
fluidPage(
  tags$style(HTML(".js-irs-0 .irs-single, .js-irs-0 .irs-bar-edge, .js-irs-0 .irs-bar {background: #E40303}")),
  tags$style(HTML(".js-irs-1 .irs-single, .js-irs-1 .irs-bar-edge, .js-irs-1 .irs-bar {background: #E40303}")),
  tags$style(HTML(".js-irs-2 .irs-single, .js-irs-2 .irs-bar-edge, .js-irs-2 .irs-bar {background: #E40303}")),
  tags$style(HTML(".js-irs-3 .irs-single, .js-irs-3 .irs-bar-edge, .js-irs-3 .irs-bar {background: #E40303}")),
  
  tags$style(HTML(".js-irs-4 .irs-single, .js-irs-4 .irs-bar-edge, .js-irs-4 .irs-bar {background: blue}")),
  tags$style(HTML(".js-irs-5 .irs-single, .js-irs-5 .irs-bar-edge, .js-irs-5 .irs-bar {background: blue}")),
  tags$style(HTML(".js-irs-6 .irs-single, .js-irs-6 .irs-bar-edge, .js-irs-6 .irs-bar {background: blue}")),
  
  tags$style(HTML(".js-irs-7 .irs-single, .js-irs-7 .irs-bar-edge, .js-irs-7 .irs-bar {background: green}")),
  tags$style(HTML(".js-irs-8 .irs-single, .js-irs-8 .irs-bar-edge, .js-irs-8 .irs-bar {background: green}")),
  tags$style(HTML(".js-irs-9 .irs-single, .js-irs-9 .irs-bar-edge, .js-irs-9 .irs-bar {background: green}")),
  tags$style(HTML(".js-irs-10 .irs-single, .js-irs-10 .irs-bar-edge, .js-irs-10 .irs-bar {background: green}")),
  
  tags$style(HTML(".js-irs-11 .irs-single, .js-irs-11 .irs-bar-edge, .js-irs-11 .irs-bar {background: #FF8C00}")),
  tags$style(HTML(".js-irs-12 .irs-single, .js-irs-12 .irs-bar-edge, .js-irs-12 .irs-bar {background: #FF8C00}")),
  tags$style(HTML(".js-irs-13 .irs-single, .js-irs-13 .irs-bar-edge, .js-irs-13 .irs-bar {background: #FF8C00}")),

  tags$head(
    tags$style(HTML("hr {border-top: 3px solid #555555;}"))
  ),
    # Application title
    titlePanel("Hypothetical reactor model"),

    # Sidebar with a slider input for number of bins
    sidebarLayout(
        sidebarPanel(fluidRow(column(5,
            sliderInput("civ_peak",
                        "Civils Peak:",
                        min = 0,
                        max = 5000,
                        value = 370),
            
            sliderInput("civ_pos",
                        "Civils Position:",
                        min = 0,
                        max = 30,
                        value = 9),
            
            
            sliderInput("civ_width",
                        "Civils Width:",
                        min = 0,
                        max = 50,
                        value = 12),
            
            sliderInput("civ_skew",
                        "Civils skew:",
                        min = -5,
                        max = 5,
                        value = 3),
            
            hr(),
            
            sliderInput("operations_limit",
                        "Operations max:",
                        min = 0,
                        max = 2000,
                        value = 300),
            
            sliderInput("operations_pos",
                        "Operations position:",
                        min = -24,
                        max = 72,
                        value = 40),
            
            
            sliderInput("operations_width",
                        "Operations build-up:",
                        min = 0,
                        max = 5,
                        step = 0.1,
                        value = 0.6)),
            
           
            
            column(5,
         
                   sliderInput("meh_peak",
                               "MEH Peak:",
                               min = 0,
                               max = 5000,
                               value = 270),
                   
                   sliderInput("meh_pos",
                               "MEH Position:",
                               min = 0,
                               max = 100,
                               value = 20),
                   
                   sliderInput("meh_width",
                               "MEH Width:",
                               min = 1,
                               max = 50,
                               value = 11),
                   
                   sliderInput("meh_skew",
                               "MEH skew:",
                               min = 0,
                               max = 5,
                               value = 3),
        
                   hr(),
                   
                       
            sliderInput("factory_limit",
                        "Factory max:",
                        min = 0,
                        max = 2000,
                        value = 1400),
            
            sliderInput("factory_pos",
                        "Factory position:",
                        min = -48,
                        max = 80,
                        value = -2),
            
            
            sliderInput("factory_width",
                        "Factory build-up:",
                        min = 0,
                        max = 5,
                        step =0.1,
                        value = 2.3)),
            
            
        )),

        
        
        
        # Show a plot of the generated distribution
        mainPanel(
            plotOutput("distPlot"),
            plotOutput("factoryPlot"),
            
            numericInput("job_family1", "Job Family1 (%)", value = 50,  min = 0, max = 100,
                         width = '100px')
        )
    )
)
