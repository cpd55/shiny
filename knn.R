install.packages("shiny",lib = "c:/R/R-3.2.3/library/")

library(shiny)
runExample("01_hello")
runExample("03_reactivity")

getwd()

setwd("f:/Dokumentumok/coursera")
App<-"f:/Dokumentumok/coursera"
setwd("c:/Users/gszilos/Documents/Coursera/datascience specialization/09 Developing Data Products/project/")
App<-"c:/Users/gszilos/Documents/Coursera/datascience specialization/09 Developing Data Products/project/"
runApp(App, display.mode = "showcase")

devtools::install_github('rstudio/shinyapps')
shinyapps::setAccountInfo(name='cpdsh',
                          token='D6F0209A3B03EE4BACE970249450D525',
                          secret='pi78SY7+2u51Cnu0KP4jujyQ2b5t2ilj+zhG+q4z')
library(shinyapps)
shinyapps::deployApp('f:/Dokumentumok/Dropbox/Dropbox/shinyproject')


##How to plot decision boundary of a k-nearest neighbor classifier from Elements of Statistical Learning?
install.packages("ElemStatLearn")
library(ElemStatLearn)

require(class)
x <- mixture.example$x
g <- mixture.example$y
xnew <- mixture.example$xnew
mod15 <- class::knn(x, xnew, g, k=15, prob=TRUE)
attributes(.Last.value)
prob <- attr(mod15, "prob")
prob <- ifelse(mod15=="1", prob, 1-prob)
px1 <- mixture.example$px1
px2 <- mixture.example$px2
prob15 <- matrix(prob, length(px1), length(px2))
par(mar=rep(2,4))
contour(px1, px2, prob15, levels=0.5, labels="", xlab="", ylab="", main=
          "15-nearest neighbour", axes=FALSE)
filled.contour(prob15, color = terrain.colors, asp = 1) # simple
points(x, col=ifelse(g==1, "coral", "cornflowerblue"))
gd <- expand.grid(x=px1, y=px2)
points(gd, pch=".", cex=1.2, col=ifelse(prob15>0.5, "coral", "cornflowerblue"))
box()


train <- rbind(iris3[1:25,,1], iris3[1:25,,2], iris3[1:25,,3])
test <- rbind(iris3[26:50,,1], iris3[26:50,,2], iris3[26:50,,3])
cl <- factor(c(rep("s",25), rep("c",25), rep("v",25)))
knn(train, test, cl, k = 3, prob=TRUE)
attributes(.Last.value)

#NNG example
install.packages("cccd")
library(cccd)
x <- matrix(runif(100),ncol=2)

G1 <- nng(x,k=1)
## Not run: 
par(mfrow=c(2,2))
plot(G1)

## End(Not run)

G2 <- nng(x,k=2)
## Not run: 
plot(G2)

## End(Not run)

G5 <- nng(x,k=5)
## Not run: 
plot(G5)

## End(Not run)

G5m <- nng(x,k=5,mutual=TRUE)
## Not run: 
plot(G5m)
par(mfrow=c(1,1))

## End(Not run)


## my knn
set.seed(123)
train <- matrix(runif(100),ncol=2)
test <- matrix(runif(5000),ncol=2)
bigger_than <- (train[,1] > 0.5)
cl<-0
for (i in 1:length(train[,1])) {
 # print(train[i])
  if (train[i]<=0.5) cl[i]<-"A"
  if (train[i]>0.5) cl[i]<-"B"
  if (train[i]>=0.9) cl[i]<-"C"
#  print(cl[i])
}
cl<-as.factor(cl)
pred <- class:::knn(as.data.frame(train), as.data.frame(test), cl, k = 15, l = 1, prob = TRUE, use.all = TRUE)
prob <- attr(pred, "prob")
prob <- ifelse(pred=="A", prob, ifelse(pred=="B", 1-prob, prob))

prob_d <- data.frame(test,prob)
prob_d <- prob_d[ order(prob_d[,1], prob_d[,2]), ]
head(prob_d)

#prob_d[with(prob_d, x<X1 & X1<x+0.2 & y<X2 & X2<y+0.2),prob_d$prob]
#mean(prob_d[x<prob_d$X1 & prob_d$X1<x+0.05 & y<prob_d$X2 & prob_d$X2<y+0.05,3])

px <- seq(.01,1 ,0.01)
py <- seq(.01,1 ,0.01)

prob_m <- matrix(0, length(px), length(px))
for (x in px){#/*px*/
  for (y in py){#/*pxy*/
    #print(x);print(y)
    xa<-round(x*100);ya<-round(y*100)
     a<-mean(prob_d[x<prob_d$X1 & prob_d$X1<x+0.06 & y<prob_d$X2 & prob_d$X2<y+0.06,3])
    prob_m[xa,ya]<-a
  }
}


#x<-0.07;y<-0.07
#a<-mean(prob_d[x<prob_d$X1 & prob_d$X1<x+0.05 & y<prob_d$X2 & prob_d$X2<y+0.05,3])
#prob_m[7,7]

 
plot.new()
contour(px, py, prob_m, levels=0.6, labels="", xlab="x1", ylab="x2", main="nearest neighbour", drawlabels=TRUE)

require(grDevices) # for colours
filled.contour(prob_m, color = terrain.colors, asp = 1) # simple

# adding the points to the plot:
points(as.data.frame(train), col=ifelse(cl=="A", "red", ifelse(cl=="B", "blue", "green")), pch = 21)
points(as.data.frame(test), col=ifelse(pred=="A", "red", ifelse(pred=="B", "blue", "green")), pch = 19)


train<-CARS[1:50,]
test<-CARS[51:100,]
cl <-train[,8]
pred<-knn(train[,1:7], test[,1:7], cl, k = 3)


require(grDevices) # for colours
x <- -6:16
op <- par(mfrow = c(2, 2))
contour(outer(x, x), method = "edge", vfont = c("sans serif", "plain"))
z <- outer(x, sqrt(abs(x)), FUN = "/")
image(x, x, z)
contour(x, x, z, col = "pink", add = TRUE, method = "edge",
        vfont = c("sans serif", "plain"))
contour(x, x, z, ylim = c(1, 6), method = "simple", labcex = 1,
        xlab = quote(x[1]), ylab = quote(x[2]))
contour(x, x, z, ylim = c(-6, 6), nlev = 20, lty = 2, method = "simple",
        main = "20 levels; \"simple\" labelling method")
par(op)