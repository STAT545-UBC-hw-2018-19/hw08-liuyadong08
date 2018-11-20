library(shiny)
library(ggplot2)
library(dplyr)
library(DT)
library(rsconnect)
library(shinyjs)
library(colourpicker)

bcl <- read.csv("bcl-data.csv", stringsAsFactors = FALSE)

ui <- fluidPage(
  titlePanel("BC Liquor Store prices"),
  sidebarLayout(
    sidebarPanel(
      sliderInput("priceInput", "Price", 0, 100, c(15, 40), pre = "$"),
      selectInput("typeInput", "Product type", multiple = TRUE,
                  choices = c("BEER", "REFRESHMENT", "SPIRITS", "WINE"),
                  selected = c("WINE", "BEER")),
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
      "A histogram shows number of liquor af different alcohol content", 
      plotOutput("coolplot"),
      br(), br(),
      uiOutput('myPanel'),
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
             Type %in% input$typeInput,
             Country == input$countryInput
      )
  })
  
  output$coolplot <- renderPlot({
    if (is.null(filtered())) {
      return()
    }
    ggplot(filtered(), aes(x = Alcohol_Content, fill = Type)) +
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