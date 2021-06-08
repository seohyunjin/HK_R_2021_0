
#변수변환 : as.자료형
A<-c(1,2,5,"10") ; A # "1"  "2"  "5"  "10" # 다문자형으로 바뀜
class(A) #"character"
as.numeric(A) # 1  2  5 10 #문자를 숫자로 바꿈
class(A) #"character"
A # "1"  "2"  "5"  "10" # 위에서 대입해서 업데이트 안해서 그래로임
A= as.numeric(A); A #1  2  5 10
as.character(A) #"1"  "2"  "5"  "10"
rm(A)



#변수제거 : rm( )
ls()  # 변수목록을 보여줌
rm(list = ls()) #변수목록에 있는 리스트 다지우기


#시각화 패키지 가져오기
remove.packages("")
install.packages("ggplot2")
library(ggplot2)
search() #설치된 패키지 확인
# [1] ".GlobalEnv"        "package:ggplot2"   "tools:rstudio"     "package:stats"     "package:graphics"  "package:grDevices"
# [7] "package:utils"     "package:datasets"  "package:methods"   "Autoloads"         "package:base"   
dir() # 파일명이 뜸

getwd() #현재디렉토리 확인 
#"C:/Users/CPB06GameN/Documents/practice1_0419/hankyungr"
setwd('c://Users') #디렉토리 변경 ##역슬러시 하나면 에러남무조건2개 써야함!
getwd() #"c:/Users"
setwd('C:/Users/CPB06GameN/Documents/practice1_0419/hankyungr')
getwd() # "C:/Users/CPB06GameN/Documents/practice1_0419/hankyungr"

.libPaths() #"C:/Users/CPB06GameN/Documents/R/win-library/4.0" "C:/Program Files/R/R-4.0.2/library"

# 산점도 그래프 그리기 plot
b<-seq(3,10,by=2)
b # 3 5 7 9
plot(b)

#벡터 반복 : rep(데이터, times=반복횟수)

rep(c("A","B","C"),times=2) #한바퀴(기본 순회)
#"A" "B" "C" "A" "B" "C"

# 각각 반복시키기
rep(c("A","B","C"),each=3)  #  각각 3번씩 반복 
#"A" "A" "A" "B" "B" "B" "C" "C" "C"


#벡터추출
var1<-c("새우깡","감자깡","고구마쌍","맛동산")
var1 #"새우깡"   "감자깡"   "고구마쌍" "맛동산"  
var1[-1] #"감자깡"   "고구마쌍" "맛동산"  
var1[-2:-4] #"새우깡" # 2번째부터 네번째 값까지 뺴주기

#기초통계 분석함수 
v<-c(70,80,65,80)
sum(v)  # 295 #합계
mean(v) #73.75 #평균
median(v)# 75 #중앙값
sd(v) # 7.5 # 표준편차
var(v) # 56.25 # 분산

quantile(v) #분위수
kurtosi(v) #첨도
skew(v) #왜도

summary(v) # 기초통계
# Min. 1st Q.  Median    Mean 3rd Qu.    Max. 
# 65.00   68.75   75.00   73.75   80.00   80.00

boxplot(v)# 상자그림

v1<-c(70,80,65,80,NA) # 결측치는 대문자로 작성
sum(v1) # NA # 결측값이 하나라도 존재하면 기초통계값 구할 수 없음
sum(v1,na.rm=T) #295 # na.rm= T 는 결측값을 제외하라는 의미
mean(v1,na.rm=T) #73.75

#QUIZ] 1에서 10까지 중복되는 데이터를 임의로 5개 추출
day1<-sample(1:10,5,replace=T)
day1 #3 3 7 7 8
sort(day1) #데이터 정렬 : sort() : 오름차순이 디폴트임 #3 3 7 7 8
sort(day1, decreasing = T) #내림차순 #8 7 7 3 3


#위치값 : which
day1
which(day1<=6) # 1 2 ;값이 아니라 (위치값) 나옴
# R의 인덱스 번호는 1부터! 0부터 아님!!
day1[which(day1<=6) ] # 위치에 존재하는 값 #3 3

which.max(day1) #5 :max값 가지는 위치가 나옴
which.min(day1) #1 :min값 가지는 위치가 나옴


#데이터 프레임 만들기
name <- c("김지훈","이유진","박동현","김민지")
eng <- c(90,80,60,70)
math <- c(50,60,100,20)
table <- data.frame(name,eng,math)
table
str(table)
#'data.frame':	4 obs. of  3 variables:
# $ name: chr  "김지훈" "이유진" "박동현" "김민지"
# $ eng : num  90 80 60 70
# $ math: num  50 60 100 20
table


# $을 이용하려 열데이터를 불러올 수 있다.
table$name # "김지훈" "이유진" "박동현" "김민지" #table의 name열 확인
table$eng #90 80 60 70  # table의 eng열의 값을 다 불러오기

table
#    name eng math
#1 김지훈  90   50
#2 이유진  80   60
#3 박동현  60  100
#4 김민지  70   20


str(table)
#'data.frame':	4 obs. of  3 variables:
#$ name: chr  "김지훈" "이유진" "박동현" "김민지"
#$ eng : num  90 80 60 70
#$ math: num  50 60 100 20
 
 

#엑셀불러오기
install.packages("readxl") # 엑셀파일은 readxl 라이브러리 설치해야함
library(readxl)

