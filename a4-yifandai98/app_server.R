library(tidyr)
library(lintr)
library(dplyr)
library(shiny)
library(ggplot2)
library(plotly)
library(RColorBrewer)

CO2_emission <- read.csv("./owid-co2-data.csv")
CO2_emission <- CO2_emission %>%
  filter(iso_code != "") %>%
  filter(iso_code != "OWID_WRL")
#What is the average value of co2 growth prct (in the current year)?
avg_co2_grw <- CO2_emission %>%
  filter(year == 2019) %>%
  summarise(avg_co2_grw = mean(co2_growth_prct)) %>%
  pull(avg_co2_grw)
#What is the highest co2 growth prct in 2019? 
highest_co2_grw_2019 <- CO2_emission %>%
  filter(year == 2019) %>%
  summarise(highest_co2_growth = max(co2_growth_prct, na.rm = T)) %>%
  pull(highest_co2_growth)
#When is co2 growth prct the highest?
year_highest_co2_grw <- CO2_emission %>%
  filter(co2_growth_prct == max(co2_growth_prct, na.rm = T)) %>%
  pull(year)
#Where is co2 growth prct the highest over years?
country_highest_co2_grw <- CO2_emission %>%
  filter(co2_growth_prct == max(co2_growth_prct, na.rm = T)) %>%
  pull(country)
#What is the highest co2 growth prct over years?
highest_co2_grw <-  CO2_emission %>%
  filter(co2_growth_prct == max(co2_growth_prct, na.rm = T)) %>%
  pull(co2_growth_prct)

year_range <- range(CO2_emission$year)

selected_values <-  unique(CO2_emission$country)

server <- function(input, output) {
  output$plot_data <- renderPlotly({
   p <- CO2_emission %>%
     filter(year > input$year_choice[1], year < input$year_choice[2])
   co2_growth_plot <- ggplot(p) +
     geom_point(mapping = aes_string(x = "year", 
                                     y = "co2_growth_prct"), 
                color = input$color_var) +
     labs(title = "Co2 emission growth percent trends over years",
          x = "Year", y = "Co2 growth rate(%)") +
     scale_x_continuous(limits = input$year_choice) +
     theme_bw()
  
   ggplotly(co2_growth_plot)
  })
}
