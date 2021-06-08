#전타임 복습
iris

str(iris)

library(dplyr)
iris %>% select(c(3:4) %>% tail(10))
iris %>% select(-Species) %>% head(10)

mean(iris$Sepal.Length)
median(iris$Sepal.Length) #5.8
summary(iris$Sepal.Length)

apply(iris,2,max) # d열방향 최대값
apply(iris,2,min) # 열방향 최소값
apply(iris[,1:4],2,sum) # 
apply(iris[-5],2,mean) 


#species가 setosa인 데이터를 df.set에 저장
df.set <- subset(iris,Species=='setosa')
head(df.set)

#petal.length가 4.35초과이고 petal.width가 1.3초과인 데이터를 df.large로 저장
df.large<-subset(iris,Sepal.Length>4.35 &  Petal.Width>1.3)
head(df.large)

#붓꽃 데이터의 집계 : df.large데이터셋의 종별 집계를 확인
table(df.large[,5])


plot(iris)
dev.new() # 새창띄우기
plot(df.large)
pairs(df.large[df.large$Species=='virginica',])

# install.packages('psych')
library(psych)  # 사후 검정,상관관계, 신뢰성 검사시 쓰이는 패키지
pairs.panels(iris) # 상관관계 

plot(iris)
plot(iris$Petal.Width,iris$Petal.Length,pch=5) 
#plot(x축 데이터열설정, y축 데이터열 설정, pch=5) #pch=5: 속이빈 다이아몬드 몽ㄹ
plot(iris$Petal.Width,iris$Petal.Length,pch=1) #pch=1; 속이 빈 동그라미 모양

summary(iris$Sepal.Length)
hist(iris$Sepal.Length,xlab='iris$Sepal.Length',col='lightblue')
summary(iris $Sepal.Width)
hist(iris$Sepal.Width,xlab='iris$Sepal.Width',col='mistyrose',
     main='iris꽃받침너비 histogram',xlim = c(2.05,4.05))

par(mfrow = c(1,2))
hist(iris$Sepal.Width,xlab='iris$Sepal.Width',col='green',
     main='iris꽃받침너비 histogram: 빈도수',xlim = c(2.05,4.05))

# freq=F 해주어야 y 축에 빈도가 아닌 밀도(density)로 나옴
hist(iris$Sepal.Width,xlab='iris$Sepal.Width',col='mistyrose',
     freq=F,
     main='iris꽃받침너비 histogram: 확률밀도',xlim = c(2.05,4.05))

lines(density(iris$Sepal.Width),col='blue') # 밀도 기준으로 line 추가

################################210503#################
#서현진
#0503#

#reshape2 패키지

head(airquality)
air_low <-airquality  # copy
# 변수명 소문자로 전환 : names(데이터셋명) <- tolower(names(데이터셋명))
names(air_low) <-tolower(names(air_low))  
head(air_low)


install.packages('reshape2')
library(reshape2)

str(air_low)#데이터프레임 : 153 obs. of  6 variables
# 가로로 긴 데이터프레임을 세로로 긴 데이터 프레임으로 바꿈
melt_test <- melt(air_low)
str(melt_test) # 데이터 프레임 : 918 obs. of  2 variables

head(melt_test)
tail(melt_test)
View(melt_test)

# melt(데이터셋명, id.vars=c('기준열1','기준열2'),measure.vars='반환할 값')
melt_test2<- melt(air_low,id.vars=c('month','wind'),measure.vars='ozone')
head(melt_test2)

# 온도의 합계를 구하시오
View(air_low)
sum(air_low$wind) #1523.5
sum(air_low $ozone) #NA
sum(air_low $ozone,na.rm=T)  # 4887

#QUIZ] airqulity 데이터 중 na가 한개라도 있으면 제외하고 NA.RM_AIR로 저장하시오
NA.RM_AIR <- na.omit(air_low)
str(NA.RM_AIR) #'data.frame':	111 obs. of  6 variables

# month와 solar에 따른 wind 확인하시오
melt_test3<- melt(air_low, id.vars=c('month','solar.r'), measure.vars='wind')
head(melt_test3)

#데이터에 결측값이 있는지 확인 : is.na(데이터 )
is.na(melt_test3)  #결측값인지 확인
table(is.na(melt_test3))  # 집계해서 간편하게 확인
#FALSE  TRUE 
#605     7    #;즉 결측값이 7개라는 의미

#QUIZ]
# na없는 값으로 월일을 기준으로한 solar.r값을 확인
melt_q <-melt(NA.RM_AIR,id.vars=c('month','day'),measure.vars = 'solar.r')
head(melt_q)
View(melt_test3)



##
dim(air_low) #[1] 153   6
head(air_low)
dim(NA.RM_AIR) #[1] 111   6
head(NA.RM_AIR)

aq_melt <- melt(air_low,id.vars=c('month','day'),na.rm=TRUE)
str(aq_melt) #'data.frame':	568 obs. of  4 variables
dim(aq_melt) #[1] 568   4

