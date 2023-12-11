##Series Filter####
seriesFilter <- function (df, sector_sel, region_sel, code_type = "LLRC") {
  df <- df %>%
    mutate(GrandTotal = sum(value)) 
  
  if (!("All" %in% llrc_sel)) {
    df <- df %>%
      filter(.data[[code_type]] %in% llrc_sel) 
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
  if (!("All" %in% region_sel)) {
    df <- df %>% 
      filter(Region %in% region_sel)
  } else {
    df
  }
  return(df)
}