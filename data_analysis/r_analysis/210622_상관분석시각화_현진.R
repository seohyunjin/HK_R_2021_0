#상관관계시각화
##########################form
# > # corrplot
#   > corrplot(airquality_cor, 
#              +          method="shade", # 색 입힌 사각형
#              +          addshade="all", # 상관관계 방향선 제시
#              +          # shade.col=NA, # 상관관계 방향선 미제시
#              +          tl.col="red", # 라벨 색 지정
#              +          tl.srt=30, # 위쪽 라벨 회전 각도
#              +          diag=FALSE, # 대각선 값 미제시
#              +          addCoef.col="black", # 상관계수 숫자 색
#              +          order="FPC" # "FPC": First Principle Component
#              +                      # "hclust" : hierarchical clustering
#              +                      # "AOE" : Angular Order of Eigenvectors
#              +          )
##########################


#library
library(readxl)

food<- read_excel("c:/R_project/Team_Complete/data/sns1819.xlsx")
weather <- read_excel("c:/R_project/Team_Complete/data/weather1819.xlsx")

#weather plot 
plot(weather)

#correalation
cor(x=food[,-1],y=weather[,-1])

##correalation visualization
# install.packages('corrplot')
library(corrplot)

mcor<- cor(x=food[,-1],y=weather[,-1])
round(mcor,2)
corrplot(mcor,method='shade',shade.col = NA, tl.col='black', tl.srt=90, tl.cex = 0.5)
