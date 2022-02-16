# A2: U.S. COVID Trends

## Overview
In many ways, we have come to understand the gravity and trends in the COVID-19 pandemic through quantitative means. Regardless of media source, people are consuming more epidemiological information than ever, primarily through reported figures, charts, and maps.

This assignment is your opportunity to work directly with the same data used by the New York Times. While the analysis is guided through a series of questions, it is your opportunity to use programming skills to ask more detailed questions about the pandemic.

You'll load the data directly from the [New York Times GitHub page](https://github.com/nytimes/covid-19-data/), and you should make sure to read through their documentation to understand the meaning of the datasets.

Note, this is a long assignment, meant to be completed over the two weeks when we'll be learning data wrangling skills. I strongly suggest that you **start early**, and approach it with patience. We're asking real questions of real data, and there is inherent trickiness involved.

## Analysis
You should start this assignment by opening up your `analysis.R` script. The script will guide you through an initial analysis of the data. Throughout the script, there are prompts labeled **Reflection**. Please write 1 - 2 sentences for each of these reflections below:

- What does each row in the data represent (hint: read the [documentation](https://github.com/nytimes/covid-19-data/)!)?

**Answer:** Each row represent each _location's cases and deaths_ on each _date_.

- What did you learn about the dataset when you calculated the state with the lowest cases (and what does that tell you about testing your assumptions in a dataset)?

**Answer:** I learned that I need to filter the _specific rows_ that _satisfy_ my conditions, such as date and cases in `state_lowest_cases`.

- Is the location with the highest number of cases the location with the most deaths? If not, why do you believe that may be the case?

**Answer:** No. In this case, I found out that the county with the most cases, which is _"Los Angeles"_, is **not** the one with the most death, _"New York City, New York"_. It means that highest number of cases **_does not_** mean the **most violent**.

- What do the plots of cases and deaths tell us about the  pandemic happening in "waves"? How (and why, do you think) these plots look so different?

**Answer:** The plots of cases and deaths tell us that the number of cases during the pandemic have **_increased_**. Also along with the pandemic, the plots became _more scatter_ as the date _more recent_. I think because of _the orders_ established to keep everyone stay at home caused an _increased_ in the unemployment. That resulted _more crimes_ happened during the pandemic as some people are struggling to live.

- Why are there so many observations (counties) in the variable `lowest_in_each_state` (i.e., wouldn't you expect the number to be ~50)?

**Answer:** There are many observations in the variable `lowest_in_each_state` because many of the states have _same lowest number_ of deaths on _different county_. Therefore, when counting the location of county, there are _more than one_ county resulted the lowest deaths.

- What surprised you the most throughout your analysis?

**Answer:** The most surprising part is as I calculated the variable `date_most_deaths`, it came out as _"2021-01-12"_, less than a month ago. Even though during the pandemic, it did not help decline the crime.
