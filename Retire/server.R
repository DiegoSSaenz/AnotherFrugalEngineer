#server.R for Retirement Calculator
library(shiny)
source("helpers.R")

# Define server logic required to draw a histogram
shinyServer(
  function(input, output) {
        
  output$plot <- renderPlot({    
    age <- as.numeric(input$age)
    s <- as.numeric(input$savings_rate) / 100 #savings rate
    end <- as.numeric(input$end) #Life expectancy
    years <- c(age:end)
    income <- seq(age:end)
    income[1] <- as.numeric(input$income) #post tax income
    expenses <- seq(age:end)
    expenses[1] <- income[1] * (1 -s) #expenses
    assets <- seq(age:end)
    assets[1] <- as.numeric(input$investments) #current investments
    r <- as.numeric(input$r) / 100 #returns
    i <- as.numeric(input$i) /100  #inflation
    tyw <- as.numeric(input$years_worked) #total years worked
    n <- 2
    l <- length(income)
    for(k in 2:l){
      income[k] <- income[k-1] * (1 + i)
      expenses[k] <- income[k-1] * (1 - s)
    }
    while(expenses[n-1] / (r - i) > assets[n-1] && n < end - age + 2){
      assets[n] <- assets[n-1] * (1 + r) + income[n-1] * s
      tyw <- tyw + 1
      n <- n + 1  
    }
    #Calculate Social Security
    ss <- ss_calc(income, tyw, i, n)
    retire <- age + n - 2
    output$text1 <- renderText({
      paste("Based on a savings rate of", input$savings_rate, ",",
            "you will be able to retire at", retire, ".")
    })
    while(n < end - age + 2){
      ss <- ss * (1 + i)
      if(input$ss_choice == "Social Security at 62" 
         && age + n - 2 > 61) {
        assets[n] <- assets[n-1] * (1 + r) - expenses[n-1] + ss*.75
      } else if(input$ss_choice == "Social Security at 66" 
                && age + n - 2 > 65){
        assets[n] <- assets[n-1] * (1 + r) - expenses[n-1] + ss
      } else {
        assets[n] <- assets[n-1] * (1 + r) - expenses[n-1]
      }
      n <- n + 1
    }
    
    if(input$log ==TRUE){
      plot(years, assets, log = "y", type = "l", col = "blue",
           xlab = "Age", ylab = "Assets", main="Assets over Time")
    } else {
      plot(years, assets, log = "", type = "l", col = "blue",
           xlab = "Age", ylab = "Assets", main="Assets over Time")
    }
    abline(v=retire,col=3,lty=3)
  })

})