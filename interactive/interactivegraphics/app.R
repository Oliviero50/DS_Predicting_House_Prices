## LIBRARES -------
library(shiny)
library(ggplot2)
library(tidyverse)
library(rnaturalearth, quietly = TRUE)
library(rnaturalearthdata, quietly = TRUE)


## IMPORT DATA -----------
# From File:
data = read_delim("../../data/house_sales.csv", delim=",")
data = data %>% as_tibble()
data = data %>% mutate(pricecat = case_when(
  price < 321950  ~ 'low 0-25 percentile',
  price < 645000  ~ 'mid 25-75 percentile',
  price > 645000  ~ 'high 75-100 percentile'
))


select_values <- c('low 0-25 percentile', 'mid 25-75 percentile', 'high 75-100 percentile' )



## USER INTERFACE -------------------
ui <- fluidPage(
  titlePanel("Interaktive Grafik 1"),
  hr(),
  
  theme = bslib::bs_theme(version = 4),
  
  
  sidebarLayout(
    
    sidebarPanel(
      width = 3,
      h3("Hauspreise nach Lage anhand der Preisklasse"),
      p("Wähle eine Preisklasse"),
      selectInput(
        inputId = "y_label",
        label = "Preisklasse:",
        choices = select_values[],
        selected = 'low 0-25 percentile'
      ),
      hr()
    ),
    
    mainPanel(
      plotOutput("plot", height = 700)
    )
  )
  
) 



## SERVER LOGIC --------------------
server <- function(input, output) {
  
  # Output
  output$plot <- renderPlot({
    

  #Filtere Daten anhand des Inputs  
    data = data %>% filter(pricecat==input$y_label)
  #Erzeuge Grafik  
    world <- ne_countries(scale = "medium", returnclass = "sf")
    ggplot(data = world) +
      geom_sf() +
      geom_point(data = data, aes(x = long, y = lat, col=as.factor(pricecat)), size = 0.5, 
                 shape = 23, fill = "darkred") +
      ggtitle("Preis der Häuser nach Lage")+
      coord_sf(xlim = c(-122.5, -121.7), ylim = c(47.20, 47.8)) + 
      labs(color="Preisklasse")
  })
}

## RUN APPLICATION 
shinyApp(ui, server)
