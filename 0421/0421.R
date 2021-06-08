rm(list=ls()) #Environment에 있는 저장된 변수기록 지우기

#그래프그리기
# 평균 75 편차3인 정규분포에서 50개 추출한 데이터
rnorm_3<-rnorm(50,75,3)

# 평균75 편차 15인 정규분포에서 50개 추출한 데이터
rnorm_15<-rnorm(50,75,15)

plot(rnorm_3)  #산점도
hist(rnorm_3)  #히스토 그램

plot(rnorm_15)
hist(rnorm_15)


#그래프비교위해 화면나누기 : par( mfrow = c(행의 수, 열의 수) ) #다중그래프 보이기
par(mfrow=c(1,2)) #(1,2)이므로 가로한줄 두개 존재
hist(rnorm_3)
hist(rnorm_15)

par(mfrow=c(2,2)) #(2,2)이므로 가로두줄 두개씩 총4그래프 존재
hist(rnorm_3)
hist(rnorm_15)
plot(rnorm_3)
plot(rnorm_15) 


#비교연산자
# 이상: >= 초과 > 이하 <= 미만 < 같지않다!=  cf) 엑셀에서의 <>


#데이터(csv파일) 불러와서 저장하기
getwd() # 현재 디렉토리 확인
exam <- read.csv("data/csv_exam.csv")  #상대경로 형식
# 절대경로 형식 c:/pg/data/csv_exam.csv 에도 또 저장해둠
exam


#테이블에서의 데이터추출 : 테이블명[행위치,열위치]

# 위치지정 데이터 추출
exam[1,] # 1행 추출 
#  id class math english science
#1  1     1   50      98      50
exam[2,] #2행 추출
# id class math english science
# 2  2     1   60      97      60
exam[,1] # 첫번째 열은 인덱스 값임
exam[,2] #exam$class열이 두번째 위치임으로 해당열에 존재하는 데이터가 모두나옴

#조건을 충족하는 행 추출하기
exam[exam$class ==1, ] #class가 1인 행 추출
# id class math english science
# 1  1     1   50      98      50
# 2  2     1   60      97      60
# 3  3     1   45      86      78
# 4  4     1   30      98      58

exam[exam$math >= 80, ] #수학점수가 80점이상인 행 추출
# id class math english science
# 7   7     2   80      90      45
# 8   8     2   90      78      25
# 18 18     5   80      78      90
# 19 19     5   89      68      87


#논리연산자 : and & or | => 결과값이 논리형으로 나옴(TRUE,FALSE)

#논리연산자 이용한 조건부 TABLE 데이터 추출
# 1반이면서 수학점수가 50점 이상
exam[exam$class==1 & exam$math >= 50, ] 
# id class math english science
# 1  1     1   50      98      50
# 2  2     1   60      97      60

#영어점수가 90점 미만이거나 과학점수가 50점 미만
exam[exam$english<90 | exam$science<50, ] 
# id class math english science
# 3   3     1   45      86      78
# 5   5     2   25      80      65
# 6   6     2   50      89      98
# 7   7     2   80      90      45
# 8   8     2   90      78      25
# 9   9     3   20      98      15
# 10 10     3   50      98      45
# 11 11     3   65      65      65
# 12 12     3   45      85      32
# 14 14     4   48      87      12
# 15 15     4   75      56      78
# 17 17     5   65      68      98
# 18 18     5   80      78      90
# 19 19     5   89      68      87
# 20 20     5   78      83      58


# QUIZ] 데이터 프레임과 c함수를 조합하여 표의 내용을 데이터 프레임으로 출력해보세요
price<-c(1800,1500,3000)
volume<-c(24,38,13)
fruit<-c("사과","딸기","수박")
sales <- data.frame(fruit,price,volume)
sales
#  fruit price volume
# 1  사과  1800     24
# 2  딸기  1500     38
# 3  수박  3000     13

#case2) 사전 정의 하지않고 한번에 만들 수 있는데 이때 <-할당 연산자x,  = 이용
data.frame(fruit=c("사과","딸기","수박"),
           price=c(1800,1500,3000) ,
           volum=c(24,38,13) )
#   fruit price volume
# 1  사과  1800     24
# 2  딸기  1500     38
# 3  수박  3000     13


#QUIZ] 앞에서 만든 데이터 프레임을 이용하여 과일 가격 평균, 판매량 평균 구하기
mean(sales$price) #2100
mean(sales$volume) #25


# A %in% B : 인수A가 집단B에 있는가? 
var5 <-c(1,3,5,7,9)  
10 %in% var5 #FALSE
7 %in% var5 #TRUE


