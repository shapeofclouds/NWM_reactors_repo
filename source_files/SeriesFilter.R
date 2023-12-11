##Series Filter####
seriesFilter <- function (df,llrc_sel, gender_sel, sector_sel, region_sel, function_sel = "All", organisation_sel = "All", site_sel = "All",
                          code_type = "LLRC") {
  df <- df %>%
    mutate(GrandTotal = sum(value)) 
  
  
  if (!("All" %in% llrc_sel)) {
    df <- df %>%
      filter(.data[[code_type]] %in% llrc_sel) 
  } else {
    df #temp <- LevelData
  }
  

  if (!("All" %in% function_sel)) {
    df <- df %>%
      filter(Function %in% function_sel) 
  } else {
    df #temp <- LevelData
  }
  
  
  if (!("All" %in% gender_sel)) {
    df <- df %>%
      #  temp %>%
      filter(Gender %in% gender_sel)
  } else {
    df # temp
  }
  
  
  if (!("All" %in% sector_sel)) {
    df <- df %>% 
      filter(Sector %in% sector_sel)
  } else {
    df #temp
  }
  
  
  if (!("All" %in% organisation_sel)) {
    df <- df %>%
      filter(Organisation %in% organisation_sel)
  } else {
    df #temp
  }
  
  
  if (!("All" %in% site_sel)) {
    df <- df %>%
      filter(Site %in% site_sel)
  } else {
    df #temp
  }
  
  
  if (!("All" %in% region_sel)) {
    df <- df %>% 
      filter(Region %in% region_sel)
  } else {
    df
  }
  
  
  return(df)
}