source("crime_data.R")

my_ui <- fluidPage(
  titlePanel("Predicting health inspection results based on safety rate of location in King County"),

  tabsetPanel(
    type = "tabs",
    tabPanel(
      "Map King County",
      
      sidebarLayout(
        sidebarPanel(
          h2("Predicting Health Rating Based on Location Safety"),
          selectInput(
            inputId = "county_zip", label = "Zip codes of county",
            choices = seattle_zip, selected = "zipcode"
          )
        ),
        mainPanel(
          plotOutput(outputId = "number_plot"), tyler_response
        )
      )  
    )
  )
)
  