# 문자 합치기 : paste()
c(1,2,3,4) # 1 2 3 4  ;숫자임
paste(1,2,3,4) # "1 2 3 4"  ; 문자임
paste(1,2,3,4, sep='') #"1234"
paste(1,2,3,4, sep='-') #-로 구분하기 #"1-2-3-4"

paste('function','in','r', sep='    ')  # 공백띄우기
#"function    in    r"

paste('c1','c2','c3','c4','c5','c6','c7','c8','c9','c10',sep='') 
# "c1 c2 c3 c4 c5 c6 c7 c8 c9 c10"
paste('c1','c2','c3','c4','c5','c6','c7','c8','c9','c10') #sep= 안쓰면, 디폴트 :띄어쓰기 하나
# "c1c2c3c4c5c6c7c8c9c10"

paste('c',1:10)
# "c 1"  "c 2"  "c 3"  "c 4"  "c 5"  "c 6"  "c 7"  "c 8"  "c 9"  "c 10"

paste('c',1:10,sep='')
# "c1"  "c2"  "c3"  "c4"  "c5"  "c6"  "c7"  "c8"  "c9"  "c10"

paste0('c',1:10) #c와 숫자사이 공백을 없애주고 싶을때 case2
#"c1"  "c2"  "c3"  "c4"  "c5"  "c6"  "c7"  "c8"  "c9"  "c10"


#QUIZ] A1~ A3인, B1~3, C1~3 인 자료를 만들어라
paste("A",1:3,sep='') #"A1" "A2" "A3"
paste("B",1:3,sep='') #"B1" "B2" "B3"
paste("C",1:3,sep='') #"C1" "C2" "C3"

paste("A","B","C",1:3,sep='') #"ABC1" "ABC2" "ABC3" # paste앞에 첫번째 인수는 한번에 묶더라

c(paste("A",1:3,sep=''),paste("B",1:3,sep=''),paste("C",1:3,sep='') )
# "A1" "A2" "A3" "B1" "B2" "B3" "C1" "C2" "C3"



#리스트 만들기 : 리스트는 길이 상관x
a<-c(1:3) # 1 2 3
b<-c(1:4) # 1 2 3 4
a
b
c<-data.frame(a,b) ;c  # 에러 발생 : 원소의 길이가 다르기 때문
d<-list(a,b); d  #리스트는 길이 상관없이 생성가능
# [[1]]
# [1] 1 2 3
# 
# [[2]]
# [1] 1 2 3 4

#리스트만들기 : 리스트는 길이 인수형태상관x
a <- 1:3
b <- "a string"
c <- pi
d <- list(-1,-5)

ken <- data.frame(a,b,c,d) ; ken # 이렇게 하면 안됨 데이터프레임은 길이를 맞춰주어야함
# 값이 나오긴 나오나 안좋음

ken_list <- list( 
  a = 1:3 ,
  b = "a string" ,
  c = pi ,
  d = list(-1,-5)
  )
ken_list
# $a   ##$는 리스트 값이므로!
# [1] 1 2 3
# 
# $b
# [1] "a string"
# 
# $c
# [1] 3.141593
# 
# $d
# $d[[1]]
# [1] -1
# 
# $d[[2]]
# [1] -5

# 리스트 원소 불러오기
ken_list[[1]][3] #3
ken_list[[1]] #1 2 3
ken_list[[2]] #"a string"
ken_list[[3]] #3.141593


# 행렬 matrix 생성 : matrix(데이터,행수,열수)
# matrix(data= 벡터, nrow=행개수, ncol=열개수, byrow=TRUE)
# 회귀분석,상관관계분석할때는 matrix 행렬 생성시 (data=)option명을 꼭 써주어야한다
# 행렬에 데이터 추가&결합 -> rbind(벡터들) , cbing(벡터들)
# dim() : 몇차원(몇행 몇열)인지 확인 , nrow(행렬), ncol(행렬)
# colnames() rownames() rowSums() colSums() rowMeans() colMeans()


mt <- matrix(1:6,2,3)
mt
# #  [,1] [,2] [,3]
# [1,]    1    3    5
# [2,]    2    4    6

mt+3
# [,1] [,2] [,3]
# [1,]    4    6    8
# [2,]    5    7    9

rowSums(mt) # 행원소끼리의 합  #9 12 #==apply(mt,1,sum)
colSums(mt) # 열원소끼리의 합 #3  7 11 #==apply(mt,2,sum)
rowMeans(mt) # 행원소끼리의 평균 #3 4  #==apply(mt,1,mean)
colMeans(mt) # 열원소끼리의 평균 # 1.5 3.5 5.5 #==apply(mt,2,mean)

