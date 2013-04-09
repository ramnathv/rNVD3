require(rNVD3)
shinyUI(bootstrapPage(
  selectInput(inputId = "gender",
    label = "Choose Gender",
    choices = c("Male", "Female"),
    selected = "Male"),
  selectInput(inputId = "type",
    label = "Choose Chart Type",
    choices = c("multiBarChart", "multiBarHorizontalChart"),
    selected = "multiBarChart"),
  checkboxInput(inputId = "stack",
    label = strong("Stack Bars?"),
    value = FALSE),
  showOutput("myChart")
))