
library(shiny)

# Define UI for application that draws a histogram
shinyUI(fluidPage(

  # Application title
  titlePanel("Demonstrating k nearest neighbours"),

  sidebarLayout(
    sidebarPanel(
      p("With these controls you can modify the input parameters of knn algorithm.", align = "left"),
      numericInput("seed", 
                   label = p("Set random seed"), 
                   value = 123), 
      sliderInput("bins",
                  "Number of k nearest neighbours:",
                  min = 1,
                  max = 50,
                  value = 7),
      sliderInput("learning",
                  "Size of training set:",
                  min = 10,
                  max = 500,
                  value = 100),
      sliderInput("testing",
                  "Size of testing set:",
                  min = 100,
                  max = 10000,
                  value = 5000),
      h3("k-Nearest Neighbour Classification", align = "left"),

      h4("Description", align = "left"),
        
      p("k-nearest neighbour classification for test set from training set. For each row of the test set, the k nearest (in Euclidean distance) training set vectors are found, and the classification is decided by majority vote, with ties broken at random. If there are ties for the kth nearest vector, all candidates are included in the vote.", align = "left")
    ),

    # Show a plot of the generated distribution
    mainPanel(
      p("Pleas wait for the calculation!", align = "center"),
      plotOutput("distPlot"),
      fluidRow(
      plotOutput("trainPlot"),
      plotOutput("testPlot")
      )
    )
  )
))

