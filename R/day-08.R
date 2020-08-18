## Name: Meagan Brown
## 08-16-2020
## Purpose: Exercise 08 plotting daily new cases

library(tidyverse)
library(knitr)
library(readxl)
library(zoo)
library(kableExtra)
library(dplyr)
library(ggplot2)

url = 'https://raw.githubusercontent.com/nytimes/covid-19-data/master/us-counties.csv'
covid = read_csv(url)

graph08 =
  covid %>%
  filter(state %in% "New York") %>%
  mutate(newCases = cases - lag(cases)) %>%
  mutate(avg = rollmean(newCases, 7, fill = NA, align = "right")) %>%
  summarise(date, avg, newCases) %>%
  pivot_longer(cols = c('avg', 'newCases'))

actualgraph =
  graph08 %>%
  ggplot(aes(x = date, y = value, color = "red"))+
  geom_line(size = 0.5) +
  ggthemes::theme_igray() +
  labs(title = "New and Average Cases within New York State",
       subtitle = "Data Source: NY-Times",
       x = "Date",
       y = "Number of Cases",
       caption = "Daily Exercise 08")

ggsave(actualgraph, file = "img/ex08.png")
