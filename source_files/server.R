##Library dependencies ####
library(shiny)
library(DT)
library(tidyr)
library(tidyverse)
library(ggrepel)
library(ggplot2)
library(ggpubr) #extracting legend from plot
library(viridis)
library(thematic)
library(purrr)
library(openxlsx)
library(dplyr)

##Time Delta####
timeDelta <- 12 #time axis resolution in months. Needs to be 12 to match existing estate data (unless that is ever interpolated)

##Colour defintions#### 
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
  
RCTLabels <- c(magenta, 
               darkGreen, 
               darkRed, 
               midnightBlue, 
               tan, 
               greyGreen)
                                
nssg_palette <- c(gold,
blue,
rose,
purple, 
black,
greyGreen,
magenta,
darkGreen,
red,
tan,
green,
grey,
moss,
darkRed,
midnightBlue)

colourFunctionMap <- c(
  "Generation GigaWatt"= gold,
  "Generation SMR" = blue,
  "Construction GigaWatt" = greyGreen,
  "Construction SMR" = darkGreen,
  "Construction" = darkGreen,
  "Operations" = midnightBlue,
  "Engineering" = darkRed,
  "Project and Programme Management" = moss,
  "Science Technical Health Safety & Environment" = magenta,
  "Trades" = purple,
  "Business Functions" = grey)
##Factors and labels####
FunctionOrder <- c("Construction",
  "Generation GigaWatt",
  "Generation SMR",
  "Construction GigaWatt",
  "Construction SMR",
  "Operations",
  "Engineering",
  "Project and Programme Management",
  "Science Technical Health Safety & Environment",
  "Trades",
  "Business Functions")

ageLabelsOffset <- c("<20", 
                     "\n20-24", 
                     "25-29", 
                     "\n30-34", 
                     "35-39", 
                     "\n40-44", 
                     "45-49",
                     "\n50-54",
                     "55-59",
                     "\n60-64",
                     "65/65+")
ageLabelsOffsetAlt <- c("<20", 
                     "", 
                     "25-29", 
                     "", 
                     "35-39", 
                     "", 
                     "45-49",
                     "",
                     "55-59",
                     "",
                     "65/65+")

levelLabelsOffset <- c("\nLevel 1",
                       "Level 2", 
                       "\nLevel 3",
                       "Level 4",
                       "\nLevel 5",
                       "Level 6",
                       "\nLevel 7",
                       "Level 8",
                       "\nSME")

levelLabelsOffsetAlt <- c("Level 1",
                       "", 
                       "\nLevel 3",
                       "",
                       "Level 5",
                       "",
                       "\nLevel 7",
                       "",
                       "SME")

trainingLevels <- c("L2",
                    "Grads",
                    "L5",
                    "L6",
                    "L3",
                    "L4",
                    "L7")

##Themes####
bar_theme <- theme(legend.position = "none",
                   strip.text = element_text(size = 16, colour = "black"), 
                   axis.title = element_text(size = 14), 
                   plot.title = element_text(size = 16),
                   axis.text = element_text(size = 14, colour = "black"), 
                   legend.title =  element_blank()) 

demand_theme <- theme(legend.position = "none",
                      strip.text = element_text(size = 16, colour = "black"), 
                      axis.title = element_text(size = 14), 
                      plot.title = element_text(size = 16),
                      axis.text = element_text(size = 14, colour = "black"), 
                      legend.title =  element_blank())

bar_theme_facet1 <- theme(legend.position = "none",
                          strip.text = element_text(size = 12, colour = "black"), 
                          axis.title.x = element_text(size = 11),
                          axis.title.y = element_text(size = 14),
                          axis.text.x = element_text(size = 11, colour = "black"),
                          axis.text.y = element_text(size = 14, colour = "black"),
                          plot.title = element_text(size = 11),
                          legend.title =  element_blank())

bar_theme_facet2 <- theme(legend.position = "none",
                          strip.text = element_text(size = 11, colour = "black"), 
                          axis.title.x = element_text(size = 12),
                          axis.title.y = element_text(size = 13),
                          axis.text.x = element_text(size = 11, colour = "black"),
                          axis.text.y = element_text(size = 12, colour = "black"),
                          plot.title = element_text(size = 11),
                          axis.text = element_text(size = 9, colour = "black"), 
                          legend.title =  element_blank())

source("./source_files/ReadExistingEstateZipFile.R", local = TRUE)

#write_csv(Age_long, "./Age.csv")

##Reading in Data####
ReqRecData <- read_csv("./data/ReqRecData.csv")
#DemandLayerData <- read_csv("./data/DemandLayerData.csv")
#DemandLayerData <- read_csv("./data/DemandLayerFunctions.csv") #three scenarios
DemandLayerData <- read_csv("./data/DemandLayerFunctionsValue.csv") #single data column value instead of three scenarios
CumulativeData <- read_csv("./data/CumulData.csv")
AgeData <- read_csv("./data/ageData.csv")
LevelData <- read_csv("./data/LevelData.csv")
TrainingData <- read_csv("./data/training_df.csv")
LeaversData <- read_csv("./data/Current_Leavers.csv")
LLRCannReq <- read_csv("./data/LLRC_Ann_Req.csv") #Contains Supply, Demand and AnnRec
demandBind_file <- read_csv("./data/demandBind.csv") #Demand from existing estate 
supply_status_file <- read_csv("./data/supply_status.csv")

startYear <- min(demandBind_file$Year)

#global_start_time = Sys.time()

source("./source_files/calcInflow_fnc.R", local = TRUE)
source("./source_files/ReactorUnitModels.R", local = TRUE)

##Read Unit Start Dates####
unitStartDates <- read_csv("./data/unitStartDates.csv")


global_start_time = Sys.time()


source("./source_files/AnnRecFnc_fnc.R", local = TRUE)
source("./source_files/calcAnnualRecruitment_fnc.R", local = TRUE)
source("./source_files/CalcScenarioDemand.R", local = TRUE)
source("./source_files/SeriesFilter.R", local = TRUE)
source("./source_files/PlotMainBar.R", local = TRUE)
source("./source_files/PlotFacetBar.R", local = TRUE)
source("./source_files/SimpleDemandSupply_fnc.R", local = TRUE)
source("./source_files/reduceLevels_fnc.R", local = TRUE)


