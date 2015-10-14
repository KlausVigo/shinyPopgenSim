
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
  

  output$downloadPlot <- downloadHandler(
      filename = function() { paste(input$filename, '.', input$ExportFormat, sep='') },
      content = function(file) {
          
          width = 6
          height = 6
          dpi=300
          ext = input$ExportFormat
          
          switch(ext,
                 eps = postscript(file, height=height, width=width),
                 ps = postscript(file, height=height, width=width),       
                 tex = pictex(file, height=height, width=width),                                                      
                 pdf = pdf(file, height=height, width=width),
                 svg = svg(file, height=height, width=width),
                 wmf = win.metafile(file, width=width, height=height),
                 emf = win.metafile(file, width=width, height=height),
                 png = png(file, width=width, height=height, res = dpi, units = "in"),
                 jpeg = jpeg(file, width=width, height=height, res=dpi, units="in"),
                 jpg = jpeg(file, width=width, height=height, res=dpi, units="in"),   
                 bmp = bmp(file, width=width, height=height, res=dpi, units="in"),
                 tiff = tiff(file, width=width, height=height, res=dpi, units="in")                                      
          )
          hawk.dove(p=c(input$freqs, 1-input$freqs), M=values[["payoff"]], time = input$time)
          dev.off()
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
