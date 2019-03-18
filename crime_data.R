library("geojsonio")
library("dplyr")
library("ggmap")
library("ggplot2")
library("maps")
library("leaflet")
library("rgdal")
library("sf")
library("sp")
library("plyr")



##Filter and Clean the Data
inspection_data <- read.csv("Food_safety_2018_zipcodes.csv", stringsAsFactors = FALSE)
inspection_data <- inspection_data %>%
  distinct(Address, .keep_all = TRUE)


crime_data <- read.csv("Crime Data.csv", stringsAsFactors = FALSE)

test_join <- left_join(crime_data, inspection_data, by = "Zip.Code")
new_total <- distinct(test_join, Name, .keep_all = TRUE)


health_rates <- data.frame(new_total %>%
  select(Name, Inspection.Result, Longitude, Latitude, Zip.Code))
na.omit(health_rates)

inspection_count <- data.frame(count(health_rates, "Inspection.Result"))

##Generate a Plot

ggplot(data = health_rates) +
  geom_bar(mapping = aes(x = Inspection.Result, fill = Inspection.Result))


##Generate the Map
options(scipen = 999)

  zip_count <- data.frame(count(new_total, "Zip.Code"))

  wacounties <- geojsonio::geojson_read("Zip_Codes.geojson",
                                        what = "sp")

  pal <- colorNumeric("viridis", NULL)
  

  leaflet(wacounties)%>% setView(lng = -122.335167, lat = 47.6062, zoom = 11) %>%
    addTiles() %>%
    addPolygons(stroke = FALSE, smoothFactor = 0.3, fillOpacity = 1,
                fillColor = ~pal(log10(zip_count$freq)),
                label = wacounties$ZIPCODE) %>%
    addLegend(pal = pal, values = ~log10(zip_count$freq), opacity = 1.0,
              labFormat = labelFormat(transform = function(x) round(10^x))) 
  
  

