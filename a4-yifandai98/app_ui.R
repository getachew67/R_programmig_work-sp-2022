library(shiny)
source("app_server.R")

year_range <- range(CO2_emission$year)

selected_values <-  unique(CO2_emission$country)

year_input <- sliderInput(
  inputId = "year_choice",
  label = "Year",
  min = year_range[1],
  max = year_range[2],
  value = year_range
)

color_input <- selectInput(
  inputId = "color_var",
  label = "Color of Points",
  choices = c("darkgray", "blue", "red", "orange",
              "green", "brown", "purple")
)

  page_one <- tabPanel(
    titlePanel("CO2 emssion Analysis"),
      mainPanel(
        p("Overview"),
        p("Welcome to my first ShinyApp! This project is about discovering 
        world's trends from 1750-2019 on co2 emissions growth, and analyze 
        what may caused this trend. The variable includes CO2 growth percent,
        years, and country. 
        Here are my summary statistics: 
        The average CO2 emssion grwoth rate in 2019 (the most recent date)
        is about ",
        strong(avg_co2_grw),
        ". The highest CO2 emssion growth rate is ",
        strong(highest_co2_grw_2019),
        ". Over years, I found out that ",
        strong(country_highest_co2_grw),
        " had the highest CO2 emssion growth rate with ",
        strong(highest_co2_grw),
        " in ",
        strong(year_highest_co2_grw),
        "."),
        p(
          "Source:",
           a("https://github.com/owid/co2-data")
      )
    )
  )
  
  page_two <- tabPanel(
    titlePanel("CO2 emission growth rate Scatterplot"),
    sidebarLayout(
      sidebarPanel(
         h3("Adjustable Graphical Parameters"),
         year_input,
         color_input
      ),
      ### Main panel displays the scatterplot
      mainPanel(
        h3("Scatterplot"),
        plotlyOutput(outputId = "plot_data"),
        p("Co2 emssion growth percent has increased over years.
          The highest emssion growth was during 1950. I think the major cause
          was the use of coal and oil began to incresae suddenly during the 
          industrial period, which also led to an increase in Co2 emssion.")
      )
    )
  )


ui <- navbarPage(
  "CO2 emission Analysis",
  page_one,
  page_two
  )
