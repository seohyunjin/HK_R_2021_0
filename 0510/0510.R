#0510 서현진

library(ggplot2)  #diamonds 데이터 사용하기 위해
library(dplyr) # 파이프연산자 사용하기 위해
library(psych) # 통계프로그램 사용하기 위해

data(diamonds)
str(diamonds) #tibble[,10] [53,940 x 10] 

#왜도 / 첨도 확인
describe(women$height)  #describe()는 psych패키지 함수 #skew =0이므로 좌우대칭
#skew : '왜도'으미 : 치우침의 정도/ 기준 :0
#kurt : '첨도'의미 : 뾰족함의 정도 / 기준:3

hist(women$height)
density


# 정규분포를 따르지 않는 다면 모수적 방법 사용 -> wilcox.test()
#shapiro검정 => 정규성 검정 / 기준 :0.05 _0.05보다크면, 정규성을 따른다.

######################################0510##########
library(psych)  #통계
describe(women$height)
hist(women$height)
density()
data(diamonds)

#편의상 변수처리
dc<- diamonds$carat
dp<-diamonds$price

#
str(diamonds)
summary(dc)

cor(diamonds$carat, diamonds$price) # 0.9215913  # carat과 price의 상관관계
cor(dc,dp) # 0.9215913
summary(dc)
#   Min. 1st Qu.  Median    Mean 3rd Qu.    Max. 
# 0.2000  0.4000  0.7000  0.7979  1.0400  5.0100 
summary(dp)
# Min. 1st Qu.  Median    Mean 3rd Qu.    Max. 
# 326     950    2401    3933    5324   18823 

# 다이아몬드 가격이 3933이상인 개수
#n(dp>=3933) #:이렇게 하면 안됨
subset(diamonds,price>=3933)  #데이터프레임에서 원하는 값 부분추출

diamonds %>% filter(price>=3933) %>% summarise(n())  #19657
#;summarise() 괄호 안에 함수사용 ; summarise()사용하므로써 기초통계함수 사용가능

#trim = 절사평균
diamonds %>% filter(price>=3933) %>% summarise(mean_1 = mean(carat),
                                               tim_mean =mean(carat,trim=0.05))
#; trim을 이용하면 양 극단에서 일정부분을 뺴고 계산한다. trimdl 0.05이므로
#trim이 0.05이므로 양 끝에서 각각 0.05만큼씩을 제외한다.


#왜도와 첨도를 summarise()안에서 사용하려면 추가패키지를 설치해야한다. : e1071
install.packages('e1071')
library(e1071)
diamonds %>% filter(price>=3933) %>% summarise(mean_1 = mean(carat),
                                               tim_mean =mean(carat,trim=0.05),
                                               skew= e1071::skewness(carat),
                                               kurt= e1071::kurtosis(carat))

############--------------------------------------------
2.3 다중 회귀분석  483

# - 여러 개의 독립변수 -> 종속변수에 미치는 영향 분석
# 연구가설 : 음료수 제품의 적절성(x1)과 친밀도(x2)는 제품 만족도(y)에 정의 영향을 미친다.
# 연구모델 : 제품 적절성(x1), 제품 친밀도(x2) -> 제품 만족도(y)
rm(list=ls())
# csv파일은 시트를 선택적으로 불러올수가 없다
rm(list=ls())
library(readxl)

setwd('C:\\Users\\CPB06GameN\\Documents\\practice1_0419\\hankyungr')
product <- read.csv("data/product.csv")

#(1) 적절성 + 친밀도 -> 만족도  

y<- product[,c(3)]
x1<- product[,c(1)]
x2<- product[,c(2)]

######################################신뢰성 추가
#신뢰도 검사 : psy패키지 
install.packages("psy")
library("psy")

df <- data.frame(x1, x2, y)
class(df)

cronbach(df)  #크롬바우
#$alpha
#[1] 0.7960089
#0.7이상이면 신뢰성있음
###############################################
cor(df) # 상관관계

# 회귀식 선형모델
result.lm <- lm(y ~ x1 + x2 , data=df)

# 계수 확인 
result.lm

# (Intercept)     x1          x2  
# 0.66731      0.09593      0.68522 
# 절편          기울기     기울기

summary(result.lm)




# 0.66731(y절편)      0.09593(x1)  0.68522(x2)      

#residuals  leverage
# 분산팽창요인 
install.packages("car") # vif() 함수 제공 패키지 설치
library(car) # 메모리 로딩

#다중공선성 확인
#단계 2 : 분산팽창요인(VIF)
vif(result.lm) 
sqrt(vif(result.lm) ) > 2 # FALSE FALSE  2이하 다중공선성 아님


## 2.4 다중공선성 문제 해결과 모델 성능평가


# [실습] 다중공선성 문제 확인

# (1) 패키지 설치 및 데이터 로딩 
install.packages("car")
library(car)
data(iris)

# (2) iris 데이터 셋으로 다중회귀분석
fit <- lm(formula=Sepal.Length ~ Sepal.Width+Petal.Length+Petal.Width, data=iris)
vif(fit)

sqrt(vif(fit))>2 # root(VIF)가 2 이상인 것은 다중공선성 문제 의심 


##  2.5 기본가정 충족으로 회귀분석 수행

# [실습] 기본가정 충족으로 회귀분석 수행 

# 1. 회귀모델 생성 
# (1) 변수 모델링 : y:Sepal.Length <- x:Sepal.Width,Petal.Length,Petal.Width
formula = Sepal.Length ~ Sepal.Width + Petal.Length + Petal.Width

# (2) 회귀모델 생성 
model <- lm(formula = formula,  data=iris)
model
