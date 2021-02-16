
library(shiny)
library(ggplot2)
library(dplyr)

shinyServer(function(input, output) {
    
    ## Model Generation: server.R Part 1
    
    model1 <- lm(price ~ carat, data = diamonds)
    model2 <- lm(price ~ carat + cut + color, data = diamonds)
    
    model1pred <- reactive({
        caratInput <- input$sliderCarat
        predict(model1, newdata = data.frame(carat = caratInput))
    })
    
    model2pred <- reactive({
        caratInput <- input$sliderCarat
        cutInput <- input$selectCut
        colorInput <- input$selectColor
        predict(model2, newdata = data.frame(carat = caratInput, cut = cutInput, color = colorInput))
    })
    

    
    output$plot1 <- renderPlot({

        caratInput <- input$sliderCarat
        cutInput <- input$selectCut
        colorInput <- input$selectColor
        
        plot(diamonds$carat, diamonds$price, xlab = "Weight of the Diamond in Carat",
             ylab = "Price in USD", bty = "n", pch = 16, xlim = c(0.0, 6.0), ylim = c(300, 19000))
        if(input$showModel1){
            abline(model1, col = "red", lwd = 2)
        }
        if(input$showModel2){
            model2lines <-  predict(model2, newdata = data.frame(carat = 0:6, 
                                           cut = cutInput, color = colorInput))
            lines(0:6, model2lines, col = "blue", lwd = 2)
                                                                 
        }
       
        ## Price Prediction: server.R Part 3
        
        legend(4.5, 10000, c("Model 1 Prediction", "Model 2 Prediction"), pch = 16,
               col = c("red", "blue"), bty = "n", cex = 1.2)
        points(caratInput, model1pred(), col = "red", pch = 16, cex = 2)
        points(caratInput, model2pred(), col = "blue", pch = 16, cex = 2)
    })

    output$pred1 <- renderText({
        model1pred()
    })
    
    output$pred2 <- renderText({
        model2pred()
    })
})


