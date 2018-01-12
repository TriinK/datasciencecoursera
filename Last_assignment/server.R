# This is server.UI file for a Shiny application in the course "Developing Data Products"

library(shiny)

shinyServer(
  
  function(input, output) {
    data(mtcars)
    #Spline
    mtcars$mpgsp <- ifelse(mtcars$mpg - 20 > 0, mtcars$mpg - 20, 0)
    
    #Linear models
    model1 <- lm(hp ~ mpg, data = mtcars)
    model2 <- lm(hp ~ mpgsp + mpg, data = mtcars)
                 
                 model1pred <- reactive({
                   mpgInput <- input$sampleSize
                   predict(model1, newdata = data.frame(mpg = mpgInput))
                 })
                 
                 model2pred <- reactive({
                   mpgInput <- input$sampleSize
                   predict(model2, newdata = 
                             data.frame(mpg = mpgInput,
                                        mpgsp = ifelse(mpgInput - 20 > 0,
                                                       mpgInput - 20, 0)))
                 })
                 
                 output$plot1 <- renderPlot({
                   mpgInput <- input$sampleSize
                   
                   plot(mtcars$mpg, mtcars$hp, xlab = "Miles Per Gallon", 
                        ylab = "Horsepower", bty = "n", pch = 16,
                        xlim = c(10, 35), ylim = c(50, 350))
                   if(input$Model1){
                     abline(model1, col = "red", lwd = 2)
                   }
                   if(input$Model2){
                     model2lines <- predict(model2, newdata = data.frame(
                       mpg = 10:35, mpgsp = ifelse(10:35 - 20 > 0, 10:35 - 20, 0)
                     ))
                     lines(10:35, model2lines, col = "blue", lwd = 2)
                   }
                   legend(25, 250, c("Model 1 horsepower Prediction", "Model 2 horsepower Prediction"), pch = 16, 
                          col = c("yellow", "blue"), bty = "n", cex = 1.2)
                   points(mpgInput, model1pred(), col = "yellow", pch = 14, cex = 2)
                   points(mpgInput, model2pred(), col = "blue", pch = 14, cex = 2)
                 })
                 
                 output$pred1 <- renderText({
                   model1pred()
                 })
                 
                 output$pred2 <- renderText({
                   model2pred()
                 }) }
)