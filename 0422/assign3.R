#서현진 0422 assign

#붓꽃 종이 versicolor 이면서 Sepal.Length 이 6이상인 데이터를 color로 저장하시오

iris
library(dplyr)
head(iris)

# iris$color<-(iris$Species ==" versicolor" & iris$Sepal.Length >=6)
color<-(iris$Species ==" versicolor" & iris$Sepal.Length >=6)

#sol)
#color <-subset(iris$Species ==" versicolor" & iris$Sepal.Length >=6)
#== color<- filter(Species==" versicolor" & Sepal.Length >=6)



#저장한 변수 중 Sepal.Length과 Petal.Length 열만 저장하여 csv로 저장하시오
versicolor<-iris[, c(1, 3)]
head(versicolor)

#파이프연산이용시, 본함수(사용할데이터,any형식)일때 파이프연산으로 중첩가능
color2 <- iris %>% select (c(1,3)) %>%  head(2)
color2
#  Sepal.Length Petal.Length
# 1          5.1          1.4
# 2          4.9          1.4


write.csv(versicolor,"data/versicolor.csv", row.names=F)





