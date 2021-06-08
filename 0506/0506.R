library(readxl)
library(dplyr)
getwd()

# 예제1
dustdata<- read_excel('localAverage(0506).xlsx')
head(dustdata)
str(dustdata)

data_anal<- dustdata %>% filter(측정소명 %in% c('도봉구','노원구'))
View(data_anal)
data_anal

count(data_anal,날짜) %>% arrange(desc(n))
count(data_anal,측정소명) %>% arrange(desc(n))

dust_anal_area_sb <-subset(data_anal, 측정소명 =='노원구')
dust_anal_area_sb

library(psych)

describe(dust_anal_area_sb$미세먼지)

boxplot(dust_anal_area_sb$미세먼지, dust_anal_area_sb$초미세먼지, main= '미세먼지 비교')

#예제2
daydata<- read_excel('day(0506).xlsx')
head(daydata)

day_anal<- daydata %>% filter(`3일` %in% c(13,11))
View(day_anal)
count(day_anal,`3일`) %>% arrange(desc(n))
day_anal_area_sb <-subset(day_anal, `3일` ==13)
day_anal_area_sb

describe(day_anal$`3일`)
boxplot(day_anal$`13일`, day_anal$`6일`, main= '초미세먼지 일별비교')

#예제3
library(readxl)
library(dplyr)
perioddata <-read_excel('period(0506).xlsx')
head(perioddata)
period_anal<- perioddata %>% filter(측정소명 %in% c('도봉구','노원구'))
View(period_anal)
period_anal

count(period_anal,날짜) %>% arrange(desc(n))
count(period_anal,측정소명) %>% arrange(desc(n))

period_anal_area_sb <-subset(period_anal, 측정소명 =='노원구')
period_anal_area_sb

period_anal_area_sb2 <-subset(period_anal, 측정소명 =='도봉구')
period_anal_area_sb2

ls(period_anal_area_sb)
boxplot(period_anal_area_sb$'미세먼지 PM10\r\n(㎍/m3)',
        period_anal_area_sb2$'미세먼지 PM10\r\n(㎍/m3)', 
        main= '미세먼지 비교',
        xlab= "측정소명",
        ylab= '미세먼지량',
        col=c('lightblue','lightgreen'))


ls(period_anal)
names(period_anal) <-c('date','area','finedust','fineparticulate','O3','NO2','CO','SO2')
head(period_anal)
t.test(data=period_anal,finedust~area,var.equal=T)


#과제 제출용
library(readxl)
library(dplyr)
library(psych)

setwd('C:\\Users\\CPB06GameN\\Documents\\practice1_0419\\hankyungr')
perioddata <-read_excel('period(0506).xlsx')
head(perioddata)
period_anal<- perioddata %>% filter(측정소명 %in% c('성북구','중구'))
# View(period_anal)
period_anal


count(period_anal,날짜) %>% arrange(desc(n))
count(period_anal,측정소명) %>% arrange(desc(n))

period_anal_area_sb <-subset(period_anal, 측정소명 =='성북구')
period_anal_area_sb

period_anal_area_sb2 <-subset(period_anal, 측정소명 =='중구')
period_anal_area_sb2


describe(period_anal_area_sb $`미세먼지 PM10\r\n(㎍/m3)`)
describe(period_anal_area_sb2 $`미세먼지 PM10\r\n(㎍/m3)`)

#이상치 제거
period_anal_area_sb $`미세먼지 PM10\r\n(㎍/m3)`<- 
        ifelse(period_anal_area_sb $`미세먼지 PM10\r\n(㎍/m3)` >=150, NA, 
               period_anal_area_sb $`미세먼지 PM10\r\n(㎍/m3)`)

period_anal_area_sb2 $`미세먼지 PM10\r\n(㎍/m3)`<- 
        ifelse(period_anal_area_sb2 $`미세먼지 PM10\r\n(㎍/m3)` >=150, NA, 
               period_anal_area_sb2 $`미세먼지 PM10\r\n(㎍/m3)`)

ls(period_anal_area_sb)
boxplot(period_anal_area_sb$'미세먼지 PM10\r\n(㎍/m3)',
        period_anal_area_sb2$'미세먼지 PM10\r\n(㎍/m3)', 
        main= '미세먼지 비교',
        xlab= "측정소명",
        names =c('성북구','중구'),
        ylab= '미세먼지량',
        col=c('lightblue','lightgreen'))


ls(period_anal)
names(period_anal) <-c('date','area','finedust','fineparticulate','O3','NO2','CO','SO2')
head(period_anal)
t.test(data=period_anal,finedust~area,var.equal=T)
#p-value가 0.05보다 크므로 유의하다 

