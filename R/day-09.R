#Meagan Brown
#August 19 2020
#Ex 10

library(USAboundaries)
library(tidyverse)
library(sf)

states_og <- us_states()

us <- states_og %>%
  filter(!(name %in% c('Puerto Rico', 'Alaska', 'Hawaii')))

state = st_cast(us, 'MULTILINESTRING') %>%
  select(geometry)

plot(state$geometry, col = 'green')
state


states_border <- st_union(us$geometry) %>%
  st_cast('MULTILINESTRING')

plot(states_border, col = 'green')
states_border