demand <- demandBind_file %>%
  group_by(Year, Level, Site, LLRC, RCT) %>% #, `Sub-sector`, Organisation, Region) %>%
  summarise(Value = sum(Value)) %>%
  arrange(Site, LLRC, Level, Year) %>%
  ungroup()

demand <- reduceLevels(demand)

supply <- supply_status_file %>%
  group_by(Year, Level,  Site, LLRC, RCT) %>%#, `Sub-sector`, Organisation, Region) %>%
  summarise(Value = sum(Value)) %>%
  arrange(Site, LLRC, Level, Year) %>%
  ungroup()

supply <- reduceLevels(supply)

demand_w <- demand %>%
  # select(-SupplyDemand) %>%
  dplyr::rename(Demand = Value)

supply_w <- supply %>%
  # select(-SupplyDemand) %>%
  dplyr::rename(Supply_current = Value)

demand_supply_w <- left_join(demand_w, supply_w, by = c("Year", "Site", "Level", "LLRC", "RCT")) #, "Sub-sector", "Organisation", "Region"))


demand_rct <- demand %>%
  group_by(Year, RCT) %>%
  summarise(value = sum(Value))

#message("demand_w")
#print(glimpse(demand_w))

#DemandSupplyAnnRec <- read_csv("./data/DemandSupplyLLRC.csv")

DemandSupplyAnnRec <- read_csv("./data/DemandSupplyLLRC.csv")
demand <- DemandSupplyAnnRec %>%
  mutate(Scenario = if_else(Scenario == "24GW", "24 GWe", # Renaming could be done at source
                            if_else(Scenario == "16GW", "16 GWe", 
                                    if_else(Scenario == "3.2GW", "3.2 GWe", Scenario)))) 
##Changing Factor orders ####
DemandLayerData$RCT <- factor(DemandLayerData$RCT, levels = FunctionOrder)
ReqRecData$RCT <- factor(ReqRecData$RCT, levels = FunctionOrder)
CumulativeData$RCT <- factor(CumulativeData$RCT, levels = FunctionOrder)



