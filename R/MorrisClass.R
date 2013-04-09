MorrisChart <- setRefClass('MorrisChart', fields = list(params = 'list'), methods = list(
  initialize = function(){
    params <<- list();
    params$chart <<- list();
    params$xAxis <<- list();
    params$yAxis <<- list();
  },
  addParams = function(...){
    params <<- modifyList(params, list(...))
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
  html = function(){
    template_file = system.file('templates', 'morrisPlot.html', package = 'r2nvd3')
    template = paste(readLines(template_file, warn = F), collapse = '\n')
    if (is.null(params$id)) params$id <<- basename(tempfile("chart"))
    myparams = r2json(params[!(names(params) %in% c('data', 'chart', 'xAxis'))])
    data = r2json(params$data)
    chartId = params$id
    html = capture.output(cat(whisker.render(template)))
  },
  printChart = function(){
    writeLines(.self$html())
  },
  render = function(){
    template_file = system.file('templates', 'morris.html', package = 'r2nvd3')
    template = paste(readLines(template_file, warn = F), collapse = '\n')
    partials = list(nvd3Plot = .self$html())
    html = capture.output(cat(whisker.render(template, partials = partials)))
  },
  save = function(destfile = 'index.html'){
    writeLines(.self$render(), destfile)
  },
  show = function(){
    tf <- tempfile(fileext = 'html');
    writeLines(.self$render(), tf)
    system(sprintf("open %s", tf))
  }
))