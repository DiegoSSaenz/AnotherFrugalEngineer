# ui.R for Retirement Calculator

library(shiny)

# Define UI for application that takes inputs and draws plot
shinyUI(fluidPage(

  inputPanel(
    fixedRow(
      column(width = 3.6,  offset = 0,
             numericInput("savings_rate", label = h5("Savings Rate:"),
                          value = 25)),      
      column(width = 3.6, offset = 0,        
             sliderInput("age", label = h5("Age:"),
                         min = 0, max = 100, value = 25, step = 1)),
      column(width = 3.6, offset = 0,
             numericInput("investments", label = h5("Current Investments:"), 
                          value = 0)),
      column(width = 3.6, offset = 0,
             numericInput("income", label = h5("Post-Tax Income:"), 
                          value = 50000))
      ),
    fixedRow(
      column(width = 3.6, offset = 0,
             numericInput("end", label = h5("Life Expectancy:"),
                          value = 85)),
      column(width = 3.6, offset = 0,
             numericInput("r", label = h5("Rate of Returns (Nominal):"),
                          value = 7)),
      column(width = 3.6, offset = 0,
             numericInput("i", label = h5("Inflation Rate:"),
                          value = 3)),      
      column(width = 3.6, offset = 0,
             numericInput("years_worked", label = h5("Years Worked:"),
                          value = 0))
    ),
    fixedRow(
      column(width = 3.6, offset = 0,
             selectInput("ss_choice", 
                         label = "Social Security Assumption:",
                         choices = list("No Social Security", "Social Security at 62",
                                        "Social Security at 66"),
                         selected = "Social Security at 66")),
      column(width = 3.6, offset = 0, br(),             
             checkboxInput("log", "Plot assets on log scale", 
                           value = FALSE))
    )
    
  ),
  mainPanel(plotOutput("plot"),
  textOutput("text1")
  )
))
#column(width = 2,offset=.5, br(),
#       helpText("This is the percentage of your take home pay", 
#                "(post-tax pay) that you contribute to investments"
#       )),
#column(width = 2,offset=.5, br(),
#       helpText("Your current age", 
#                "",
#                ""))
#column(width = 2,offset=.5, br(),
#       helpText("Current balance of investments", 
#                "",
#                "")),
#column(width = 2,offset=.5, br(),
#       helpText("Annual take home pay (Post-tax pay)", 
#                "",
#                ""))
#column(width = 2, offset = 0.5, br(),
#       helpText(a("Life Expectancy Calculator", href="http://gosset.wharton.upenn.edu/mortality/perl/CalcForm.html"))
#),
#column(width = 2, offset = 0.5, br(),
#       helpText("Nominal Rate of Returns (not accounting",
#                "for inflation)"))
#column(width = 2, offset = 0.5, br(),
#       helpText(a("I'll defer to FRED on this one", href="http://research.stlouisfed.org/fred2/tags/series?t=inflation"))
#),
#column(width = 2, offset = 0.5, br(),
#       helpText("Used to", a("calculate Social Security Benefits", href="http://www.ssa.gov/pubs/EN-05-10070.pdf"))
#)