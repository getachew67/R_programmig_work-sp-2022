# Overview ----------------------------------------------------------------

# Assignment 1: Analysis of the protest data from Crowd Love
# For each question/prompt, write the necessary code to calculate the answer.
# For grading, it's important that you store your answers in the variable names
# listed with each question in `backtics`.
# For each prompt marked `Reflection`, please write a response
# in your `README.md` file.



# Part 1:Set up -----------------------------------------------------------

# In this section, you're loading the data and necessary packages.
# Load the `stringr` package, which you'll use later.

# Load the data from https://countlove.org/data/data.csv
# into a variable called `protests`
library(stringr)
protests <- read.csv("https://countlove.org/data/data.csv")
# How many protests are in the dataset? `num_protests`
num_protests <- nrow(protests)
# How much information is available about each protest? `num_features`
num_features <- ncol(protests)

# Part 2: Attendees -------------------------------------------------------

# In this section, you're exploring the number of attendees.

# Extract the `Attendees` column into a variable called `num_attendees`
num_attendees <- protests$Attendees
# What is the lowest number of attendees? `min_attendees`
# (hint for this and other calculations: you'll need to consider missing values)
min_attendees <- min(num_attendees, na.rm = T)
# What is the highest number of attendees? `max_attendees`
max_attendees <- max(num_attendees, na.rm = T)
# What is the mean number of attendees? `mean_attendees`
mean_attendees <- mean(num_attendees, na.rm = T)
# What is the median number of attendees? `median_attendees`
median_attendees <- median(num_attendees, na.rm = T)
# What is the difference between the mean and median number of attendees?
# `mean_median_diff`
mean_median_diff <- mean_attendees - median_attendees
# Reflection: What does the difference between the mean and the median
# tell you about the *distribution* of the data? (if you're unfamiliar with
# working with distibutions, feel free to ask your TA for clarification)

# To further assess the distribution of values, create a boxplot of the number
# of attendees using the `boxplot()` function.
# Store the plot in a variable called `attendess_distribution`
# (Note, we'll use much more refined plotting methods, and pay far
# more attention to detail later in the course)
attendess_distribution <- boxplot(num_attendees)
# Create another boxplot of the *log* of the number of attendees.
# Store the plot in a variable `log_attendees_distribution`.
# (note, you will see a warning in the console, which is expected)
log_attendess_distribution <- boxplot(log(num_attendees, base = exp(1)))

# Part 3: Locations -------------------------------------------------------

# In this section, you're exploring where protests happened.

# Extract the `Location` column into a variable called `locations`
locations <- protests$Location
# How many *unique* locations are in the dataset? `num_locations`
num_locations <- length(unique(protests$Location))
# How many protests occured in Washington? `num_in_wa`
# (hint: use a function from the stringr package to detect the letters "WA")
num_in_wa <- sum(str_count(protests$Location, "WA"))
# What proportion of protests occured in Washington? `prop_in_wa`
prop_in_wa <- (num_in_wa/length(locations))
# Reflection: Does the number of protests in Washington surprise you?
# Why or why not?

# Write a function `count_in_location()` that accepts (as a parameter)
# a `location` name, and returns the sentence (note: spacing and punctuation):
# "There were N protests in LOCATION.", where N is the number of
# protests that occured in that location, and LOCATION is the parameter that
# was provided into the function.
# Note, you should count the number of locations that *match* the parameter
# put into the function, so `Seattle` should be a match for "Seattle, WA"
count_in_location <- function(location){
  num_pt <- sum(str_detect(protests$Location, location))
  location_count <- paste0("There were ", num_pt, " protests in ", location, ".")
  location_count
}
# Use your function above to describe the number of protests in "Washington, DC"
# `dc_summary`
dc_summary <- count_in_location("Washington, DC")
# Use your function above to describe the number of protests in "Minneapolis"
# `minneapolis_summary`
minneapolis_summary <- count_in_location("Minneapolis")
# Create a new vector `states` which is the last two characters of each
# value in the `locations` vector. Hint, you may want to again use the
# `stringr` package
states <- substr(locations, nchar(locations) - 1, nchar(locations))
# Create a vector of the unique states in your dataset. `uniq_states`
uniq_states <- c(unique(states, incomparables = F))
# Create a summary sentence for each state by passing your `uniq_states`
# variable and `count_in_location` variables to the `sapply()` function.
# Store your results in `state_summary`
# (don't miss how amazing this is! Very powerful to apply your function to an
# entire vector *at once* with `sapply()`)
state_summary <- sapply(uniq_states, count_in_location)
# Create a summary table by passing your `states` variable to the `table()`
# funciton, and storing the result in a variable `state_table`.
state_table <- table(states)
# Optional: use the View() function to more easily read the table

# Reflection: Looking at the `state_table` variable, what data quality issues
# do you notice, and how would you use that to change your analysis (no need
# to actually change your analysis)?

# What was the maximum number of protests in a state? `max_in_state`
# (hint: use your `state_table` variable)
max_in_state <- max(state_table)

