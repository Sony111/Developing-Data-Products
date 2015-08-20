library(shiny)

# Define UI for Predicting MPG of a car,display summary,table and plot using  mtcars dataset with tabs
shinyUI(pageWithSidebar(
    # Application title
  headerPanel("Predict Miles Per Gallon of a car"),
  
  # Adding widgets
    sidebarPanel(
    h4("Help text"),
    helpText("Enter Weight , qsec and Transmisson ,click on ",strong("Predict!")," to get predicted value of MPG."),
    numericInput("Weight","Weight",value=3,min=1.513,max=5.424),
    br(),
    radioButtons("Trans","Transmission",list("Automatic" = 0,"Manual" = 1),"0"),
    sliderInput("Qsec", "QSec", value = 18, min = 14, max = 23,animate=T),
    actionButton("actionButton","Predict!",align = "center"),
    helpText("Note : for ",strong("Summary,Plot")," and" ,strong("Table")," whole",strong("mtcars"),"dataset is taken into account and results are displayed respectively")
    
  ),
  
  # Show a tabset that includes mpg prediction, plot, summary, and table view of mtcars dataset
    mainPanel(
    tabsetPanel(
      tabPanel("Prediction",
               h2("MLR Predction ",align="center") ,
               p("A multiple linear regression (MLR) model that describes a ",
                 strong("dependent variable y by independent variables x1, x2, ..., xp with error.")), 
               p("For example, in the built-in data set",strong(" mtcars")," from observations of a Motor Trend car road Tests comprises fuel 
                 consumption,automobile design and performance. First Transform the dataset (cyl,gear,am,vs as factor variables).",strong("lm")," is 
                 ", strong("used to fit linear model")," by taking all the dependnt variables into account.Choose a",strong("model by AIC in a stepwise Algorithm"),
                 "The obtained model has 3 (wt,qsec,am) dependent variables.") ,
               h3("Predction Interval for MLR"),
               
               p("We now apply the predict function and set the predictor variable in the newdata argument. We also set the interval type as",
                 strong("predict")," and use",strong(" the default 0.95 confidence level")),
               
               p("The predicted",span(" MPG value",style = "color:blue")," and its",span(" Lower Bound",style="color:blue"),"and",
                 span("Upper Bound",style="color:blue")," values are :"),
               
               code(textOutput("myp"))
               ),
               
      tabPanel("Summary", verbatimTextOutput("summary")), 
      tabPanel("Table", tableOutput("table")),
      tabPanel("Plot" ,plotOutput("myplot"))
    )
  )
))
