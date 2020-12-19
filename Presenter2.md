Presentation of the shinyApp. Week 4. Assingment.
========================================================
author: Beatriz Jimenez Franco
date: 
autosize: true

Introduction
========================================================

In this app we study the relationship between two variables, carat and price of the dataset diamonds, that yoy can find loading ggplot2. With a subset of the datframe we can also observe the predicted values of price. Notice that ib the difeerent tabs you can find interactive plots and tables. 

Link to the shinyApp :

<https://spoke.shinyapps.io/Diamonds/>

Link to my presentation in shinyapps.io:

<<https://spoke.shinyapps.io/shiny-presentation/#1>


Link to my RPubs presentation:

<https://rpubs.com/spoke/706042>

Link to my Github repository:

<https://github.com/singulritarian7/Shiny_assingment>

Data
========================================================


```r
library(shiny)
library(ggplot2)
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

U.I Code
========================================================


```r
library(shiny);library(ggplot2);data("diamonds")

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
```

<!--html_preserve--><nav class="navbar navbar-default navbar-static-top" role="navigation">
<div class="container-fluid">
<div class="navbar-header">
<span class="navbar-brand">Shiny Application</span>
</div>
<ul class="nav navbar-nav" data-tabsetid="9219">
<li class="active">
<a href="#tab-9219-1" data-toggle="tab" data-value="Model">Model</a>
</li>
</ul>
</div>
</nav>
<div class="container-fluid">
<div class="tab-content" data-tabsetid="9219">
<div class="tab-pane active" data-value="Model" id="tab-9219-1">
<div class="container-fluid">
<h2>Diamonds - Influences on the Carat/Price Relationship</h2>
<div class="row">
<div class="col-sm-4">
<form class="well">
<h4>Filter Variables</h4>
<div class="form-group shiny-input-container">
<label class="control-label" for="cut">Cut</label>
<div>
<select id="cut"><option value="Ideal" selected>Ideal</option>
<option value="Premium">Premium</option>
<option value="Very Good">Very Good</option>
<option value="Good">Good</option>
<option value="Fair">Fair</option></select>
<script type="application/json" data-for="cut" data-nonempty="">{}</script>
</div>
</div>
<div class="form-group shiny-input-container">
<label class="control-label" for="color">Color</label>
<div>
<select id="color"><option value="D" selected>D</option>
<option value="E">E</option>
<option value="F">F</option>
<option value="G">G</option>
<option value="H">H</option>
<option value="I">I</option>
<option value="J">J</option></select>
<script type="application/json" data-for="color" data-nonempty="">{}</script>
</div>
</div>
<div class="form-group shiny-input-container">
<label class="control-label" for="clarity">Clarity</label>
<div>
<select id="clarity"><option value="IF" selected>IF</option>
<option value="VVS1">VVS1</option>
<option value="VVS2">VVS2</option>
<option value="VS1">VS1</option>
<option value="VS2">VS2</option>
<option value="SI1">SI1</option>
<option value="SI2">SI2</option>
<option value="I1">I1</option></select>
<script type="application/json" data-for="clarity" data-nonempty="">{}</script>
</div>
</div>
<button id="showall" type="button" class="btn btn-default action-button">Show All</button>
<button id="appfil" type="button" class="btn btn-default action-button">Filter Mode</button>
<h4>Price Summary</h4>
<pre id="summary" class="shiny-text-output noplaceholder"></pre>
<div class="form-group shiny-input-container">
<label class="control-label" for="lm">Carat</label>
<input class="js-range-slider" id="lm" data-min="0.2" data-max="5.01" data-from="2.505" data-step="0.1" data-grid="true" data-grid-num="9.62" data-grid-snap="false" data-prettify-separator="," data-prettify-enabled="true" data-keyboard="true" data-data-type="number"/>
</div>
<h4>Predicted Price</h4>
<pre id="predict" class="shiny-text-output noplaceholder"></pre>
</form>
</div>
<div class="col-sm-8">
<div class="tabbable">
<ul class="nav nav-tabs" data-tabsetid="8995">
<li class="active">
<a href="#tab-8995-1" data-toggle="tab" data-value="Plot">Plot</a>
</li>
<li>
<a href="#tab-8995-2" data-toggle="tab" data-value="Table">Table</a>
</li>
<li>
<a href="#tab-8995-3" data-toggle="tab" data-value="Documentation">Documentation</a>
</li>
<li>
<a href="#tab-8995-4" data-toggle="tab" data-value="Data Description">Data Description</a>
</li>
</ul>
<div class="tab-content" data-tabsetid="8995">
<div class="tab-pane active" data-value="Plot" id="tab-8995-1">
<div id="distPlot" class="shiny-plot-output" style="width: 100% ; height: 400px" data-click-id="plot_click" data-click-clip="TRUE"></div>
<pre id="info" class="shiny-text-output noplaceholder"></pre>
</div>
<div class="tab-pane" data-value="Table" id="tab-8995-2">
<div id="table" class="shiny-datatable-output"></div>
</div>
<div class="tab-pane" data-value="Documentation" id="tab-8995-3">
<br/>
<span class="help-block">This app enables you to display various subsets of the diamond data set (as included in the ggplot2 R-package) and check the influence on the
                             carat/price relationship in the data. A basic linear model relationship is displayed based on the selected subset of the data and price prediction
                            is possible via selecting the respective filter variables and a carat value.</span>
<br/>
<span class="help-block">Furthermore it is possible to remove the filter and display the whole dataset by pressing the button SHOW ALL.
                            To go back the the filtered view, press FILTER MODE and all your filters are reapplied. Per default, filter
                            mode is active.</span>
<br/>
<span class="help-block">You can also see the x, y coordenates by clicking the interactive plot.</span>
<br/>
<span class="help-block">Finally a data summary is displayed and a price can be predicted by selecting a subset of the data and choosing a carat value.
                            Simply choose cut, color, clarity and carat as you see fit and a value is predicted based on your selection.</span>
</div>
<div class="tab-pane" data-value="Data Description" id="tab-8995-4">
<br/>
<span class="help-block">See data description here:</span>
<br/>
<a href="http://ggplot2.tidyverse.org/reference/diamonds.html">http://ggplot2.tidyverse.org/reference/diamonds.html</a>
</div>
</div>
</div>
</div>
</div>
</div>
</div>
</div>
</div><!--/html_preserve-->

Server Code
========================================================


```r
library(shiny);library(ggplot2);library(tidyverse);
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
    
    output$predict <- renderPrint({
      
      fit <- lm(price~carat,data=diamonds)
      
      unname(predict(fit, data.frame(carat = input$lm)))
    })
    
    
  })
  
  observeEvent(input$appfil, {
    distPlot <<- NULL
    
    output$distPlot <- renderPlot({
    
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
```




