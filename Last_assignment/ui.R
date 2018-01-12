#Ui.R file for a Shiny app in Developing Data Products course

library(shiny)

shinyUI(
  fluidPage(
    navbarPage("Coursera course Developing Data Products"),
  titlePanel("Horsepower predition from gas consumption"),
  sidebarLayout(
    sidebarPanel(
      
      h3('Tweek the Plot'),
      
      sliderInput('sampleSize', 'Choose Sample Size', min=10, max=35,
                  value=10, round=0),
      
      checkboxInput("Model1", "Show/Hide Model 1", value = TRUE),
      checkboxInput("Model2", "Show/Hide Model 2", value = TRUE)
      
      ),
    mainPanel(
      h2('Basic Introductory Exploratory Analysis'),
      p("It uses solely the training dataset build in R called mtcars"),
      p('On the side panel you can change the model that are injected to the plot.'),
      p('Moving the slider shows the position on the current model on the plot'),
      
      plotOutput('plot1'),
      h3("Model 1 (Horsepower prediction):"),
      textOutput("pred1"),
      h3("Model 2 (Horsepower prediction):"),
      textOutput("pred2")
    )
      )
      ))
