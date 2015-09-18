
# This is the user-interface definition of a Shiny web application.
# You can find out more about building applications with Shiny here:
#
# http://shiny.rstudio.com
#

library(shiny)
library(rhandsontable)

shinyUI(fluidPage(

  # Application title
  titlePanel("Hawk dove game"),

  # Sidebar with a slider input for number of bins
  sidebarLayout(
    sidebarPanel(
      numericInput("freqs",
                     "Proportion of hawks:",
                     min = 0,
                     max = 1,
                     value = 0.01, step=.001),    
      p(strong("Payoff matrix")),
      rHandsontableOutput("pay_off"),
      numericInput("time",
                   "Time:",
                   min = 2,
                   max = 10000,
                   value = 100, step=1)
      
    ),
    
    # Show a plot 
    mainPanel(
      plotOutput("distPlot")
    )
  )
))
