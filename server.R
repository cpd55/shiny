library(shiny)
library(ggplot2)

# Define server logic required to draw a histogram
shinyServer(function(input, output) {

  output$distPlot <- renderPlot({

    bins <- input$bins
    learning <- input$learning
    testing <- input$testing

    set.seed(input$seed)
    train <- matrix(runif(learning),ncol=2)
    test <- matrix(runif(testing),ncol=2)
    
    cl<-0
    for (i in 1:length(train[,1])) {
      if (train[i]<=0.5) cl[i]<-"A"
      if (train[i]>0.5) cl[i]<-"B"
      if (train[i]>=0.9) cl[i]<-"C"
    }
    cl<-as.factor(cl)
    pred <- class:::knn(as.data.frame(train), as.data.frame(test), cl, k = bins, l = 1, prob = TRUE, use.all = TRUE)
    prob <- attr(pred, "prob")
    prob <- ifelse(pred=="A", prob, ifelse(pred=="B", prob, prob))
    
    prob_d <- data.frame(test,prob)
    prob_d <- prob_d[ order(prob_d[,1], prob_d[,2]), ]

    px <- seq(.01,1 ,0.01)
    py <- seq(.01,1 ,0.01)
    
    prob_m <- matrix(0, length(px), length(px))
    for (x in px){
      for (y in py){
        xa<-round(x*100);ya<-round(y*100)
        a<-mean(prob_d[x<prob_d$X1 & prob_d$X1<x+0.06 & y<prob_d$X2 & prob_d$X2<y+0.06,3])
        prob_m[xa,ya]<-a
      }
    }
    
    filled.contour(prob_m, color = terrain.colors, asp = 1, 
                   plot.title=title("How certain the knn is at a given point.\n (1-all the wotes are the same 0.5-half of the wotes are the same)")
                   ) 
    
    output$trainPlot <- renderPlot({
      ggplot(as.data.frame(train), mapping=aes(x = as.data.frame(train)[,1], y = as.data.frame(train)[,2])) + 
        geom_point() +
        labs(x="x coordinates", 
             y = "y coordinates",
             title ="Random generated train dataset") +
        aes(color=factor(cl)) + 
        scale_color_manual(values = c("red", "blue", "green"),name="Categorized by these rules",labels = c("x<0.5", "0.5<x<0.9", "0.9<x<1"))
    })
    output$testPlot <- renderPlot({
      ggplot(as.data.frame(test), mapping=aes(x = as.data.frame(test)[,1], y = as.data.frame(test)[,2])) + 
        geom_point() +
        labs(x="x coordinates", 
             y = "y coordinates",
             title ="Random generated test dataset") +
        aes(color=factor(pred)) + 
        scale_color_manual(values = c("red", "blue", "green"),name="Predicted")
    })  
    
  })
  
  
})

