#library("shiny")
library("ggplot2")
library("leaflet")
library("geojsonio")
library("dplyr")
library("ggmap")
library("maps")
library("rgdal")
library("sf")
library("sp")
library("plyr")

source("crime_data.R")
source("my_ui.R")
source("my_server.R")


shinyApp(ui = my_ui, server = my_server)
