#
# This is the user-interface definition of a Shiny web application. You can
# run the application by clicking 'Run App' above.
#
# Find out more about building applications with Shiny here:
#
#    http://shiny.rstudio.com/
#

library(shiny)

# Define UI for application that draws a histogram
fluidPage(

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
                        min = 1,
                        max = 5000,
                        value = 1000),
            
            sliderInput("civ_pos",
                        "Civils Position:",
                        min = 1,
                        max = 30,
                        value = 20),
            
            
            sliderInput("civ_width",
                        "Civils Width:",
                        min = 0,
                        max = 50,
                        value = 6),
            
            sliderInput("civ_skew",
                        "Civils skew:",
                        min = 0-5,
                        max = 5,
                        value = 0),
            
            hr(),
            
            sliderInput("operations_limit",
                        "Operations max:",
                        min = 1,
                        max = 2000,
                        value = 300),
            
            sliderInput("operations_pos",
                        "Operations position:",
                        min = 1,
                        max = 100,
                        value = 25),
            
            
            sliderInput("operations_width",
                        "Operations build-up:",
                        min = 0,
                        max = 5,
                        step = 0.1,
                        value = 2)),
            
           
            
            column(5,
         
                   sliderInput("meh_peak",
                               "MEH Peak:",
                               min = 0,
                               max = 5000,
                               value = 1000),
                   
                   sliderInput("meh_pos",
                               "MEH Position:",
                               min = 0,
                               max = 100,
                               value = 30),
                   
                   sliderInput("meh_width",
                               "MEH Width:",
                               min = 1,
                               max = 50,
                               value = 5),
                   
                   sliderInput("meh_skew",
                               "MEH skew:",
                               min = 0-5,
                               max = 5,
                               value = 0),
        
                   hr(),
                   
                       
            sliderInput("factory_limit",
                        "Factory max:",
                        min = 1,
                        max = 2000,
                        value = 300),
            
            sliderInput("factory_pos",
                        "Factory position:",
                        min = -20,
                        max = 80,
                        value = 0),
            
            
            sliderInput("factory_width",
                        "Factory build-up:",
                        min = 0,
                        max = 5,
                        step =0.1,
                        value = 2)),
            
            
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
