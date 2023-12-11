##Library dependancies ####
library(shiny)
library(shinyalert)
library(shinycssloaders)
library(dplyr)
library(tidyr)
library(tidyverse)
library(openxlsx)
library(bslib)
library(bsicons)

##Color Definitions ####
purple <- "#8667AAFF"
grey <- "#988B83FF"
gold <- "#ECBF6BFF"
blue <- "#6CA3B9FF"
magenta <- "#C76992FF"
black <- "#394049FF"
red <- "#D34B52FF"
tan <- "#E09B64FF"
green <- "#92C467FF"
InsuffData <- "#CCCCCCFF"
darkGreen <- "#0B5614FF"
moss <- "#8F945EFF"
darkRed <- "#700E0EFF"
rose <- "#A54D73FF"
greyGreen <- "#A0A599FF"
midnightBlue <- "#191970FF"

##Factors, Labels and Lists ####
LLRC_list <- c("All", "Abovewater Warfare Tactical",
               "Abovewater Warfare Weapons",
               "Administrators",
               "Analytical Sciences",
               "Architectural Engineers",
               "Artificial Intelligence / Machine Learning ",
               "Assurance and Testing",
               "Building envelope specialists",
               "Business Security",
               "Cable Pullers",
               "Cable Tray Fixers",
               "Chemical Engineers",
               "Chemists",
               "Civil and Structural Engineers",
               "Civil and Structural Operatives ",
               "Commercial Contracts",
               "Commercial Procurement",
               "Commercial Sales",
               "Commercial Support",
               "Commissioning Engineers",
               "Commissioning Operatives",
               "Construction Engineers",
               "Construction Management",
               "Construction Plant Operators",
               "Construction Site Managers",
               "Control and Instrumentation Engineers",
               "Control and Instrumentation Pipe Fitters",
               "Cost Control Engineers",
               "Craft Workers (not otherwise counted)",
               "Customer Facing",
               "Cyber Security",
               "Cyber Security (Defence)",
               "Data Analytics",
               "Decommissioning",
               "Design Engineers (C and I)",
               "Design Engineers (Electrical)",
               "Design Engineers (Mechanical)",
               "Digital Engineering",
               "Digital Transformation",
               "Electrical Engineers",
               "Electrical Operatives ",
               "Electronic Warfare",
               "Emergency - Fire and Medical Responders",
               "Emergency Planning",
               "Energy Marketing",
               "Engineering Construction Erectors",
               "Environmental Science Geology Hydrology and Modelling",
               "Estimating",
               "Executive and Strategy",
               "Expediting",
               "Facilities Management",
               "Fault Analysis Engineers",
               "Finance",
               "Fuel Processing",
               "Fuel Scientists",
               "General Mates",
               "Generation",
               "Health and Safety - Radiological Protection",
               "Health and Safety Regulation",
               "Human and Organisation Capability",
               "Human Resources",
               "Industrial Health and Safety",
               "IT",
               "Knowledge Management",
               "Labourers",
               "Learning and Development",
               "Legal",
               "Maintenance Engineers",
               "Manufacturing Engineers",
               "Material Science",
               "Mathematicians",
               "Mechanical and Electrical (combined) Engineers",
               "Mechanical Engineers",
               "Mechanical Fitters",
               "Mechanical Operatives",
               "Modelling and Analysis",
               "Non construction operatives",
               "Non-destructive Testing",
               "Nuclear Criticality and Shielding",
               "Nuclear Engineers",
               "Nuclear Materials Accountancy and Control",
               "Nuclear Materials Transport",
               "Nuclear Materials Transport Assessment",
               "Nuclear Trials",
               "Occupational Health",
               "Offsite Shop Based Workshop",
               "Operational Research",
               "Operations Transport",
               "Other construction (not otherwise counted)",
               "Other Construction Roles",
               "Other Engineers (including non-specific)",
               "Physical Advisory and Operations (Defence)",
               "Physicists",
               "Pipefitters",
               "Platers",
               "Post Irradiation Examination",
               "PR and Comms",
               "Process Engineers",
               "Programme Management",
               "Project Engineers",
               "Project Management",
               "Project Planning and Control",
               "Quality Assurance",
               "Quality Audit",
               "Regulation (EA)",
               "Regulation (ONR)",
               "Remote Engineering and Robotics",
               "Research Facility Operators",
               "Riggers",
               "Safety Case Preparation",
               "Scaffolders",
               "Security and Intelligence (Defence)",
               "Seismic",
               "Specialist building operatives (not otherwise counted)",
               "Steel Erectors",
               "Supervisors",
               "Supervisors (not otherwise counted)",
               "Support (not otherwise counted)",
               "Systems Engineers",
               "Technicians (not otherwise counted)",
               "Trades Support (not otherwise counted)",
               "Trading",
               "Underwater Warfare",
               "Ventilation Engineers",
               "Waste Management",
               "Welders",
               "Wood trades and interior fit-out")

HLRC_list <- c( "Security and Intelligence",
                "Remote Engineering and Robotics",
                "Military",
                "Research",
                "Research and Development",
                "Waste Management",
                "Environment/Geology",
                "Control and Instrumentation",
                "Transport",
                "Construction Management",
                "Project and Programme Management, Construction",
                "Civils",
                "Design",
                "Nuclear",
                "Radiological Safety/Health Physics",
                "Facilities Management Infrastructure",
                "Quality Management",
                "Project Controls",
                "Safety Case Management",
                "Science",
                "Electrical",
                "Fuel and Plant",
                "Industrial Safety",
                "Processing",
                "Project Management",
                "Building Trades",
                "Mechanical",
                "ME and I",
                "Commissioning and other Engineers",
                "Business Functions")

  
RCT_list <- c("Business Functions",
              "Operations",
              "Engineering",
              "Science Technical Health Safety & Environment",
              "Trades",
              "Project and Programme Management")

  
  Region_list <- c("East",
              "Midlands",
              "Northeast",
              "Northwest",
              "Scotland",
              "Southeast",
              "Southwest",
              "Wales",
              "No linked Region",
              "NSR")
  
  Status_list <- c("Construction",
                   "Manufacturing",
                   "Defueling ",
                   "HQ",
                   "Generation",
                   "TSO",
                   "Defence",
                   "New Build",
                   "Research and Development",
                   "Regulation",
                   "Transport",
                   "Supply Chain (non-ECI)",
                   "Decommissioning")
  
Subsector_list <- c("NNB",
                  "Operations",
                  "Decommissioning",
                  "Defence",
                  "Research",
                  "Regulator",
                  "Supply Chain")
  
  
Sector_list <- c("Civil", "Defence")

Site_list <- c("Barrow-in-Furness",
               "Berkeley Site",
               "Bristol",
               "Chapelcross Site",
               "Clyde",
               "Derby",
               "Devonport",
               "Dounreay",
               "Dungeness B",
               "Dungeness Site",
               "Generation HQ",
               "Hartlepool",
               "Harwell Site",
               "Heysham 1",
               "Heysham 2",
               "Hinkley Point B",
               "Hinkley Point C",
               "Hinkley Site",
               "Hunterston",
               "Hunterston Site",
               "London",
               "Magnox Support Office",
               "NNL_CULHAM",
               "NNL_NO SITE",
               "NNL_PRESTON",
               "NNL_RISLEY",
               "NNL_SELLAFIELD",
               "NNL_STONEHOUSE",
               "NNL_WINDSCALE",
               "NNL_WORKINGTON",
               "NTS",
               "Oldbury Site",
               "ONR",
               "Other",
               "Operationally committed",
               "Portsmouth",
               "Reading",
               "Rolls Royce Midlands",
               "Rolls Royce North West",
               "Sellafield Ltd",
               "Sizewell B",
               "Sizewell C",
               "Sizewell Site",
               "Supply Chain A",
               "Torness",
               "Trawsfynydd Site",
               "TSO HQ",
               "Winfrith Site",
               "Wylfa Site",
               "unit1",
               "unit2",
               "unit3",
               "unit4",
               "unit5",
               "unit6",
               "unit7",
               "unit8",
               "unit9",
               "unit10",
               "unit11",
               "unit12",
               "unit13",
               "unit14",
               "unit15",
               "unit16",
               "unit17",
               "unit18",
               "unit19",
               "unit20",
               "unit21",
               "unit22",
               "unit23",
               "unit24",
               "unit25",
               "unit26",
               "unit27",
               "unit28",
               "unit29",
               "unit30")


