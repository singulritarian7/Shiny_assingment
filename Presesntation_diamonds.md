Presesntation_diamonds
========================================================
author: Beatriz Jiménez Franco
date: 
autosize: true


========================================================

# The presentation include:
# - Overview
# - Code  examples
# - Links <https://spoke.shinyapps.io/Diamonds/>

========================================================
# Data

```r
library(datasets)
library(ggplot2)
data(diamonds)
head(diamonds)
```

```
# A tibble: 6 x 10
  carat cut       color clarity depth table price     x     y     z
  <dbl> <ord>     <ord> <ord>   <dbl> <dbl> <int> <dbl> <dbl> <dbl>
1 0.23  Ideal     E     SI2      61.5    55   326  3.95  3.98  2.43
2 0.21  Premium   E     SI1      59.8    61   326  3.89  3.84  2.31
3 0.23  Good      E     VS1      56.9    65   327  4.05  4.07  2.31
4 0.290 Premium   I     VS2      62.4    58   334  4.2   4.23  2.63
5 0.31  Good      J     SI2      63.3    58   335  4.34  4.35  2.75
6 0.24  Very Good J     VVS2     62.8    57   336  3.94  3.96  2.48
```

========================================================
# Code u.i

library(shiny)
library(ggplot2)
data("diamonds")
shinyUI(
    navbarPage("Shiny Application",
        tabPanel("Model",
            fluidPage(
                titlePanel("Diamonds - Influences on the Carat/Price Relationship"),
                sidebarLayout(
                    sidebarPanel(
                    h4("Filter Variables"),
            
                        selectInput("cut",   
                            "Cut",
                            (sort(
                            unique(diamonds$cut), decreasing = T
                        ))),
            
                        selectInput("color",
                            "Color",
                             (sort(
                             unique(diamonds$color)
                        ))),
            
                        selectInput("clarity",
                             "Clarity",
                             (sort(
                             unique(diamonds$clarity), decreasing = T
                        ))),
            
                             actionButton("showall",
                             "Show All"),
            
                             actionButton("appfil",
                             "Filter Mode"),
            
                             h4("Price Summary"),
            
                             verbatimTextOutput("summary"),
            
                             sliderInput(
                             "lm",
                             "Carat",
                              min = min(diamonds$carat),
                              max = max(diamonds$carat),
                              value = max(diamonds$carat) / 2,
                              step = 0.1
                       ),
            
                       h4("Predicted Price"),
            
                       verbatimTextOutput("predict"),
            
                       width = 4
        ),
        
        # Show a plot of the carat/price relationship
        
                   mainPanel(tabsetPanel(
                       tabPanel("Plot", 
                          plotOutput("distPlot",click = "plot_click" ),
                          verbatimTextOutput("info")
                       ),       
                       tabPanel("Table", dataTableOutput("table")),
                       tabPanel(
                           "Documentation",
                            br(),
                
                            helpText(
                            "This app enables you to display various subsets of the diamond data set (as included in the ggplot2 R-package) and check the influence on the
                             carat/price relationship in the data. A basic linear model relationship is displayed based on the selected subset of the data and price prediction
                            is possible via selecting the respective filter variables and a carat value."
                   ),
                
                           br(),
                
                           helpText(
                           "Furthermore it is possible to remove the filter and display the whole dataset by pressing the button SHOW ALL.
                            To go back the the filtered view, press FILTER MODE and all your filters are reapplied. Per default, filter
                            mode is active."
                ),
                
                           br(),
                
                           helpText("You can also see the x, y coordenates by clicking the interactive plot."
                ),
                
                           br(),
                
                           helpText(
                           "Finally a data summary is displayed and a price can be predicted by selecting a subset of the data and choosing a carat value.
                            Simply choose cut, color, clarity and carat as you see fit and a value is predicted based on your selection."
                )),
            
                      tabPanel(
                           "Data Description",
                
                           br(),
                
                           helpText("See data description here:"),
                
                           br(),
                
                           tags$a(
                           "http://ggplot2.tidyverse.org/reference/diamonds.html",
                            href = "http://ggplot2.tidyverse.org/reference/diamonds.html"
                )
            )
            
        ))
    )
)
)))

  

