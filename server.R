
# This is the server logic for a Shiny web application.
# You can find out more about building applications with Shiny here:
#
# http://shiny.rstudio.com
#


#library(popgenSim) # later in (more games)
library(shiny)
library(rhandsontable)
source("hawkdove.R")

M<-matrix(c(0.6,1.5,0.5,1.0),2,2,byrow=T, dimnames = list(c("hawk", "dove"),
                                                          c("hawk", "dove")))

shinyServer(function(input, output) {

    values = reactiveValues(
        payoff = M
    )
    
    calc = reactive({
        M = values[["payoff"]]
    })
    
    
  output$distPlot <- renderPlot({
    hawk.dove(p=c(input$freqs, 1-input$freqs), M=values[["payoff"]], time = input$time)
  })
  

  output$pay_off = renderRHandsontable({
      if (!is.null(input$pay_off)) {
          DF = hot_to_r(input$pay_off)
          values[["payoff"]] = DF
          rhandsontable(DF)
      } else if (!is.null(values[["payoff"]])) {
          DF = values[["payoff"]]
          rhandsontable(DF)
      }
  })
  
 

})