trainingArea_list <- c("All", "Advanced Engineering Construction",
  "Advanced Manufacturing",
  "Advanced Manufacturing Engineering",
  "Aerospace Manufacturing Electrical, Mechanical And Systems Fitter L3 ST0012",
  "Any other frameworks not reported above",
  "Any other standards not reported above",
  "Associate Project Manager  L4   ST0310",
  "Biology",
  "Building Services Engineering Ductwork Craftsperson  L3   ST0064",
  "Building Services Engineering Ductwork Installer  L2   ST0060",
  "Building Services Engineering Technician  L4   ST0041",
  "Building Services Engineering Technology & Project Management",
  "Business Administrator",
  "Business Administrator L3  ST0070",
  "Business Management",
  "BusinessÂ support Assisstant L2  ST0870",
  "Chartered Management",
  "Chartered Surveyor L6  ST0331",
  "Chem Engineeering",
  "Chemistry",
  "Civil Engineer (degree)  L6   ST0417",
  "Civil Engineering",
  "Civil Engineering Site Management (degree)  L6   ST0042",
  "Civil Engineering Technician  L3   ST0091",
  "Commercial",
  "Construction",
  "Construction & Built Environment",
  "Construction Building",
  "Construction Civil Engineering",
  "Construction Management",
  "Construction Quantity Surveying Technician L4 ST0049",
  "Construction Site Engineering Technician L4  ST0046",
  "Construction Site Management (degree) L6  ST0047",
  "Construction Specialist",
  "Construction Technical",
  "Construction: Civil Engineering",
  "Control / Technical Support Engineer (degree) L6  ST0023",
  "Control Systems",
  "Cyber Intrusion Analyst L4  ST0114",
  "Cyber Security",
  "Cyber Security Technical Professional (degree)  L6   ST0409",
  "Cyber Security Technologist  L4   ST0124",
  "Data Analyst L4  ST0118",
  "Demolition Operative L2  ST0615",
  "Design & Draughting",
  "Digital Applications",
  "Digital Degree Apprenticeship",
  "Digital Engineering Technician L3 ST0266",
  "Digital Telecommunications",
  "Digital User Experience (ux) Professional L6  ST0470",
  "Electrical And Instrumentation",
  "Electrical Electronic Engineering",
  "Electrical Electronic Product Service And Installation Engineer  L3   ST0150",
  "Electrical Electronic Product Service And Installation Engineer L3 ST0150",
  "Electrical Engineering",
  "Electrical Installation",
  "Electrical Maintenance",
  "Electronics",
  "Electrotechnical",
  "Engineering",
  "Engineering And Advanced Manufacturing Degree Apprenticeship",
  "Engineering Construct",
  "Engineering Construction Erector/rigger  L3   ST0433",
  "Engineering Construction Pipefitter L3  ST0162",
  "Engineering Environmental Technologies",
  "Engineering Fitter  L3   ST0432",
  "Engineering Machinists",
  "Engineering Maintenance",
  "Engineering Manufacture",
  "Engineering Manufacturing Technician L4  ST0841",
  "Engineering Operative  L2   ST0537",
  "Engineering Technical Support",
  "Engineering Technician  L3   ST0457",
  "Engineering: Design & Manufacture",
  "Engineering: Instrumentation, Measurement & Control",
  "Environmental Science",
  "Fabrication",
  "Facilities Management",
  "Facilities Management Supervisor L3  ST0170",
  "Facilities Manager  L4   ST0484",
  "Fire & Rescue (new)",
  "General Welder (Arc Processes) L2  ST0349",
  "Geology",
  "Geospatial Mapping & Science (degree)  L6   ST0492",
  "Geospatial Survey Technician  L3   ST0491",
  "Groundworker L2  ST0513",
  "Health Physics Monitor",
  "Health Physics Monitor L2  ST0290",
  "Heating Ventilation, Air Conditioning & Refrigeration",
  "HR",
  "HR  Consultant/partner, L5 ST0238",
  "Industrial Applications",
  "Installation Electrician/maintainance Electrician L3 ST0152",
  "Instrumentation & Control",
  "IT & Telecommunicati",
  "IT Infrastructure",
  "It Infrastructure Technician L3  ST0125",
  "IT Solutions Development & Support",
  "It, Software, Web & Telecoms Professionals",
  "Laboratory & Science Technicians",
  "Laboratory Scientist (degree) L6  ST0626",
  "Laboratory Technician L3  ST0248",
  "Land-based Service Engineering Technician L3 ST0243",
  "Life Science & Related Science Industries",
  "Life Sciences & Related Science Industr",
  "Lifting Technician  L2   ST0267",
  "Maintenance",
  "Maintenance And Operations Engineering Technician  L3   ST0154",
  "Managem",
  "Management",
  "Manufacturing Engineer (degree) L6 ST0025",
  "Marine Engineering",
  "Materials",
  "Maths",
  "Mechanical",
  "Mechanical Engineering",
  "Mechanical Fitting",
  "Mechanical Maintenance",
  "Metal Fabricator L3  ST0607",
  "Metrology Technician  L3   ST0282",
  "Multi-positional Welder (Arc Processes)  L3   ST0350",
  "Non-destructive Testing (NDT) Operator  L2   ST0358",
  "Non-destructive Testing Engineer (degree  L6   ST0369",
  "Non-destructive Testing Engineering Technician  L3   ST0288",
  "Non Destructive Testing",
  "Nuclear Operative (decommissioning) ST0291",
  "Nuclear Operative (process) ST0291",
  "Nuclear Power Plant Operations",
  "Nuclear Related Technology",
  "Nuclear Scientist & Nuclear Engineer (degree)  L6   ST0289",
  "Nuclear Technician  L5   ST0380",
  "Nuclear Welding Inspection Technician  L4   ST0292",
  "Nuclear Welding Inspection Technician (new)",
  "Nuclear Worker (process)",
  "Nuclear Working",
  "Occupational Health & Safety",
  "Other Graduate Intake Not Reported Above",
  "Physics",
  "Pipefitting",
  "Postgraduate Engineer (degree)  L7   ST0456",
  "Process Automation Engineer (degree)  L6   ST0407",
  "Process Leader  L4   ST0695",
  "Process Manufactur",
  "Process Manufacturing",
  "Product Design And Development Engineer (degree) L6 - ST0027",
  "Project Controls Technician  L3   ST0163",
  "Project Management",
  "Project Manager (degree)  L6   ST0411",
  "Rigging",
  "Risk And Safety Management Professional L7 Â  ST0465",
  "Safety Health And Environment Technician L3  ST0550",
  "Scaffolder L2  ST0359",
  "Science Industry Maintenance Technician  L3   ST0249",
  "Science Industry Process/plant Engineer (degree)  L6   ST0473",
  "Science Manufacturing Technician L3 ST0250",
  "Scientific Trainee",
  "Senior Leader L7  ST0480",
  "Senior Metrology Technician  L5   ST0283",
  "Steel Erecting",
  "Structural Steelwork Fabricator  L2   ST0099",
  "Supply Chain Operator L2 ST0258",
  "Supporting Engineering Construction Activities",
  "Supporting Engineering Construction Operations",
  "Surveying",
  "Systems Engineering (master's degree)  L7   ST0107",
  "Team Leader / Supervisor L3  ST0384",
  "Technician Scientist  L5   ST0597",
  "Through Life Engineering Services Specialist L7  ST0740",
  "Unified Communications Trouble Shooter L4  ST0131")


Function_List  <- c("Generation GigaWatt",
                   "Generation SMR",
                   "Construction GigaWatt",
                   "Construction SMR",
                   "Operations",
                   "Engineering",
                   "Project and Programme Management",
                   "Science Technical Health Safety & Environment",
                   "Trades",
                   "Business Functions")


