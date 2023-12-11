list(
  selectInput(  
  inputId = "dataGroup",
  label = "Display Group",
  choices = c("None",
              "HLRC",
              "LLRC",
              "Organisation",
              "Function",
              "Region",
              "Status",
              "Sub-sector",
              "Sector",
              "Site"),
  selected = "Function"
),

selectInput(  
  inputId = "dataGroupFilter",
  label = "Data Filter A",
  choices = c("None",
    "HLRC",
    "LLRC",
    "Organisation",
    "Function",
    "Region",
    "Status",
    "Sub-sector",
    "Sector",
    "Site"),
  selected = "None"
),


selectInput(  
  inputId = "dataGroupFilter2",
  label = "Data Filter B",
  choices = c("None",
              "HLRC",
              "LLRC",
              "Organisation",
              "Function",
              "Region",
              "Status",
              "Sub-sector",
              "Sector",
              "Site"),
  selected = "None"
),

hr(),

checkboxGroupInput(inputId = "levels",
                   label = "Levels",
                   choices = c("L12" = "L12", "L34" = "L34", "L56" = "L56", "L78" = "L78"),
                   selected = c("L12", "L34", "L56", "L78"),
                   inline = TRUE),
                #   choiceNames = c("L12", "L34", "L56", "L78"),
               #    choiceValues = c("L12", "L34", "L56", "L78")),

hr(),

radioButtons(
  inputId = "existingSel",
  label = "Defence and Exisitng Civil Data",
  choices = list("Set A", 
                 "Set B", 
                 "Set C",
                 "NULL",
                 "TEST"),
  selected = "Set B",
  inline = TRUE,
  #  "Combined Demand/Inflow" = 5)
),

hr(),

##Mean Range input$meanRange ####
sliderInput(
  inputId = "meanRange",
  label = "Region of Interest*",
  value = c(2023, 2043),
  min = 2023,
  max = 2043,
  step = 1,
  sep ="" #no comma in thousands
),

hr(),

radioButtons(inputId = "summary",
             choices = c("Demand", "Inflow", "Cumulative"),
             label = "Spot value", selected = "Demand", inline = TRUE
),

textInput(inputId = "selYear", label = "Year", value = "2030", width = '100px'),

hr(),

radioButtons(
  inputId = "lineDemand",
  label = "Demand Chart",
  choices = c("Stacked Layer" = FALSE, "Overlaid Line" = TRUE), inline = TRUE
  
),

checkboxInput(
  inputId = "lineRebase",
  label = "Demand Line Rebase",
  value = FALSE
  
),

hr(),

checkboxInput(
  
  inputId = "useAttritionFile",
  label = "Use attition file",
  value = FALSE
  
),

##Attrition input$attrition ####                                     
sliderInput(
  inputId = "attrition",
  label = "General attrition (%)",
  value = 7.5,
  min = 0,
  max = 15,
  step = 0.1,
  sep="" #no comma in thousands
), 

uiOutput("attritionStatus"),


sliderInput(
  inputId = "inflowAttrition",
  label = "Inflow attrition (%)",
  value = 2,
  min = 0,
  max = 15,
  step = 0.1,
  sep="" #no comma in thousands
),

##Attrition input$attrition ####                                     
sliderInput(
  inputId = "redeploy_coeff",
  label = "Redeployment co-efficient",
  value = 0.8,
  min = 0,
  max = 1,
  step = 0.01,
  sep="" #no comma in thousands
),

##Person-years Range input$integrateRange ####
# sliderInput(
#   inputId = "integrateRange",
#   label = "Person-years Range",
#   value = c(2024, 2040),
#   min = 2023,
#   max = 2043,
#   step = 1,
#   sep ="" #no comma in thousands
# ),

hr(),

radioButtons(
  inputId = "replaceExpand",
  label = "Replacement/Expansion",
  choices = list("Both" = "annualRecruitment",
                 "Expansion" = "annualRecruitmentExpansion",
                 "Replacement" = "annualRecruitmentReplacement")
),

checkboxInput(
  inputId = "combineRepExp",
  label = "Show Replacement/Expansion",
  value = FALSE
  
),

hr(),

checkboxInput(
  inputId = "filterYear1",
  label = "Show Initial Year (No inflow)",
  value = FALSE
),

hr(),

radioButtons(
  inputId = "csv_select",
  label = "Data set",
  choices = list("Demand" = 1, 
                 "Demand and Attrition line" = 2, 
                 "Required Inflow" = 3, 
                 "Cumulative Inflow" = 4) #,
               #  "Combined Demand/Inflow" = 5)
),

radioButtons(
  inputId = "dataFormat",
  label = "Data Format",
  choices = list("Narrow (to pivot)" = 1,
                 "Wide" = 2)
),

##Demand Download output$Dowload #### 
downloadButton(outputId = "downloadWorkforce", label = "Download CSV")

)