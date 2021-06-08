#2021.04.22

#데이터 불러오기
library(dplyr)  #rename()은 dplyr 있어야 사용가능

# 칼럼명 없는 파일 불러올 때 지정하는 방식 : header = F 설정
  # header =F : 가져오는 데이터에 칼럼명이 없다는 의미

re_name1 <- c("class","index","english","math")
# read.csv("data/no_mid_exam.csv", header = F,col.names = re_name1)
read.csv("data/no.csv", header = F,col.names = re_name1)


data_view<- read.csv("data/no.csv", header = F,col.names = re_name1)
View(data_view) # View(변수) 할 때 따옴표 쓰는거 아님!!!


#칼럼명이 있는 파일 불러올 때
read.csv("header.csv")

#칼럼명 있으나 이름을 변경하고 싶을때
re_name1<- c("lab1","lab2","lab3","lab4")
read.csv("header.csv",col.names = re_name1)


#-----------------------------------------
# TXT 파일 불러오기
getwd() #현재 디렉토리 확인
txt1<-readLines("data/data2/구매후기.txt") #readLine 은 L대문자임!
txt1
# [1] "가격은 저렴한데 배송이 느려요."         
# [2] "가격은 맘에 드는데 디자인이 노티나네요."
# [3] "색상이 촌스럽지만 가격이 싸서 샀어요."  
# [4] "배송이 진짜 너무 느리네요"   

txt2 <- readLines("data/data2/구매후기_utf8.txt")  #encoding="UTF-8"
txt2 
# [1] "癤욧<b0>\u0080寃⑹<9d>\u0080 <ec><a0>\u0080<eb>졃<ed>븳<eb>뜲 諛곗넚<ec>씠 <eb>뒓<eb>젮<ec>슂."           
# [2] "媛\u0080寃⑹<9d>\u0080 留섏뿉 <eb>뱶<eb>뒗<eb>뜲 <eb>뵒<ec>옄<ec>씤<ec>씠 <eb>끂<ed>떚<eb>굹<eb>꽕<ec>슂."
# [3] "<ec>깋<ec>긽<ec>씠 珥뚯뒪<eb>읇吏\u0080留<8c> 媛\u0080寃⑹씠 <ec>떥<ec>꽌 <ec><83>\u0080<ec>뼱<ec>슂."    
# [4] "諛곗넚<ec>씠 吏꾩쭨 <eb>꼫臾<b4> <eb>뒓由щ꽕<ec>슂"

# UTF8로 인코딩 된것 글씨깨짐 -> SOL2
# SOL1) ANSI로 TXT파일 저장하면 글씨가 안깨진다.
# SOL2) "encoding="UTF-8" 읽을 때 써주기
txt2 <- readLines("data/data2/구매후기_utf8.txt",encoding="UTF-8")
txt2
# #[1] "가격은 저렴한데 배송이 느려요."         
# [2] "가격은 맘에 드는데 디자인이 노티나네요."
# [3] "색상이 촌스럽지만 가격이 싸서 샀어요."  
# [4] "배송이 진짜 너무 느리네요"        
 
########################이부분 뒷부분에도 나오므로 생략
txt4 <- read.table("data/data2/전공.txt",header= T)
txt4
View(txt4) # 필드명 잘 분리되어 있음 

# :로 구분되어 있는 데이터를 불러오기
txt6 <- read.table("data/data2/전공2.txt", header=T, sep="")
txt6
View(txt6) # :를 기준으로 분리하지 못하고 잘 분리되어있지 않음

# 구분자 분리 지정 : sep="구분자" 해주어야 정상적으로 분리함
txt6 <- read.table("data/data2/전공2.txt", header=T, sep=":")
txt6
View(txt6)
#########################

#조건설정 데이터 추출  
    # 데이터명[ 데이터명$칼럼명을이용한 조건식 ]
    # subset( 데이터명, 칼럼명을이용한 조건식 )
    # filter( 데이터명, 칼럼명을이용한 조건식 )

data(iris)
df.1 <- iris[iris$Species == "setosa", ] ; head(df.1,3)
df.2 <- subset(iris, Species=="setosa") ; head(df.2,3)
library(dplyr)
df.3<- filter(iris,Species == "setosa") ; head(df.3,3)
#df.1 과 df.2와 df.3은 모두 같은결과가 나옴
#    Sepal.Length Sepal.Width Petal.Length Petal.Width Species
# 1          5.1         3.5          1.4         0.2  setosa
# 2          4.9         3.0          1.4         0.2  setosa
# 3          4.7         3.2          1.3         0.2  setosa


