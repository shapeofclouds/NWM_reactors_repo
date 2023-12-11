lowRes = TRUE
stepsize = 12 #step size

##Reactor unit model path and file####
unitModelFilePathHPC <- "./data/reactor_unit_models/HPC_model.xlsx"
unitModelFilePathSZC <- "./data/reactor_unit_models/SZC_model.xlsx"
unitModelFilePathGW1 <- "./data/reactor_unit_models/GW1_model.xlsx"
unitModelFilePathGW2 <- "./data/reactor_unit_models/GW2_model.xlsx"
unitModelFilePathSMR1 <- "./data/reactor_unit_models/SMR1_model.xlsx"
unitModelFilePathSMR2 <- "./data/reactor_unit_models/SMR2_model.xlsx"
unitModelFilePathSMR3 <- "./data/reactor_unit_models/Unit.xlsx"
unitModelFilePathSMR_FACTORY <- "./data/reactor_unit_models/Factory.xlsx"
unitModelFilePathTEST <- "./data/reactor_unit_models/TEST_model.xlsx"


##Read in reactor unit models####
#GW1 <- read_csv("./data/unitDescription1_large.csv") %>%
#  filter(!(is.na(time))) %>%
#  mutate(across(Status, as_factor))

HPC_L12 <- read.xlsx(xlsxFile = unitModelFilePathHPC, sheet = 1) %>%
  filter(!(is.na(time))) %>%
  mutate(across(Status, as_factor)) %>%
  mutate(Level = "L12")

if (lowRes == TRUE) {
  HPC_L12 <- HPC_L12 %>%
    filter(time %% stepsize == 0)}


HPC_L34 <- read.xlsx(xlsxFile = unitModelFilePathHPC, sheet = 2) %>%
  filter(!(is.na(time))) %>%
  mutate(across(Status, as_factor)) %>%
  mutate(Level = "L34")

if (lowRes == TRUE) {
  HPC_L34 <- HPC_L34 %>%
    filter(time %% stepsize == 0)}


HPC_L56 <- read.xlsx(xlsxFile = unitModelFilePathHPC, sheet = 3) %>%
  filter(!(is.na(time))) %>%
  mutate(across(Status, as_factor)) %>%
  mutate(Level = "L56")

if (lowRes == TRUE) {
  HPC_L56 <- HPC_L56 %>%
    filter(time %% stepsize == 0)}


HPC_L78 <- read.xlsx(xlsxFile = unitModelFilePathHPC, sheet = 4) %>%
  filter(!(is.na(time))) %>%
  mutate(across(Status, as_factor)) %>%
  mutate(Level = "L78")

if (lowRes == TRUE) {
  HPC_L78 <- HPC_L78 %>%
    filter(time %% stepsize == 0)}


HPC <- rbind(HPC_L12, HPC_L34, HPC_L56, HPC_L78)

####

SZC_L12 <- read.xlsx(xlsxFile = unitModelFilePathSZC, sheet = 1) %>%
  filter(!(is.na(time))) %>%
  mutate(across(Status, as_factor)) %>%
  mutate(Level = "L12")

if (lowRes == TRUE) {
  SZC_L12 <- SZC_L12 %>%
    filter(time %% stepsize == 0)}


SZC_L34 <- read.xlsx(xlsxFile = unitModelFilePathSZC, sheet = 2) %>%
  filter(!(is.na(time))) %>%
  mutate(across(Status, as_factor)) %>%
  mutate(Level = "L34")

if (lowRes == TRUE) {
  SZC_L34 <- SZC_L34 %>%
    filter(time %% stepsize == 0)}


SZC_L56 <- read.xlsx(xlsxFile = unitModelFilePathSZC, sheet = 3) %>%
  filter(!(is.na(time))) %>%
  mutate(across(Status, as_factor)) %>%
  mutate(Level = "L56")

if (lowRes == TRUE) {
  SZC_L56 <- SZC_L56 %>%
    filter(time %% stepsize == 0)}


SZC_L78 <- read.xlsx(xlsxFile = unitModelFilePathSZC, sheet = 4) %>%
  filter(!(is.na(time))) %>%
  mutate(across(Status, as_factor)) %>%
  mutate(Level = "L78")

if (lowRes == TRUE) {
  SZC_L78 <- SZC_L78 %>%
    filter(time %% stepsize == 0)}


SZC <- rbind(SZC_L12, SZC_L34, SZC_L56, SZC_L78)