#예제 ) 
#과자의 50g인지 확인을 위해 50봉지를 구매
# 각각의 무게를 재고 평균을 구한 것 : 표본 평균
# 실제 과자 봉지의 평균과 비교(모집단의 알려진 평균)

m = 50 # 알려진 모집단의 평균
sa_1 <- rnorm(50,58,3) #표본을 뽑는다
boxplot(sa_1)  #상자그림

shapiro.test(sa_1) # 정규성 검사 : > 0.05보다 크면 정규성가짐
# W = 0.98017, p-value = 0.5593 따라서 정규성 가짐

# 정규성 가지므로 t-test 한다.
t.test(sa_1,mu=m, var.equal = T) #양측검정
#var.equal = T : 분산이 같다 : 등분산이다 

#동질성 검정 : 등분산 test :var.test(집단1, 집단2)
var.test()

## 단측검정 속성추가; alternative='greater'// alternative='less'
# conf.level = 0.95 #;신뢰구간 설정

t.test(sa_1, mu=m, alternative='greater', var.equal = T, conf.level = 0.95) #단측검정
#t = 23.957, df = 49, p-value < 2.2e-16 #;즉 0.05보다 작으므로 대립가설 채택 : '크다'
t.test(sa_1, mu=m, alternative='less', var.equal = T) #단측검정
#p-value = 1  #즉, 0.05보다 크므로 영가설 채택

########################33

#t- 검정
t.test()
#차이 검정 
# - 평균이 같은지 여부 : mu=m
# - 독립표본 t 검정(두 그룹간의 차이를 비교, 분산이 같은지 확인) : var.equal = TRUE
# - 대응표본 (쌍으로 묶여 차이만을 계산, 검증 차이값을 하나로) : paired = TRUE

# 중간고사 이후 과외를 받은 10명 학생의 중간고사, 기말고사 점수를 비교 

# 30개 이하임을 확인
mid = c(16,20,21,22,23,22,27,25,27,28)
final =c(19,22,24,24,25,25,26,26,28,32)

#정규성 확인
shapiro.test(mid)  #W = 0.94809, p-value = 0.6459 #;p-value 가 0.05보다 크므로 정규성o
shapiro.test(final)  #W = 0.95546, p-value = 0.7332 #;p-value 가 0.05보다 크므로 정규성o


#귀무가설 : 차이가 없다 //대립가설 : 평균이 차이가 있다.

#과외후 차이가 있는지 비교 t.test(after,before)
t.test(final, mid, paired=T, var.equal =T) #p-value = 0.00155


####################################상관관계 분석
# 상관관계분석이란 변수들 간의 관련성을 분석하기 위해 사용하는 분석방법
# 하나의 변수가 다른 변수와 관련성이 있는지, 있다면 어느정도 관련성이 있는지 개관 가능

#피어슨 상관계수와 상관관계 정도

x <- c(0,1,4,9)
y <- c(0,5,7,9)

mean(x) # 3.5
mean(y) # 5.25

cor(x,y,method= 'pearson') #기본값이 피어슨 상관계수
 #[1] 0.8648892

# 상관관계
head(mtcars)

install.packages('corrplot')
library(corrplot)

car_cor <- cor(mtcars)
car_cor
round(car_cor,2)

corrplot(car_cor)


str(car_cor)
summary(car_cor)


###
# 귀무가설 : 담배값인상과 흡연과는 차이가 없다.
# 대립가설 : 담배값인상과 흡연과는 차이가 있다.

x1 <-c(70,72,62,64,71,76,0,65,74,72)
y1 <-c(70,74,65,68,72,74,61,66,76,75)
cor(x1,y1)
xy_1 <-data.frame(x1,y1)

t.test(y1,x1, paired =T, var.equal = T, data=xy_1)
#mean of the differences 
# 7.5  #; 평균은 7.5정도 차이가 나며
#t = 1.2565, df = 9, p-value = 0.2406 #; p-value가 0.2406으로 0.05보다 크므로 
#영가설 채택,즉 담배값 인상과 흡연과의 차이는 없다.  



##### 비모수 검정
# 

#카이제곱 검정
# 범주별로 관측빈도와 기대빈도의 차이를 통해서 확률 모형이 데이터를 
# 얼마나 잘 설명하는지를 검정하는 통계적 방법
# 일반적으로 교차분석으로 얻어진 분하표를 대상으로 유의확률을 적용하여 
#변수간의 독립성 여부(관련성)여부를 검정하는 분석방법으로 

##