#------------------------------------------
#데이터 가져오기 : read.table() 속성 설정
ex_data <- read.table("data/data_ex.txt")
View(ex_data)


#헤더 유무 차이
read.table("data/data_ex.txt", header=T)
read.table("data/data_ex.txt", header=F)
read.table("data/data_ex.txt")

#특정행 부터 : skip=
read.table("data/data_ex.txt",header=T, skip=3)
read.table("data/data_ex.txt",header=F, skip=3)

#특정행 까지 : nrows=
read.table("data/data_ex.txt",header=T, nrows=7) # 가져올 행 개수 지정 
#skip안쓰면 처음부터 7행

read.table("data/data_ex.txt",header=F, skip=3, nrows=7) #3부터 7개의 행가져오기



#데이터 구분자지정 : sep = 

txt4 <- read.table("data/data2/전공.txt",header= T) 
txt4
View(txt4) # 필드명 잘 분리되어 있음 

# :로 구분되어 있는 데이터를 불러오기
# txt6 <- read.table("data/data2/전공2.txt", header=T, sep="")
txt6 <- read.table("data/data2/전공2.txt", header=T)
txt6
View(txt6) # :를 기준으로 분리하지 못하고 잘 분리되어있지 않음

# 구분자 분리 지정 : sep="구분자" 해주어야 정상적으로 분리함
txt6 <- read.table("data/data2/전공2.txt", header=T, sep=":")
txt6
View(txt6)


#----------------------------------------------------------------

# 조건문
exdata1
exdata1$AVG_AMT <- exdata1$AMT / exdata1$CNT
exdata1$AGE50_YN <- ifelse(exdata1$AGE>=50,"Y","N")
View(exdata1)

exdata1$AVG_GR10 <- ifelse(exdata1$AGE >= 50, "A1,50++",
                           ifelse(exdata1$AGE >= 40, "A2,4049",
                                  ifelse(exdata1$AGE >= 30, "A1,3039",
                                         ifelse(exdata1$AGE >= 20, "A1,2029",
                                                "A5,0019"))))
View(exdata1)                  

#데이터 프레임 생성하기

var1 <- c(4,3,8)
var2 <- c(2,6,1)

df <- data.frame(var1, var2)
df

#파생변수 생성 _var_sum 와 var_mean
df$var_sum <- df$var1 + df$var2
df
df$var_mean <- df$var_sum /2
df

#var_mean 3이상이면 A 그렇지 않으면 B 부여 변수 var_con
var_con <- ifelse(df$var_mean >= 3,'A','B')
var_con #"A" "A" "A"
#var_mean 5이상이면 A,4이상이면 B,3이상이면 C 그렇지 않으면 D 부여 변수 var_con
var_con <- ifelse(df$var_mean >= 5,'A',
                  ifelse(df$var_mean >= 4,'B',
                         ifelse(df$var_mean >= 3,'C',
                                'D' )))
var_con  # "C" "B" "B"


# 기초통계량 확인
summary(tot_compact)
summary(tot_suv)
par(mfrow=c(1,2))  # 그래프 비교하려고 화면 나눔
hist(tot_compact)
hist(tot_suv)

# %>%  : ctrl+ shift + m
#QUIZ] CON 변수를 생성하여 TOTAL(=(co_mpg$cty+co_mpg$hwy)/2) 25 이상이고 
                    #cty가 20이상이면 우수, 나머지는 일반

co_mpg$con <- ifelse ((co_mpg$cty+co_mpg$hwy)/2>=25&co_mpg$cty>=20,"우수","일반")
co_mpg



#QUIZ] manufacturer, trans, drv, cty, hwy, class, total, con 열만가져와서 sep_mpg로
#저장하고 sep_mpg,csv파일로 저장하시오
co_mpg$total<-(co_mpg$cty+co_mpg$hwy)/2
View(co_mpg)

sep_mpg <- co_mpg[,c(1,6:9,11:13)]
head(sep_mpg,2)
write.csv(sep_mpg,"data/sep_mpg.csv", row.names=F)

#table()함수 : '집계' 임 -> 데이터를상태를 집계해서 알려줌
# con에 '일반'과 '우수'의 개수를 알고싶음
table(co_mpg$con)
#우수 일반 
#43  191 


library(ggplot2)   # qplot은 ggplot2 패키지 안에 존재함
qplot(co_mpg$con)
dev.new() # 새창 띄우기, 이후에 보고싶은것 불러오면됨
qplot(co_mpg$con)

