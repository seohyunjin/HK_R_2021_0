rm(list=ls()) # 변수목록 지우기

#factor 개념정리  : factor = 범주
fe_test <- c('c','b','a','c','b','b','c','c')
str(fe_test) #chr [1:8] "c" "b" "a" "c" "b" "b" "c" "c" :문자

fe.factor <- factor(fe_test)
str(fe.factor)  #Factor w/ 3 levels "a","b","c": 3 2 1 3 2 2 3 3
#factor로 바꾸면 레벨 나옴 : factor 은 레벨이 존재(범주)

#a, b, c, C를 입력해 넣음
fe_test <- c('c','b','a','C','b','b','c','c')
str(fe_test)  #chr [1:8] "c" "b" "a" "C" "b" "b" "c" "c" :문자

fe.factor <- factor(fe_test)
str(fe.factor)  #Factor w/ 4 levels "a","b","c","C": 3 2 1 4 2 2 3 3
#대소문자를 구분하기 떄문에 레벨이 4임

library(ggplot2)
qplot(fe.factor)

# 그래프 높은 순으로 바꾸고 싶을때

#레벨 순서 바꾸고 싶을때 : 강제지정
a <- factor(fe.factor, levels = c("c","b","a"))
str(a)  #Factor w/ 3 levels "c","b","a": 1 2 3 1 2 2 1 1
qplot(a)

a
as.numeric(a)
str(a)


#
url <-"https://www.nrc.gov/reading-rm/doc-collections/event-status/reactor-status/2021/2021powerstatus.txt"
#정형데이터임 & txt 파일임 -> read.table
url.tr<-read.table(url,sep = '|')
head(url.tr)

tr_2<-read.table( "data/2021powerstatus.txt" ,
                  sep = '|',stringsAsFactors = F, 
                  header= T, 
                  nrow = 1000)
head(tr_2,5)
View(tr_2)
# 날짜가 date 형식으로 인식이 안돼있다.
tr_2$ReportDt <- as.Date(tr_2$Report,format='%m/%d/%y') #날짜형식 지정
tr_2$ReportDt
head(tr_2)

class(tr_2$ReportDt) #"Date"
View(tr_2) 

getwd()

library(readxl)
read_excel("data/1.xlsx",sheet=3)
head(tr_2,5)

#비정형파일 한글깨짐 현상 : readLines('파일',encoding='UTF-8')

#CSV파일 깨지는 경우 :read.csv('파일', fileEncoding='UTF-8')
ex_file <- read.csv('data/1.csv',fileEncoding='UTF-8')
View(ex_file)



###
#apply() : 배열 또는 행렬에 주어진 함수를 적용한 뒤 결과를 벡터, 배열 또는 리스트로 반환 : 배열, 행렬

#lapply() : 벡터 리스트 또는 표현식에 함수를 적용하여 그결과를 리스트로 반환 ; 리스트

#sapply() : lapply()와 유사하지만 결과를 벡터, 행렬 또는 배열로 반환 ; 벡터, 행렬 배열

#tapply() : 특정 컬럼에 있는 값을 기준으로 모아서 집계를 한후 지정된 작업을 수행 ; 벡터, 배열

data(iris)
head(iris,3)
#apply() 함수 : 2 ;열 / 1;행 의미
iris[,c(1,3,5)] # 1열,3,열,5열가져오고 싶을떄
head( iris[,c(1:4)] )
head( iris[,(1:4)] ) # 연결되는 숫자일때는 c 함수 굳이 사용하지 않아도 됨

apply(iris[,c(1:4)],2,sum)  #아이리스 1열 부터 4열까지 열(2)들을 다합친것(sum)들을 가져와
apply(iris[,c(1:4)],1,mean) # 아이리스 1열 부터 4열까지 행(1)들을 평균구한것을 다 가져와

score<- read.csv("data/score.csv")
head(score,2)
#   id class math english science
# 1  1     1   50      98      50
# 2  2     1   60      97      60

