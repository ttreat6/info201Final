source("crime_data.R")

my_server <- function(input, output) {
  output$health_plot <- renderPlot({
    filtered_inspection <- reviews_Vs_safety %>%
      filter(location.zipcode == input$zip) })
  
  output$my_map <- renderLeaflet({
    
    leaflet(wacounties)%>% setView(lng = -122.335167, lat = 47.6062, zoom = 11) %>%
      addTiles() %>%
      addPolygons(stroke = FALSE, smoothFactor = 0.3, fillOpacity = 1,
                  fillColor = ~pal(log10(zip_count$freq)),
                  label = wacounties$ZIPCODE) %>%
      addLegend(pal = pal, values = ~log10(zip_count$freq), opacity = 1.0,
                labFormat = labelFormat(transform = function(x) round(10^x))) 
    
    filtered_number <- health_rates%>% 
      filter(Zip.Code == input$county_zip)
    
    result <- ggplot(data = health_rates) +
      geom_bar(mapping = aes(x = Inspection.Result, fill = Inspection.Result))
    
  })
    
}