#암기 tip ) 열기준 / cbing / apply 2 - 열심히

# apply()함수 apply(데이터, 행계산은1 열계산은2, 연산함수)
apply(mt,1,mean) #행끼리 평균  # 3 4
apply(mt,2,mean) #열끼리 평균 # 1.5 3.5 5.5
apply(mt,1,sum) #행끼리 합 #9 12
apply(mt,2,sum) #열끼리 합 # 3  7 11


mt
#     [,1] [,2] [,3]
# [1,]    1    3    5
# [2,]    2    4    6
t(mt)  #행과 열을 바꾸는 함수 : t()  transpose
# [,1] [,2]
# [1,]    1    2
# [2,]    3    4
# [3,]    5    6

dim(mt) #matrix행렬의 차원 #2 3

y<- c(1:6)
array(y, dim=c(2,2,3))  #2행 2열 3차원3개 배열만듬
#, , 1
# 
# [,1] [,2]
# [1,]    1    3
# [2,]    2    4
# 
# , , 2
# 
# [,1] [,2]
# [1,]    5    1
# [2,]    6    2
# 
# , , 3
# 
# [,1] [,2]
# [1,]    3    5
# [2,]    4    6


#내장 데이터 세트 iris 
??iris  #앞에 물음표 2개 붙이면 help창으로 내장데이터 설명을 볼 수 있음
.libPaths() #경로 구하기
#[1] "C:/Users/CPB06GameN/Documents/R/win-library/4.0"
#[2] "C:/Program Files/R/R-4.0.2/library"  # 즉 여기에 iris 데이터가 존재 

iris #그냥 쳤는데 데이터 안불러와지는 경우 강제 불러오기 2가지방법
data("iris") 
attach(iris) #attach한 후 필요없으면 dettach(iris) 하면됨

#아이리스 데이터 살펴보기
my_iris <- iris
head(my_iris) # 맨앞 여섯개만 추출 # 6이 디폴트임
head(my_iris,3) # 맨앞 3개만 추출함 # 맨앞 head()
tail(my_iris,3) # 맨뒤 3개 추출함 # 맨뒤 tail()
dim(my_iris) #150   5 #너무커서 경고와 같이 나옴
nrow(my_iris) #150  #열 개수
ls(my_iris)  #변수목록확인하기 : ls()
#"Petal.Length" "Petal.Width"  "Sepal.Length" "Sepal.Width"  "Species"  

my_iris <-my_iris[,1:4] ; my_iris
apply(my_iris,2,mean) 
# #Sepal.Length  Sepal.Width Petal.Length  Petal.Width 
# 5.843333     3.057333     3.758000     1.199333 
apply(my_iris,2,sum)
# Sepal.Length  Sepal.Width Petal.Length  Petal.Width 
# 876.5        458.6        563.7        179.9

lapply(my_iris,mean) #리스트 형태의 apply 
#lapply(리스트로 가져올 데이터, 리스트로가져올 형태)
# $Sepal.Length
# [1] 5.843333
# 
# $Sepal.Width
# [1] 3.057333
# 
# $Petal.Length
# [1] 3.758
# 
# $Petal.Width
# [1] 1.199333

View(my_iris) #데이터 엑셀처럼 보고싶을때 *맨앞 대문자 주의

#엑셀 데이터 불러와서 데이터보기
library(readxl)
exdata1<-read_excel("data/1.xlsx")
exdata1
View(exdata1)
str(exdata1)
dim(exdata1)
is(exdata1)

#엑셀데이터는 read_excel로 불러오고 csv파일은 read.csv 로 불러와야함!

library(readxl)
exdata1 <- read_excel("'data/Sample1.xlsx" )

#새로운 파생변수 생성
install.packages("dplyr") # rename()함수는 dplyr 패키지 안에 들어있으므로 패키지 설치해야함
library(dplyr)
exdata1
exdata1 <- rename(exdata1, Y17_AMT= AMT17, Y16_AMT=AMT16) # 변수명 바꿈
#변수명변경 rename(데이터세트, 새변수명 = 기존변수명) # 구버전을 신버전으로 바꿈


exdata1$AMT <- exdata1$Y17_AMT +exdata1$Y16_AMT #새로운 파생변수 생성
exdata1$CNT <- exdata1$Y17_CNT + exdata1$Y16_CNT #새로운 파생변수 생성
View(exdata1)