apply(score[,c(3:5)],2,mean) #원데이터의 3열~5열까지의 데이터를 열(2)끼리평균내어 가져와
# apply(score[,-c(1:2)],2,mean) 1열부터 2열빼는 것 ; 위와 같은 결과!
#   math english science 
#57.45   84.90   59.45 
apply(score[,-c(1:2)],2,sd)
apply(score[,-c(1:2)],2,var)

# 연습문제56p
#1)
getwd()  # "C:/Users/CPB06GameN/Documents/practice1_0419/hankyungr"
setwd('c:/Rwork')
getwd()  #"c:/Rwork"

#2)
name<-c('apple','banana')
age<-c(11,25)
address<-c('서울','대구')
mode(name) #"character"
mode(age) #"numeric"
mode(address) # "character"
is.character(name) #TRUE
is.character(age) # FALSE
is.numeric(age) #TRUE

#3)
data(women)
View(women)
str(women) #num으로 이루어진 dataframe임
plot(women)
#  예측선 만들기 # : 
#선형모델 : lm(종속변수 ~ 독립변수1 + 독립변수2 , data= 데이터)
head(women,2)
women.lm<- lm(weight ~ height, data = women) # 예측선 만들어 변수생성
plot(women)
abline() #추세선 : abline() 
abline(women.lm, col='red')

head(women,2)
women.lm <- lm(weight~height, data= women)
summary(women.lm)





#4)
vec <-c(1:100)
mean(vec)

#5)R의 특징
#- 무료오픈소스
#- 인터프리터 언어, 대소문자 구별
#- 객체지향언어, 함수형언어

#벡터의 자료 처리 
x

#Matrix 자료구조 
x1<-c(5,40,50:52)
x2<-c(30,5,6:8)
x3<-c(1:5)
mc<-cbind(x1,x2,x3) # 옆으로 합치기
mc

#
setwd('C:/Users/CPB06GameN/Documents/practice1_0419/hankyungr')
csvtemp<- read.csv('data/data3/emp.csv',header = T)
csvtemp
help(read.csv)
name<-c('사번','이름','급여') #변수명 바꾸기
sabun<-read.csv('data/data3/emp2.csv', header= F, col.names= name)
sabun
mean(sabun$급여) #370
#df<- data.frame(x=c(1:5), y =seq(2,10,2))

#칼럼명 소문자로 바꾸기 :  tolower(names(데이터셋))
head(iris)
names(iris)<- tolower(names(iris))


#조건을 만족하는 행 추출해 객체생성 : 변수 <- subset(데이터 프레임, 조건)



#데이터 병합
height <- data.frame( id= c(1,2), h=c(180,175)) ; height
weight <- data.frame( id=c(1,2), w= c(80,75) ); weight

user <- merge(height, weight, by.x='id',by.y='id')
user


# 리스트의 자료구조 
#- unlist() ; 리스트를 푸는 것

list<- list('lee','이순신',95) #key 생략한 리스트 생성
list
# [[1]] #"lee"키
# [1] "lee"
# 
# [[2]] #"이순신"키
# [1] "이순신"
#  
# [[3]] #95 키
# [1] 95

unlist <- unlist(list) #리스트를 벡터구조로 변경
unlist


#key-value 형식
member <- list (name =c('홍길동','유관순'),age=c(35,25),
                address = c('한양','충남'),gender = c('남자','여자'),
                htype = c('아파트','오피스텔'))
member
# $name
# [1] "홍길동" "유관순"
# 
# $age
# [1] 35 25
# 
# $address
# [1] "한양" "충남"
# 
# $gender
# [1] "남자" "여자"
# 
# $htype
# [1] "아파트"   "오피스텔"

member$name #"홍길동" "유관순"
member$name[1] #"홍길동"
member$name[2]  #"유관순"