# Part 4: Dates -----------------------------------------------------------

# In this section, you're exploring *when* protests happened.

# Extract the `Date` column into a variable called `dates` by passing the
# column to the `as.Date()` function (this will process the values as dates,
# which are *luckily* already in an optimal format for parsing)
dates <- as.Date(protests$Date)
# What is the most recent date in the dataset? `most_recent`
most_recent <- max(dates)
# What is the earliest date in the dataset? `earliest`
earliest <- min(dates)
# What is the length of the timespan of the dataset? `time_span`
# hint: R can do math with dates pretty well by default!
time_span <- most_recent-earliest
# Create a vector of the dates that are in 2020 `in_2020`
in_2020 <- dates[(str_sub(dates, 1, 4)) == 2020]
# Create a vector of the dates that are in 2019. `in_2019`
in_2019 <- dates[(str_sub(dates, 1, 4)) == 2019]
# What is the ratio of the number of protests in 2020 comparted to 2019?
# `ratio_2020_2019`
ratio_2020_2019 <- length(in_2020)/length(in_2019)
# Reflection: Does the change in the number of protests from 2019 to 2020
# surprise you? Why or why not?

# Write a function `count_on_date()` that accecpts as a parameter a `date`,
# and returns the sentence:
# "There were N protests on DATE.", where N is the number of protests on that
# date, and DATE is the date provided
count_on_date <- function(date){
  c_date <- as.Date(date, format = "%B %d, %Y")
  total_protests <- length(grep(c_date, dates))
  sentence_1 <- paste0("There were ", total_protests, " protests on ",
                       c_date, ".")
  sentence_1
} 
# Using your function you just wrote, how many protests were there on
# May 24th, 2020? `num_may_24`
num_may_24 <- count_on_date("May 24, 2020")
# Using your function you just wrote, how many protests were there on
# May 31th, 2020? `num_on_may_31`
num_on_may_31 <- count_on_date("May 31, 2020")
# For more on this timeline, see:
# https://www.nytimes.com/article/george-floyd-protests-timeline.html

# How many protests occured each month in 2020? `by_month_table`
# Hint: use the `months()` function, your `in_2020` dates, and the `table()`
# Function. If you like, you can do this in multiple different steps.
by_month_table <- table(months(in_2020))
# As a comparison, let's assess the change between July 2019 and July 2020.
# What is the *difference* in the number of protests between July 2020 and
# July 2019? You'll want to do this in multiple steps as you see fit, though
# your answer should be stored in the variable `change_july_protests`.
num_july_2019 <- sum(str_count(months(in_2019), "July"))
num_july_2020 <- sum(str_count(months(in_2020), "July"))
change_july_protests <- num_july_2020 - num_july_2019
# Reflection: do a bit of research. Find at least *two specific policies* that
# have been changed as a result of protests in 2020. These may be at the
# city, state, or University level. Please provide a basic summary, as well as a
# link to each article.

# Part 5: Protest Purpose -------------------------------------------------

# In this section, you're exploring *why* protests happened
# Extract the `Event..legacy..see.tags.` column into a variable called `purpose`
purpose <- protests$Event..legacy..see.tags.
# How many different purposes are listed in the dataset? `num_purposes`
num_purposes <- length(unique(purpose))
# That's quite a few -- if you look at -- View() -- the vector, you'll notice
# a common pattern for each purpose. It's listed as:
# SOME_PURPOSE (additiona_detail)
# To get  higher level summary, create a variable `high_level_purpse` by
# extracting *everything before the first parenthesis* in each value
# in the vector. For example, from "Civil Rights (Black Women's March)"
# you would extract "Civil Rights". You'll also have to *remove the space*
# before the first parenthasis.
# Hint: this will take a little bit of googling // trial and error. Be patient!
high_level_purpose <- sub(" \\(.*", "", purpose)
# How many "high level" purposes have you identified? `num_high_level`
num_high_level <- length(unique(high_level_purpose))
# Create a table that counts the number of protests for each high level purpose
# `high_level_table`
high_level_table <- table(high_level_purpose)

# Reflection: Take a look (`View()`) your `high_level_table` variable. What
# picture does this paint of the U.S.?


# Part 6: Independent Exploration -----------------------------------------

# As a last step, you should write your own function that allows you to
# quickly ask questions of the dataset. For example, in the above sections,
# you wrote functions to ask the same question about different months, or
# locations. If you need any guidance here, feel free to ask!

#I wrote a function that would answer how many protests happened that 
#have certain attendees.
attendees <- function(type_attendees){
  n <- length(na.omit(str_extract(protests$Attendees, type_attendees)))
  summary_attendees <- 
    if(n == 0){
      paste0("There are 0 protest that has ", type_attendees, " attendees.")
    }else{
      paste0("There are ", n, " protests that have ", type_attendees, 
             " attendees.")
    }
  summary_attendees
}
example_1 <- attendees("1500")
example_2 <- attendees("9000000000")