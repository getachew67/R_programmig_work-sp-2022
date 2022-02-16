# Libraries
library(dplyr)
library(ggplot2)
CO2_emission <- read.csv("./owid-co2-data.csv")

source("app_ui.R")
source("app_server.R")

shinyApp(ui = ui, server = server)