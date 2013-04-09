showOutput <- function(outputId) {
  # Add javascript resources
  suppressMessages(singleton(addResourcePath("nvd3", system.file('nvd3', package='rNVD3'))))
    
  div(class="NVD3", 
    # Add Javascripts
    tagList(
     singleton(tags$head(tags$script(src = "nvd3/js/d3.v2.min.js", type='text/javascript'))),
     singleton(tags$head(tags$script(src = "nvd3/js/nv.d3.js", type='text/javascript'))),
     singleton(tags$head(tags$script(src = "nvd3/js/fisheye.js", type='text/javascript'))),
     singleton(tags$head(tags$link(href = "nvd3/css/nv.d3.css", rel="stylesheet"))),
     singleton(tags$head(tags$link(href = "nvd3/css/rNVD3.css", rel="stylesheet")))
    ),
    # Add chart html
    htmlOutput(outputId)
  )
}
