library(shiny)

# transforming into factor variables
mtcars$cyl <- as.factor(mtcars$cyl)
mtcars$vs <- as.factor(mtcars$vs)
mtcars$am <- as.factor(mtcars$am)
mtcars$gear <- as.factor(mtcars$gear)

# mtcars structure after tranformation 
str(mtcars)

# fitting linear model
model <- lm(mpg ~. ,  data=mtcars)

# Choose a model by AIC in a Stepwise Algorithm
best_model <- step(model,direction="both")

# generate model summary
summary(best_model)

# Define server logic for this application
shinyServer(function(input, output) {
  
  # Reactive expression to predict the mpg. This is 
  # called whenever the inputs change. The renderers defined 
  # below then all use the value computed from this expression
  output$myTrans <- renderText({ input$Trans })
  
  output$myp <- renderText({ 
    input$actionButton
    isolate({
      # wt ,qsec,am
      newdata = data.frame(wt=we(),qsec=input$Qsec, am=input$Trans)
      myp  <- predict(best_model,newdata , interval = "predict")
      #output$myP <- p[1]
    })
  })
  
  
  # Generate diagnostic plot s
  output$myplot <- renderPlot({
    
     # optional 4 graphs/page
     layout(matrix(c(1,2,3,4),2,2,byrow=T))
     plot(best_model)
     
    })
  we <- reactive({
    w <- as.numeric(input$Weight)
  })
  
  # Generate a summary of the data
  output$summary <- renderPrint({
    summary(mtcars)
  })
  
  # Generate an HTML table view of the data
  output$table <- renderTable({
    data.frame(mtcars)
  })
})

