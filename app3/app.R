#
# This is a Shiny web application. You can run the application by clicking
# the 'Run App' button above.
#
# Find out more about building applications with Shiny here:
#
#    http://shiny.rstudio.com/
#

library(ggplot2)
library(shiny)

# Define UI for application that draws a histogram
ui <- fluidPage(
  
  # Application title
  titlePanel("Drawing Balls Experiment"),
  
  # Sidebar with a slider input for number of bins 
  sidebarLayout(
    sidebarPanel(
      sliderInput("repetitions",
                  label = "Number of repetitions:",
                  min = 1,
                  max = 5000,
                  value = 100),
      
      sliderInput("threshold",
                  label = "Threshold for choosing boxes:",
                  min = 0,
                  max = 1,
                  value = 0.5),
      
      numericInput("seed",
                   "Choose a random seed",
                   value = 123)
    ),
    
    # Show a plot of the generated distribution
    mainPanel(
      plotOutput("freqs_plot")
    )
  )
)

# Define server logic required to draw a histogram
server <- function(input, output) {
  
  output$freqs_plot <- renderPlot({
    # generate bins based on input$bins from ui.R
    box1 <- c('blue', 'blue', 'red')
    box2 <- c('blue', 'blue', 'red', 'red', 'red', 'white')
    
    size <- 4
    drawn_balls <- matrix(0,nrow = input$repetitions, ncol = size)
    set.seed(input$seed)
    for (i in 1 : input$repetitions) {
      if (runif(1) > input$threshold) {
        # with repl size = 4 from box1
        drawn_balls[i,] <- sample(box1, size = 4, replace = TRUE)
      } else {
        # without repl size = 4 from box2
        drawn_balls[i,] <- sample(box2, size = 4, replace = FALSE)
      }
    }
    
    counter <- c(rep(0, 5))
    num <- c(rep(0, input$repetitions))
    for (i in 1 : input$repetitions) {
      numberOfBlue <- 0
      for (j in 1 : 4) {
        if (drawn_balls[i,j] == "blue") {
          numberOfBlue <- numberOfBlue + 1
        }
      }
      num[i] <- numberOfBlue
      if (numberOfBlue == 0) {
        counter[1] <- counter[1] + 1
      } else if (numberOfBlue == 1) {
        counter[2] <- counter[2] + 1
      } else if (numberOfBlue == 2) {
        counter[3] <- counter[3] + 1
      } else if (numberOfBlue == 3) {
        counter[4] <- counter[4] + 1
      } else {
        counter[5] <- counter[5] + 1
      }
    }
    # 0 blue proportion
    count0 <- counter[1] / input$repetitions
    # 1 blue proportion
    count1 <- counter[2] / input$repetitions
    # 2 blue proportion
    count2 <- counter[3] / input$repetitions
    # 3 blue proportion
    count3 <- counter[4] / input$repetitions
    # 4 blue proportion
    count4 <- counter[5] / input$repetitions
    
    
    a0 <- num == "0"
    relFreq0 <- cumsum(a0)/ 1 : input$repetitions
    a1 <- num == "1"
    relFreq1 <- cumsum(a1)/ 1 : input$repetitions
    a2 <- num == "2"
    relFreq2 <- cumsum(a2)/ 1 : input$repetitions
    a3 <- num == "3"
    relFreq3 <- cumsum(a3)/ 1 : input$repetitions
    a4 <- num == "4"
    relFreq4 <- cumsum(a4)/ 1 : input$repetitions
    relFreq <- c(relFreq0, relFreq1, relFreq2, relFreq3, relFreq4)
    reps <- c(rep(1:input$repetitions, 5))
    times <- rep(0:4, each = input$repetitions)
    freqReps <- data.frame(relFreq, reps, times)
    numbers <- factor(freqReps$times)
    ggplot(freqReps, aes(x = freqReps$reps, y = freqReps$relFreq)) + geom_line( aes(col= numbers)   )
  })
}

# Run the application 
shinyApp(ui = ui, server = server)