Region_List <- c("All",
"Northwest",
"East",
"Southwest",
"Scotland",
"Northeast",
"Southeast",
"Wales",
"NSR",
"TBD",
"Region1",
"Region2")


##UI####
ui <- fluidPage(theme = bslib::bs_theme(bootswatch = "sandstone"),
  tags$head(
    tags$link(rel = "stylesheet", type = "text/css", href = "dark_mode.css")
  ),

    tags$head(
      tags$style(HTML('
  
  .column_w_bar {
      border-right-color: #6CA3B9;
      border-right-width: 1px;
      border-right-style: solid;
      
      font-size: 12px;
      
  }
    
  .row_w_bar {
      border: 4px double red;
      
    } 
  ') 
                  
                 
                 ) # end tags$style
    ), # end tags$head
  ##Title Panel####
  titlePanel("Draft NWM Dashboard"),
  tabsetPanel(type = "tabs",
              
              tabPanel("Home", fluid = TRUE,  style = "padding-top:30px",
                       
                       source("./source_files/ui_title_panel.R", local = TRUE)
              ),
  
   
  
##Demand Tab####                    
              tabPanel("Demand", fluid = TRUE, style = "padding-top:30px",
                  sidebarLayout(position = "left", 
                      sidebarPanel("Dataset", width = 2, 
                        source("./source_files/ui_demand_side_bar_panel.R", local = TRUE)
                                              ),
                                          
                                        #  downloadButton(outputId = "Download data")
                                         #     ),
                                          mainPanel(fluidRow(
                                            
                                            column(4, offset = 0, #style = "padding-top:30px",
                                                   value_box (title = "Mean", value = textOutput("meanVal", container = h2), 
                                                              showcase = bs_icon("bar-chart"), width = 1)),
                                            
                                            column(4, offset = 0, #style = "padding-top:30px",
                                                   value_box (title = "Peak", value = textOutput("maxValue", container = h2),
                                                              showcase = bs_icon("graph-up"), width = 1))
                                          ),
                                            
                                            
                                            fluidRow(
                                               
                                                              column(4, offset = 0, style = "padding-top:30px",
##Plot DEMAND output$LayerDemand  ####                                                                  
                                                             withSpinner(plotOutput(outputId = "LayerDemand", brush = "plot_brush"), hide.ui = FALSE)),
                                                             column(4, style = "padding-top:30px",

##Plot DEMAND and CURRENT PROJECTION output$demandSupply ####                                                                                                                              
                                                             withSpinner(plotOutput(outputId = "demandSupply", brush = "plot_brush"), hide.ui = FALSE)),
                                                             column(4, offset = 0, 
##Plot DEMAND LEGEND output$DemandLegend ####                                                                   
                                                             plotOutput(outputId = "DemandLegend"))),
                                                                    #p("Mean Annual Inflow: ", textOutput("mean", inline = TRUE), p("Max demand: ",
                                                                    #style="color:black;background-color:white;padding:15px;border-style:solid;
                                                                    #border-width:thin;border-radius:10px")))),
                                                    
                                                    fluidRow(column(4, 
##Plot REQUIRED RECRUITMENT output$ReqRec ####                                                                    
                                                            withSpinner(plotOutput(outputId = "ReqRec", brush = "plot_brush"), hide.ui = FALSE)),
                                                             column(4,
##Plot CUMULATIVE RECRUITMENT output$cumulative ####
                                                            withSpinner(plotOutput(outputId = "cumulative", brush = "plot_brush"), hide.ui = FALSE)),
                                                            # column(4, offset = 0,
                                                             #       tableOutput(outputId = "demandSummaryTable")),

                                                          
                                                         ),
                                                                          
                                                    width = 10)
                                         ),
                          ),

                  tabPanel("Demand Filters",
                           fluidRow(
                             
                       #      column(2,    
                       # checkboxGroupInput(inputId = "llrc_category", label = "LLRC", choices = LLRC_list, selected = LLRC_list),
                        #     ) ,    
                             column(class = 'column_w_bar', 1, style = "padding-top:30px", h5("LLRC"), 
                                    actionButton("gobutton", "Uncheck All"), actionButton("gobutton2", "Check All"),
                        checkboxGroupInput(inputId = "llrc_category", label = "", choices = LLRC_list, selected = LLRC_list),
                             ) ,
                             
                             column(class = 'column_w_bar',1, style = "padding-top:30px", h5("HLRC"),   
                        checkboxGroupInput(inputId = "hlrc_category", label = "", choices = HLRC_list, selected = HLRC_list),
                           ) , 
                        
                        column(class = 'column_w_bar', 1, style = "padding-top:30px", h5("Function/RCT"),
                        checkboxGroupInput(inputId = "rct_category", label = "", choices = RCT_list, selected = RCT_list)
                           ),
                        
                        column(class = 'column_w_bar',1, style = "padding-top:30px", h5("Region"),
                               checkboxGroupInput(inputId = "region_category", label = "", choices = Region_List, selected = Region_List)
                          ),
                        
                        column(class = 'column_w_bar',1, style = "padding-top:30px", h5("Status"),
                               checkboxGroupInput(inputId = "status_category", label = "", choices = Status_list, selected = Status_list)
                        ),
                        
                        column(class = 'column_w_bar',1, style = "padding-top:30px", h5("Subsector"),
                               checkboxGroupInput(inputId = "subsector_category", label = "", choices = Subsector_list, selected = Subsector_list)
                        ),
                        
                        column(class = 'column_w_bar',1, style = "padding-top:30px", h5("Sector"),
                               checkboxGroupInput(inputId = "sector_category", label = "", choices = Sector_list, selected = Sector_list)
                        ),
                        
                        column(class = 'column_w_bar',1, style = "padding-top:30px", h5("Site"),
                               checkboxGroupInput(inputId = "site_category", label = "", choices = Site_list, selected = "Barrow-in-Furness")
                        ),
                           
                            )
                        ),

                   
##Age####                 
                  tabPanel ("Age",
                            sidebarLayout(position = "left",
                                sidebarPanel("", width = 2,
##Age Sector selector input$sector_age ####                                            
                                          selectInput(
                                          inputId = "sector_age",
                                          label = "Sector",
                                          choices = c("All",  "Civil", "Defence"),
                                          selected = "All"
                                                     ),
##Age Gender selector input$gender_age ####
                                          selectInput(
                                            inputId = "gender_age",
                                            label = "Gender",
                                            choices = c("Male", "Female", "Non-binary", "All"),
                                            selected = "All"
                                                      ),
##Age Region selector input$region_age ####                                          
                                          selectInput(
                                            inputId = "region_age",
                                            label = "Region",
                                            choices = c(Region_List),
                                            selected = "All"
                                          ),
                                          
                                          selectInput(
                                            inputId = "llrc_age",
                                            label = "Resource Code",
                                            choices = (LLRC_list),#c("Electrical Engineers", "HLRC", "All"),
                                            multiple = TRUE,
                                            selected = "All"
                                                      ),
                                          
                                          radioButtons(
                                            inputId = "percent_age",
                                            label = "Main Y axis",
                                            choices = c("Absolute", "Percentage")
                                          ),
                                          
                                          downloadButton(outputId = "DownloadAge", label = "Download data")
                                              ),

                                        mainPanel(fluidRow(column(5,
                                                                  withSpinner(plotOutput(outputId = "agePlot", brush = "plot_brush"))),
                                                           column(5, 
                                                                  withSpinner(plotOutput(outputId = "agePlot_STEM"))),
                                                           # column(2,
                                                           #        p("This sample size: ", textOutput("total", inline = TRUE), 
                                                           #           style="color:black;background-color:white;padding:15px;border-style:solid;
                                                           #          border-width:thin;border-radius:10px"))
                                                           column(2, 
                                                                  dataTableOutput(outputId = "test"))     
                                                          ),
                                                  fluidRow(column(10, offset = ,
                                                                  withSpinner(plotOutput(outputId = "agePlot_RCT"))))
                                                  )
                                        ),

                          ),
##Level####                          
                  tabPanel("Level",
                           sidebarLayout(position = "left",
                                         sidebarPanel("", width = 2,
                                                      selectInput(
                                                        inputId = "sector_level",
                                                        label = "Sector",
                                                        choices = c("All",  "Civil", "Defence"),
                                                        selected = "All"
                                                      ),
                                                      
                                                      selectInput(
                                                        inputId = "gender_level",
                                                        label = "Gender",
                                                        choices = c("Male", "Female", "Non-binary", "All"),
                                                        selected = "All"
                                                      ),
                                                      
                                                      selectInput(
                                                        inputId = "region_level",
                                                        label = "Region",
                                                        choices = c(Region_List),
                                                        selected = "All"
                                                      ),
                                                      
                                                      selectInput(
                                                        inputId = "llrc_level",
                                                        label = "Resource Code",
                                                        choices = (LLRC_list),#c("Electrical Engineers", "HLRC", "All"),
                                                        multiple = TRUE,
                                                        selected = "All"
                                                      ),
                                                      
                                                      radioButtons(
                                                        inputId = "percent_level",
                                                        label = "Main Y axis",
                                                        choices = c("Absolute", "Percentage")
                                                      ),
                                                      
                                                      downloadButton(outputId = "Download3", label = "Download data")      
                                         ),

                                         mainPanel(fluidRow(column(5,
                                                                   withSpinner(plotOutput(outputId = "levelPlot", brush = "plot_brush"))),
                                                            column(5,
                                                                   withSpinner(plotOutput(outputId = "levelPlot_STEM", brush = "plot_brush")))
                                                            
                                                            ),
                                                   fluidRow(column(10, offset = ,
                                                                  withSpinner(plotOutput(outputId = "levelPlot_RCT"))))
                                        
                                                  )
                                        ),

                          ),
                                        
##Attrition####                 
tabPanel("Leavers",
         sidebarLayout(position = "left",
                       sidebarPanel("", width = 2,
                                    selectInput(
                                      inputId = "sector_levelLeavers",
                                      label = "Sector",
                                      choices = c("All",  "Civil", "Defence"),
                                      selected = "All"
                                    ),
                                    
                                    selectInput(
                                      inputId = "gender_levelLeavers",
                                      label = "Gender",
                                      choices = c("Male", "Female", "Non-binary", "All"),
                                      selected = "All"
                                    ),
                                    
                                    selectInput(
                                      inputId = "region_levelLeavers",
                                      label = "Region",
                                      choices = c(Region_List),
                                      selected = "All"
                                    ),
                                    
                                    selectInput(
                                      inputId = "llrc_levelLeavers",
                                      label = "Resource Code",
                                      choices = (LLRC_list),
                                      multiple = TRUE,
                                      selected = "All"
                                    ),
                                    
                                    radioButtons(
                                      inputId = "percent_leavers",
                                      label = "Main Y axis",
                                      choices = c("Absolute", "Percentage")
                                    ),
                                    
                                    downloadButton(outputId = "Download_leavers", label = "Download data")      
                       ),
                       
                       mainPanel(fluidRow(column(5,
                                                 plotOutput(outputId = "leaversPlot", brush = "plot_brush")),
                                          column(5,
                                                 plotOutput(outputId = "leaversPlot_STEM", brush = "plot_brush"))
                                          
                       ),
                       fluidRow(column(10, offset = ,
                                       plotOutput(outputId = "leaversPlot_RCT")))
                       
                       )
         ),
         
),


##EDI####                 
tabPanel("EDI",
         sidebarLayout(position = "left",
                       sidebarPanel("", width = 1,
                                    radioButtons(
                                      inputId = "percent_edi",
                                      label = "Main Y axis",
                                      choices = c("Absolute", "Percentage")
                                    ),
                                    selectInput(
                                      inputId = "EDI_table",
                                      label = "EDI Table",
                                      choices = c("Ethnicity",  "Disability", "Sexuality"),
                                      selected = "Ethnicity"
                                    ),
                                       downloadButton(outputId = "Download_EDI", label = "Download data")
                       ),
                       
                       mainPanel(  fluidRow(column(4, style = "padding:15px", fluidRow(style = "padding:10px"),
                                                 plotOutput(outputId = "ethnicityPlot", click = "plot_brush")),
                                            column(4, style = "padding:15px", fluidRow(style = "padding:10px"),
                                                   plotOutput(outputId = "disabilityPlot", brush = "plot_brush")),
                                            column(4, style = "padding:15px", fluidRow(style = "padding:10px"),
                                                   plotOutput(outputId = "sexualityPlot",  brush = "plot_brush")),
                                            column(4, style = "padding-left:100px", fluidRow(style = "padding:30px"),
                                                   tableOutput(outputId = "EDI_Data"))
                                            
                                            )                 
                      )
         ),
         
),

##Vacancy####                 
                  tabPanel("Vacancy rates",
                           sidebarLayout(position = "left",
                                         sidebarPanel("", width = 2,
                                                      selectInput(
                                                        inputId = "value",
                                                        label = "LLRC",
                                                        choices = c("A", "B", "C"),
                                                        selected = "A"
                                                      )
                                             ),
                                         
                                         mainPanel()
                                        )
                          ),
##Trainees####
 tabPanel("Training",
          sidebarLayout(position = "left",
                        sidebarPanel("", width = 2,
                                     selectInput(
                                       inputId = "sector_training",
                                       label = "Sector",
                                       choices = c("All",  "Civil", "Defence"),
                                       selected = "All"
                                     ),

                                     selectInput(
                                       inputId = "gender_training",
                                       label = "Gender",
                                       choices = c("Male", "Female", "Non-binary", "All"),
                                       selected = "All"
                                     ),

                                     selectInput(
                                       inputId = "region_training",
                                       label = "Region",
                                       choices = c(Region_List),
                                       selected = "All"
                                     ),

                                     selectInput(
                                       inputId = "llrc_training",
                                       label = "Training Area",
                                       choices = (trainingArea_list),
                                       multiple = TRUE,
                                       selected = "All"
                                     ),
#
                                     radioButtons(
                                       inputId = "percent_training",
                                       label = "Main Y axis",
                                       choices = c("Absolute", "Percentage")
                                     ),

                                     downloadButton(outputId = "Download_training", label = "Download data")
                        ),

                        mainPanel(
                                    fluidRow(column(5,
                                                  plotOutput(outputId = "trainingPlot", brush = "plot_brush")),
                                           column(5,
                                             plotOutput(outputId = "trainingPlot_STEM", brush = "plot_brush"))

                        ),
                        fluidRow(column(10, offset = ,
                                        plotOutput(outputId = "trainingPlot_RCT"))

                                      )
                                )
                        )
 ),
##Recruitment####                  
                  tabPanel("Recruitment",
                           sidebarLayout(position = "left",
                                         sidebarPanel("", width = 2,
                                                      selectInput(
                                                        inputId = "value",
                                                        label = "LLRC",
                                                        choices = c("A", "B", "C"),
                                                        selected = "A"
                                                                  )
                                                      ),
                                         
                                         mainPanel()
                                        
                        
                  
                     )#Tabset Panel end
               ),
##Select Reactor Models####
tabPanel("Unit model select",
         sidebarLayout(position = "left",
                       sidebarPanel("", width = 0,
                                    
                       ),
                       
                       mainPanel( 
                                fluidRow(column(class = 'column_w_bar',
                                                 width=2,
##Scenario unit model and region selectors ####                                       
                         radioButtons(
                         inputId = "unit1sel",
                         label= "Unit 1",
                         choices = c("None", "GW1", "GW2", "SMR1", "SMR2", "AMR"),
                         selected = "GW1",
                         inline = TRUE,
                         width = '100%',
                         choiceNames = NULL,
                         choiceValues = NULL
                       ),
                       
                       selectInput(
                         inputId ="unit1region",
                         label = "Unit 1 Regional Group",
                         choices = Region_List,
                         selected = "Southeast",
                         multiple = FALSE,
                         selectize = TRUE,
                         width = NULL,
                         size = NULL
                       ),
                       
                       radioButtons(
                         inputId = "unit2sel",
                         label= "Unit 2",
                         choices = c("None", "GW1", "GW2", "SMR1", "SMR2", "AMR"),
                         selected = "GW2",
                         inline = TRUE,
                         width = '100%',
                         choiceNames = NULL,
                         choiceValues = NULL
                       ),
                       
                       selectInput(
                         inputId ="unit2region",
                         label = "Unit 2 Regional Group",
                         choices = Region_List,
                         selected = "East",
                         multiple = FALSE,
                         selectize = TRUE,
                         width = NULL,
                         size = NULL
                       ),
                       
                       radioButtons(
                         inputId = "unit3sel",
                         label= "Unit 3",
                         choices = c("None", "GW1", "GW2", "SMR1", "SMR2", "AMR"),
                         selected = "None",
                         inline = TRUE,
                         width = '100%',
                         choiceNames = NULL,
                         choiceValues = NULL
                       ),
                       
                       selectInput(
                         inputId ="unit3region",
                         label = "Unit 3 Regional Group",
                         choices = Region_List,
                         selected = "TBD",
                         multiple = FALSE,
                         selectize = TRUE,
                         width = NULL,
                         size = NULL
                       ),
                       
                       radioButtons(
                         inputId = "unit4sel",
                         label= "Unit 4",
                         choices = c("None", "GW1", "GW2", "SMR1", "SMR2", "AMR"),
                         selected = "None",
                         inline = TRUE,
                         width = '100%',
                         choiceNames = NULL,
                         choiceValues = NULL
                       ),
                       
                       selectInput(
                         inputId ="unit4region",
                         label = "Unit 4 Regional Group",
                         choices = Region_List,
                         selected = "TBD",
                         multiple = FALSE,
                         selectize = TRUE,
                         width = NULL,
                         size = NULL
                       ),
                       radioButtons(
                         inputId = "unit5sel",
                         label= "Unit 5",
                         choices = c("None", "GW1", "GW2", "SMR1", "SMR2", "AMR"),
                         selected = "None",
                         inline = TRUE,
                         width = '100%',
                         choiceNames = NULL,
                         choiceValues = NULL
                       ),
                       
                       selectInput(
                         inputId ="unit5region",
                         label = "Unit 5 Regional Group",
                         choices = Region_List,
                         selected = "TBD",
                         multiple = FALSE,
                         selectize = TRUE,
                         width = NULL,
                         size = NULL
                       ),
                       
                       radioButtons(
                         inputId = "unit6sel",
                         label= "Unit 6",
                         choices = c("None", "GW1", "GW2", "SMR1", "SMR2", "AMR"),
                         selected = "None",
                         inline = TRUE,
                         width = '100%',
                         choiceNames = NULL,
                         choiceValues = NULL
                       ),
                       
                       selectInput(
                         inputId ="unit6region",
                         label = "Unit 6 Regional Group",
                         choices = Region_List,
                         selected = "TBD",
                         multiple = FALSE,
                         selectize = TRUE,
                         width = NULL,
                         size = NULL
                       )),
                       column (class = 'column_w_bar',
                               width=2,
                       radioButtons(
                         inputId = "unit7sel",
                         label= "Unit 7",
                         choices = c("None", "GW1", "GW2", "SMR1", "SMR2", "AMR"),
                         selected = "None",
                         inline = TRUE,
                         width = '100%',
                         choiceNames = NULL,
                         choiceValues = NULL
                       ),
                       
                       selectInput(
                         inputId ="unit7region",
                         label = "Unit 7 Regional Group",
                         choices = Region_List,
                         selected = "TBD",
                         multiple = FALSE,
                         selectize = TRUE,
                         width = NULL,
                         size = NULL
                       ),
                       
                       radioButtons(
                         inputId = "unit8sel",
                         label= "Unit 8",
                         choices = c("None", "GW1", "GW2", "SMR1", "SMR2", "AMR"),
                         selected = "None",
                         inline = TRUE,
                         width = '100%',
                         choiceNames = NULL,
                         choiceValues = NULL
                       ),
                       
                       selectInput(
                         inputId ="unit8region",
                         label = "Unit 8 Regional Group",
                         choices = Region_List,
                         selected = "TBD",
                         multiple = FALSE,
                         selectize = TRUE,
                         width = NULL,
                         size = NULL
                       ),
                       
                       radioButtons(
                         inputId = "unit9sel",
                         label= "Unit 9",
                         choices = c("None", "GW1", "GW2", "SMR1", "SMR2", "AMR"),
                         selected = "None",
                         inline = TRUE,
                         width = '100%',
                         choiceNames = NULL,
                         choiceValues = NULL
                       ),
                       
                       selectInput(
                         inputId ="unit9region",
                         label = "Unit 9 Regional Group",
                         choices = Region_List,
                         selected = "TBD",
                         multiple = FALSE,
                         selectize = TRUE,
                         width = NULL,
                         size = NULL
                       ),
                       
                       radioButtons(
                         inputId = "unit10sel",
                         label= "Unit 10",
                         choices = c("None", "GW1", "GW2", "SMR1", "SMR2", "AMR"),
                         selected = "None",
                         inline = TRUE,
                         width = '100%',
                         choiceNames = NULL,
                         choiceValues = NULL
                       ),
                       
                       selectInput(
                         inputId ="unit10region",
                         label = "Unit 10 Regional Group",
                         choices = Region_List,
                         selected = "TBD",
                         multiple = FALSE,
                         selectize = TRUE,
                         width = NULL,
                         size = NULL
                       ),
                       
                       radioButtons(
                         inputId = "unit11sel",
                         label= "Unit 11",
                         choices = c("None", "GW1", "GW2", "SMR1", "SMR2", "AMR"),
                         selected = "None",
                         inline = TRUE,
                         width = '100%',
                         choiceNames = NULL,
                         choiceValues = NULL
                       ),
                       
                       selectInput(
                         inputId ="unit11region",
                         label = "Unit 11 Regional Group",
                         choices = Region_List,
                         selected = "TBD",
                         multiple = FALSE,
                         selectize = TRUE,
                         width = NULL,
                         size = NULL
                       ),
                       
                       radioButtons(
                         inputId = "unit12sel",
                         label= "Unit 12",
                         choices = c("None", "GW1", "GW2", "SMR1", "SMR2", "AMR"),
                         selected = "None",
                         inline = TRUE,
                         width = '100%',
                         choiceNames = NULL,
                         choiceValues = NULL
                       ),
                       
                       selectInput(
                         inputId ="unit12region",
                         label = "Unit 12 Regional Group",
                         choices = Region_List,
                         selected = "TBD",
                         multiple = FALSE,
                         selectize = TRUE,
                         width = NULL,
                         size = NULL
                       )),
                       column (class = 'column_w_bar',
                               width=2,
                       radioButtons(
                         inputId = "unit13sel",
                         label= "Unit 13",
                         choices = c("None", "GW1", "GW2", "SMR1", "SMR2", "AMR"),
                         selected = "None",
                         inline = TRUE,
                         width = '100%',
                         choiceNames = NULL,
                         choiceValues = NULL
                       ),
                       
                       selectInput(
                         inputId ="unit13region",
                         label = "Unit 13 Regional Group",
                         choices = Region_List,
                         selected = "TBD",
                         multiple = FALSE,
                         selectize = TRUE,
                         width = NULL,
                         size = NULL
                       ),
                       
                       radioButtons(
                         inputId = "unit14sel",
                         label= "Unit 14",
                         choices = c("None", "GW1", "GW2", "SMR1", "SMR2", "AMR"),
                         selected = "None",
                         inline = TRUE,
                         width = '100%',
                         choiceNames = NULL,
                         choiceValues = NULL
                       ),
                       
                       selectInput(
                         inputId ="unit14region",
                         label = "Unit 14 Regional Group",
                         choices = Region_List,
                         selected = "TBD",
                         multiple = FALSE,
                         selectize = TRUE,
                         width = NULL,
                         size = NULL
                       ),
                       
                       radioButtons(
                         inputId = "unit15sel",
                         label= "Unit 15",
                         choices = c("None", "GW1", "GW2", "SMR1", "SMR2", "AMR"),
                         selected = "None",
                         inline = TRUE,
                         width = '100%',
                         choiceNames = NULL,
                         choiceValues = NULL
                       ),
                       
                       selectInput(
                         inputId ="unit15region",
                         label = "Unit 15 Regional Group",
                         choices = Region_List,
                         selected = "TBD",
                         multiple = FALSE,
                         selectize = TRUE,
                         width = NULL,
                         size = NULL
                       ),
                       
                       radioButtons(
                         inputId = "unit16sel",
                         label= "Unit 16",
                         choices = c("None", "GW1", "GW2", "SMR1", "SMR2", "AMR"),
                         selected = "None",
                         inline = TRUE,
                         width = '100%',
                         choiceNames = NULL,
                         choiceValues = NULL
                       ),
                     
                       selectInput(
                         inputId ="unit16region",
                         label = "Unit 16 Regional Group",
                         choices = Region_List,
                         selected = "TBD",
                         multiple = FALSE,
                         selectize = TRUE,
                         width = NULL,
                         size = NULL
                       ),
                       
                       radioButtons(
                         inputId = "unit17sel",
                         label= "Unit 17",
                         choices = c("None", "GW1", "GW2", "SMR1", "SMR2", "AMR"),
                         selected = "None",
                         inline = TRUE,
                         width = '100%',
                         choiceNames = NULL,
                         choiceValues = NULL
                       ),
                       
                       selectInput(
                         inputId ="unit17region",
                         label = "Unit 17 Regional Group",
                         choices = Region_List,
                         selected = "TBD",
                         multiple = FALSE,
                         selectize = TRUE,
                         width = NULL,
                         size = NULL
                       ),
                       
                       radioButtons(
                         inputId = "unit18sel",
                         label= "Unit 18",
                         choices = c("None", "GW1", "GW2", "SMR1", "SMR2", "AMR"),
                         selected = "None",
                         inline = TRUE,
                         width = '100%',
                         choiceNames = NULL,
                         choiceValues = NULL
                       ),
                       
                       selectInput(
                         inputId ="unit18region",
                         label = "Unit 18 Regional Group",
                         choices = Region_List,
                         selected = "TBD",
                         multiple = FALSE,
                         selectize = TRUE,
                         width = NULL,
                         size = NULL
                       )),
                       column (class = 'column_w_bar',
                               width=2,
                       radioButtons(
                         inputId = "unit19sel",
                         label= "Unit 19",
                         choices = c("None", "GW1", "GW2", "SMR1", "SMR2", "AMR"),
                         selected = "None",
                         inline = TRUE,
                         width = '100%',
                         choiceNames = NULL,
                         choiceValues = NULL
                       ),
                       
                       selectInput(
                         inputId ="unit19region",
                         label = "Unit 19 Regional Group",
                         choices = Region_List,
                         selected = "TBD",
                         multiple = FALSE,
                         selectize = TRUE,
                         width = NULL,
                         size = NULL
                       ),
                       
                       radioButtons(
                         inputId = "unit20sel",
                         label= "Unit 20",
                         choices = c("None", "GW1", "GW2", "SMR1", "SMR2", "AMR"),
                         selected = "None",
                         inline = TRUE,
                         width = '100%',
                         choiceNames = NULL,
                         choiceValues = NULL
                       ),
                       
                       selectInput(
                         inputId ="unit20region",
                         label = "Unit 20 Regional Group",
                         choices = Region_List,
                         selected = "TBD",
                         multiple = FALSE,
                         selectize = TRUE,
                         width = NULL,
                         size = NULL
                       ),
                       radioButtons(
                         inputId = "unit21sel",
                         label= "Unit 21",
                         choices = c("None", "GW1", "GW2", "SMR1", "SMR2", "AMR"),
                         selected = "None",
                         inline = TRUE,
                         width = '100%',
                         choiceNames = NULL,
                         choiceValues = NULL
                       ),
                       
                       selectInput(
                         inputId ="unit21region",
                         label = "Unit 21 Regional Group",
                         choices = Region_List,
                         selected = "TBD",
                         multiple = FALSE,
                         selectize = TRUE,
                         width = NULL,
                         size = NULL
                       ),
                       
                       radioButtons(
                         inputId = "unit22sel",
                         label= "Unit 22",
                         choices = c("None", "GW1", "GW2", "SMR1", "SMR2", "AMR"),
                         selected = "None",
                         inline = TRUE,
                         width = '100%',
                         choiceNames = NULL,
                         choiceValues = NULL
                       ),
                       
                       selectInput(
                         inputId ="unit22region",
                         label = "Unit 22 Regional Group",
                         choices = Region_List,
                         selected = "TBD",
                         multiple = FALSE,
                         selectize = TRUE,
                         width = NULL,
                         size = NULL
                       ),
                       
                               radioButtons(
                                 inputId = "unit23sel",
                                 label= "Unit 23",
                                 choices = c("None", "GW1", "GW2", "SMR1", "SMR2", "AMR"),
                                 selected = "None",
                                 inline = TRUE,
                                 width = '100%',
                                 choiceNames = NULL,
                                 choiceValues = NULL
                               ),
                               
                               selectInput(
                                 inputId ="unit23region",
                                 label = "Unit 23 Regional Group",
                                 choices = Region_List,
                                 selected = "TBD",
                                 multiple = FALSE,
                                 selectize = TRUE,
                                 width = NULL,
                                 size = NULL
                               ),
                               
                               radioButtons(
                                 inputId = "unit24sel",
                                 label= "Unit 24",
                                 choices = c("None", "GW1", "GW2", "SMR1", "SMR2", "AMR"),
                                 selected = "None",
                                 inline = TRUE,
                                 width = '100%',
                                 choiceNames = NULL,
                                 choiceValues = NULL
                               ),
                               
                               selectInput(
                                 inputId ="unit24region",
                                 label = "Unit 24 Regional Group",
                                 choices = Region_List,
                                 selected = "TBD",
                                 multiple = FALSE,
                                 selectize = TRUE,
                                 width = NULL,
                                 size = NULL
                               )),
                              column (class = 'column_w_bar',
                                      width=2,
                               radioButtons(
                                 inputId = "unit25sel",
                                 label= "Unit 25",
                                 choices = c("None", "GW1", "GW2", "SMR1", "SMR2", "AMR"),
                                 selected = "None",
                                 inline = TRUE,
                                 width = '100%',
                                 choiceNames = NULL,
                                 choiceValues = NULL
                               ),
                               
                               selectInput(
                                 inputId ="unit25region",
                                 label = "Unit 25 Regional Group",
                                 choices = Region_List,
                                 selected = "TBD",
                                 multiple = FALSE,
                                 selectize = TRUE,
                                 width = NULL,
                                 size = NULL
                               ),
                               
                               radioButtons(
                                 inputId = "unit26sel",
                                 label= "Unit 26",
                                 choices = c("None", "GW1", "GW2", "SMR1", "SMR2", "AMR"),
                                 selected = "None",
                                 inline = TRUE,
                                 width = '100%',
                                 choiceNames = NULL,
                                 choiceValues = NULL
                               ),
                               
                               selectInput(
                                 inputId ="unit26region",
                                 label = "Unit 26 Regional Group",
                                 choices = Region_List,
                                 selected = "TBD",
                                 multiple = FALSE,
                                 selectize = TRUE,
                                 width = NULL,
                                 size = NULL
                               ),
                               
                               radioButtons(
                                 inputId = "unit27sel",
                                 label= "Unit 27",
                                 choices = c("None", "GW1", "GW2", "SMR1", "SMR2", "AMR"),
                                 selected = "None",
                                 inline = TRUE,
                                 width = '100%',
                                 choiceNames = NULL,
                                 choiceValues = NULL
                               ),
                               
                               selectInput(
                                 inputId ="unit27region",
                                 label = "Unit 27 Regional Group",
                                 choices = Region_List,
                                 selected = "TBD",
                                 multiple = FALSE,
                                 selectize = TRUE,
                                 width = NULL,
                                 size = NULL
                               ),
                               
                               radioButtons(
                                 inputId = "unit28sel",
                                 label= "Unit 28",
                                 choices = c("None", "GW1", "GW2", "SMR1", "SMR2", "AMR"),
                                 selected = "None",
                                 inline = TRUE,
                                 width = '100%',
                                 choiceNames = NULL,
                                 choiceValues = NULL
                               ),
                               
                               selectInput(
                                 inputId ="unit28region",
                                 label = "Unit 28 Regional Group",
                                 choices = Region_List,
                                 selected = "TBD",
                                 multiple = FALSE,
                                 selectize = TRUE,
                                 width = NULL,
                                 size = NULL
                               ),
                       
                               radioButtons(
                                 inputId = "unit29sel",
                                 label= "Unit 29",
                                 choices = c("None", "GW1", "GW2", "SMR1", "SMR2", "AMR"),
                                 selected = "None",
                                 inline = TRUE,
                                 width = '100%',
                                 choiceNames = NULL,
                                 choiceValues = NULL
                               ),
                               
                               selectInput(
                                 inputId ="unit29region",
                                 label = "Unit 29 Regional Group",
                                 choices = Region_List,
                                 selected = "TBD",
                                 multiple = FALSE,
                                 selectize = TRUE,
                                 width = NULL,
                                 size = NULL
                               ),
                               
                               radioButtons(
                                 inputId = "unit30sel",
                                 label= "Unit 30",
                                 choices = c("None", "GW1", "GW2", "SMR1", "SMR2", "AMR"),
                                 selected = "None",
                                 inline = TRUE,
                                 width = '100%',
                                 choiceNames = NULL,
                                 choiceValues = NULL
                               ),
                               
                               selectInput(
                                 inputId ="unit30region",
                                 label = "Unit 30 Regional Group",
                                 choices = Region_List,
                                 selected = "TBD",
                                 multiple = FALSE,
                                 selectize = TRUE,
                                 width = NULL,
                                 size = NULL
                               )
                       
                       )
                       
                  )
                       )       
                       
                       
         )#Tabset Panel end
),

##Scenario GW Generating capacity input$capacityGW1  ####
                tabPanel("Scenarios",
                        sidebarLayout(position = "left",
                                      sidebarPanel("", width = 2,
                                                   sliderInput(
                                                     inputId = "capacityGW1",
                                                     label = "GW1 Single Reactor Capacity /GWe",
                                                     value = 3.2,
                                                     min = 0,
                                                     max = 10,
                                                     step = 0.01,
                                                     width = NULL
                                                   ),
                                                   
##Scenario GW1 Build time input$buildTimeGW1  ####
                                                    sliderInput(
                                                     inputId = "buildTimeGW1",
                                                     label = "GW1 Build Duration (Years)",
                                                     value = 7,
                                                     min = 0,
                                                     max = 15,
                                                     step = 0.1,
                                                     width = NULL
                                                   ),
##Scenario GW Generating capacity input$capacityGW2  ####
                                                   sliderInput(
                                                     inputId = "capacityGW2",
                                                     label = "GW2 Capacity /GWe",
                                                     value = 3.2,
                                                     min = 0,
                                                     max = 10,
                                                     step = 0.01,
                                                     width = NULL
                                                   ),
#Scenario GW1 Build time input$buildTimeGW1  ####
                                                  sliderInput(
                                                    inputId = "buildTimeGW2",
                                                    label = "GW2 Build Duration (Years)",
                                                    value = 9,
                                                    min = 0,
                                                    max = 15,
                                                    step = 0.1,
                                                    width = NULL
                                                  ),


##Scenario SMR Generating capacity input$capacitySMR1 ####
                                                  sliderInput(
                                                     inputId = "capacitySMR1",
                                                     label = "SMR1 Capacity /GWe",
                                                     value = 0.4,
                                                     min = 0,
                                                     max = 10,
                                                     step = 0.01,
                                                     width = NULL
                                                   ),
#Scenario GW1 Build time input$buildTimeGW1  ####
                                                  sliderInput(
                                                      inputId = "buildTimeSMR1",
                                                      label = "SMR1 Build Duration (Years)",
                                                      value = 4,
                                                      min = 0,
                                                      max = 15,
                                                      step = 0.1,
                                                      width = NULL
                                                    ),




##Scenario SMR Generating capacity input$capacitySMR2 ####
                                                  sliderInput(
                                                     inputId = "capacitySMR2",
                                                     label = "SMR2 Capacity /GWe",
                                                     value = 0.33,
                                                     min = 0,
                                                     max = 10,
                                                     step = 0.01,
                                                     width = NULL
                                                   ),

#Scenario GW1 Build time input$buildTimeGW1  ####
                                                  sliderInput(
                                                    inputId = "buildTimeSMR2",
                                                    label = "SMR1 Build Duration (Years)",
                                                    value = 4,
                                                    min = 0,
                                                    max = 15,
                                                    step = 0.1,
                                                    width = NULL
                                                  ),

                                                  
                                                  textInput(inputId = "scenarioTitle", label = "Scenario Title", value = "Default"),


##SAVE scenario ####
                                                   downloadButton(outputId = "downloadData", label = "Save Scenario"),
                                             
                                      
                                                fileInput("file1", "Load Scenario",
                                                multiple = FALSE,
                                                accept = c("text/csv",
                                                           "text/comma-separated-values,text/plain",
                                                           ".csv"))),
                       
                                      mainPanel(
##Plot SCENARIO output$data_test #####                                        
                                          fluidRow(column (6, withSpinner(plotOutput(outputId = "Capacity"), hide.ui = FALSE)),
                                
                                                   column (6, withSpinner(plotOutput(outputId = "data_test"), hide.ui = FALSE))),       
                              







##Scenario Start Years input$unitXstart ####                                       
                                        fluidRow(column (2, sliderInput(
                                        inputId = "unit1start",
                                        label = "Unit 1 Start Year",
                                        value = c(2020),
                                        min = 2020,
                                        max = 2055,
                                        step = 1,
                                        sep ="" #no comma in thousands
                                      ),
                                      sliderInput(
                                        inputId = "unit2start",
                                        label = "Unit 2 Start Year",
                                        value = c(2027),
                                        min = 2020,
                                        max = 2055,
                                        step = 1,
                                        sep ="" #no comma in thousands
                                      ),
                                      sliderInput(
                                        inputId = "unit3start",
                                        label = "Unit 3 Start Year",
                                        value = c(2024),
                                        min = 2020,
                                        max = 2055,
                                        step = 1,
                                        sep ="" #no comma in thousands
                                      ),
                                      sliderInput(
                                        inputId = "unit4start",
                                        label = "Unit 4 Start Year",
                                        value = c(2025),
                                        min = 2020,
                                        max = 2055,
                                        step = 1,
                                        sep ="" #no comma in thousands
                                      ),
                                      sliderInput(
                                        inputId = "unit5start",
                                        label = "Unit 5 Start Year",
                                        value = c(2026),
                                        min = 2020,
                                        max = 2055,
                                        step = 1,
                                        sep ="" #no comma in thousands
                                      ),
                                      sliderInput(
                                        inputId = "unit6start",
                                        label = "Unit 6 Start Year",
                                        value = c(2027),
                                        min = 2020,
                                        max = 2055,
                                        step = 1,
                                        sep ="" #no comma in thousands
                                      )),
                                      column(2,
                                      sliderInput(
                                        inputId = "unit7start",
                                        label = "Unit 7 Start Year",
                                        value = c(2028),
                                        min = 2020,
                                        max = 2055,
                                        step = 1,
                                        sep ="" #no comma in thousands
                                      ),
                                      sliderInput(
                                        inputId = "unit8start",
                                        label = "Unit 8 Start Year",
                                        value = c(2029),
                                        min = 2020,
                                        max = 2055,
                                        step = 1,
                                        sep ="" #no comma in thousands
                                      ),
                                      sliderInput(
                                        inputId = "unit9start",
                                        label = "Unit 9 Start Year",
                                        value = c(2030),
                                        min = 2020,
                                        max = 2055,
                                        step = 1,
                                        sep ="" #no comma in thousands
                                      ),
                                      sliderInput(
                                        inputId = "unit10start",
                                        label = "Unit 10 Start Year",
                                        value = c(2031),
                                        min = 2020,
                                        max = 2055,
                                        step = 1,
                                        sep ="" #no comma in thousands
                                      ),
                                      sliderInput(
                                        inputId = "unit11start",
                                        label = "Unit 11 Start Year",
                                        value = c(2032),
                                        min = 2020,
                                        max = 2055,
                                        step = 1,
                                        sep ="" #no comma in thousands
                                      ),
                                      sliderInput(
                                        inputId = "unit12start",
                                        label = "Unit 12 Start Year",
                                        value = c(2033),
                                        min = 2020,
                                        max = 2055,
                                        step = 1,
                                        sep ="" #no comma in thousands
                                      )),
                                      column(2,
                                             sliderInput(
                                               inputId = "unit13start",
                                               label = "Unit 13 Start Year",
                                               value = c(2034),
                                               min = 2020,
                                               max = 2055,
                                               step = 1,
                                               sep ="" #no comma in thousands
                                             ),
                                             sliderInput(
                                               inputId = "unit14start",
                                               label = "Unit 14 Start Year",
                                               value = c(2035),
                                               min = 2020,
                                               max = 2055,
                                               step = 1,
                                               sep ="" #no comma in thousands
                                             ),
                                             sliderInput(
                                               inputId = "unit15start",
                                               label = "Unit 15 Start Year",
                                               value = c(2036),
                                               min = 2020,
                                               max = 2055,
                                               step = 1,
                                               sep ="" #no comma in thousands
                                             ),
                                             sliderInput(
                                               inputId = "unit16start",
                                               label = "Unit 16 Start Year",
                                               value = c(2037),
                                               min = 2020,
                                               max = 2055,
                                               step = 1,
                                               sep ="" #no comma in thousands
                                             ),
                                             sliderInput(
                                               inputId = "unit17start",
                                               label = "Unit 17 Start Year",
                                               value = c(2038),
                                               min = 2020,
                                               max = 2055,
                                               step = 1,
                                               sep ="" #no comma in thousands
                                             ),
                                             sliderInput(
                                               inputId = "unit18start",
                                               label = "Unit 18 Start Year",
                                               value = c(2039),
                                               min = 2020,
                                               max = 2055,
                                               step = 1,
                                               sep ="" #no comma in thousands
                                             )),
                                      column(2,
                                             sliderInput(
                                               inputId = "unit19start",
                                               label = "Unit 19 Start Year",
                                               value = c(2040),
                                               min = 2020,
                                               max = 2055,
                                               step = 1,
                                               sep ="" #no comma in thousands
                                             ),
                                             sliderInput(
                                               inputId = "unit20start",
                                               label = "Unit 20 Start Year",
                                               value = c(2041),
                                               min = 2020,
                                               max = 2055,
                                               step = 1,
                                               sep ="" #no comma in thousands
                                             ),
                                             sliderInput(
                                               inputId = "unit21start",
                                               label = "Unit 21 Start Year",
                                               value = c(2042),
                                               min = 2020,
                                               max = 2055,
                                               step = 1,
                                               sep ="" #no comma in thousands
                                             ),
                                             sliderInput(
                                               inputId = "unit22start",
                                               label = "Unit 22 Start Year",
                                               value = c(2043),
                                               min = 2020,
                                               max = 2055,
                                               step = 1,
                                               sep ="" #no comma in thousands
                                             ),
                                             sliderInput(
                                               inputId = "unit23start",
                                               label = "Unit 23 Start Year",
                                               value = c(2044),
                                               min = 2020,
                                               max = 2055,
                                               step = 1,
                                               sep ="" #no comma in thousands
                                             ),
                                             sliderInput(
                                               inputId = "unit24start",
                                               label = "Unit 24 Start Year",
                                               value = c(2022),
                                               min = 2020,
                                               max = 2055,
                                               step = 1,
                                               sep ="" #no comma in thousands
                                             )),
                                      column(2,
                                             sliderInput(
                                               inputId = "unit25start",
                                               label = "Unit 25 Start Year",
                                               value = c(2022),
                                               min = 2020,
                                               max = 2055,
                                               step = 1,
                                               sep ="" #no comma in thousands
                                             ),
                                             sliderInput(
                                               inputId = "unit26start",
                                               label = "Unit 26 Start Year",
                                               value = c(2022),
                                               min = 2020,
                                               max = 2055,
                                               step = 1,
                                               sep ="" #no comma in thousands
                                             ),
                                             sliderInput(
                                               inputId = "unit27start",
                                               label = "Unit 27 Start Year",
                                               value = c(2022),
                                               min = 2020,
                                               max = 2055,
                                               step = 1,
                                               sep ="" #no comma in thousands
                                             ),
                                             sliderInput(
                                               inputId = "unit28start",
                                               label = "Unit 28 Start Year",
                                               value = c(2022),
                                               min = 2020,
                                               max = 2055,
                                               step = 1,
                                               sep ="" #no comma in thousands
                                             ),
                                             sliderInput(
                                               inputId = "unit29start",
                                               label = "Unit 29 Start Year",
                                               value = c(2022),
                                               min = 2020,
                                               max = 2055,
                                               step = 1,
                                               sep ="" #no comma in thousands
                                             ),
                                             sliderInput(
                                               inputId = "unit30start",
                                               label = "Unit 30 Start Year",
                                               value = c(2022),
                                               min = 2020,
                                               max = 2055,
                                               step = 1,
                                               sep ="" #no comma in thousands
                                              )),
                                               
                                             column(2,
                                             sliderInput(
                                                 inputId = "manuf1range",
                                                 label = "Manufacturing Unit 1",
                                                 value = c(2030, 2045),
                                                 min = 2020,
                                                 max = 2055,
                                                 step = 1,
                                                 sep ="" #no comma in thousands
                                             ),
                                             sliderInput(
                                               inputId = "manuf2range",
                                               label = "Manufacturing Unit 2",
                                               value = c(2030, 2045),
                                               min = 2020,
                                               max = 2055,
                                               step = 1,
                                               sep ="" #no comma in thousands
                                             ),
                                             sliderInput(
                                               inputId = "manuf3range",
                                               label = "Manufacturing Unit 3",
                                               value = c(2030, 2045),
                                               min = 2020,
                                               max = 2055,
                                               step = 1,
                                               sep ="" #no comma in thousands
                                             
                                             ))
                                      
                                      
                                      )
                                , width = 10)#main panel end
                      )

              ),
              tabPanel("Settings",
                       
                       mainPanel(fileInput("existing_new", "Load Existing Estate Data",
                                           multiple = FALSE,
                                           accept = c("text/csv",
                                                      "text/comma-separated-values,text/plain",
                                                      ".zip")),
                                 radioButtons(
                                   inputId = "scaleAuto",
                                   label= "Y-axis scaling",
                                   choices = c("Auto", "Manual"),
                                   selected = "Auto",
                                   inline = TRUE,
                                   width = '100%',
                                   choiceNames = NULL,
                                   choiceValues = NULL
                                 ),
                                 
                                 numericInput(
                                   inputId = "demandLimit",
                                   label= "Max Demand",
                                   value = 120000,
                                   min = 10,
                                   max = 200000,
                                   step = 10,
                                   width = NULL
                                 ),
                                 
                                 numericInput(
                                   inputId = "inflowLimit",
                                   label= "Max Inflow",
                                   value = 40000,
                                   min = 10,
                                   max = 70000,
                                   step = 10,
                                   width = NULL
                                 ),
                                 
                                 numericInput(
                                   inputId = "cumulativeLimit",
                                   label= "Max Cumulative",
                                   value = 350000,
                                   min = 10,
                                   max = 600000,
                                   step = 10,
                                   width = NULL
                                 )
                                 
                                 ))
        )#Fluid Page end

)
             
        

  
  
  

