#연습문제 90p
#1) 
Vec1 <- rep('r',5) ; Vec1
Vec2 <- seq(1,10,by=3) ; Vec2
Vec3 <- rep(Vec2,3)  ; Vec3
Vec4 <- c(Vec2,Vec3); Vec4
Vec6 <- seq(25,15,by=-5) ; Vec6

Vec5 <- c(Vec4[1],Vec4[3],Vec4[5],Vec4[7],Vec4[9],Vec4[11],Vec4[13],Vec4[15]) ; Vec5
#== Vec5 <-Vec4[seq(1,16,by=2)] 동일한 결과
Vec5 <-Vec4[seq(1,16,by=2)] ; Vec5

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
# name     age  gender job      sat grade total 
# [1,] "유관순" "45" "2"    "주부"   "4" "c"   "28.5"
# [2,] "김유신" "53" "1"    "직장인" "5" "d"   NA  

#
user2 <-user[seq(2,4,2)] ; user2  #"유관순" "김유신"

#3)
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
apply(df3[,c(1:3)],1,max) # 90 92 90
#apply(df3[c(1:3),],1,max)
# 1  2  3 
#90 92 90 

#조건3)
#열방향
round( apply(df3[,c(1:3)],2,mean) , 2)
#  kor   eng   mat 
#88.33 76.67 88.67 

##랜덤값 고정
## set.seed(1) #set.seed() 같이 사용하면 다음 랜덤값이 같이 저장된다
## Vec1<-round(rnorm(100,80,5), 2) ; Vec1

round(apply( df3,2, mean),2)  #위와 같은 결과 
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
