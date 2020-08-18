## Author: Meagan Brown
## Date: 08/12/2020
## Purpose: Using plots for the first time Daily Exercise 06

library(tidyverse)

url = 'https://raw.githubusercontent.com/nytimes/covid-19-data/master/us-counties.csv'

covid = read_csv(url)

library(dplyr)
library(ggplot2)
library(ggthemes)

covid %>%
  filter(date == max(date)) %>%
  group_by(state) %>%
  summarize(totCases = sum(cases)) %>%
  ungroup() %>%
  arrange(desc(totCases)) %>%
  head(6) %>%
  pull(state) ->
  worstcases

what = covid %>%
  filter(state %in% worstcases) %>%
  group_by(state, date) %>%
  summarize(cases = sum(cases)) %>%
  ungroup() %>%
  ggplot(aes(x = date, y = cases, color = state)) +
  geom_line(size=0.5) +
  facet_wrap(~state) +
  ggthemes::theme_excel() +
  labs(title ="Top 6 states with Highest Covid Counts",
       subtitle ="Data Source: NY-Times",
       x= "Date",
       y= "Cases",
       caption = "Daily Exercise 06")

ggsave(what, file = "img/myplot.png")


question2 =
covid%>%
  group_by(date) %>%
  summarize(cases = sum(cases)) %>%
  ggplot(aes(x = date, y= cases)) +
  geom_col(fill = "blue", color = "green", alpha = 10) +
  geom_line(color = "blue", size = 2) +
  ggthemes:: theme_excel() +
  labs(title = "Covid Counts for the US",
       x = "Date",
       y = "Cases",
       caption = "Daily Exercise 06")

ggsave(question2, file = "img/graph2.png")