#데이터 추가
member$age[1]<-45 #수정
member$Id <-'hong'
member$pwd <- '1234'
member
member$age <-NULL
member
length(member)
mode(member)
class(member)


#연습문제 90p
#1) 
Vec1 <- rep('r',5) ; Vec1
Vec2 <- seq(1,10,by=3) ; Vec2
Vec3 <- rep(Vec2,3)  ; Vec3
Vec4 <- c(Vec2,Vec3); Vex4
Vec6 <- seq(25,15,by=-5) ; Vec6
Vec5 <- c(Vec4[1],Vec4[3],Vec4[5],Vec4[7],Vec4[9],Vec4[11],Vec4[13],Vec4[15]) ; Vec5

#2)
name <- c('최민수','유관순','이순신','김유신','홍길동')
age<-c(55,45,45,53,15)
gender<-c(1,2,1,1,1)
job<-c('연예인','주부','군인','직장인','학생')
sat <- c(3,4,2,5,5)
grade<-c('c','c','a','d','a')
total <- c(44.4,28.5,43.5,NA,27.1) #총구매금액

#조건1)위 7개의 벡터를 칼럼으로 갖는 user 데이터프레임을 생성
user <-cbind(name,age, gender,job,sat,grade,total) ; user
# 조건2) gender변수를 이용하여 히스토그램을 그리시오
hist(gender)
#조건3) 데이터 플레임 user에서 짝수행만 선택-> user2
user2 <- rbind(user[2,],user[4,] ) ; user2

#3
kor <- c(90,85,90)
eng <- c(70,85,75)
mat <- c(86,92,88)
#조건1)
df3<- data.frame(kor,eng,mat) ; df3
max(df3)
max(df3$kor)
max(df3$eng)
max(df3$mat)

df3
#열 방향 
apply(df3[,c(1:3)],2,max)
#kor eng mat 
#90  85  92 

#행방향
apply(df3[c(1:3),],1,max)
# 1  2  3 
#90 92 90 
apply(df3[,c(1:3)],1,max) # 90 92 90

#조건3)
#열방향
round( apply(df3[,c(1:3)],2,mean) , 2)
#  kor   eng   mat 
#88.33 76.67 88.67 

#행방향
round( apply(df3[,c(1:3)],1,mean) , 2) #82.00 87.33 84.33

apply(df3[,c(1:3)],1,sd)  # 10.583005  4.041452  8.144528
apply(df3[,c(1:3)],1,var)  # 112.00000  16.33333  66.33333


#4)
data2 <- c('2017-02-05 수입 3000원',
           '2017-02-06 수입 4500원',
           '2017-02-07 수입 2500원')
library(stringr)
#조건1) 일자별 수입
str_extract(data2,"[0-9]{4}원")
#조건4) 모든 원소를 쉼표에 의해 하나의 문자열로 합치기
paste(data2,collapse = ",")

########################그래프 그리기
#
data(mpg)
library(ggplot2)
ggplot(data= mpg, aes(x=displ,y=hwy))
head(mpg,2)

library(dplyr)
distinct(mpg,fl) # 중복없이 종류


#배경에 산점도 추가 : +geom_point()
ggplot(data= mpg, aes(x=displ,y=hwy))+geom_point()

#x축 점우 3~6으로 지정 , y 축 범위 10~30으로 지정
ggplot(data= mpg, aes(x=displ,y=hwy))+geom_point() + xlim(3,6) + ylim(10,30)

#ggplot(data= 데이터, aes(x=displ, y=hwy))+
  # 그래프종류  : geom_point() +
  # x축범위 a부터 b 까지 :xlim(a,b) + 
  # y축 범위 a부터 b 까지  : ylim(a,b)

# qplot() : 전처리 단계 데이터 확인 용 문법 간단, 기능 단순
# ggplot() : 최종 보고용, 색, 크기 폰트 등 세부 조작가능

