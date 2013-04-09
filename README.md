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

`rNVD3` is also compatible with [Slidify](http://slidify.org). Here is a [slide deck](http://ramnathv.github.io/slidifyExamples/examples/rNVD3) with examples.

More documentation is underway.

### Credits

Most of the implementation in `rNVD3` is inspired by [rHighcharts](https://github.com/metagraf/rHighcharts) and [rVega](https://github.com/metagraf/rVega). I have reused some code from these packages verbatim, and would like to acknowledge the efforts of its author [Thomas Reinholdsson](https://github.com/reinholdsson).

### License

MIT