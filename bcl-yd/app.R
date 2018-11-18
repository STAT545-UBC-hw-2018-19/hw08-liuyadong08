library(shiny)
library(ggplot2)
library(dplyr)
library(DT)
library(rsconnect)

bcl <- read.csv("bcl-data.csv", stringsAsFactors = FALSE)

ui <- fluidPage(
  titlePanel("BC Liquor Store prices"),
  sidebarLayout(
    sidebarPanel(
      sliderInput("priceInput", "Price", 0, 100, c(25, 40), pre = "$"),
      radioButtons("typeInput", "Product type",
                  choices = c("BEER", "REFRESHMENT", "SPIRITS", "WINE"),
                  selected = "WINE"),
      selectInput("countryInput", "Country",
                  sort(unique(bcl$Country)),
                  selected = "FRANCE"),
      checkboxInput("checkbox", "Sort by price or not",
                   value = TRUE),
      br(),
      img(src='liquor.jpg', width="240", height="180", align="left")
      #uiOutput("countryOutput")
    ),
    mainPanel(
      plotOutput("coolplot"),
      br(), br(),
      dataTableOutput("results")
    )
  )
)

server <- function(input, output) {
  #output$countryOutput <- renderUI({
   # selectInput("countryInput", "Country",
    #            sort(unique(bcl$Country)),
     #           selected = "CANADA")
  #})  
  
  filtered <- reactive({
    if (is.null(input$countryInput)) {
      return(NULL)
    }    
    
    bcl %>%
      filter(Price >= input$priceInput[1],
             Price <= input$priceInput[2],
             Type == input$typeInput,
             Country == input$countryInput
      )
  })
  
  output$coolplot <- renderPlot({
    if (is.null(filtered())) {
      return()
    }
    ggplot(filtered(), aes(Alcohol_Content)) +
      geom_histogram()
  })

  output$results <- renderDataTable({
    if (input$checkbox){
      arrange(filtered(), Price)
    } else{
      filtered()
    }
  })
}

shinyApp(ui = ui, server = server)