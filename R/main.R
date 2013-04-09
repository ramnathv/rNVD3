nvd3Plot <- function(x, data, width = 800, height = 400, ...){
  myChart <- NVD3$new()
  myChart$getChartParams(x, data, ...)
  myChart$addParams(width = width, height = height)
  myChart$fixChartParams()
  return(myChart$copy())
}

chainConfig <- function(..., prefix){
  dotlist = list(...)
  obj = names(dotlist)
  params = dotlist[[1]]
  config <- sapply(names(params), USE.NAMES = F, function(param){
    sprintf('  .%s( %s )', param, toJSON(params[[param]]))
  })
  if (length(config) != 0L){
    paste(c(prefix, obj, config), collapse = "\n")
  } else {
    ""
  }
}

morrisPlot <- function(xkey, ykeys, data){
  
}