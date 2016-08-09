
function(input, output) {

  Sdata=reactive({
    if(!input$im){
      maldata[,input$mal]
    } else{
      maldatai[,input$mal]
    }
  })
  timeda=reactive({
    Sdataa=Sdata()
    window(Sdataa,start=input$ty[1],end=input$ty[2]+23/24)
  })
  fn=reactive({
    ((input$py)-2010)*24
  })
  
  output$plot <- renderPlot({
    timedaa=timeda()
    pn=fn()
    if(input$meth=="Holt"){
      b=HoltWinters(timedaa)
      y=forecast.HoltWinters(b,pn)
      plot.forecast(y)
      title(main=input$mal)
    } else{
      
      x=auto.arima(timedaa)
      z=as.numeric(x$arma)
      p1=c(z[1],z[3],z[2])
      p2=c(z[6],z[4],z[7])
      malmodel=Arima(timedaa,order =p1,seasonal = p2)
      malpre= predict(malmodel,n.ahead = pn)
      ts.plot(timedaa,malpre$pred,col=c("black","red"))
      title(main=input$mal)
    }
  })
  output$summary <- renderPlot({
    plot(timeda())
  })
  
  output$table <- renderPrint({
    timeda()
  })
  
}