####

GW1_L12 <- read.xlsx(xlsxFile = unitModelFilePathGW1, sheet = 1) %>%
  filter(!(is.na(time))) %>%
  mutate(across(Status, as_factor)) %>%
  mutate(Level = "L12")

if (lowRes == TRUE) {
  GW1_L12 <- GW1_L12 %>%
    filter(time %% stepsize == 0)}


GW1_L34 <- read.xlsx(xlsxFile = unitModelFilePathGW1, sheet = 2) %>%
  filter(!(is.na(time))) %>%
  mutate(across(Status, as_factor)) %>%
  mutate(Level = "L34")

if (lowRes == TRUE) {
  GW1_L34 <- GW1_L34 %>%
    filter(time %% stepsize == 0)}


GW1_L56 <- read.xlsx(xlsxFile = unitModelFilePathGW1, sheet = 3) %>%
  filter(!(is.na(time))) %>%
  mutate(across(Status, as_factor)) %>%
  mutate(Level = "L56")

if (lowRes == TRUE) {
  GW1_L56 <- GW1_L56 %>%
    filter(time %% stepsize == 0)}


GW1_L78 <- read.xlsx(xlsxFile = unitModelFilePathGW1, sheet = 4) %>%
  filter(!(is.na(time))) %>%
  mutate(across(Status, as_factor)) %>%
  mutate(Level = "L78")

if (lowRes == TRUE) {
  GW1_L78 <- GW1_L78 %>%
    filter(time %% stepsize == 0)}


GW1 <- rbind(GW1_L12, GW1_L34, GW1_L56, GW1_L78)
#message("GW1")
#print(GW1)


GW2_L12 <- read.xlsx(xlsxFile = unitModelFilePathGW2, sheet = 1) %>%
  filter(!(is.na(time))) %>%
  mutate(across(Status, as_factor)) %>%
  mutate(Level = "L12")

if (lowRes == TRUE) {
  GW1_L12 <- GW1_L12 %>%
    filter(time %% stepsize == 0)}


GW2_L34 <- read.xlsx(xlsxFile = unitModelFilePathGW2, sheet = 2) %>%
  filter(!(is.na(time))) %>%
  mutate(across(Status, as_factor)) %>%
  mutate(Level = "L34")

if (lowRes == TRUE) {
  GW1_L34 <- GW1_L34 %>%
    filter(time %% stepsize == 0)}


GW2_L56 <- read.xlsx(xlsxFile = unitModelFilePathGW2, sheet = 3) %>%
  filter(!(is.na(time))) %>%
  mutate(across(Status, as_factor)) %>%
  mutate(Level = "L56")

if (lowRes == TRUE) {
  GW1_L56 <- GW1_L56 %>%
    filter(time %% stepsize == 0)}


GW2_L78 <- read.xlsx(xlsxFile = unitModelFilePathGW2, sheet = 4) %>%
  filter(!(is.na(time))) %>%
  mutate(across(Status, as_factor)) %>%
  mutate(Level = "L78")

if (lowRes == TRUE) {
  GW1_L78 <- GW1_L78 %>%
    filter(time %% stepsize == 0)}


GW2 <- rbind(GW2_L12, GW2_L34, GW2_L56, GW2_L78)


SMR1_L12 <- read.xlsx(xlsxFile = unitModelFilePathSMR1, sheet = 1) %>%
  filter(!(is.na(time))) %>%
  mutate(across(Status, as_factor)) %>%
  mutate(Level = "L12")

if (lowRes == TRUE) {
  SMR1_L12 <- SMR1_L12 %>%
    filter(time %% stepsize == 0)}


SMR1_L34 <- read.xlsx(xlsxFile = unitModelFilePathSMR1, sheet = 2) %>%
  filter(!(is.na(time))) %>%
  mutate(across(Status, as_factor)) %>%
  mutate(Level = "L34")

if (lowRes == TRUE) {
  SMR1_L34 <- SMR1_L34 %>%
    filter(time %% stepsize == 0)}


SMR1_L56 <- read.xlsx(xlsxFile = unitModelFilePathSMR1, sheet = 3) %>%
  filter(!(is.na(time))) %>%
  mutate(across(Status, as_factor)) %>%
  mutate(Level = "L56")

if (lowRes == TRUE) {
  SMR1_L56 <- SMR1_L56 %>%
    filter(time %% stepsize == 0)}


