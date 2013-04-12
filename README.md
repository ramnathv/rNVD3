## rNVD3

This R package provides a familiar plotting interface for R users to create interactive visualizations using [NVD3.js](http://www.nvd3.org).

### Installation

You can install `rNVD3` from `github` using the `devtools` package

```{r eval = F}
require(devtools)
install_github('rNVD3', 'ramnathv')
```

### Usage

`rNVD3` uses a formula interface to specify plots, just like the `lattice` package. Here is an example that you can try in your R console

```{r eval = F}
hair_eye = subset(as.data.frame(HairEyeColor), Sex == "Female")
p1 <- nvd3Plot(Freq ~ Hair | Eye, data = hair_eye, type = 'multiBarChart')
p1$chart(color = c('brown', 'blue', '#594c26', 'green'))
p1
p1$save('haireye.html')
```

`rNVD3` is also compatible with [Slidify](http://slidify.org). Here is a [slide deck](http://ramnathv.github.io/slidifyExamples/examples/rNVD3) with examples. **Note that `rNVD3` plots work best in Google Chrome.**

More documentation is underway.

### Using with Shiny

```
## server.r
require(rNVD3)
shinyServer(function(input, output) {
  output$myChart <- renderChart({
    hair_eye = as.data.frame(HairEyeColor)
    p6 <- nvd3Plot(Freq ~ Hair | Eye, data = subset(hair_eye, Sex == input$gender), 
      type = input$type, id = 'myChart', width = 800)
    p6$chart(color = c('brown', 'blue', '#594c26', 'green'), stacked = input$stack)
    return(p6)
  })
})

## ui.R
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
```

### Credits

Most of the implementation in `rNVD3` is inspired by [rHighcharts](https://github.com/metagraf/rHighcharts) and [rVega](https://github.com/metagraf/rVega). I have reused some code from these packages verbatim, and would like to acknowledge the efforts of its author [Thomas Reinholdsson](https://github.com/reinholdsson).

### License

MIT

### See Also

There has been a lot of interest recently in creating packages that allow R users to make use of Javascript charting libraries. 

- [gg2v](https://github.com/hadley/gg2v) by [Hadley Wickham](https://github.com/hadley)
- [clickme](https://github.com/nachocab/clickme) by [Nacho Caballero](https://github.com/nachocab)
- [rHighcharts](https://github.com/metagraf/rHighcharts) by [Thomas Reinholdsson](https://github.com/reinholdsson)
- [rHighcharts](https://github.com/metagraf/rVega) by [Thomas Reinholdsson](https://github.com/reinholdsson)
- [rNVD3](https://github.com/ramnathv/rNVD3) by [Ramnath Vaidyanathan](https://github.com/ramnathv)

