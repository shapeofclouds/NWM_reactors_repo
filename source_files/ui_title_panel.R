list (

fluidRow(
  column(offset =1,
         
         mainPanel(h1("This is an experimental web page"), p() ),
         
         br(),
         p("Data accessed through this interface ", 
           strong("must"), "be interpreted with care. Configurations are possible that may not correspond to likely, or even meaninful, scenarios. 
           No data extracted from this tool can be considered as endorsed by any of the bodies contributing to it.",
           style="text-align:justify;color:black;background-color:#ECBF6B;padding:15px;border-radius:10px"),
         br(),
         
         p(strong("Date Data collected:"), "2023.",
           style="text-align:justify;color:black;background-color:#6CA3B9;padding:15px;border-radius:10px"),
         
         br(),
         
         p(strong("Important notes:"), "about the use and interpretaion of workforce data",
           p(strong("Data Loading:"),"The model loads a large dataset when starting that may take more than 1 minute to complete. 
           Some scenarios may also take a minute or more recalculate.", 
             style="text-align:justify;color:black;background-color:#ECBF6B;padding:15px;border-radius:10px"),
         ),
         
         br(),
         
         p(strong("Civil New Build Scenarios:"), "The app loads with a default scenario. To adjust, or load a new scenario, use the SCENARIOS tab. 
         Loaded files should be CSV files formed from three equal length columns. The three columns should be headed Year, Type and Region. 
         Permitted Types are (currently) HPC, SZC, SMR1, SMR2. A Type setting other than 'none' must be selected for the unit to be included in the calculation.
           Regions are Midlands, Northwest, Northeast, Southwest, Southeast, Scotland, Wales, TBD", 
           style="text-align:justify;color:black;background-color:#6CA3B9;padding:15px;border-radius:10px"),
         
         br(),
         
         p(strong("Scenario adjustments:"), "The default or loaded scenarios can be adjusted for start year (SCENARIO tab), Region or Type (UNIT MODEL SELECT tab). 
           A unit is only inlcuded if the radio button on the UNIT MODEL SELCT tab is set to something other than 'none'. Note that the unit start years 
           will have no effect if the Unit is is to 'none' on the unit model select tab.",
           style="text-align:justify;color:black;background-color:#ECBF6B;padding:15px;border-radius:10px"),
         
         br(),
         
         p(strong("Attrition:"), "Proin aliquam laoreet consequat. Sed molestie leo non ex volutpat sollicitudin. 
                              Proin et ex vitae sapien fringilla mollis. Morbi interdum auctor augue, eget tincidunt enim sodales eget. 
                              Suspendisse consectetur fermentum purus, quis accumsan dui dignissim et.",
           style="text-align:justify;color:black;background-color:#6CA3B9;padding:15px;border-radius:10px"),
         
         br(),
         
         p(strong("Vacancy Rates:"), "Nam at elit lobortis, feugiat augue a, rutrum mauris. 
                              Proin aliquam laoreet consequat. Sed molestie leo non ex volutpat sollicitudin. 
                              Proin et ex vitae sapien fringilla mollis. Morbi interdum auctor augue, eget tincidunt enim sodales eget. 
                              Suspendisse consectetur fermentum purus, quis accumsan dui dignissim et.",
           style="text-align:justify;color:black;background-color:#ECBF6B;padding:15px;border-radius:10px"),
         
         
         width=6)    
)
)