SMR1_L78 <- read.xlsx(xlsxFile = unitModelFilePathSMR1, sheet = 4) %>%
  filter(!(is.na(time))) %>%
  mutate(across(Status, as_factor)) %>%
  mutate(Level = "L78")

if (lowRes == TRUE) {
  SMR1_L78 <- SMR1_L78 %>%
    filter(time %% stepsize == 0)}

SMR1 <- rbind(SMR1_L12, SMR1_L34, SMR1_L56, SMR1_L78)


SMR2_L12 <- read.xlsx(xlsxFile = unitModelFilePathSMR2, sheet = 1) %>%
  filter(!(is.na(time))) %>%
  mutate(across(Status, as_factor)) %>%
  mutate(Level = "L12")

if (lowRes == TRUE) {
  SMR2_L12 <- SMR2_L12 %>%
    filter(time %% stepsize == 0)}


SMR2_L34 <- read.xlsx(xlsxFile = unitModelFilePathSMR2, sheet = 2) %>%
  filter(!(is.na(time))) %>%
  mutate(across(Status, as_factor)) %>%
  mutate(Level = "L34")

if (lowRes == TRUE) {
  SMR2_L34 <- SMR2_L34 %>%
    filter(time %% stepsize == 0)}


SMR2_L56 <- read.xlsx(xlsxFile = unitModelFilePathSMR2, sheet = 3) %>%
  filter(!(is.na(time))) %>%
  mutate(across(Status, as_factor)) %>%
  mutate(Level = "L56")

if (lowRes == TRUE) {
  SMR2_L56 <- SMR2_L56 %>%
    filter(time %% stepsize == 0)}


SMR2_L78 <- read.xlsx(xlsxFile = unitModelFilePathSMR2, sheet = 4) %>%
  filter(!(is.na(time))) %>%
  mutate(across(Status, as_factor)) %>%
  mutate(Level = "L78")

if (lowRes == TRUE) {
  SMR2_L78 <- SMR2_L78 %>%
    filter(time %% stepsize == 0)}


SMR2 <- rbind(SMR2_L12, SMR2_L34, SMR2_L56, SMR2_L78)

###SMR3####

SMR3_L12 <- read.xlsx(xlsxFile = unitModelFilePathSMR3, sheet = 1) %>%
  filter(!(is.na(time))) %>%
  mutate(across(Status, as_factor)) %>%
  mutate(Level = "L12")

if (lowRes == TRUE) {
  SMR3_L12 <- SMR3_L12 %>%
    filter(time %% stepsize == 0)}


SMR3_L34 <- read.xlsx(xlsxFile = unitModelFilePathSMR3, sheet = 2) %>%
  filter(!(is.na(time))) %>%
  mutate(across(Status, as_factor)) %>%
  mutate(Level = "L34")

if (lowRes == TRUE) {
  SMR3_L34 <- SMR3_L34 %>%
    filter(time %% stepsize == 0)}


SMR3_L56 <- read.xlsx(xlsxFile = unitModelFilePathSMR3, sheet = 3) %>%
  filter(!(is.na(time))) %>%
  mutate(across(Status, as_factor)) %>%
  mutate(Level = "L56")

if (lowRes == TRUE) {
  SMR3_L56 <- SMR3_L56 %>%
    filter(time %% stepsize == 0)}


SMR3_L78 <- read.xlsx(xlsxFile = unitModelFilePathSMR3, sheet = 4) %>%
  filter(!(is.na(time))) %>%
  mutate(across(Status, as_factor)) %>%
  mutate(Level = "L78")

if (lowRes == TRUE) {
  SMR3_L78 <- SMR3_L78 %>%
    filter(time %% stepsize == 0)}


SMR3 <- rbind(SMR3_L12, SMR3_L34, SMR3_L56, SMR3_L78)

##FACTORY####

SMR_FACTORY_L12 <- read.xlsx(xlsxFile = unitModelFilePathSMR_FACTORY, sheet = 1) %>%
  filter(!(is.na(time))) %>%
  mutate(across(Status, as_factor)) %>%
  mutate(Level = "L12")

if (lowRes == TRUE) {
  SMR_FACTORY_L12 <- SMR_FACTORY_L12 %>%
    filter(time %% stepsize == 0)}


SMR_FACTORY_L34 <- read.xlsx(xlsxFile = unitModelFilePathSMR_FACTORY, sheet = 2) %>%
  filter(!(is.na(time))) %>%
  mutate(across(Status, as_factor)) %>%
  mutate(Level = "L34")

