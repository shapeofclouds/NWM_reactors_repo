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


defaultCivilsL12 <- 60
defaultCivilsL34 <- 30
defaultCivilsL56 <- 5
defaultCivilsL78 <- 5

defaultMEHL12 <- 60
defaultMEHL34 <- 30
defaultMEHL56 <- 5
defaultMEHL78 <- 5

defaultOpsL12 <- 60
defaultOpsL34 <- 30
defaultOpsL56 <- 5
defaultOpsL78 <- 5

defaultFactoryL12 <- 60
defaultFactoryL34 <- 30
defaultFactoryL56 <- 5
defaultFactoryL78 <- 5

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
    tags$style(HTML("hr {border-top: 3px solid #555555;}")),
    tags$style("#civils {color:#E40303};}"),
    tags$style("#operations {color:blue};}"),
    tags$style("#meh {color:green};}"),
    tags$style("#factory {color:#FF8C00};}")

      ),
    # Application title
    titlePanel("Hypothetical reactor model"),
  tabsetPanel(type = "tabs",
        tabPanel("Profiles", fluid = TRUE,  style = "padding-top:30px",       

    sidebarLayout(
        sidebarPanel(fluidRow(column(4,
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
            
           
            
            column(4,
         
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
                        value = 2.3))#,
         #   column(2,
                   
                   #numericInput("civil_frac", "Civils (%)", value = 100,  min = 0, max = 100,
                   #             width = '100px'),  
                   
                   #hr(),
                   
                   #numericInput("mech_frac", "Mechanical (%)", value = 100,  min = 0, max = 100,
                   #             width = '100px'),
                   
                   
                   
           # )
            
        )),

        
        # Show a plot of the generated distribution
        mainPanel(
            plotOutput("distPlot"),
            plotOutput("factoryPlot")
            
        ),
        
    ),
    
               
             ),  
    tabPanel("Role and Level splits", fluid = TRUE,  style = "padding-top:30px",
             
             fluidRow(column(1,
                            # numericInput("mech_frac", "Civils (%)", value = 100,  min = 0, max = 100,
                            #              width = '100px')
                            strong(id = "civils", "Civils"),
                            
                        ),
##Civils####                        
            column(1,textInput('civilsName1', span(id = "civils",'Role Name'), value="Major Civils")),
             
          #  tags$span("#mechrole1_frac {color : red;}"),
            
             column(1,
                    numericInput("civilsRole1", span(id = "civils", "Role1 (%)"), value = 100,  min = 0, max = 100,
                          width = '100px')),
             
             column(1,
                    numericInput("civilsRole1_L12", span(id = "civils", "Role1 L12 (%)"), value = defaultCivilsL12,  min = 0, max = 100,
                                 width = '100px')),
             column(1,
                    numericInput("civilsRole1_L34", span(id = "civils", "Role1 L34 (%)"), value = defaultCivilsL34,  min = 0, max = 100,
                                 width = '100px')),
             column(1,
                    numericInput("civilsRole1_L56", span(id = "civils", "Role1 L56 (%)"), value = defaultCivilsL56,  min = 0, max = 100,
                                 width = '100px')),
             column(1,
                    numericInput("civilsRole1_L78", span(id = "civils", "Role1 L78 (%)"), value = defaultCivilsL78,  min = 0, max = 100,
                                 width = '100px'))),
             
            fluidRow(
              ####             
              
             column(1, offset = 1, textInput('civilsName2', span(id = "civils", 'Role Name'), value="Minor Civils")),   
            
             column(1, 
                    numericInput("civilsRoles2", span(id = "civils", "Role2 (%)"), value = defaultCivilsL12,  min = 0, max = 100,
                                 width = '100px')),
             
             
             column(1,
                    numericInput("civilsRoles2_L12", span(id = "civils","Role2 L12 (%)"), value = defaultCivilsL12,  min = 0, max = 100,
                                 width = '100px')),
             column(1,
                    numericInput("civilsRoles2_L34", span(id = "civils", "Role2 L34 (%)"), value = defaultCivilsL34,  min = 0, max = 100,
                                 width = '100px')),
             column(1,
                    numericInput("civilsRoles2_L56", span(id = "civils","Role2 L56 (%)"), value = defaultCivilsL56,  min = 0, max = 100,
                                 width = '100px')),
             column(1,
                    numericInput("civilsRoles2_L78", span(id = "civils", "Role2 L78 (%)"), value = defaultCivilsL78,  min = 0, max = 100,
                                 width = '100px'))),
  ####        
       
 fluidRow(
 
   column(1, offset = 1, textInput('civilsName3', span(id = "civils", 'Role Name'), value="Tunneling")), 
 
   column(1, 
          numericInput("civilsRoles3", span(id = "civils", "Role3 (%)"), value = 100,  min = 0, max = 100,
                       width = '100px')),
   
   column(1,
          numericInput("civilsRoles3_L12", span(id = "civils", "Role3 L12 (%)") , value = defaultCivilsL12,  min = 0, max = 100,
                       width = '100px')),
   column(1,
          numericInput("civilsRoles3_L34", span(id = "civils","Role3 L34 (%)"), value = defaultCivilsL34,  min = 0, max = 100,
                       width = '100px')),
   column(1,
          numericInput("civilsRoles3_L56", span(id = "civils", "Role3 L56 (%)"), value = defaultCivilsL56,  min = 0, max = 100,
                       width = '100px')),
   column(1,
          numericInput("civilsRoles3_L78", span(id = "civils", "Role3 L78 (%)"), value = defaultCivilsL78,  min = 0, max = 100,
                       width = '100px'))),
 
 
 ####
 
 fluidRow(
   
   column(1, offset = 1, textInput('civilsName4', span(id = "civils", 'Role Name'), value="-")), 
   
   column(1, 
          numericInput("civilsRole4", span(id = "civils", "Role4 (%)"), value = 100,  min = 0, max = 100,
                       width = '100px')),
   
   column(1,
          numericInput("civilsRoles4_L12", span(id = "civils", "Role4 L12 (%)"), value = defaultCivilsL12,  min = 0, max = 100,
                       width = '100px')),
   column(1,
          numericInput("civilsRoles4_L34", span(id = "civils", "Role4 L34 (%)"), value = defaultCivilsL34,  min = 0, max = 100,
                       width = '100px')),
   column(1,
          numericInput("civilsRoles4_L56", span(id = "civils", "Role4 L56 (%)"), value = defaultCivilsL56,  min = 0, max = 100,
                       width = '100px')),
   column(1,
          numericInput("civilsRoles4_L78", span(id = "civils", "Role4 L78 (%)"), value = defaultCivilsL78,  min = 0, max = 100,
                       width = '100px'))),
 
##MEH#### 
 fluidRow(column(1,
                 strong(id = "meh", "MEH")),
          
          column(1,textInput('mehName1', span(id = "meh", 'Role Name'), value="Major Civils")),
          
          column(1,
                 numericInput("mehRole1", span(id = "meh", "Role1 (%)"), value = 100,  min = 0, max = 100,
                              width = '100px')),
          
          
          
          column(1,
                 numericInput("mehRoles1_L12", span(id = "meh", "Role1 L12 (%)"), value = defaultMEHL12,  min = 0, max = 100,
                              width = '100px')),
          column(1,
                 numericInput("mehRoles1_L12", span(id = "meh","Role1 L34 (%)"), value = defaultMEHL34,  min = 0, max = 100,
                              width = '100px')),
          column(1,
                 numericInput("mehRoles1_L12", span(id = "meh","Role1 L56 (%)"), value = defaultMEHL56,  min = 0, max = 100,
                              width = '100px')),
          column(1,
                 numericInput("mehRoles1_L12", span(id = "meh","Role1 L78 (%)"), value = defaultMEHL78,  min = 0, max = 100,
                              width = '100px'))),
 
 fluidRow(
   ####             
   
   column(1, offset = 1, textInput('mehName2', span(id = "meh",'Role Name'), value="Minor Civils")),   
   
   column(1, 
          numericInput("mehRole2", span(id = "meh","Role2 (%)"), value = 100,  min = 0, max = 100,
                       width = '100px')),
   
   
   column(1,
          numericInput("mehRoles2_L12", span(id = "meh","Role2 L12 (%)"), value = defaultMEHL12,  min = 0, max = 100,
                       width = '100px')),
   column(1,
          numericInput("mehRoles2_L34", span(id = "meh","Role2 L34 (%)"), value = defaultMEHL34,  min = 0, max = 100,
                       width = '100px')),
   column(1,
          numericInput("mehRoles2_L56", span(id = "meh","Role2 L56 (%)"), value = defaultMEHL56,  min = 0, max = 100,
                       width = '100px')),
   column(1,
          numericInput("mehRoles2_L78", span(id = "meh","Role2 L78 (%)"), value = defaultMEHL78,  min = 0, max = 100,
                       width = '100px'))),
 ####        
 
 fluidRow(
   
   column(1, offset = 1, textInput('mehName3', span(id = "meh",'Role Name'), value="Tunneling")), 
   
   column(1, 
          numericInput("mehRole3", span(id = "meh","Role3 (%)"), value = 100,  min = 0, max = 100,
                       width = '100px')),
   
   column(1,
          numericInput("mehRoles3_L12", span(id = "meh","Role3 L12 (%)"), value = 100,  min = 0, max = 100,
                       width = '100px')),
   column(1,
          numericInput("mehRoles3_L34", span(id = "meh","Role3 L34 (%)"), value = 100,  min = 0, max = 100,
                       width = '100px')),
   column(1,
          numericInput("mehRoles3_L56", span(id = "meh","Role3 L56 (%)"), value = 100,  min = 0, max = 100,
                       width = '100px')),
   column(1,
          numericInput("mehRoles3_L78", span(id = "meh","Role3 L78 (%)"), value = 100,  min = 0, max = 100,
                       width = '100px'))),
 
 
 ####
 
 fluidRow(
   
   column(1, offset = 1, textInput('mehName4', span(id = "meh",'Role Name'), value="-")), 
   
   column(1, 
          numericInput("mehRole4", span(id = "meh","Role4 (%)"), value = 100,  min = 0, max = 100,
                       width = '100px')),
   
   column(1,
          numericInput("mehRoles4_L12", span(id = "meh","Role4 L12 (%)"), value = 100,  min = 0, max = 100,
                       width = '100px')),
   column(1,
          numericInput("mehRoles4_L34", span(id = "meh","Role4 L34 (%)"), value = 100,  min = 0, max = 100,
                       width = '100px')),
   column(1,
          numericInput("mehRoles4_L56", span(id = "meh","Role4 L56 (%)"), value = 100,  min = 0, max = 100,
                       width = '100px')),
   column(1,
          numericInput("mehRoles4_L78", span(id = "meh","Role4 L78 (%)"), value = 100,  min = 0, max = 100,
                       width = '100px'))),
 
 ##Operations####
 
 fluidRow(column(1,
                 strong(id = "operations", "Ops")),
          
          column(1,textInput('operationsName1', span(id = "operations", 'Role Name'), value="Major Civils")),
          
          column(1,
                 numericInput("operationsRole1", span(id = "operations", "Role1 (%)"), value = 100,  min = 0, max = 100,
                              width = '100px')),
          
          
          
          column(1,
                 numericInput("operationsRoles1_L12", span(id = "operations", "Role1 L12 (%)"), value = defaultOpsL12,  min = 0, max = 100,
                              width = '100px')),
          column(1,
                 numericInput("operationsRoles1_L34", span(id = "operations","Role1 L34 (%)"), value = defaultOpsL34,  min = 0, max = 100,
                              width = '100px')),
          column(1,
                 numericInput("operationsRoles1_L56", span(id = "operations","Role1 L56 (%)"), value = defaultOpsL56,  min = 0, max = 100,
                              width = '100px')),
          column(1,
                 numericInput("operationsRoles1_L78", span(id = "operations","Role1 L78 (%)"), value = defaultOpsL78,  min = 0, max = 100,
                              width = '100px'))),
 
 fluidRow(
   ####             
   
   column(1, offset = 1, textInput('operationsName2', span(id = "operations",'Role Name'), value="Minor Civils")),   
   
   column(1, 
          numericInput("operationsRole2", span(id = "operations","Role2 (%)"), value = 100,  min = 0, max = 100,
                       width = '100px')),
   
   
   column(1,
          numericInput("operationsRoles2_L12", span(id = "operations","Role2 L12 (%)"), value = defaultOpsL12,  min = 0, max = 100,
                       width = '100px')),
   column(1,
          numericInput("operationsRoles2_L34", span(id = "operations","Role2 L34 (%)"), value = defaultOpsL34,  min = 0, max = 100,
                       width = '100px')),
   column(1,
          numericInput("operationsRoles2_L56", span(id = "operations","Role2 L56 (%)"), value = defaultOpsL56,  min = 0, max = 100,
                       width = '100px')),
   column(1,
          numericInput("operationsRoles2_L78", span(id = "operations","Role2 L78 (%)"), value = defaultOpsL78,  min = 0, max = 100,
                       width = '100px'))),
 ####        
 
 fluidRow(
   
   column(1, offset = 1, textInput('operationsName3', span(id = "operations",'Role Name'), value="Tunneling")), 
   
   column(1, 
          numericInput("operationsRole3", span(id = "operations","Role3 (%)"), value = 100,  min = 0, max = 100,
                       width = '100px')),
   
   column(1,
          numericInput("operationsRoles3_L12", span(id = "operations","Role3 L12 (%)"), value = 100,  min = 0, max = 100,
                       width = '100px')),
   column(1,
          numericInput("operationsRoles3_L34", span(id = "operations","Role3 L34 (%)"), value = 100,  min = 0, max = 100,
                       width = '100px')),
   column(1,
          numericInput("operationsRoles3_L56", span(id = "operations","Role3 L56 (%)"), value = 100,  min = 0, max = 100,
                       width = '100px')),
   column(1,
          numericInput("operationsRoles3_L78", span(id = "operations","Role3 L78 (%)"), value = 100,  min = 0, max = 100,
                       width = '100px'))),
 

 ####
 
 fluidRow(
   
   column(1, offset = 1, textInput('operationsName4', span(id = "operations",'Role Name'), value="-")), 
   
   column(1, 
          numericInput("operationsRoles4_L12", span(id = "operations","Role4 (%)"), value = 100,  min = 0, max = 100,
                       width = '100px')),
   
   column(1,
          numericInput("operationsRoles4_L12", span(id = "operations","Role4 L12 (%)"), value = 100,  min = 0, max = 100,
                       width = '100px')),
   column(1,
          numericInput("operationsRoles4_L34", span(id = "operations","Role4 L34 (%)"), value = 100,  min = 0, max = 100,
                       width = '100px')),
   column(1,
          numericInput("operationsRoles4_L56", span(id = "operations","Role4 L56 (%)"), value = 100,  min = 0, max = 100,
                       width = '100px')),
   column(1,
          numericInput("operationsRoles4_L78", span(id = "operations","Role4 L78 (%)"), value = 100,  min = 0, max = 100,
                       width = '100px'))),

##Factory####

fluidRow(column(1,
                strong(id = "factory", "Ops")),
         
         column(1,textInput('factoryName1', span(id = "factory", 'Role Name'), value="Major Civils")),
         
         column(1,
                numericInput("factoryRole1", span(id = "factory", "Role1 (%)"), value = 100,  min = 0, max = 100,
                             width = '100px')),
         
         
         
         column(1,
                numericInput("factoryRoles1_L12", span(id = "factory", "Role1 L12 (%)"), value = defaultOpsL12,  min = 0, max = 100,
                             width = '100px')),
         column(1,
                numericInput("factoryRoles1_L34", span(id = "factory","Role1 L34 (%)"), value = defaultOpsL34,  min = 0, max = 100,
                             width = '100px')),
         column(1,
                numericInput("factoryRoles1_L56", span(id = "factory","Role1 L56 (%)"), value = defaultOpsL56,  min = 0, max = 100,
                             width = '100px')),
         column(1,
                numericInput("factoryRoles1_L78", span(id = "factory","Role1 L78 (%)"), value = defaultOpsL78,  min = 0, max = 100,
                             width = '100px'))),

fluidRow(
  ####             
  
  column(1, offset = 1, textInput('factoryName2', span(id = "factory",'Role Name'), value="Minor Civils")),   
  
  column(1, 
         numericInput("factoryRole2", span(id = "factory","Role2 (%)"), value = 100,  min = 0, max = 100,
                      width = '100px')),
  
  
  column(1,
         numericInput("factoryRoles2_L12", span(id = "factory","Role2 L12 (%)"), value = defaultOpsL12,  min = 0, max = 100,
                      width = '100px')),
  column(1,
         numericInput("mfactoryRoles2_L34", span(id = "factory","Role2 L34 (%)"), value = defaultOpsL34,  min = 0, max = 100,
                      width = '100px')),
  column(1,
         numericInput("factoryRoles2_L56", span(id = "factory","Role2 L56 (%)"), value = defaultOpsL56,  min = 0, max = 100,
                      width = '100px')),
  column(1,
         numericInput("factoryRoles2_L78", span(id = "factory","Role2 L78 (%)"), value = defaultOpsL78,  min = 0, max = 100,
                      width = '100px'))),
####        

fluidRow(
  
  column(1, offset = 1, textInput('factoryName3', span(id = "factory",'Role Name'), value="Tunneling")), 
  
  column(1, 
         numericInput("factoryRole3", span(id = "factory","Role3 (%)"), value = 100,  min = 0, max = 100,
                      width = '100px')),
  
  column(1,
         numericInput("factoryRoles3_L12", span(id = "factory","Role3 L12 (%)"), value = 100,  min = 0, max = 100,
                      width = '100px')),
  column(1,
         numericInput("factoryRoles3_L34", span(id = "factory","Role3 L34 (%)"), value = 100,  min = 0, max = 100,
                      width = '100px')),
  column(1,
         numericInput("factoryRoles3_L56", span(id = "factory","Role3 L56 (%)"), value = 100,  min = 0, max = 100,
                      width = '100px')),
  column(1,
         numericInput("factoryRoles3_L78", span(id = "factory","Role3 L78 (%)"), value = 100,  min = 0, max = 100,
                      width = '100px'))),


####

fluidRow(
  
  column(1, offset = 1, textInput('factoryName4', span(id = "factory",'Role Name'), value="-")), 
  
  column(1, 
         numericInput("factoryRole4", span(id = "factory","Role4 (%)"), value = 100,  min = 0, max = 100,
                      width = '100px')),
  
  column(1,
         numericInput("factoryRoles4_L12", span(id = "factory","Role4 L12 (%)"), value = 100,  min = 0, max = 100,
                      width = '100px')),
  column(1,
         numericInput("factoryRoles4_L34", span(id = "factory","Role4 L34 (%)"), value = 100,  min = 0, max = 100,
                      width = '100px')),
  column(1,
         numericInput("factoryRoles4_L56", span(id = "factory","Role4 L56 (%)"), value = 100,  min = 0, max = 100,
                      width = '100px')),
  column(1,
         numericInput("factoryRoles4_L78", span(id = "factory","Role4 L78 (%)"), value = 100,  min = 0, max = 100,
                      width = '100px'))),
 
  
       
    )        
             
    
))

