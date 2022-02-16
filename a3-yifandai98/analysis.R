library(dplyr)
library(tidyr)
library(ggplot2)
library(maps)
library(mapproj)
library(lintr)
setwd("~/Desktop/info201/a3-yifandai98")
lint("analysis.R")
Incarceration <- read.csv("./incarceration_trends.csv")
# What is the average values of my variable aapi_jail_pop across all of counties 
avg_aapi_jail <- Incarceration %>%
  summarize(avg_aapi_jail = mean(aapi_jail_pop, na.rm = TRUE)) %>%
  pull(avg_aapi_jail)
#what is my variable the highest?
highest_aapi_jail <- Incarceration %>%
  summarise(highest_aapi_jail = max(aapi_jail_pop, na.rm = TRUE)) %>%
  pull(highest_aapi_jail)

#what is my variable the lowest?
lowest_aapi_jail <- Incarceration %>%
  summarise(lowest_aapi_jail = min(aapi_jail_pop, na.rm = TRUE)) %>%
  pull(lowest_aapi_jail)

#where is it the highest?
location_highest_aaj <- Incarceration %>%
  filter(aapi_jail_pop == max(aapi_jail_pop, na.rm = TRUE)) %>%
  pull(county_name)

#When is my variable the highest?
year_highest_aapi <- Incarceration %>%
  filter(aapi_jail_pop == max(aapi_jail_pop, na.rm = TRUE)) %>%
  pull(year)


#Trend Over time chart
change_in_aapi_jail <- Incarceration %>%
  group_by(year) %>%
  summarise(across(c(total_jail_pop, black_jail_pop, white_jail_pop,
                     aapi_jail_pop), sum, na.rm = TRUE)) %>%
  pivot_longer(cols = !year, names_to = "race", values_to = "population")
plot <- ggplot(data = change_in_aapi_jail) +
  geom_point(mapping = aes(x = year, y = population, color = race)) +
  geom_line(mapping = aes(x = year, y = population, color = race)) +
labs(x = "Year", y = "Population in jail" , 
     title = "Population in jail Over Time", color = "Race")

#Variable comparison chart
total_pop_vs_total_jail <- Incarceration %>%
  filter(year == 2018) %>%
  group_by(state) %>%
  summarise(across(c(total_jail_pop, aapi_jail_pop), sum, na.rm = TRUE)) %>%
  top_n(10, wt = state) %>%
  pivot_longer(cols = !state, names_to = "race", values_to = "population")
comparison <- ggplot(data = total_pop_vs_total_jail) +
  geom_col(mapping = aes(x = population, y = state, fill = race)) + 
  labs(y = "State", title = "Top 10 states of population in jail", fill = "race")

#map:find ratio of aapi:total in jail in 2018 (most recent year)
aapi_ratio_2018 <- Incarceration %>%
  filter(year == 2018) %>%
  group_by(state) %>%
  summarise(total_pop_injail = sum(total_jail_pop, na.rm = TRUE),
            total_aapi_jail = sum(aapi_jail_pop, na.rm = TRUE),
            ratio = total_aapi_jail/total_pop_injail)

state_fips <- sub(":.*", "", state.fips$polyname)

new_state_fips <- state.fips  %>%
  mutate(states = state_fips) %>%
  distinct(states, .keep_all = TRUE)

state_shape <- map_data("state") %>%
  rename(states = region) %>% 
  left_join(new_state_fips, by="states") %>%
  rename(state = abb) %>% 
  left_join(aapi_ratio_2018, by="state")

blank_theme <- theme_bw() +
  theme(
    axis.line = element_blank(),        # remove axis lines
    axis.text = element_blank(),        # remove axis labels
    axis.ticks = element_blank(),       # remove axis ticks
    axis.title = element_blank(),       # remove axis titles
    plot.background = element_blank(),  # remove gray background
    panel.grid.major = element_blank(), # remove major grid lines
    panel.grid.minor = element_blank(), # remove minor grid lines
    panel.border = element_blank()      # remove border around plot
  )
aapi_map <- ggplot(state_shape) +
  geom_polygon(
    mapping = aes(x = long, y = lat, group = group, fill = ratio),
    color = "white", 
    size = .1        
  ) +
  coord_map() + 
  scale_fill_continuous(low = "#132B43", high = "Red") +
  labs(title = "The ratio of AA:Total in jail in 2018", 
       fill = "AA:total in jail") +
  blank_theme