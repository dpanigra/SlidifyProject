#load shiny library
library(shiny)
data(mtcars)

#find the best regression model for mtcards data
modelFit <- lm(mpg ~ hp + cyl + wt, data=mtcars)

predictedMPG <- function(horsepower, numcylinders, weigth) {
  modelFit$coefficients[1] + modelFit$coefficients[2] * horsepower + 
    modelFit$coefficients[3] * numcylinders + modelFit$coefficients[4] * weigth
}
shinyServer(
  function(input, output) {
    predicted_mpg <- reactive({predictedMPG(input$horsepower, as.numeric(input$numcylinders), input$weigth/1000)})
    output$inputValues <- renderPrint({paste(input$numcylinders, "Number of Cylinders, ",
                                             input$horsepower, "Horsepower, ",
                                             input$weigth, "weight (in lbs.)")})
    output$prediction <- renderPrint({paste(round(predicted_mpg(), 2), "Miles per Gallon (mpg)")})
    output$plots <- renderPlot({
      par(mfrow = c(1, 3))
      with(mtcars, plot(hp, mpg,
                        xlab='Gross horsepower',
                        ylab='Miles per Gallon (mpg)',
                        main='mpg vs horsepower'))
      points(input$horsepower, predicted_mpg(), col='blue', cex=4, type="o", pch=15)                 
      with(mtcars, plot(cyl, mpg,
                        xlab='Number of cylinders',
                        ylab='Miles per Gallon (mpg)',
                        main='mpg vs num cylinders'))
      points(as.numeric(input$numcylinders), predicted_mpg(), col='red', cex=4, type="o", pch=16)  
      with(mtcars, plot(wt, mpg,
                        xlab='Weight (lb/1000)',
                        ylab='Miles per Gallon (mpg)',
                        main='mpg vs weight'))
      points(input$weigth/1000, predicted_mpg(), col='gray', cex=4, type="o", pch=17)  
    })
  }
)