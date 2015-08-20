library(shiny)
library(corrgram)

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
  
  
  # Generate a plot 
  output$myplot <- renderPlot({
    
     corrgram(mtcars, order=NULL, lower.panel=panel.shade,
     upper.panel=panel.pie, text.panel=panel.txt,
     main="Car Milage Data (unsorted)")
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

