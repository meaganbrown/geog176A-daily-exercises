library(tidyverse)
library(sf)
homes = read_csv("~/Documents/github/geog176A-daily-exercises/data/uscities.csv") %>%
st_as_sf(coords = c("lng","lat"), crs = 4326) %>%
filter(city %in% c("Santa Barbara", "Lake Elsinore"))

st_distance(homes)
st_distance((st_transform(homes, 5070)))
st_distance(st_transform(homes, '+proj=eqdc +lat_0=40 +long_0=-96 +lat_1=20 +lat_2=60 +x_0=0 +y_0=0 +datum=NAD83 +units=m +nodefs'))

library(units)
st_distance(homes)
(st_distance(homes) %>%
    set_units("km") %>%
    drop_units())
