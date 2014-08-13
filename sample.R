age <- 30
s <- (60000-18000)/60000 #savings rate
end <- 65 #Life expectancy
years <- c(age:end)
income <- seq(age:end)
income[1] <- 60000 #post tax income
expenses <- seq(age:end)
expenses[1] <- income[1] * (1 -s) #expenses
assets <- seq(age:end)
assets[1] <- 0 #current investments
tradIRA <- seq(age:end)
tradIRA[1] <- 0 #initial traditional IRA
rothIRA <- seq(age:end)
rothIRA[1] <- 0 #initial Roth IRA
r <- 7 / 100 #returns
i <- 0 /100  #inflation
#tyw <- as.numeric(input$years_worked) #total years worked
n <- 2
l <- length(income)
for(k in 2:l){
  income[k] <- income[k-1] * (1 + i)
  expenses[k] <- income[k-1] * (1 - s)
}
while( n < 12){
  assets[n] <- assets[n-1] * (1 + r) + income[n-1] * s
  n <- n + 1  
}
#Calculate Social Security
#ss <- ss_calc(income, tyw, i, n)
retire <- age + n - 2
#output$text1 <- renderText({
#  paste("Based on a savings rate of", input$savings_rate, ",",
#        "you will be able to retire at", retire, ".")
#})
while(n < end - age + 2){  
    assets[n] <- assets[n-1] * (1 + r) - expenses[n-1]
    n <- n + 1
} 

plot(years, assets, log = "", type = "l", col = "blue",
     xlab = "Age", ylab = "Assets", main="Assets over Time")
abline(v=retire,col=3,lty=3)