aq_dcst <-dcast(aq_melt,month+day ~ variable)
aq_dcst
dim(aq_dcst) #[1] 153   6
head(aq_dcst)
View(aq_dcst)

#5월 부터 9월/1일에서 30일까지 오존, 태양복사, 바람, 온도의 측정값

aq_dcst$ozone
aq_dcst$solar.r
aq_dcst$wind
aq_dcst$temp

#
str(aq_melt)
head(aq_melt) #'data.frame':	568 obs. of  4 variables:

#acast (데이터 셋 , 행데이터기준열 ~열데이터 기준열 ~ variable(값의미) )
acast(aq_melt, day ~month ~ variable)# 기준 


# 행데이터 : month / 값을 평균으로 요약
acast(aq_melt,month ~ variable, mean) # 기준 1개
#; 월마다 기록이 평균으로 나옴


# 행데이터: month / 값을 sum으로 요약 
acast (aq_melt,month ~ variable, sum) #
#; 월마다 기록이 합으로 나옴


##############################################통계
#고등학교 2학년 남학생 키 분포도를 통해 기초통계량을 구하시오
height <- c(164,166,168,170,172,174,176)
mean(height) #170
# 편차 (변량 - 평균)  // 편차들의 합 = 0
var(height) #18.66667  #편차(표본-표본평균)의 제곱의 합 /(표본의갯수-1)
sd(height) #4.320494 #

boxplot(height)


#정규성 여부 판단 : shapiro.test(num형 데이터)
# p-value가 0.05보다 크다 => 정규성이다.
hist(rnorm(10))  
shapiro.test(rnorm(100,5,3))
 #W = 0.979, p-value = 0.111   #;p값이 0.05보다 크므로 정규성이다.

data("ToothGrowth")
# ??ToothGrowth
str(ToothGrowth)
shapiro.test(ToothGrowth$len) 
#W = 0.96743, p-value = 0.1091 #;0.05보다 크므로 정규성


hist(ToothGrowth$len)

#shapiro 검정 : 0.05보다 크면 귀무가설을 채택, 정규성 띈다
par(mfrow = c(2,1))
data1<- sample(50:100,100,replace= T)
hist(data1,col='orange',las=1)
shapiro.test(data1) #정규성 X

data2<- rnorm(100,80,2)
hist(data2,col='skyblue',las=1)
shapiro.test(data2) # 정규성O


# ###############Resape2 복습#################3333
library(reshape2)
getwd()
setwd('C:\\Users\\CPB06GameN\\Documents\\practice1_0419\\hankyungr')
data<- read.csv('data/data3/data.csv')
data

head(data)
wide<-dcast(data, Customer_ID ~ Date, sum) 
# customer_ID행기준 열기준:date, 값은 sum으로 요약
wide
#  Customer_ID 20150101 20150102 20150103 20150104 20150105 20150106 20150107
# 1           1        5        2        5        5        0        0        9
# 2           2        7        0        4        8        0        6        0
# 3           3        0        0        0        5        0        6        4
# 4           4        0        6        8        0        0        0        0
# 5           5        0        1        5        0        6        0       10


write.csv(wide, 'wide.csv', row.names=FALSE) #행번호 없이 저장

wide<-read.csv('wide.csv')
wide
# Customer_ID X20150101 X20150102 X20150103 X20150104 X20150105 X20150106
# 1           1         5         2         5         5         0         0
# 2           2         7         0         4         8         0         6
# 3           3         0         0         0         5         0         6
# 4           4         0         6         8         0         0         0
# 5           5         0         1         5         0         6         0
# X20150107
# 1         9
# 2         0
# 3         4
# 4         0
# 5        10

# 칼럼명 변경 
colnames(wide) <-c('Customer_ID','day1','day2','day3',
                   'day4','day5','day6','day7')

wide
# Customer_ID day1 day2 day3 day4 day5 day6 day7
# 1           1    5    2    5    5    0    0    9
# 2           2    7    0    4    8    0    6    0
# 3           3    0    0    0    5    0    6    4
# 4           4    0    6    8    0    0    0    0
# 5           5    0    1    5    0    6    0   10

long<-melt(wide, id= 'Customer_ID')
long

# melt한 데이터 long 칼럼명 바꾸기
name <-c('Customer_ID','Date','Buy')
colnames(long) <-name
head(long)

data('smiths')
smiths

long<-melt(id= 1:2,smiths)
long

#긴 형식을 넓은 형식으로 변경 : dcast(데이터, 기준1 + 기준2)
dcast(long,subject +time ~ ...) 


data("airquality")
names(airquality) <-toupper(names(airquality)) #칼럼명 다 대문자로
head(airquality)

air_melt<- melt(airquality,id= c('MONTH','DAY'),na.rm=T)
head(air_melt)

names(air_melt) <-tolower(names(air_melt)) # 칼럼명 소문자로 변경
acast<-acast(air_melt, day~month ~ variable) #3차원 구조로 변경
acast #행데이터 :day, 열데이터: month

acast(air_melt, month ~ variable, sum, margins= T)

??complete
