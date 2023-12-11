##Plot Main Bar####
plotMainBar <- function(df_abs, df_perc, x, 
                        xLables = NULL,
                        percentFlag = FALSE,
                        fillCol = "darkblue", 
                        abLabel = "Workforce/FTEs", 
                        percLabel = "Percentage of total", 
                        plotTitle = "",
                        fill_var = NULL,
                        stack = FALSE) {
  
  ## summarise to avoid striations in in the ggplot output

  if(stack == FALSE) {
    
   if(percentFlag == FALSE) {

     df_abs <- df_abs %>%
       group_by(.data[[x]]) %>%
       summarise(value = sum(value))
     
     ggplot(df_abs, aes(x=.data[[x]], y=value)) + geom_bar(stat = "identity", fill = fillCol) +
       scale_x_discrete(labels = xLables) + 
       ylab(abLabel)  + ggtitle(plotTitle) 
     
   } else {
     
     df_perc <- df_perc %>%
       group_by(.data[[x]]) %>%
       summarise(value_perc = sum(value_perc)) 
     
     ggplot(df_perc, aes(x=.data[[x]], y=value_perc)) + geom_bar(stat = "identity", fill = fillCol) +
       scale_y_continuous(labels = scales::percent_format(scale = 100)) + #,
       #   breaks = c(0,  0.2,  0.40,  0.60,  0.80,  1.00)) +
       scale_x_discrete(labels = xLables) + 
       ylab(percLabel)  + ggtitle(plotTitle)
   }
    
    
  } else { #if Stack is True
    
    if(percentFlag == FALSE) { 
      
      df_abs <- df_abs %>%
        group_by(.data[[x]], .data[[fill_var]]) %>%
        summarise(value = sum(value))
      
      ggplot(df_abs, aes(x=.data[[x]], y=value, fill = .data[[fill_var]])) + geom_bar(stat = "identity") +
        scale_x_discrete(labels = xLables) + 
        ylab(abLabel)  + ggtitle(plotTitle) 
      
      
    } else {
        
      df_perc <- df_perc %>%
        group_by(.data[[x]], .data[[fill_var]]) %>%
        summarise(value_perc = sum(value_perc)) 
      
      ggplot(df_perc, aes(x=.data[[x]], y=value_perc, fill = .data[[fill_var]]) ) + geom_bar(stat = "identity", fill = fillCol) +
        scale_y_continuous(labels = scales::percent_format(scale = 100)) + #,
        #   breaks = c(0,  0.2,  0.40,  0.60,  0.80,  1.00)) +
        scale_x_discrete(labels = xLables) + 
        ylab(percLabel)  + ggtitle(plotTitle)
      
      }
  
  }
     
}    
     
     

  ##
  
 