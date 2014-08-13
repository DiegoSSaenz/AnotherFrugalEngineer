# ss calculates Social Security income
ss_calc <- function(income, tyw, i, n){
  if(tyw > 35)tyw <- 35
  if(income[1] > 113700){
    ss_income <- floor(113700 * tyw / 420)
  } else { 
    ss_income <- floor(income[1] * tyw /420)
  }
  if(ss_income > 4917){
    ss <- (ss_income - 4917) * 0.15 + 2046.72
  } else if(ss_income > 816) {
    ss <- (ss_income - 816) * 0.32 + 734.40
  } else {
    ss <- ss_income * 0.90
  }
  ss <- ss * (1 + i)^(n - 2)
  return(ss)
}