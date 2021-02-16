
#    http://shiny.rstudio.com/
#

library(shiny)
library(ggplot2)
library(dplyr)
data("diamonds")

##diamonds <- as.data.frame(diamonds)
##carat <- diamonds$carat

# Define UI for application that draws a histogram
shinyUI(fluidPage(
    titlePanel("Predicting the price of Diamond from a model based on its carat"),
    sidebarLayout(
        sidebarPanel(
            sliderInput("sliderCarat", "What is the Carat of the diamond?", min = 0.0, max = 6.0, value = 2),
            selectInput("selectCut", "Select", choices = levels(diamonds$cut)),
            selectInput("selectColor", "Select", choices = levels(diamonds$color)),
            checkboxInput("showModel1", "Show/Hide Model 1", value = TRUE),
            checkboxInput("showModel2", "Show/Hide Model 2", value = TRUE),
            p("This app makes use of the diamond dataset in r and uses this to generate a model
                       for the price prediction of diamonds based on 3 characteristics: carat, cut, and color.
                       Model1 solely makes use of carat while Model2 combines all the 3 qualities.The different 
                       parameters can be changed using the input gadgets on the side panel, while the predicted
                       values are provided in the rendered text below the plot panel.", style = "font-family: 'times'; font-si16pt")
            
        ),

        mainPanel(
            plotOutput("plot1"),
            h3("Predicted Price from Model 1:"),
            textOutput("pred1"),
            h3("Predicted Price from Model 2:"),
            textOutput("pred2")
            
        )
    )
))



