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
library(openxlsx)

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
  
  # wb <- createWorkbook()
  # addWorksheet(wb, sheetName = "sheet1")
  # writeData(wb, sheet = 1, x = combined_L12, startCol = 1, startRow = 1)
  # writeData(wb, sheet = 2, x = combined_L34, startCol = 1, startRow = 1)
  # writeData(wb, sheet = 3, x = combined_L56, startCol = 1, startRow = 1)
  # writeData(wb, sheet = 4, x = combined_L78, startCol = 1, startRow = 1)
  
  wb <- createWorkbook()
  addWorksheet(wb, sheetName = "L12")
  addWorksheet(wb, sheetName = "L34")
  addWorksheet(wb, sheetName = "L56")
  addWorksheet(wb, sheetName = "L78")
  

output$dl <- downloadHandler(
    filename = function() {
      paste0("example", ".xlsx")
    },
    content = function(file) {
      saveWorkbook(wb, file = file, overwrite = TRUE)
    }
  )
  
    
  
  
  observe({
    
   # civilsName1 <- sub(" ", "_", input$civilsName1)
   # print(civilsName1)
    write_csv(combined_L12(), "combined.csv")
    print( civilsDataframe())
    
    
    
    writeData(wb, sheet = 1, x = combined_L12(), startCol = 1, startRow = 1)
    writeData(wb, sheet = 2, x = combined_L34(), startCol = 1, startRow = 1)
    writeData(wb, sheet = 3, x = combined_L56(), startCol = 1, startRow = 1)
    writeData(wb, sheet = 4, x = combined_L78(), startCol = 1, startRow = 1)
    
    #, mehDataframe(), operationsDataframe())
    
  })
  
   df_units_civils  <- reactive({

     df_units %>%
        mutate(civils = input$civ_peak * input$civ_width * sqrt(2*pi) * 
                 dsn(time, xi=input$civ_pos, omega =input$civ_width , alpha = input$civ_skew)) %>% 
       mutate(civils = input$civ_peak/max(civils)*civils) })
       
  df_units_meh <-reactive({
      df_units %>%
       mutate(meh = input$meh_peak * input$meh_width * sqrt(2*pi) * 
                dsn(time, xi=input$meh_pos, omega =input$meh_width , alpha = input$meh_skew)) %>% 
       mutate(meh = input$meh_peak/max(meh)*meh) }) 
    
  df_units_operations <- reactive({
      df_units %>%
       mutate(operations = sigmoid(time, input$operations_limit, input$operations_pos, input$operations_width)) })
    
  df_units_all <- reactive({ #just for display
      df1 <- df_units_civils() 
      
      df2 <- df_units_meh() %>%
        select(-time) 
      
      df3 <- df_units_operations() %>%
        select(-time)
      
      cbind(df1, df2, df3) 
      #   pivot_longer(cols = (2:ncol(.)), names_to = "", values_to = "value")
      # 
      # return(tmp)
    })
       
  plot_df_units <- reactive({
      df_units_all() %>%  
        mutate(workforce = civils + meh + operations) %>%
        pivot_longer(cols = c(civils, meh, workforce, operations), names_to = "discipline", values_to = "value") #%>%
    #    group_by(discipline) %>%
      #summarise(value = sum(value)) #sum 
    })

     
   
   civilsDataframe <- reactive({

     df <- df_units_civils()

     civilsName1 <- sub(" ", "_", input$civilsName1)
     civilsName2 <- sub(" ", "_", input$civilsName2)
     civilsName3 <- sub(" ", "_", input$civilsName3)
     civilsName4 <- sub(" ", "_", input$civilsName4)

     if (nchar(civilsName1)>0)  { #check a name exists
     df <- df %>%
       mutate(!!sym(civilsName1) := input$civilsRole1/100*civils)%>%
       mutate(!!sym(paste0(civilsName1, "_L12")) := !!sym(civilsName1) * input$civilsRole1_L12/100) %>%
       mutate(!!sym(paste0(civilsName1, "_L34")) := !!sym(civilsName1) * input$civilsRole1_L34/100) %>%
       mutate(!!sym(paste0(civilsName1, "_L56")) := !!sym(civilsName1) * input$civilsRole1_L56/100) %>%
       mutate(!!sym(paste0(civilsName1, "_L78")) := !!sym(civilsName1) * input$civilsRole1_L78/100) %>%
       select(-(!!sym(civilsName1)))
     }
     
     if (nchar(civilsName2)>0)  {
     df <- df %>%
       mutate(!!sym(civilsName2) := input$civilsRole2/100*civils) %>%
       mutate(!!sym(paste0(civilsName2, "_L12")) := !!sym(civilsName2) * input$civilsRole2_L12/100) %>%
       mutate(!!sym(paste0(civilsName2, "_L34")) := !!sym(civilsName2) * input$civilsRole2_L34/100) %>%
       mutate(!!sym(paste0(civilsName2, "_L56")) := !!sym(civilsName2) * input$civilsRole2_L56/100) %>%
       mutate(!!sym(paste0(civilsName2, "_L78")) := !!sym(civilsName2) * input$civilsRole2_L78/100) %>%
       select(-(!!sym(civilsName2)))
     }
     
     if (nchar(civilsName3)>0)  {
       df <- df %>%
         mutate(!!sym(civilsName3) := input$civilsRole3/100*civils) %>%
         mutate(!!sym(paste0(civilsName3, "_L12")) := !!sym(civilsName3) * input$civilsRole3_L12/100) %>%
         mutate(!!sym(paste0(civilsName3, "_L34")) := !!sym(civilsName3) * input$civilsRole3_L34/100) %>%
         mutate(!!sym(paste0(civilsName3, "_L56")) := !!sym(civilsName3) * input$civilsRole3_L56/100) %>%
         mutate(!!sym(paste0(civilsName3, "_L78")) := !!sym(civilsName3) * input$civilsRole3_L78/100) %>%
         select(-(!!sym(civilsName3))) 
     }
     
     if (nchar(civilsName4)>0)  {
       df <- df %>%
         mutate(!!sym(civilsName4) := input$civilsRole4/100*civils) %>%
         mutate(!!sym(paste0(civilsName4, "_L12")) := !!sym(civilsName4) * input$civilsRole4_L12/100) %>%
         mutate(!!sym(paste0(civilsName4, "_L34")) := !!sym(civilsName4) * input$civilsRole4_L34/100) %>%
         mutate(!!sym(paste0(civilsName4, "_L56")) := !!sym(civilsName4) * input$civilsRole4_L56/100) %>%
         mutate(!!sym(paste0(civilsName4, "_L78")) := !!sym(civilsName4) * input$civilsRole4_L78/100) %>%
         select(-(!!sym(civilsName4))) %>%
         as.data.frame()
     }

     df <- df %>%
       select(-civils) %>%
       pivot_longer(cols = (2:ncol(.)), names_to = "discipline", values_to = "value")%>%
       as.data.frame()
     
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
         mutate(!!sym(mehName1) := input$mehRole1/100*meh) %>%
         mutate(!!sym(paste0(mehName1, "_L12")) := !!sym(mehName1) * input$mehRole1_L12/100) %>%
         mutate(!!sym(paste0(mehName1, "_L34")) := !!sym(mehName1) * input$mehRole1_L34/100) %>%
         mutate(!!sym(paste0(mehName1, "_L56")) := !!sym(mehName1) * input$mehRole1_L56/100) %>%
         mutate(!!sym(paste0(mehName1, "_L78")) := !!sym(mehName1) * input$mehRole1_L78/100) %>%
         select(-(!!sym(mehName1)))
     }

     if (nchar(mehName2)>0)  {
       df <- df %>%
         mutate(!!sym(mehName2) := input$mehRole2/100*meh) %>%
         mutate(!!sym(paste0(mehName2, "_L12")) := !!sym(mehName2) * input$mehRole2_L12/100) %>%
         mutate(!!sym(paste0(mehName2, "_L34")) := !!sym(mehName2) * input$mehRole2_L34/100) %>%
         mutate(!!sym(paste0(mehName2, "_L56")) := !!sym(mehName2) * input$mehRole2_L56/100) %>%
         mutate(!!sym(paste0(mehName2, "_L78")) := !!sym(mehName2) * input$mehRole2_L78/100) %>%
         select(-(!!sym(mehName2)))
     }

     if (nchar(mehName3)>0)  {
       df <- df %>%
         mutate(!!sym(mehName3) := input$mehRole3/100*meh) %>%
         mutate(!!sym(paste0(mehName3, "_L12")) := !!sym(mehName3) * input$mehRole3_L12/100) %>%
         mutate(!!sym(paste0(mehName3, "_L34")) := !!sym(mehName3) * input$mehRole3_L34/100) %>%
         mutate(!!sym(paste0(mehName3, "_L56")) := !!sym(mehName3) * input$mehRole3_L56/100) %>%
         mutate(!!sym(paste0(mehName3, "_L78")) := !!sym(mehName3) * input$mehRole3_L78/100) %>%
         select(-(!!sym(mehName3)))
     }

     if (nchar(mehName4)>0)  {
       df <- df %>%
         mutate(!!sym(mehName4) := input$mehRole4/100*meh) %>%
         mutate(!!sym(paste0(mehName4, "_L12")) := !!sym(mehName4) * input$mehRole4_L12/100) %>%
         mutate(!!sym(paste0(mehName4, "_L34")) := !!sym(mehName4) * input$mehRole4_L34/100) %>%
         mutate(!!sym(paste0(mehName4, "_L56")) := !!sym(mehName4) * input$mehRole4_L56/100) %>%
         mutate(!!sym(paste0(mehName4, "_L78")) := !!sym(mehName4) * input$mehRole4_L78/100) %>%
         select(-(!!sym(mehName4)), -meh)  
     }
     
     df <- df %>%
       select(-meh) %>%
       pivot_longer(cols = (2:ncol(.)), names_to = "discipline", values_to = "value")%>%
       as.data.frame()

     return(df)

   })
   
   
   operationsDataframe <- reactive({
     
     df <- df_units_operations()
     
     operationsName1 <- sub(" ", "_", input$operationsName1)
     operationsName2 <- sub(" ", "_", input$operationsName2)
     operationsName3 <- sub(" ", "_", input$operationsName3)
     operationsName4 <- sub(" ", "_", input$operationsName4)
     
     if (nchar(operationsName1)>0)  { #check a name exists
       df <- df %>%
         mutate(!!sym(operationsName1) := input$operationsRole1/100*operations) %>%
         mutate(!!sym(paste0(operationsName1, "_L12")) := !!sym(operationsName1) * input$operationsRole1_L12/100) %>%
         mutate(!!sym(paste0(operationsName1, "_L34")) := !!sym(operationsName1) * input$operationsRole1_L34/100) %>%
         mutate(!!sym(paste0(operationsName1, "_L56")) := !!sym(operationsName1) * input$operationsRole1_L56/100) %>%
         mutate(!!sym(paste0(operationsName1, "_L78")) := !!sym(operationsName1) * input$operationsRole1_L78/100) %>%
         select(-(!!sym(operationsName1)))
     }
     
     if (nchar(operationsName2)>0)  {
       df <- df %>%
         mutate(!!sym(operationsName2) := input$operationsRole2/100*operations) %>%
         mutate(!!sym(paste0(operationsName2, "_L12")) := !!sym(operationsName2) * input$operationsRole2_L12/100) %>%
         mutate(!!sym(paste0(operationsName2, "_L34")) := !!sym(operationsName2) * input$operationsRole2_L34/100) %>%
         mutate(!!sym(paste0(operationsName2, "_L56")) := !!sym(operationsName2) * input$operationsRole2_L56/100) %>%
         mutate(!!sym(paste0(operationsName2, "_L78")) := !!sym(operationsName2) * input$operationsRole2_L78/100) %>%
         select(-(!!sym(operationsName2))) 
     }
     
     if (nchar(operationsName3)>0)  {
       df <- df %>%
         mutate(!!sym(operationsName3) := input$operationsRole3/100*operations) %>%
         mutate(!!sym(paste0(operationsName3, "_L12")) := !!sym(operationsName3) * input$operationsRole3_L12/100) %>%
         mutate(!!sym(paste0(operationsName3, "_L34")) := !!sym(operationsName3) * input$operationsRole3_L34/100) %>%
         mutate(!!sym(paste0(operationsName3, "_L56")) := !!sym(operationsName3) * input$operationsRole3_L56/100) %>%
         mutate(!!sym(paste0(operationsName3, "_L78")) := !!sym(operationsName3) * input$operationsRole3_L78/100)  %>%
         select(-(!!sym(operationsName3))) 
     }
     
     if (nchar(operationsName4)>0)  {
       df <- df %>%
         mutate(!!sym(operationsName4) := input$operationsRole4/100*operations) %>%
         mutate(!!sym(paste0(operationsName4, "_L12")) := !!sym(operationsName4) * input$operationsRole4_L12/100) %>%
         mutate(!!sym(paste0(operationsName4, "_L34")) := !!sym(operationsName4) * input$operationsRole4_L34/100) %>%
         mutate(!!sym(paste0(operationsName4, "_L56")) := !!sym(operationsName4) * input$operationsRole4_L56/100) %>%
         mutate(!!sym(paste0(operationsName4, "_L78")) := !!sym(operationsName4) * input$operationsRole4_L78/100) %>%
         select(-(!!sym(operationsName4)), operations)
     }
     
      df <- df %>%
        select(-operations) %>%
        pivot_longer(cols = (2:ncol(.)), names_to = "discipline", values_to = "value")%>%
        as.data.frame()
     return(df)
     
   })

    combined <- reactive({
      rbind(civilsDataframe(), mehDataframe(), operationsDataframe()) %>%
        mutate(value = round(value,0)) %>%
        group_by(time, discipline) %>%
        summarise(value = sum(value))
    })
    
    combined_L12 <- reactive({
      combined() %>%
        filter(grepl("_L12", discipline)) %>%
        mutate(discipline = str_replace(discipline,"_L12", "")) %>%
        pivot_wider(names_from = discipline, values_from = value)
    })
    
        combined_L34 <- reactive({
      combined() %>%
        filter(grepl("_L34", discipline)) %>%
        mutate(discipline = str_replace(discipline,"_L34", ""))%>%
            pivot_wider(names_from = discipline, values_from = value)
    })
   
    combined_L56 <- reactive({
      combined() %>%
        filter(grepl("_L56", discipline)) %>%
        mutate(discipline = str_replace(discipline,"_L56", "")) %>%
        pivot_wider(names_from = discipline, values_from = value)
    })
    
    combined_L78 <- reactive({
      combined() %>%
        filter(grepl("_L78", discipline)) %>%
        mutate(discipline = str_replace(discipline,"_L78", ""))%>%
        pivot_wider(names_from = discipline, values_from = value)
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