if (lowRes == TRUE) {
  SMR_FACTORY_L34 <- SMR_FACTORY_L34 %>%
    filter(time %% stepsize == 0)}


SMR_FACTORY_L56 <- read.xlsx(xlsxFile = unitModelFilePathSMR_FACTORY, sheet = 3) %>%
  filter(!(is.na(time))) %>%
  mutate(across(Status, as_factor)) %>%
  mutate(Level = "L56")

if (lowRes == TRUE) {
  SMR_FACTORY_L56 <- SMR_FACTORY_L56 %>%
    filter(time %% stepsize == 0)}


SMR_FACTORY_L78 <- read.xlsx(xlsxFile = unitModelFilePathSMR_FACTORY, sheet = 4) %>%
  filter(!(is.na(time))) %>%
  mutate(across(Status, as_factor)) %>%
  mutate(Level = "L78")

if (lowRes == TRUE) {
  SMR_FACTORY_L78 <- SMR_FACTORY_L78 %>%
    filter(time %% stepsize == 0)}

SMR_FACTORY <- rbind(SMR_FACTORY_L12, SMR_FACTORY_L34, SMR_FACTORY_L56, SMR_FACTORY_L78)

##TEST####

TEST_L12 <- read.xlsx(xlsxFile = unitModelFilePathTEST, sheet = 1) %>%
  filter(!(is.na(time))) %>%
  mutate(across(Status, as_factor)) %>%
  mutate(Level = "L12")

if (lowRes == TRUE) {
  TEST_L12 <- TEST_L12 %>%
    filter(time %% stepsize == 0)}


TEST_L34 <- read.xlsx(xlsxFile = unitModelFilePathTEST, sheet = 2) %>%
  filter(!(is.na(time))) %>%
  mutate(across(Status, as_factor)) %>%
  mutate(Level = "L34")

if (lowRes == TRUE) {
  TEST_L34 <- TEST_L34 %>%
    filter(time %% stepsize == 0)}


TEST_L56 <- read.xlsx(xlsxFile = unitModelFilePathTEST, sheet = 3) %>%
  filter(!(is.na(time))) %>%
  mutate(across(Status, as_factor)) %>%
  mutate(Level = "L56")

if (lowRes == TRUE) {
  TEST_L56 <- TEST_L56 %>%
    filter(time %% stepsize == 0)}


TEST_L78 <- read.xlsx(xlsxFile = unitModelFilePathTEST, sheet = 4) %>%
  filter(!(is.na(time))) %>%
  mutate(across(Status, as_factor)) %>%
  mutate(Level = "L78")

if (lowRes == TRUE) {
  TEST_L78 <- TEST_L78 %>%
    filter(time %% stepsize == 0)}

TEST <- rbind(TEST_L12, TEST_L34, TEST_L56, TEST_L78)


NULL_REACTOR <- data.frame(time = c(0,1,2,3,4,5,6,7,8,10), 
                           role1 = c(0,0,0,0,0,0,0,0,0,0),
                           role2 = c(0,0,0,0,0,0,0,0,0,0),
                           role3 = c(0,0,0,0,0,0,0,0,0,0),
                           role4 = c(0,0,0,0,0,0,0,0,0,0),
                           role5 = c(0,0,0,0,0,0,0,0,0,0),
                           role6 = c(0,0,0,0,0,0,0,0,0,0),
                           role7 = c(0,0,0,0,0,0,0,0,0,0),
                           role8 = c(0,0,0,0,0,0,0,0,0,0),
                           role9 = c(0,0,0,0,0,0,0,0,0,0),
                           role10 = c(0,0,0,0,0,0,0,0,0,0),
                           role11= c(0,0,0,0,0,0,0,0,0,0),
                           role12 = c(0,0,0,0,0,0,0,0,0,0),
                           role13 = c(0,0,0,0,0,0,0,0,0,0),
                           role14 = c(0,0,0,0,0,0,0,0,0,0),
                           role15 = c(0,0,0,0,0,0,0,0,0,0),
                           Status = c("Construction",
                                      "Construction",
                                      "Construction",
                                      "Construction",
                                      "Construction",
                                      "Construction",
                                      "Construction",
                                      "Construction",
                                      "Construction",
                                      "Construction"),
                           Level = c("L12", "L12", "L12", "L12", "L12",
                                     "L12", "L12", "L12", "L12", "L12"))