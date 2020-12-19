library(shiny)
library(ggplot2)
data("diamonds")

# Define UI for application that draws a histogram
shinyUI(
    navbarPage("Shiny Application",
        tabPanel("Model",
            fluidPage(
    # Application title
                titlePanel("Diamonds - Influences on the Carat/Price Relationship"),
    
    # Sidebar with a slider input for number of bins
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

