library(tidyverse)

update <- function(target, implant) {
  excise_sites <- implant %>%
    select(Site) %>%
    unique() %>%
    unlist()
  
  target_excised <- target %>%
    filter(!(Site %in% excise_sites))
  
  target_updated <- target_excised %>%
    rbind(implant)
  
  return(target_updated)
}

insertFile <- "existing_estate_insert_C.zip"
receivingFile <- "existing_estate_C.zip"

unzip(paste0("./data/data_to_insert/", insertFile), exdir = "./data/data_to_insert/tmp/")
unzip(paste0("./data/inputData/", receivingFile), exdir = "./data/data_to_insert")
unzip(paste0("./data/inputData/", receivingFile), exdir = "./data/data_to_insert/updated")

write_new_file <- function(file_name) {
  implant <- read_csv(paste0("./data/data_to_insert/tmp/outputData/", file_name))
  target <- read_csv(paste0("./data/data_to_insert/outputData/", file_name))
  write_csv(update(target=target, implant=implant), paste0("./data/data_to_insert/updated/outputData/", file_name))
}

write_new_file("demand.csv")
write_new_file("demand_reduced.csv")
write_new_file("demandLevel.csv")
write_new_file("ProgrammeDemand.csv")
