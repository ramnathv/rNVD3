require(rNVD3)
shinyUI(pageWithSidebar(
  headerPanel("rNVD3: Interactive Charts from R using NVD3.js"),
  
  sidebarPanel(
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
      value = FALSE)
  ),
  mainPanel(
    showOutput("myChart")
  )
))