##Server####
server <- function(input, output, session) {
  thematic::thematic_shiny()
  
##Demand Table (reactive)####
  demand_table <- reactive({
    
    DemandLayerData %>%
      select(Year, RCT, value)
    
  })
##DemandMax (reactive)####  
  demandMax <- reactive({
    
    DemandLayerData %>%
      
      select(Year, RCT, value) %>%
    #  filter(RCT %in% input$RCT) %>%
      group_by(Year) %>%
      summarise(total = sum(value)) %>%
      filter(total == max(total))
    
  })
  
  message("Age Data")
  print(AgeData)

source("./source_files/FilterSummation_Age.R", local = TRUE)
source("./source_files/Output_AgeCharts.R", local = TRUE)  
  
source("./source_files/FilterSummation_Level.R", local = TRUE)
source("./source_files/Output_LevelCharts.R", local = TRUE) 
  
source("./source_files/FilterSummation_Training.R", local = TRUE)  
source("./source_files/Output_TrainingCharts.R", local = TRUE)  

source("./source_files/FilterSummation_LevelLeavers.R", local = TRUE)  
# source("./source_files/Output_LevelLeaversCharts.R", local = TRUE) 
  
##Sample Size####
output$total <- renderText({
  
   d <- age_plot()
    
   d$total[1] 
    

})

age_download <- reactive({
  age_plot() %>%
    mutate(Gender = input$gender, Sector = input$sector)
})


#df <- age_llrc_gender_sector 


output$DownloadAge <- downloadHandler(
  filename = function() {
    paste("AgeData_" , Sys.time(), ".csv", sep="")
    
  },
  
  content = function(file) {
    write.csv(age_download(), file, row.names = FALSE)
  }
)
  
calcInFlow<- reactive({
  
  calcInflow(input$attrition, scenario_w) 
    
})

ReqRecData_df_test <- reactive({
  
  calcInflow(input$attrition, scenario_w) %>%
    select(-Organisation, -Region, -`Sub-sector`) %>%
    group_by(Year, RCT) %>% #,  annualRecruitment) %>%
    dplyr::summarise(annualRecruitment = sum(annualRecruitment)) %>%
    mutate(cumulativeRec = cumsum(annualRecruitment)) #%>%
   # filter(Year > 2021) %>%
  #  filter(Year < 2043)
})


ReqRecData_df <- reactive({
  
    calcInflow(input$attrition, scenario_w) %>%
    filter(Year > 2021) %>%
    filter(Year < 2043) %>%
    select(-Organisation, -Region, -`Sub-sector`) %>%
    group_by(Year, RCT) %>% 
    dplyr::summarise(annualRecruitment = sum(annualRecruitment), .groups = "drop_last") %>%
    ungroup() %>%
      complete(Year, RCT, fill=list(annualRecruitment = 0)) %>% 
    mutate(cumulativeRecGroup = cumsum(annualRecruitment)) %>%
    group_by(RCT) %>%
    mutate(cumulativeRec = cumsum(annualRecruitment)) %>%
    group_by(Year) %>%
    mutate(cumulativeRecTotal = cumsum(annualRecruitment)) 
  
  })


# cumul <- reactive({
#   
#   ReqRecData_df() %>%
#     group_by(RCT) %>%
#     mutate(cumRec = cumsum(annualRecruitment))
#   
# })
  output$dynamic <- renderDataTable(age_llrc_gender_sector_region(), options = list(pageLength = 5))
##***Output ReqRec ####
  output$ReqRec <- renderPlot(width= 600, height =300,{
    
    
    ggplot(ReqRecData_df(), aes(x=Year, y=annualRecruitment, fill=RCT)) + geom_bar(stat="identity") +
   #   geom_segment(aes(x = x_start, xend = x_end,  y=meanY$mean, yend = meanY$mean), linetype="solid") +
      # scale_fill_manual(labels = RCTLabels3, values = nssg_palette, drop = FALSE) +
      scale_fill_manual(values = colourFunctionMap, levels = FunctionOrder, drop = FALSE) +
      scale_y_continuous(labels = scales::comma) + 
      # facet_wrap(vars(RCT), labeller = labeller(RCT = RCTLabels2), scales='free_y', ncol = 3) + 
      # scale_fill_discrete(labels = RCTLabels3) +
      demand_theme + ylab("Required Inflow/FTE")  + ggtitle("Annual Required Inflow X") + xlim(2022, 2042) + ylim(0,10000)
      
    # coord_cartesian(xlim = year_limits, ylim = c(0, y_max_reqInflow))
    # ggplot(ReqRecData, aes(x=Year, y=.data[[input$y]], fill=RCT)) + geom_bar(stat="identity") +
    #  # scale_fill_manual(labels = RCTLabels3, values = nssg_palette, drop = FALSE) +
    #   scale_fill_manual(values = nssg_palette, drop = FALSE) +
    #   scale_y_continuous(labels = scales::comma) + 
    #   # facet_wrap(vars(RCT), labeller = labeller(RCT = RCTLabels2), scales='free_y', ncol = 3) + 
    #   # scale_fill_discrete(labels = RCTLabels3) +
    #   theme(legend.position = "none", 
    #         strip.text = element_text(size = 10), 
    #         axis.text = element_text(size = 10), legend.title =  element_blank()) + ylab("Required Inflow/FTE") + ylim(0,10000) + ggtitle("Annual Required Inflow") 
    #  # coord_cartesian(xlim = year_limits, ylim = c(0, y_max_reqInflow))
  })
  
 
##level Table(reactive)####   
  Level_table <- reactive({if(input$gender == "All"){
    LevelData %>%
      group_by(Level, Sector) %>%
      filter(Sector == input$sector) %>%
      summarise(Value = sum(Value)) %>%
      mutate_if(is.numeric, round, 0) 
    # group_by(Level, Sector, LLRC, Site, HLRC, Organisation, `Sub-sector`, Region, RCT, `Generic/Nuclear`, STEM_Status) %>%
    # summarise(Value = sum(Value))
  } else {
    LevelData %>%
      group_by(Level, Sector, Gender) %>%
      filter(Gender == input$gender) %>%
      filter(Sector == input$sector) %>%
      summarise(Value = sum(Value)) %>%
      mutate_if(is.numeric, round, 0) 
  }
    
  }) 
##Output LevelPlot####
  output$LevelPlot <- renderPlot({
    
    if(input$gender == "All"){
      df <- LevelData #%>%
      # group_by(Level, Sector, LLRC, Site, HLRC, Organisation, `Sub-sector`, Region, RCT, `Generic/Nuclear`, STEM_Status) %>%
      # summarise(Value = sum(Value))
    } else {
      df <- LevelData %>%
        filter(Gender == input$gender2) 
    }
    
    
    df <- df %>%
      group_by(Level, Sector) %>%
      filter(Sector == input$sector2) %>%
      
      summarise(Value = sum(Value)) 
    
##Level Plotting ####
    ggplot(df, aes(x=Level, y=Value) ) + geom_bar(stat = "identity", fill="darkgreen") +
      # facet_wrap(vars(RCT), labeller = labeller(RCT = RCTLabels2), scales='free_y', ncol = 3) +
      scale_x_discrete(labels = levelLabelsOffset) +
      bar_theme + ylab("Workforce/FTEs")  + ggtitle("Level")
  })
  
  output$Level_table <- renderDataTable(Level_table(), options = list(pageLength = 5))
  

  
  # ReqRecData_plot <- reactive ({
  #   ReqRecData_df() %>%
  #   
  #   select(Year, RCT, input$y) %>%
  #   
  #   group_by(Year, RCT) %>%
  #   summarise(value = sum(.data[[input$y]])) 
  #   
  # })
  
  ##*** ReqREc ####
  output$ReqRec <- renderPlot(width= 450, height =300,{
    
   # print(glimpse(ReqRecData_df))
    # ReqRecData_df <- ReqRecData_df %>%
    #   filter(RCT %in% input$RCT)
    
    x_start = input$meanRange[1]
    x_end = input$meanRange[2]
    
    req(x_start <= x_end, "First year must be earlier than End Year")
    
    meanLine <- ReqRecData_df() %>%
      filter(Year>=input$meanRange[1]) %>%
      filter(Year<=input$meanRange[2]) %>%
      select(Year, RCT, annualRecruitment) %>%
      group_by(Year) %>%
      summarise(value = sum(annualRecruitment)) %>%
      mutate(mean = mean(value)) %>%
      select(mean) %>%
      mutate(across(mean, round, 0))%>%
      slice(1)
  
    
    ggplot(ReqRecData_df(), aes(x=Year, y=annualRecruitment, fill=RCT)) + geom_bar(stat="identity") +
      geom_segment(aes(x = x_start, xend = x_end,  y=as.numeric(meanLine$mean), yend = as.numeric(meanLine$mean)), linetype="solid") +
      # scale_fill_manual(labels = RCTLabels3, values = nssg_palette, drop = FALSE) +
      scale_fill_manual(values = colourFunctionMap, drop = FALSE) +
      scale_y_continuous(labels = scales::comma) + 
      # facet_wrap(vars(RCT), labeller = labeller(RCT = RCTLabels2), scales='free_y', ncol = 3) + 
      # scale_fill_discrete(labels = RCTLabels3) +
      demand_theme + ylab("Required Inflow/FTE")  + ggtitle("Annual Required Inflow")
   
     # ReqRecData_df <- ReqRecData_df() %>%
     #  mutate(meanY = meanLine)
     # 
     # 
     # 
     # 
     # if (x_start > x_end) {
     #   temp = x_start
     #   x_start = x_end
     #   x_end = temp
     # }
     # 
     # observeEvent(meanY$mean, {
     #   if(meanY$mean < 500) {
     #     shinyalert("Mean is too low")
     #   }

 #   })
    
    
  })  
  
##Layer Demand Plot (renderPlot)####
  
  # DemandLayerData <- reactive ({ rbind(DemandLayerData, scenario_df()) %>%
  #   filter(RCT %in% input$RCT) }) 
  
  scenario_rct <- reactive({scenario_df() %>%
    group_by(Year, Status) %>%
    summarise(value = sum(value)) %>%
    dplyr::rename(RCT = Status) %>%
      group_by(Year, RCT) %>%
      arrange(Year, by_group = TRUE)
  })
  
  #existingPlusNNB <- reactive({scenario_df() %>%
  scenario_w <- reactive({scenario_df() %>%
      group_by(Year, Status, Level, Role, Type, Region, Unit) %>%
      summarise(Demand = sum(value)) %>%
      dplyr::rename(RCT = Status, LLRC = Role) %>%
      dplyr::rename(Site = Unit) %>%
      dplyr::rename(Organisation = Type) %>%
      mutate(`Sub-sector` = "NNB") %>%
      mutate(Supply_current = 0) %>%
      group_by(Year, RCT) %>%
      arrange(Year, by_group = TRUE) %>%
      rbind(demand_supply_w) %>%
      mutate(RCT = factor(RCT, levels = FunctionOrder))
    
  })
  
  # existingPlusNNB <- reactive({
  #   rbind(demand_supply_w, scenario_w())
    
 # })
  
  combined_df <- reactive ({                     #demand only
    message("Scenario_df from combined_df")
    scenario_rct() %>%
    rbind(demand_rct) %>%
      arrange(Year, RCT) %>%
      
      group_by(Year, RCT) %>%
     # complete( RCT, fill = list(value = 0)) #%>%
      summarise(value = sum(value))
      
   # message("Writing combined_df.csv")
    #write_csv(scenario_w(), "./combined_df.csv")
    

    }) 
  
  # observe({
  #   message("Write scenaro file")
  #   write_csv(scenario_df(), "./scenario_df.csv")
  #   write_csv(scenario_rct(), "./scenario_rct.csv")
  #   write_csv(demand_rct, "./demand.csv")
  #   write_csv(combined_df(), "./combined_df.csv")
  #   write_csv(scenario_w(), "./scenario_w.csv")
  #   write_csv(demand_supply_w, "./demand_supply_w.csv")
  #   write_csv(ReqRecData_df(), "./ReqRecData_df.csv")
  #   write_csv(cumulativeSummary(), "./cumulativeSummary.csv")
  #  write_csv(calcInFlow(), "./calcInflow.csv")
  #   
  # })
  
  ##***Layer Demand ####
  output$LayerDemand <- renderPlot(width= 450, height =300,{ 
    
   # message("demandLayerData_df")
   #  print(glimpse(combined_df()))
    
   # ggplot(data = plot_df(), aes(x=Year, y=annualRecruitment, fill = RCT)) + geom_bar(stat = "identity") +
   #    #stat_summary(aes(x= Year, y=Demand, group = 1, color = SupplyDemand), fun = "sum", colour = 'black', geom = 'line') +
   #    #stat_summary(aes(x= Year, y=Supply, group = 1, color = SupplyDemand), fun = "sum", colour = 'black', geom = 'line') +
   #    # scale_fill_manual(values = nssg_palette) +
   #    #  facet_wrap(vars(RCT), labeller = labeller(RCT = RCTLabels2), scales='free_y', ncol = 3) +
   #    theme(legend.position = "none", 
   #          strip.text = element_text(size = 10), 
   #          axis.text = element_text(size = 10)) + ylab("Workforce /FTE") + ylim(0,10000) 
   #  #coord_cartesian(xlim = year_limits, ylim = c(0, y_max))
    

    DemandLayerData_plot <-  scenario_w() %>% # DemandLayerData()
    group_by(Year, RCT) %>%
      summarise(Demand = sum(Demand))
      
      
    ggplot(DemandLayerData_plot, aes(x=Year, y=Demand, fill = RCT)) + geom_area() +
   geom_smooth(position = "stack", method = 'loess', span = 0.25, linetype = 0) +
      # scale_fill_manual(labels = RCTLabels3, values = nssg_palette, drop = FALSE) +
    scale_fill_manual(values = colourFunctionMap, drop = FALSE) +
    scale_y_continuous(labels = scales::comma) +
    # facet_wrap(vars(RCT), labeller = labeller(RCT = RCTLabels2), scales='free_y', ncol = 3) +
    # scale_fill_discrete(labels = RCTLabels3) +
    demand_theme + 
      ylab("Total Programme Demmand/FTE") + ggtitle("Programme Demand") + xlim(2020, 2042)#+ ylim(0,100000)
    
  })

##Output Demand legend####
output$DemandLegend <- renderPlot({
    
 # DemandLayerData_plot <- DemandLayerData %>%
 #      filter(RCT %in% input$RCT)
    
 p <- ggplot(scenario_w(), aes(x=Year, y=Demand, fill=RCT)) + 
   geom_area() + 
   scale_fill_manual(values = colourFunctionMap, drop = TRUE) + theme(legend.title = element_blank(), legend.text=element_text(size=12))
    leg <- get_legend(p) #drop TRUE drops unused categories from legend
    as_ggplot(leg)
    
  })
  
##***Output Demand Supply Lines (renderPlot)#### 
  output$demandSupply <- renderPlot(width= 450, height =300,{
    
    DemandLayerData_plot <- scenario_w() %>%
     # filter(RCT %in% input$RCT) %>%
      group_by(Year) %>%
      summarise(demand = sum(Demand)) %>%
      mutate(supply = SimpleDemandSupply(demand, input$attrition/100)) %>%
      pivot_longer(cols = c("demand", "supply"), names_to = "SupplyDemand", values_to = "value") %>%
      filter(Year < 2042)
    
 #   message("DemandLayerData_plot")
  #  print(glimpse(DemandLayerData_plot))
    
    ggplot(DemandLayerData_plot, aes(x=Year, y=value, linetype = SupplyDemand)) + geom_line(size = 1) +
      scale_color_manual(values = c("black", "grey")) + 
    scale_y_continuous(labels = scales::comma) + ylab("Total Programme Demmand/FTE") +
      theme(strip.text = element_text(size = 10), axis.text = element_text(size = 10), 
            legend.position = "top",legend.key = element_rect(fill = "transparent", colour = "transparent"), legend.title = element_blank()) +
      demand_theme  + ggtitle("Demand and Current Projected")
    
  })
 
##Mean Value calculation (reactive)#### 
  MeanValue <- reactive({
    ReqRecData_df <- ReqRecData_df() %>%
      filter(RCT %in% input$RCT)
    
    df<- ReqRecData_df %>%
      filter(Year>=input$meanRange[1]) %>%
      filter(Year<=input$meanRange[2]) %>%
      select(Year, RCT, annualRecruitment) %>%
      group_by(Year, annualRecruitment) %>%
      summarise(value = sum(annualRecruitment)) %>%
      mutate(mean = mean(value)) %>%
      select(mean) %>%
      mutate(across(mean, round, 0))%>%
      slice(1)
    
    df <- as.character(df)
   #unlist(df$mean
    
  })
  
##Output Mean (RenderText) #### 
  output$mean <- renderText({

    MeanValue()
  #unlist(df$mean[1])

  })
  
##meanY calculation (reactive)####
 meanY <- reactive({

    ReqRecData_df %>%
      filter(Year>=input$meanRange[1]) %>%
      filter(Year<=input$meanRange[2]) %>%
      select(Year, RCT, annualRecruitment) %>%
      group_by(Year) %>%
      summarise(value = sum(annualRecruitment)) %>%
      mutate(mean = mean(value)) %>%
      select(mean) %>%
      mutate(across(mean, round, 0))%>%
      slice(1)
#message("meanY")
#   print(glimpse(meanY))
  })
  
##Output Demand Table (renderDataTable)####
output$demandTable <- renderDataTable(combined_df(), options = list(pageLength = 5))
div(dataTableOutput("output$demandTable"), style="font-size:20%")

##***Output Cumulative Plot (renderPlot)####
  output$cumulative <- renderPlot(width= 450, height =300,{
    
 #   CumulativeData <- CumulativeData() %>%
      # cumul <- cumul() %>%
      # filter(RCT %in% input$RCT)
    
    ReqRecData_df() %>%
  #     filter(RCT %in% input$RCT) %>%
      group_by(Year, RCT) %>%
      arrange(Year)
    
    
    ggplot(data = ReqRecData_df(), aes(x=Year, y=cumulativeRec, fill=RCT)) + geom_area() + #data = ReqRecData_df(), aes(x=Year, y= cumulativeRec)) +
      scale_fill_manual(values = colourFunctionMap, drop = FALSE) +
      scale_y_continuous(labels = scales::comma) +#, limits = c(0, 300000)) +
      demand_theme + ylab("Cumulative Inflow/FTE") + ggtitle("Cumulative Recruitment") + ylim(0,160000) +
      xlim(2022, 2042)
  })

##Cumulative Summary -spot years 2030/2050 (reactive)#### 
cumulativeSummary <- reactive({
  ReqRecData_df() %>%
   # filter(RCT %in% input$RCT) %>%
    group_by(Year) %>%
    summarise(value = cumsum(annualRecruitment)) %>%
    filter(Year %in% c("2030", "2050")) %>%
    slice(1)
  
})
  
##demandSummary - uses Cumulative summary (reactive)####  
demandSummary <- reactive({
  
  D_max <- demandMax() %>%
    select(total)
  
  D_max_year <- demandMax() %>%
    select(Year) 


  Cum_2030 <- ReqRecData_df()%>%
    dplyr::filter(Year == 2030) %>%
    slice(1) %>%
    dplyr::select(cumulativeRecGroup)
  


  
  
  meanValue <- ReqRecData_df() %>%
    filter(Year>=input$meanRange[1]) %>%
    filter(Year<=input$meanRange[2]) %>%
    select(Year, RCT, annualRecruitment) %>%
    group_by(Year) %>%
    summarise(value = sum(annualRecruitment)) %>%
    mutate(mean = mean(value)) %>%
    select(mean) %>%
    mutate(across(mean, round, 0))%>%
    slice(1) #%>%
  #  select(value)

 # message("Cum2030")
 # print(Cum_2030)
 
  A <- c("Peak Demand", "Peak Year",  "Cumulative (2030)", "Mean")
  B <- c(as.numeric(D_max),as.numeric(D_max_year), as.numeric(unlist(Cum_2030[, 2])), as.numeric(meanValue)) #D_max[1,1], "0")
  data.frame(Name = A, Value =B)
  
})
    
    
  
##Output Demand Summary Table#### 
  output$demandSummaryTable <- renderTable(colnames = FALSE, digits = 0,{ 

    
    demandSummary()
       
     # formatCurrency(columns = 2, currency ='', 
        #                interval =3, 
        #                mark = ',', 
        #                before = FALSE)
  })
  
##Scenario Generation scenario_df (reactive)####  
  scenario_df <- reactive({
    
    startList <- c(input$unit1start, 
                   input$unit2start, 
                   input$unit3start,
                   input$unit4start,
                   input$unit5start, 
                   input$unit6start, 
                   input$unit7start,
                   input$unit8start,
                   input$unit9start, 
                   input$unit10start, 
                   input$unit11start,
                   input$unit12start,
                   input$unit13start, 
                   input$unit14start, 
                   input$unit15start,
                   input$unit16start)
    
    reactorTypes <- c(input$unit1sel,
                      input$unit2sel,
                      input$unit3sel, 
                      input$unit4sel,
                      input$unit5sel,
                      input$unit6sel,
                      input$unit7sel, 
                      input$unit8sel,
                      input$unit9sel,
                      input$unit10sel,
                      input$unit11sel, 
                      input$unit12sel,
                      input$unit13sel,
                      input$unit14sel,
                      input$unit15sel, 
                      input$unit16sel) 
    
    region <- c(input$unit1region,
                input$unit2region,
                input$unit3region,
                input$unit4region,
                input$unit5region,
                input$unit6region,
                input$unit7region,
                input$unit8region,
                input$unit9region,
                input$unit10region,
                input$unit11region,
                input$unit12region,
                input$unit13region,
                input$unit14region,
                input$unit15region,
                input$unit16region)
    
    timeLine <- data.frame("Start" = startList, "Type" = reactorTypes, "Region" = region)
    
    timeLine <- timeLine %>%
      filter(Type != "None")
    
  #  write_csv(timeLine, "./timeline.csv")
    
    #calcScenarioDemand(startList, reactorTypes)
    
    scenario_df <- calcScenarioDemand(timeLine) %>%
      group_by(Year_source, Status, Level, Type, Role, Region, Unit) %>% 
      summarise(value = sum(value))%>%
      mutate(Year = ((Year_source+0.5) %/% (timeDelta/12))*timeDelta/12) %>%
    #reduce to 1 year time resolution (needs to match existing workforce data - although could interpolate the latter?)
      group_by(Year, Status, Level, Type, Role, Region, Unit) %>% 
      #filter(Status == "Operations") %>%
      #summarise(across(everything(), mean, na.rm = TRUE)) %>% 
      summarise(value = mean(value)) %>%
      ungroup() #%>%
     # tidyr::complete(Year, Role, Status, Region, fill = list(value = 0))
    
    # first_years <-group_by(scenario, Status, Role) %>%
    #   summarise(Year = min(Year) - 1) %>%
    #  # filter(year > 2020) %>%
    #   mutate(value = 0)
    # 
    # scenario_df <- rbind(scenario, first_years) %>%
    #   arrange(Year, Status, Role)
    
  })

              

# combined_df <- reactive ({
# scenario_df() %>%
#   dplyr::rename(RCT = Role, Value = value) %>%
#  rbind(demand_rct) 
# })

# DemandLayerData <- reactive({
#   scenario_df()%>%
#     dplyr::rename(RCT = Role, Value = value)
#   
#    rbind(demand_rct, scenario_df()) 
#   
# }) 
 
##Output data_test (renderPlot) ####
  output$data_test <- renderPlot({
   
    scenario_df <- scenario_df() %>%
    group_by(Year, Status) %>% #drops role levels here
      summarise(value = sum(value))
    
 #   message("This is the output from scenario_df")
 #   print(scenario_df) 
    
    ggplot(scenario_df, aes(x=Year, y=value, fill = Status)) +  geom_area(colour = "black") +
      scale_x_continuous(breaks = scales::breaks_width(2)) +
      theme(axis.text.x = element_text(size = 16), 
            axis.text.y = element_text(size = 16),
            axis.title.x = element_text(size = 16),
            axis.title.y = element_text(size = 16),
            legend.text = element_text(size = 14),
            legend.title = element_blank()) + ylab("Workforce") + xlim(2020, 2054)
      #stat_smooth(se=TRUE, geom="area", position = "stack",
                                                                        # method = 'loess', 
                                                                        # span = 0.3)
    #plot(scenario_df)
   
  })
 
##Write Scenario #### 
observeEvent(input$do, {
    check =tryCatch({
    write_csv(scenarioParameters(), "./data/scenarioParameters.csv" )
    },
  error = function(e){
      showNotification("Can't access file", type = "error")
   
     })
  })
  
  
output$downloadData <- downloadHandler(
  filename = function() { 
      paste("Scenario-", Sys.Date(), ".csv", sep="")
    },
  content = function(file) {
      write_csv(scenarioParameters(), file)
    })
  
   #input$unit1start <- importScenario[1,2]
  
  #  observeEvent(importScenario, {
  #    
  #     df1<-importScenario()
  #       updateSliderInput(inputId = "unit1start", value = df1[2, ])
  #       print(df1[2, ])
  # 
  # })
    
 observe({
    
   file1 = input$file1
    
    if (is.null(file1)) {
      return(NULL)
    }
    
    df1 <- read.csv(input$file1$datapath)
    
    updateSliderInput(inputId = "unit1start", value = as.numeric(df1[1, 1]))
    updateSliderInput(inputId = "unit2start", value = as.numeric(df1[2, 1]))
    updateSliderInput(inputId = "unit3start", value = as.numeric(df1[3, 1]))
    updateSliderInput(inputId = "unit4start", value = as.numeric(df1[4, 1]))
    updateSliderInput(inputId = "unit5start", value = as.numeric(df1[5, 1]))
    updateSliderInput(inputId = "unit6start", value = as.numeric(df1[6, 1]))
    updateSliderInput(inputId = "unit7start", value = as.numeric(df1[7, 1]))
    updateSliderInput(inputId = "unit8start", value = as.numeric(df1[8, 1]))
    updateSliderInput(inputId = "unit9start", value = as.numeric(df1[9, 1]))
    updateSliderInput(inputId = "unit10start", value = as.numeric(df1[10, 1]))
    updateSliderInput(inputId = "unit11start", value = as.numeric(df1[11, 1]))
    updateSliderInput(inputId = "unit12start", value = as.numeric(df1[12, 1]))
    updateSliderInput(inputId = "unit13start", value = as.numeric(df1[13, 1]))
    updateSliderInput(inputId = "unit14start", value = as.numeric(df1[14, 1]))
    updateSliderInput(inputId = "unit15start", value = as.numeric(df1[15, 1]))
    updateSliderInput(inputId = "unit16start", value = as.numeric(df1[16, 1]))
    updateSliderInput(inputId = "unit17start", value = as.numeric(df1[17, 1]))
    updateSliderInput(inputId = "unit18start", value = as.numeric(df1[18, 1]))
    updateSliderInput(inputId = "unit19start", value = as.numeric(df1[19, 1]))
    updateSliderInput(inputId = "unit20start", value = as.numeric(df1[20, 1]))
    updateSliderInput(inputId = "unit21start", value = as.numeric(df1[21, 1]))
    updateSliderInput(inputId = "unit22start", value = as.numeric(df1[22, 1]))
    updateSliderInput(inputId = "unit23start", value = as.numeric(df1[23, 1]))
    updateSliderInput(inputId = "unit24start", value = as.numeric(df1[24, 1]))
    updateSliderInput(inputId = "unit25start", value = as.numeric(df1[25, 1]))
    updateSliderInput(inputId = "unit26start", value = as.numeric(df1[26, 1]))
    updateSliderInput(inputId = "unit27start", value = as.numeric(df1[27, 1]))
    updateSliderInput(inputId = "unit28start", value = as.numeric(df1[28, 1]))
    updateSliderInput(inputId = "unit29start", value = as.numeric(df1[29, 1]))
    updateSliderInput(inputId = "unit30start", value = as.numeric(df1[30, 1]))
    
    updateSliderInput(inputId = "unit1sel", value = (df1[1, 2]))
    updateSliderInput(inputId = "unit2sel", value = (df1[2, 2]))
    updateSliderInput(inputId = "unit3sel", value = (df1[3, 2]))
    updateSliderInput(inputId = "unit4sel", value = (df1[4, 2]))
    updateSliderInput(inputId = "unit5sel", value = (df1[5, 2]))
    updateSliderInput(inputId = "unit6sel", value = (df1[6, 2]))
    updateSliderInput(inputId = "unit7sel", value = (df1[7, 2]))
    updateSliderInput(inputId = "unit8sel", value = (df1[8, 2]))
    updateSliderInput(inputId = "unit9sel", value = (df1[9, 2]))
    updateSliderInput(inputId = "unit10sel", value = (df1[10, 2]))
    updateSliderInput(inputId = "unit11sel", value = (df1[11, 2]))
    updateSliderInput(inputId = "unit12sel", value = (df1[12, 2]))
    updateSliderInput(inputId = "unit13sel", value = (df1[13, 2]))
    updateSliderInput(inputId = "unit14sel", value = (df1[14, 2]))
    updateSliderInput(inputId = "unit15sel", value = (df1[15, 2]))
    updateSliderInput(inputId = "unit16sel", value = (df1[16, 2]))
    updateSliderInput(inputId = "unit17sel", value = (df1[17, 2]))
    updateSliderInput(inputId = "unit18sel", value = (df1[18, 2]))
    updateSliderInput(inputId = "unit19sel", value = (df1[19, 2]))
    updateSliderInput(inputId = "unit20sel", value = (df1[20, 2]))
    updateSliderInput(inputId = "unit21sel", value = (df1[21, 2]))
    updateSliderInput(inputId = "unit22sel", value = (df1[22, 2]))
    updateSliderInput(inputId = "unit23sel", value = (df1[23, 2]))
    updateSliderInput(inputId = "unit24sel", value = (df1[24, 2]))
    updateSliderInput(inputId = "unit25sel", value = (df1[25, 2]))
    updateSliderInput(inputId = "unit26sel", value = (df1[26, 2]))
    updateSliderInput(inputId = "unit27sel", value = (df1[27, 2]))
    updateSliderInput(inputId = "unit28sel", value = (df1[28, 2]))
    updateSliderInput(inputId = "unit29sel", value = (df1[29, 2]))
    updateSliderInput(inputId = "unit30sel", value = (df1[30, 2]))
    
    updateSliderInput(inputId = "unit1region", value = (df1[1, 3]))
    updateSliderInput(inputId = "unit2region", value = (df1[2, 3]))
    updateSliderInput(inputId = "unit3region", value = (df1[3, 3]))
    updateSliderInput(inputId = "unit4region", value = (df1[4, 3]))
    updateSliderInput(inputId = "unit5region", value = (df1[5, 3]))
    updateSliderInput(inputId = "unit6region", value = (df1[6, 3]))
    updateSliderInput(inputId = "unit7region", value = (df1[7, 3]))
    updateSliderInput(inputId = "unit8region", value = (df1[8, 3]))
    updateSliderInput(inputId = "unit9region", value = (df1[9, 3]))
    updateSliderInput(inputId = "unit10region", value = (df1[10, 3]))
    updateSliderInput(inputId = "unit11region", value = (df1[11, 3]))
    updateSliderInput(inputId = "unit12region", value = (df1[12, 3]))
    updateSliderInput(inputId = "unit13region", value = (df1[13, 3]))
    updateSliderInput(inputId = "unit14region", value = (df1[14, 3]))
    updateSliderInput(inputId = "unit15region", value = (df1[15, 3]))
    updateSliderInput(inputId = "unit16region", value = (df1[16, 3]))
    updateSliderInput(inputId = "unit17region", value = (df1[17, 3]))
    updateSliderInput(inputId = "unit18region", value = (df1[18, 3]))
    updateSliderInput(inputId = "unit19region", value = (df1[19, 3]))
    updateSliderInput(inputId = "unit20region", value = (df1[20, 3]))
    updateSliderInput(inputId = "unit21region", value = (df1[21, 3]))
    updateSliderInput(inputId = "unit22region", value = (df1[22, 3]))
    updateSliderInput(inputId = "unit23region", value = (df1[23, 3]))
    updateSliderInput(inputId = "unit24region", value = (df1[24, 3]))
    updateSliderInput(inputId = "unit25region", value = (df1[25, 3]))
    updateSliderInput(inputId = "unit26region", value = (df1[26, 3]))
    updateSliderInput(inputId = "unit27region", value = (df1[27, 3]))
    updateSliderInput(inputId = "unit28region", value = (df1[28, 3]))
    updateSliderInput(inputId = "unit29region", value = (df1[29, 3]))
    updateSliderInput(inputId = "unit30region", value = (df1[30, 3]))

    
  
    
    
  })

   
 NNB_map <- reactive({
   
   start <- c(input$unit1start,
              input$unit2start,
              input$unit3start,
              input$unit4start,
              input$unit5start,
              input$unit6start,
              input$unit7start,
              input$unit8start,
              input$unit9start,
              input$unit10start,
              input$unit11start,
              input$unit12start,
              input$unit13start,
              input$unit14start,
              input$unit15start,
              input$unit16start,
              input$unit17start,
              input$unit18start,
              input$unit19start,
              input$unit20start,
              input$unit21start,
              input$unit22start,
              input$unit23start,
              input$unit24start,
              input$unit25start,
              input$unit26start,
              input$unit27start,
              input$unit28start,
              input$unit29start,
              input$unit19start)
   
   type <- c(input$unit1sel,
             input$unit2sel,
             input$unit3sel,
             input$unit4sel,
             input$unit5sel,
             input$unit6sel,
             input$unit7sel,
             input$unit8sel,
             input$unit9sel,
             input$unit10sel,
             input$unit11sel,
             input$unit12sel,
             input$unit13sel,
             input$unit14sel,
             input$unit15sel,
             input$unit16sel,
             input$unit17sel,
             input$unit18sel,
             input$unit19sel,
             input$unit20sel,
             input$unit21sel,
             input$unit22sel,
             input$unit23sel,
             input$unit24sel,
             input$unit25sel,
             input$unit26sel,
             input$unit27sel,
             input$unit28sel,
             input$unit29sel,
             input$unit30sel)
   
   region <- c(input$unit1region,
               input$unit2region,
               input$unit3region,
               input$unit4region,
               input$unit5region,
               input$unit6region,
               input$unit7region,
               input$unit8region,
               input$unit9region,
               input$unit10region,
               input$unit11region,
               input$unit12region,
               input$unit13region,
               input$unit14region,
               input$unit15region,
               input$unit16region,
               input$unit17region,
               input$unit18region,
               input$unit19region,
               input$unit20region,
               input$unit21region,
               input$unit22region,
               input$unit23region,
               input$unit24region,
               input$unit25region,
               input$unit26region,
               input$unit27region,
               input$unit28region,
               input$unit29region,
               input$unit30region)
   
   NNB_map <- data.frame(Year = start, Type = type, Region = region) %>%
     mutate(UnitNameIndex = row_number())
 #  message("NNB_map")
 #  print(NNB_map)
   
   
   
 })
  
  # observeEvent(input$do, {
  #   updateSliderInput(inputId = "unit1start", value = 2022)
  #   updateRadioButtons(inputId = "unit1sel", selected = "None")
  #   updateSliderInput(inputId = "unit2start", value = 2023)
  # 
  #   updateSliderInput(inputId = "unit3start", value = 2024)
  #  
  #   updateSliderInput(inputId = "unit4start", value = 2025)
  # 
  #   updateSliderInput(inputId = "unit5start", value = 2026) 
  #   updateSliderInput(inputId = "unit6start", value = 2027)
  #   updateSliderInput(inputId = "unit7start", value = 2028)
  #   updateSliderInput(inputId = "unit8start", value = 2029)
  #   updateSliderInput(inputId = "unit9start", value = 2030)
  #   updateSliderInput(inputId = "unit10start", value = 2031)
  #   updateSliderInput(inputId = "unit11start", value = 2032)
  #   updateSliderInput(inputId = "unit12start", value = 2033)rsconn
  #   updateSliderInput(inputId = "unit13start", value = 2034)
  #   updateSliderInput(inputId = "unit14start", value = 2035)
  #   updateSliderInput(inputId = "unit15start", value = 2036)
  #   updateSliderInput(inputId = "unit16start", value = 2037)
  #   updateSliderInput(inputId = "unit17start", value = 2038)
  #   updateSliderInput(inputId = "unit18start", value = 2039)
  #   updateSliderInput(inputId = "unit19start", value = 2040)
  #   updateSliderInput(inputId = "unit20start", value = 2041)
  #})  
 
 #  scenarioParameters <- reactive({
 #    
 #    startCtrlVector <- c(input$unit1start,
 #                          input$unit2start,
 #                          input$unit3start,
 #                          input$unit4start,
 #                          input$unit5start,
 #                          input$unit6start,
 #                          input$unit7start,
 #                          input$unit8start,
 #                          input$unit9start,
 #                          input$unit10start,
 #                          input$unit11start,
 #                          input$unit12start,
 #                          input$unit13start,
 #                          input$unit14start,
 #                          input$unit15start,
 #                          input$unit16start,
 #                          input$unit17start,
 #                          input$unit18start,
 #                          input$unit19start,
 #                          input$unit20start,
 #                          input$unit21start,
 #                          input$unit22start,
 #                          input$unit23start,
 #                          input$unit24start,
 #                          input$unit25start,
 #                          input$unit26start,
 #                          input$unit27start,
 #                          input$unit28start,
 #                          input$unit29start,
 #                          input$unit30start)
 #    
 #    selectionVector <- c(input$unit1sel,
 #                          input$unit2sel,
 #                          input$unit3sel,
 #                          input$unit4sel,
 #                          input$unit5sel,
 #                          input$unit6sel,
 #                          input$unit7sel,
 #                          input$unit8sel,
 #                          input$unit9sel,
 #                          input$unit10sel,
 #                          input$unit11sel,
 #                          input$unit12sel,
 #                          input$unit13sel,
 #                          input$unit14sel,
 #                          input$unit15sel,
 #                          input$unit16sel,
 #                          input$unit17sel,
 #                          input$unit18sel,
 #                          input$unit19sel,
 #                          input$unit20sel,
 #                          input$unit21sel,
 #                          input$unit22sel,
 #                          input$unit23sel,
 #                          input$unit24sel,
 #                          input$unit25sel,
 #                          input$unit26sel,
 #                          input$unit27sel,
 #                          input$unit28sel,
 #                          input$unit29sel,
 #                          input$unit30sel)
 #    
 #    regionVector <- c(input$unit1region,
 #                         input$unit2region,
 #                         input$unit3region,
 #                         input$unit4region,
 #                         input$unit5region,
 #                         input$unit6region,
 #                         input$unit7region,
 #                         input$unit8region,
 #                         input$unit9region,
 #                         input$unit10region,
 #                         input$unit11region,
 #                         input$unit12region,
 #                         input$unit13region,
 #                         input$unit14region,
 #                         input$unit15region,
 #                         input$unit16region,
 #                         input$unit17region,
 #                         input$unit18region,
 #                         input$unit19region,
 #                         input$unit20region,
 #                         input$unit21region,
 #                         input$unit22region,
 #                         input$unit23region,
 #                         input$unit24region,
 #                         input$unit25region,
 #                         input$unit26region,
 #                         input$unit27region,
 #                         input$unit28region,
 #                         input$unit29region,
 #                         input$unit30region)
 #    
 #    
 #   scenarioParameters <-  data.frame("Year" = startCtrlVector, "Type" = selectionVector, "Region" = regionVector)
 # #  print(startCtrlVector)
 # #  print(selectionVector)
 #  
 #  })
  
}



