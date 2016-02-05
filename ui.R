#load library
library(shiny)
shinyUI(pageWithSidebar(
  headerPanel('Vehicle Mileage data'),
  sidebarPanel(
    p('Linear Model is used. MPG is predicted based on horse power, num of cylinders, and weight of the vehicle.'),
    p('This progrm uses mtcars dataset.'),
    h4('Please enter desired values below :- '),
    p('After inspection of num. of cylinders in mtcards data, the input for num. of cylinders are restricted to 4, 6, and 8.'),
    selectInput("numcylinders", label = h5("Select the 'Number of cylinders':"), 
                choices = list("4" = 4, "6" = 6,
                               "8" = 8), selected = 6),    
    numericInput('horsepower', label = h5("Enter the 'Gross horsepower' below:"), 200),
    numericInput('weigth', label = h5("Enter the 'Weight (in lbs)' below:"), 5000)
  ),
  mainPanel(
    tags$style(type='text/css', '#inputValues {background-color: rgba(255,255,0,0.40); color: green;}'), 
    tags$style(type='text/css', '#prediction {background-color: rgba(0,0,255,0.10); color: blue;}'), 
    h5('Predicted value:'),
    verbatimTextOutput("prediction"),
    h5('for you inputs:'),
    verbatimTextOutput("inputValues"),
    h5('Predicted MPGs:'),
    plotOutput('plots')
  )
))