========================================================
# Based on the selected subset and the carat value a predicted price value is printed in the UI.

r, echo = F
library(ggplot2)
data(diamonds)
fit <- lm(price~carat,data=diamonds)
unname(predict(fit, data.frame(carat = 3)))



========================================================
# Code Server
library(shiny)
library(ggplot2)
library(tidyverse)
library(curl)

shinyServer(function(input, output) {
  
  data(diamonds)
  output$table <- renderDataTable({
    head(diamonds)
  })
  
  output$distPlot <- renderPlot({
    
    diamonds_sub <-
      subset(
        diamonds,
        cut == input$cut &
          color == input$color &
          clarity == input$clarity
      )
    output$info <- renderPrint({
      req(input$plot_click)
      x <- round(input$plot_click$x, 2)
      y <- round(input$plot_click$y, 2)
      cat("[", x, ", ", y, "]", sep = "")
    })
    
    p <-
      ggplot(data = diamonds_sub, aes(x = carat, y = price)) + geom_point()
    p <-
      p + geom_smooth(method = "lm") + xlab("Carat") + ylab("Price")
    p <- p + xlim(0, 6) + ylim (0, 20000)
    p
  }, height = 700)
  
  output$summary <- renderPrint({
    diamonds_sub <-
      subset(
        diamonds,
        cut == input$cut &
          color == input$color &
          clarity == input$clarity
      )
    
    summary(diamonds_sub$price)
  })
  
  output$predict <- renderPrint({
    diamonds_sub <-
      subset(
        diamonds,
        cut == input$cut &
          color == input$color &
          clarity == input$clarity
      )
    
    fit <- lm(price~carat,data=diamonds_sub)
    
    unname(predict(fit, data.frame(carat = input$lm)))
  })

  observeEvent(input$showall, {
    distPlot <<- NULL
    
    output$distPlot <- renderPlot({
      p <-
        ggplot(data = diamonds, aes(x = carat, y = price)) + geom_point()
      p <-
        p + geom_smooth(method = "lm") + xlab("Carat") + ylab("Price")
      p <- p + xlim(0, 6) + ylim (0, 20000)
      p
    }, height = 700)
    
    output$summary <- renderPrint(summary(diamonds$price))
    
    # create linear model
    
    output$predict <- renderPrint({
      
      fit <- lm(price~carat,data=diamonds)
      
      unname(predict(fit, data.frame(carat = input$lm)))
    })
    
    
  })
  
  observeEvent(input$appfil, {
    distPlot <<- NULL
    
    output$distPlot <- renderPlot({
      # subset the date based on the inputs
      
      diamonds_sub <-
        subset(
          diamonds,
          cut == input$cut &
            color == input$color &
            clarity == input$clarity
        )
      
      p <-
        ggplot(data = diamonds_sub, aes(x = carat, y = price)) + geom_point()
      p <-
        p + geom_smooth(method = "lm") + xlab("Carat") + ylab("Price")
      p <- p + xlim(0, 6) + ylim (0, 20000)
      p
    }, height = 700)
    

    output$summary <- renderPrint({
      diamonds_sub <-
        subset(
          diamonds,
          cut == input$cut &
            color == input$color &
            clarity == input$clarity
        )
      
      summary(diamonds_sub$price)
    })
    
    output$predict <- renderPrint({
      diamonds_sub <-
        subset(
          diamonds,
          cut == input$cut &
            color == input$color &
            clarity == input$clarity
        )
      
      fit <- lm(price~carat,data=diamonds_sub)
      
      unname(predict(fit, data.frame(carat = input$lm)))
    })
    
  })
  
})

========================================================




