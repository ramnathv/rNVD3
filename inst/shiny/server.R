require(rNVD3)
shinyServer(function(input, output) {
  output$show <- renderChart({
    return(.nvd3_object)
  })
})
