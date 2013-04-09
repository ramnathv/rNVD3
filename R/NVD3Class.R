NVD3 <- setRefClass('NVD3', fields = list(params = 'list'), methods = list(
  initialize = function(){
    params <<- list(id = basename(tempfile("chart")));
    params$chart <<- list();
    params$xAxis <<- list();
    params$yAxis <<- list();
  },
  addParams = function(...){
    params <<- modifyList(params, list(...))
  },
  chart = function(...){
    params$chart <<- modifyList(params$chart, list(...))
  },
  xAxis = function(..., replace = F){
    if (replace) {
      params$xAxis <<- list(...)
    } else {
      params$xAxis <<- modifyList(params$xAxis, list(...))
    }
  },
  yAxis = function(..., replace = F){
    if (replace) {
      params$yAxis <<- list(...)
    } else {
      params$yAxis <<- modifyList(params$yAxis, list(...))
    }
  },
  getChartParams = function(x, data, ...){
    fml = lattice::latticeParseFormula(x, data = data)
    params <<- modifyList(params, list(x = fml$right.name, y = fml$left.name, 
      group = names(fml$condition), data = data, ...))
  },
  fixChartParams = function(){
    if (length(params$y) == 0){
      variables = c(params$x, params$group)
      params$data <<- count(params$data, variables[variables != ""])
      params$y <<- 'freq'
    }
    return(params)
  },
  html = function(chartId = NULL){
    template_file = system.file('nvd3', 'layouts', 'nvd3Plot.html', package = 'rNVD3')
    template = paste(readLines(template_file, warn = F), collapse = '\n')
    if (is.null(chartId)){
      chartId <- params$id
    } else {
      params$id <<- chartId
    }
    myparams = r2json(params[!(names(params) %in% c('data', 'chart', 'xAxis'))])
    data = r2json(params$data)
    xAxis =  chainConfig(params$xAxis, prefix = 'chart.xAxis')
    yAxis = chainConfig(params$yAxis, prefix = 'chart.yAxis')
    chart = chainConfig(params$chart, prefix = 'chart')
    html = paste(capture.output(cat(whisker.render(template))), collapse = '\n')
    return(html)
  },
  printChart = function(chartId = NULL){
    writeLines(.self$html(chartId))
  },
  render = function(chartId = NULL){
    if (is.null(chartId)){
      chartId <- params$id
    } else {
      params$id <<- chartId
    }
    template_file = system.file('nvd3', 'layouts', 'nvd3.html', package = 'rNVD3')
    template = paste(readLines(template_file, warn = F), collapse = '\n')
    partials = list(nvd3Plot = .self$html(chartId))
    html = capture.output(cat(whisker.render(template, partials = partials)))
  },
  save = function(destfile = 'index.html'){
    writeLines(.self$render(), destfile)
  },
  show = function(static = !("shiny" %in% rownames(installed.packages()))){
    if (static){
      tf <- tempfile(fileext = 'html');
      writeLines(.self$render(), tf)
      system(sprintf("open %s", tf))
    } else {
      assign(".nvd3_object", .self$copy(), envir = .GlobalEnv) 
      shiny::runApp(file.path(system.file(package = "rNVD3"), "shiny"))
    }
  }
))
