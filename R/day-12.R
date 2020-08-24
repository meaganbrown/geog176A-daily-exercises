library(USAboundaries)
library(tidyverse)
library(ggplot2)
library(sf)

USAboundaries::us_states(resolution = "low")
us <- us_states()

eqdc = '+proj=eqdc +lat_0=40 +lon_0=-96 +lat_1=20 +lat_2=60 +x_0=0 +y_0=0 +datum=NAD83 +units=m +no_defs'

conus = us %>%
  filter(!(name %in% c('Puerto Rico', 'Alaska', 'Hawaii'))) %>%
  st_as_sf(coords = c("lng","lat"), crs = 4326) %>%
  st_transform(eqdc)

states = filter(conus, stusps %in% c("FL", "GA", "AL")) %>%
  select(name)

fl = filter(states, name == "Florida")

(mutate(states,
        deim9 = st_relate(states, fl),
        touch = st_touches(states, fl, sparse = F)))

mutate(states,
       touch = st_touches(states, fl, sparse = FALSE))

 FloridaGraph =
   ggplot(conus) +
  geom_sf() +
  geom_sf(data = fl, fill = "blue", alpha = .3) +
  geom_sf(data = st_filter(states, fl, .predicate = st_touches), fill = "red", alpha = .5) +
  theme_dark()

  ggsave(FloridaGraph, file = ("~/Documents/github/geog176A-daily-exercises/img/ex_11.png"))


