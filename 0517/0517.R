#####0517_ 시험 KEY POINT

library(ggplot2) #

ggplot(economics, aes(x= date, y=psavert))+ geom_line()

#회귀식 모형 적합도 확인
a.lm <- lm(data = economics, psavert ~date)
summary(a.lm)

a.lm$coef
plot(a.lm)

#예측선 추가하기
ggplot(economics, aes(x= date, y=psavert)) + geom_line() +
  geom_abline(intercept = 12.18671, slope=-0.0005444, col='red')

#### 산점도 그래프
install.packages('lattice') #필요패키지
library(lattice)
str(airquality)

xyplot(Ozone~ Wind, data= airquality)
range(airquality$Ozone, na.rm =T)
xyplot(Ozone ~ Wind | Month, data = airquality)
xyplot(Ozone ~ Wind | Day,data = airquality)
xyplot(Ozone ~ Wind | Month, data = airquality, layout = c(5,1))
xyplot(Ozone ~ Wind | factor(Month), data = airquality, layout = c(5,1)) #month 실제값을 넣고 싶을떄

xyplot(Ozone +Solar.R ~Wind |factor(Month),
       data = airquality,
       col = c('blue','red'),
       layout = c(5,1)) #xyplot은 y축에 두개의 변수값 적용가능


convert <-transfrom (quakes, depth2=factor(depth2))
xyplot(lat~long | depth2, data =convert)

