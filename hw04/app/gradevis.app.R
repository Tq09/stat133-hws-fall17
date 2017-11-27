library(shiny)
library(readr)
cleanscores <- read_csv("../data/cleandata/cleanscores.csv")
source('../code/functions.R')

ui <- fluidPage(
  # Application title
  headerPanel("Grade Visualizer"),
  
  # Sidebar with table
  sidebarPanel(
    conditionalPanel(condition="input.tabselected==1",
                     h4('Grades Distribution'),tableOutput("view")),
    conditionalPanel(condition="input.tabselected==2",
                     selectInput("variable", "X-axis varable", 
                                 choices = names(cleanscores)),
                     sliderInput("Bin", "Bin Width", 
                                 min = 1, max = 10, value = 10)),
    conditionalPanel(condition="input.tabselected==3",
                     selectInput("variableX", "X-axis varable", 
                                 choices = names(cleanscores),
                                 selected='Test1'),
                     selectInput("variableY", "Y-axis varable", 
                                 choices = names(cleanscores),
                                 selected='Overall'),
                     sliderInput("Opacity", "Opacity", 
                                 min = 0, max = 1, value = 0.5),
                     radioButtons("line_opt", "Show line:",
                                  list("none" = "none",
                                       "lm" = "lm",
                                       "loess" = "loess"))
    )
  ),
  # Show a disPlot
  mainPanel(
    tabsetPanel(
      tabPanel("Barchart", value=1,plotOutput("distPlot")), 
      tabPanel("Histogram", value=2, plotOutput("histogram"), 
               h4('Summary Statistics'),verbatimTextOutput("summary")),
      tabPanel("Scatterplot", value=3, plotOutput("Scatter"),
               h4('Correlation'), verbatimTextOutput("printCor")),
      id = "tabselected"
    )
  )
)

server <- function(input, output) {
  cleanscores <- read.csv('../data/cleandata/cleanscores.csv', stringsAsFactors = FALSE)
  freq=table(cleanscores$Grade)
  freq=freq[ c(3,1,2,6,4,5,9,7,8,10,11)]
  
  
  output$distPlot <- renderPlot({
    barplot(freq, col=4, xlab="Grade",ylab= "frequency")
  })
  output$histogram <- renderPlot({
    hist(cleanscores[[input$variable]], col="grey",
         breaks=100/input$Bin,main='',xlab=input$variable, ylab = 'count')
  })
  
  output$summary <- renderPrint({
    temp_stats=summary_stats(cleanscores[[input$variable]])
    print_stats(temp_stats)
  })
  output$view <- renderTable({
    Grade=names(freq)
    Prop=round(freq/sum(freq),2)
    new_table=cbind(Grade,freq, Prop)
  })
  get_col <-function(opacity){
    return(rgb(opacity,opacity,opacity))
  }
  output$Scatter <- renderPlot({
    X=input$variableX
    Y=input$variableY
    plot(cleanscores[[X]], cleanscores[[Y]], xlab=X, ylab=Y,
         pch=16, col=get_col(input$Opacity))
    if(input$line_opt == 'lm'){
      abline(lm(formula = as.formula(paste(X, " ~ ", Y)), 
                data = cleanscores))}
    if(input$line_opt == 'loess'){
      loess_pred=predict(loess(formula = as.formula(paste(X, " ~ ", Y)), 
                               data = cleanscores))
      lines(loess_pred)}
  })
  output$printCor <- renderPrint({
    X=input$variableX
    Y=input$variableY
    cor(cleanscores[[X]], cleanscores[[Y]])
  })
}

shinyApp(ui = ui, server = server)