# 데이터 값 바꾸기
head(sep_mpg,2)

sep_mpg[2,2] <- "auto(90)"
head(sep_mpg,2)

sep_mpg[1,6] <- "suv"
head(sep_mpg,2)

#결측치 정체

# 결측치 = 누락된 값, 비어있는 값
  #함수 적용불가, 분석결과 왜곡-> 제거후 분석 실시해야함

# 결측치 만들기
df <- data.frame(sex= c("M","F",NA,"M","F"),
                 score= c(5,4,3,4,NA)) ; df

is.na(df) # logic으로 반환함
#      sex score
# [1,] FALSE FALSE
# [2,] FALSE FALSE
# [3,]  TRUE FALSE
# [4,] FALSE FALSE
# [5,] FALSE  TRUE

table(is.na(df$sex)) #table() 은 집계정보를 알려주는 함수
#FALSE  TRUE 
# 4     1 

df[3,1] <- "M" ; df # NA를 M으로 값 바꿈 
#  sex score
# 1   M     5
# 2   F     4
# 3   M     3
# 4   M     4
# 5   F    NA

df[3,1] <- NA ; df
#   sex score
# 1    M     5
# 2    F     4
# 3 <NA>     3
# 4    M     4
# 5    F    NA

#결측치 포함된 데이터 분석
mean(df$score) #NA  #; 결측치 있으므로 NA뜸
mean(df$score, na.rm = T) #4  # na.rm=T 통해 결측치를 제거하고 계산해야함


# 결측치가 있는 행 제거하기
# install.packages('dplyr')
library(dplyr)
#  %>% 은 dplyr에 존재하므로 파이프 연산자 쓰려면 불러와야함.

# 데이터프레임명 %>%  filter(조건)
#-파이프 연산자 이용시
df %>% filter(is.na(score)) #score에 결측치 있는 행 가져와
#  sex score
#1   F    NA
#-파이프 연산자 이용x시 : filter(데이터 프레임명, 조건)
filter(df,is.na(score))
#  sex score
#1   F    NA

df %>%  filter( !is.na(score)) #score에 결측치 없는 행만 가져와
#   sex score
# 1    M     5
# 2    F     4
# 3 <NA>     3
# 4    M     4

df_nomiss <- df %>% filter(!is.na(score))
df_nomiss
#   sex score
# 1    M     5
# 2    F     4
# 3 <NA>     3
# 4    M     4

#결측치 제외

#case1)  데이터프레임명 %>%  filter(조건) 이용
df_nomiss <- df %>%  filter(!is.na(score) & !is.na(sex))
df_nomiss
# sex score
#1   M     5
#2   F     4
#3   M     4

#case2) na.omit(데이터프레임명) 이용
df_nomiss2 <- na.omit(df)
df_nomiss2
#  sex score
# 1   M     5
# 2   F     4
# 4   M     4


#데이터 추출#
# %>% 연산자 이용하려면 dplyr 설치해야함

#dplyr 패키지 주요함수 : 주로 파이프 연산자 %>%  와 함께 사용
# select() : 원하는 데이터의 변수 선택 (열 데이터)
# filter() : 조건에 맞는 데이터 추출 (행 데이터)
# arrange() : 지정열 기준 정렬 _ 기본값: 오름차순, arrange(desc()) :내림차순
# mutate() : 열 추가 (파생변수 생성)
# summarize() : 데이터 요약
# %>% : 파이프 연산자(중첩연산자) : ctrl + shift + m
# sample_n() : n개의 샘플 추출
# group_by() : edlxjrmfnq todtjd
# distinct() : 중복값 제거 
# 파이프 연산자를 이용하면 함수들을 중첩해서 사용할 수 있음

exdata1 %>% select(ID)  # ID변수만 추출 
# == select(exdata1, ID)

exdata1 %>% select(ID,AREA,Y17_CNT) #ID,AREA,Y17_CNT 변수 추출

exdata1 %>% select(-AREA) #AREA 제외하고 추출
exdata1 %>% select(-AREA,-Y17_CNT) #AREA,Y17_CNT 제외하고 추출

exdata1 %>% filter(AREA =="서울") #서울인 값 
exdata1 %>% filter(AREA =="서울" &Y17_CNT >=10 )

#데이터 정렬
exdata1 %>% arrange(AGE) #AGE 변수 오름차순 정렬
exdata1 %>% arrange(desc(Y17_AMT)) # Y17_AMT변수 내림차순 정렬

exdata1 %>% arrange(AGE,desc(Y17_AMT)) # 중첩정렬



