plotFacetBar <- function(df, x, ncol, xLables, fillCol, yLabel, facetVar) {
  if(!is.null(fillCol)) {
    p <- ggplot(df, aes(x=.data[[x]], y=value)) + geom_bar(stat = "identity", fill=fillCol) 
    
  } else 
    p <- ggplot(df, aes(x=.data[[x]], y=value, fill=.data[[facetVar]])) + geom_bar(stat = "identity")
  
  if (!is.null(facetVar)) {
    p <- p + facet_wrap(~.data[[facetVar]], scales='free_y', ncol = ncol)  
  } 
  p<- p + scale_x_discrete(labels = xLables) +
    ylab(yLabel)
  
  return(p)
}