#
# QUIZ] mpg데이터와 midwest 데이터를 이용해서 분석문제를 해결
#1) mpg데이터의 cty 와 hwy 간에 어떤 관계가 있는지 알아보려고 합니다.
  #x 축은 cty, y축은 hwy로 된 산점도를 만들어 보세요

ggplot(data= mpg, aes(x=cty,y=hwy))+geom_point()

#2) 미국 지역별 인구통계 정보를 담은 ggplot2 패키지의 midwest 데이터를 이용해서 전체 인구와
  # 아시아인 인구간에 어떤 관계가 있는지 알아보려고 합니다. 
  # x축은 poptotal, y축은 popasian으로 된 산점도를 만들어 보세요.
  # 전체인구는 50만이하, 아시아인 인구는 1만 이하인 지역만 산점도 표시하시오

data(midwest)
ggplot(data= midwest, aes(x=poptotal,y=popasian))+geom_point()+
  xlim(0,500000)+ ylim(0.,1000)
options(scipen=99) # +쓰지말고 options(scipen=99) 넣어 같이 실행하면 축 단위 정수로 설정 
# options(scipen=0) 은 원래 범위대로 e와 함께 표현

#막대그래프 : 집단 간 차이 표현하기
  #bar chart : 데이터의 크기를 막대의 길이로 표현한 그래프

#집단간 평균표 만들기
df_mpg <- mpg %>% group_by(drv) %>% 
  summarise(mean_hwy = mean(hwy))
df_mpg
# A tibble: 3 x 2
# drv   mean_hwy
# <chr>    <dbl>
#   1 4         19.2
# 2 f         28.2
# 3 r         21  

#그래프 생성하기
ggplot(data = df_mpg, aes(x = drv, y= mean_hwy)) + geom_col()

ggplot(data = df_mpg, aes(x = reorder(drv, -mean_hwy),y= mean_hwy) ) + geom_col()

#geom_col() : 평균 막대 그래프 : 데이터를 요약한 평균표를 먼저 만든 후 
  # 평균표를 이용해 그래프 생성
#geom_bar() : 빈도 막대 그래프 : 별도로 표를 만들지 않고 원자료를 이용해 바로 
  # 그래프 생성

ggplot(data=mpg, aes(x=drv)) +geom_bar()
ggplot(data=mpg, aes(x=hwy)) +geom_bar()

#QUIZ]
# 어떤 회사에서 생산한 suv 차종의 연비가 높은지 알아보기
#suv 차종을 대상으로 평균 cty가 가장 높은 회사 다섯 곳을 막대 그래프로 표현
#막대는 연비가 높은 순으로 정렬하세요
head(mpg)
library(dplyr)

q_mpg<-mpg %>% 
  group_by(manufacturer) %>%
  filter(class=='suv') %>%
  summarise(mean_cty= mean(cty)  ) %>% 
  arrange(desc(mean_cty)) %>% 
  head(5)

q_mpg

ggplot(data=q_mpg, aes(x=reorder(manufacturer,-mean_cty),
       y=mean_cty)) + geom_col() #geom_col() : 평균막대그래프


####시계열 그래프 만들기 
economics
ggplot(data = economics, aes(x= date, y = unemploy)) + geom_line()

#QUIZ] economics 데이터를 이용하여 분석
ggplot(data = economics , aes(x = date, y= psavert)) + geom_line()



#
ggplot(mtcars, aes(x= factor(cyl)))+geom_bar(width=0.5)
ggplot(mtcars, aes(x= factor(cyl)))+geom_bar(aes(fill= factor(gear))) #누적막대그래프
ggplot(mtcars, aes(x= factor(cyl)))+geom_bar(aes(fill= factor(gear))) +coord_polar()


#꺽은선 그래프에 사선 그리기
ggplot(data = economics , aes(x = date, y= psavert)) + geom_line() +
  geom_abline(intercept = 12.18671, slope = -0.0005444)

