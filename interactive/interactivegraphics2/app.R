library(shiny)
library(tidyverse)
library(ggplot2)

data = read_delim("../../data/house_sales.csv", delim=",")
data = data %>% as_tibble()
temp=colnames(data %>% select(-c(id,date,price,lat,long,zipcode,yr_built,yr_renovated)))


# Eingaben
ui <- fluidPage(
  
  # Application title
  titlePanel("Interaktive Grafik 2"),
  
  # Sidebar mit Buttons 
  sidebarLayout(
    sidebarPanel(p("Wähle die X- und Y-Achse:"),
      radioButtons(inputId = "userinput1",
                   label = "X-Variable",
                   choices = temp,
                   selected = "sqft_living"),
      radioButtons(inputId = "userinput2",
                   label = "Y-Variable",
                   choices = temp,
                   selected = "sqft_living15")
    ),
    
    # Scatterplot der 2 ausgewählten Inputs gegeneinander
    mainPanel(
      plotOutput("scatterplot", height = 700)
    )
  )
)

# Define server logic required to draw a histogram
server <- function(input, output) {
  
  output$scatterplot <- renderPlot({
    #req(input$userinput1)
    #req(input$userinput2)
    data %>% ggplot(aes_string(x=input$userinput1, y=input$userinput2)) +
      geom_point(aes(color=grade))
    
  })
}

# Run the application 
shinyApp(ui = ui, server = server)
