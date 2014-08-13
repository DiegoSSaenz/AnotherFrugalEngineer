#server.R for Roth vs. Traditional

library(shiny)
source("helpers.R")

# Define server logic required to draw a histogram
shinyServer(
  function(input, output) {
    
    getFed <- reactive({
      fed_tax(as.numeric(input$income))
    })
    getState <- reactive({
      state_tax(as.numeric(input$income), input$state)
    })
    getFICA <- reactive({
      fica(input$income)
    })    
    getTotal <- reactive({
      total_tax(as.numeric(input$income), input$state)
    })
    output$text1 <- renderText({
      paste("Based on an income of", input$income, "and a",
            "standard deduction, your state taxes are", getState(),
            ",", "your federal taxes are", getFed(),
            ", and your FICA deductions are", getFICA(),".",
            "Your total taxes are", getTotal(), 
            "and your post-tax pay is", input$income - getTotal(), ".")
    })
    
    #output$plot <- renderPlot({    
      
      
      
    #  if(input$log ==TRUE){
    #    plot(years, assets, log = "y", type = "l", col = "blue",
    #        xlab = "Age", ylab = "Assets", main="Assets over Time")
    #  } else {
    #    plot(years, assets, log = "", type = "l", col = "blue",
    #         xlab = "Age", ylab = "Assets", main="Assets over Time")
    #  }
    #  abline(v=retire,col=3,lty=3)
    #})
    
  })