excel_ex1 <-read_excel("c:/pg/data/1.xlsx")
excel_ex1

excel_ex2 <-read_excel("c:/pg/data/1.xlsx",sheet=2)
excel_ex2
# csv파일은 sheet를 여러개로 할 수 없으며 xlsx파일로 만들어 sheet 지정해주어야함

excel_ex3 <-read_excel("c:/pg/data/1.xlsx",sheet=3)
excel_ex3


# 행렬생성하기 matrix(데이터,nrow=행갯수,ncol=열갯수) #세로축(열)먼저 채워짐

x<- c(1,2,3,4,5,6)
matrix(x,nrow=2,ncol=3) 
matrix(x,nrow=3,ncol=2)

m1<-matrix(x,nrow=3,ncol=2)
m1[1,] #1 4  
m1[,2] #4 5 6
m1[1,2] #4

#행렬에 데이터 채우는 순서 바꾸기 (열기준이 기본값)
matrix(x,nrow=3,ncol=2,byrow=3) #가로축 먼저 데이터 채우기


#배열 생성하기 : array (변수명, dim=c(행수, 열수, 차원 수) )
y <- c(1,2,3,4,5,6)
array(y,dim=c(2,2,3)) #2행 2열 3차원 배열 생성

list1 <- list(c(10,20,60),"Hello")
list1[[1]] # 10 20 60
list1[[1]][3] # 60
list1[[2]][2] #NA : 존재하지 않으므로 NA나옴
list1[[2]] #"Hello" 


a<-1:10
b<-matrix(a,ncol=2)
b
#    [,1] [,2]
# [1,]    1    6
# [2,]    2    7
# [3,]    3    8
# [4,]    4    9
# [5,]    5   10
# > 
c<-data.frame(a,b=11:20)
d<-list(a,b,c)
d

#QUIZ] 데이터 세트 만들기
id<-c(1,2,3,4,5)
mid_exam<-c(10,25,100,75,30)
class<-c('1','2','3','1','2')
example_text<-data.frame(id,mid_exam,class)
example_text

df_midterm1 <- data.frame(english = c(90,80,60,70),
                          math1 = c(50,60,100,20),
                          class1 = c(1,1,2,2) )
df_midterm1
#  english math1 class1
# 1      90    50      1
# 2      80    60      1
# 3      60   100      2
# 4      70    20      2


# 특정 행/열 더하기 : apply()
apply(df_midterm1,1,sum) # 행  # 141 141 162  92
apply(df_midterm1,2,sum) # 열
# english   math1  class1 
# 300     230       6

#기준열을 통한 합산 : aggregate(더하고싶은열~합치는기준,data=데이터,sum)
aggregate(math1~class1, data= df_midterm1,sum)
  #  class1 math1
  #1      1   110
  #2      2   120
aggregate(english~class1, data= df_midterm1,mean)
  #   class1 math1
  # 1      1   110
  # 2      2   120
aggregate(.~class1, data= df_midterm1,mean) #학급별 전화목 평균 .은all의미
  #    class1 english math1
  # 1      1      85    55
  # 2      2      65    60


#정규확률 분포로부터 임의의 수를 추출하는 함수 : rnorm()
rnorm(100,80,5) #평균이 80이고 표준편차5인 정규확률 분포에서 100개 랜덤추출
round(rnorm(100,80,5))  #round() : 소수점 아래 숫자 안보이게 (반올림)

rnorm_DB <-round(rnorm(100,80,5),0) # 0은 소수점 뒤의 숫자 개수를 의미 설정
rnorm_DB 
getwd()
write.csv(rnorm_DB,"rnorm_DB.csv") #왼쪽열에 인덱스와 함께 값이 두번째 열에 나옴

write.csv(rnorm_DB,"rnorm_DB.csv", row.names = F) # names열, 인덱스 적혀있던 열이 사라짐



#데이터병합

k1 <- c(5, 40, 50:52) ; k1  #5 40 50 51 52
k2 <- c(30,5,6:8) ; k2 #30  5  6  7  8
mc <- cbind(k1,k2)
mc  # 열 기준으로 병합
#k1 k2
# [1,]  5 30
# [2,] 40  5
# [3,] 50  6
# [4,] 51  7
# [5,] 52  8

mr <- rbind(k1,k2) # 행기준으로 병합
mr
# [,1] [,2] [,3] [,4] [,5]
# k1    5   40   50   51   52
# k2   30    5    6    7    8


#펙터생성
fe_test<-c("G","B","I")
str(fe_test) #chr [1:3] "G" "B" "I" #:문자형임
fe.factor<-factor(fe_test) #펙터로 만들어서 fe.factor에 저장
fe.factor
 # [1] G B I
 # Levels: B G I  #현재 레벨도 같이보여줌
str(fe.factor) #속성파악 # Factor w/ 3 levels "B","G","I": 2 1 3 #펙터임

a<- factor(fe.factor,levels = c('B','I','G')) # 레벨을 강제 지정해서 factor생성
a
# G B I
# Levels: B I G

str(a) #Factor w/ 3 levels "B","I","G": 3 1 2


is.factor(fe.factor) # 펙터인지 체크 #TRUE
as.numeric(fe.factor) # 강제로 숫자로 변환  # 2 1 3
as.character(fe.factor) # 강제로 문자로 변환 # "G" "B" "I"


#
iris
data(iris)
head(iris)

install.packages("dplyr")
library(dplyr)
