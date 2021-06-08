
#----
data(iris)
names(iris) # 항목명 나옴
tolower(names(iris))  # 항목명이 다 소문자로 바뀜

Cas_iris <- tolower(names(iris))
Cas_iris

#rename() 변수명을 변경하는 함수 :  단 dplyr 패키지를 로드
table(iris$Species) # 집계를 확인




rm(list=ls()) # 저장된 변수목록 삭제

#print()는 출력뒤 자동줄바꿈이 일어남
print(100) #100
print(pi) #3.141593
data<-c('딸기','사과','포도') 
print(data) #"딸기" "사과" "포도"
print(data,quote=FALSE) #""따옴표 없애기 #딸기 사과 포도
print(data, print.gap=3, quote=FALSE) # gap : 데이터 사이의 공간 생성 
#   딸기   사과   포도



#cat()은 출력하고 행을 바꾸지 않음 강제줄바꿈코드'\n'
cat(100) #100
cat(100,200) 
1+1
#> cat(100,200) #100 200
# 100 200> 1+1
# [1] 2
# 같이 묶어서 실행(ctrl+enter)시, 자동줄바꿈이 되지 않은 상태로 출력된다.

cat(100,200,"\n")  
1+1
# > cat(100,200,"\n")  
# 100 200 
# > 1+1
# [1] 2
#즉, 같이 묶어서 실행(ctrl+enter)시, 자동줄바꿈이 되어서 출력된다

x<-20
if (x>10){ print("x is large number")  } #참이므로 {}블럭사이 문장 실행
if (x>10){ cat(x," is large number")  } #20  is large number 
#cat()은 print()와 달리 안에 변수를 집어 넣어도 되고 다양하게 활용가능



#제어구문(반복문) :괄호사용시 spacebar이용시 인식못함
  # for(i in data){조건식이 참일떄까지만 i를 사용하여 반복수행할 문장 }
  # while(con){조건이 참일때 수행할 문장} 
  # repeat{반복해서 수행할 문장} break: 종료/ next: 다음실행


for(i in 1:10){
  cat (i,"번째 실행중입니다","\n")
  }  #\t : tab , \n : enter
# 1 번째 실행중입니다 
# 2 번째 실행중입니다 
# 3 번째 실행중입니다 
# 4 번째 실행중입니다 
# 5 번째 실행중입니다 
# 6 번째 실행중입니다 
# 7 번째 실행중입니다 
# 8 번째 실행중입니다 
# 9 번째 실행중입니다 
# 10 번째 실행중입니다 

paste0(i,"번째 실행중입니다")  #[1] "10번째 실행중입니다

for(i in 1:10){
  cat(paste0(i,"번째 실행중입니다"),"\n") 
}
# 1번째 실행중입니다 
# 2번째 실행중입니다 
# 3번째 실행중입니다 
# 4번째 실행중입니다 
# 5번째 실행중입니다 
# 6번째 실행중입니다 
# 7번째 실행중입니다 
# 8번째 실행중입니다 
# 9번째 실행중입니다 
# 10번째 실행중입니다 
## 1번쨰 인자랑 2번째 인자사이 자동띄어쓰기 안하려고 : paste0()

Vec1<-c(1,2,3)
for(i in Vec1){print('안녕')}
# [1] "안녕"
# [1] "안녕"
# [1] "안녕"

gg<-3
for(i in 1:10){
  cat(paste(gg,"x",i,"=",gg*i),"\n")
}
#3 x 1 = 3 
# 3 x 2 = 6 
# 3 x 3 = 9 
# 3 x 4 = 12 
# 3 x 5 = 15 
# 3 x 6 = 18 
# 3 x 7 = 21 
# 3 x 8 = 24 
# 3 x 9 = 27 
# 3 x 10 = 30 

## cat()은 출력시에 ""가 나오지 않는 것이 기본값이며 앞에 [1]도 없음, 
## 또한강제 줄바꿈 해야함 : "\n"

gg<-3
for(i in 1:10){
  print(paste(gg,"x",i,"=",gg*i))
}
# [1] "3 x 1 = 3"
# [1] "3 x 2 = 6"
# [1] "3 x 3 = 9"
# [1] "3 x 4 = 12"
# [1] "3 x 5 = 15"
# [1] "3 x 6 = 18"
# [1] "3 x 7 = 21"
# [1] "3 x 8 = 24"
# [1] "3 x 9 = 27"
# [1] "3 x 10 = 30"
#print()는 [1]과 ""와 함께 출력되더라, 또한 자동줄바꿈됨

#sum함수 이용
sum <-0
for(i in 1:10){
  sum <-sum+i
}
sum #55


#짝수
a<-8
#%% : 나머지연산자 ; 짝수와 홀수를 구할 떄 주로 사용
if(a%%2==0){
  print(a)
  print("짝수에요")
}
#[1] 8
#[1] "짝수에요"

#홀수
a<-7
#%% : 나머지연산자 ; 짝수와 홀수를 구할 떄 주로 사용
if(a%%2==0){
  print(a)
  print("짝수에요")
}else{
  print(a)
  print("홀수에요")
}
#[1] 7
#[1] "홀수에요"



data<-c(1:10)

switch(data[2],
       "1"=print("one"),
       "2"=print("two"),
       "3"=print("three"),
       print("null") )
                   
#[1] "two"

user <- function() {
  answer <- readline("Input Data : ") 
      if(substr(answer,1,1)=="n")cat("아니요") else cat("예") }
# 원하는부분 긁어오기: substr(변수, 시작번째, 마지막번째) 

user()


str(iris)
ls(iris)
distinct(iris,Species)
#     Species
# 1     setosa
# 2 versicolor
# 3  virginica

#불용어를 제거
txt <- readLines("좋아하는과일.txt") #readLines : 비정형데이터 불러올때 쓰는 것
txt
cnt_txt <-length(txt)
cnt_txt

# i<- 1
# for(i in 1:cnt_txt){
#   place <- gsub((txt[i]),"",place) # 수정하고싶은데이터
# }

cnt_txt
txt



# dplyr 패키지
library(dplyr)
exam <- read.csv("data/csv_exam.csv")
exam

exam %>%  filter(class==1) #class 가 1반인 자료 

exam %>%  filter(class!=1)  #class 가 1반 아닌 자료 

exam %>%  filter(math >50)  # 수학점수가 50초과인 자료
exam %>%  filter(math >50 & english >=90)  #여러개의 조건 건 filter
#  id class math english science
# 1  2     1   60      97      60
# 2  7     2   80      90      45
# 3 16     4   58      98      65

exam %>%  filter(class==1 & math > 50) #1반이면서 수학점수가 50점 이상
#  id class math english science
#1  2     1   60      97      60

#id와 영어점수, 과학점수 열만 가지고 아래 데이터를 출력하시오
exam1 <- select(exam,id,english,science)
exam1
exam1 %>%  filter(english < 90 | science < 50)

# id english science
# 1   3      86      78
# 2   4      98      58
# 3   5      80      65
# 4   6      89      98
# 5   8      78      25
# 6  11      65      65
# 7  12      85      32
# 8  14      87      12
# 9  15      56      78
# 10 16      98      65
# 11 17      68      98
# 12 18      78      90
# 13 19      68      87
# 14 20      83      58

exam %>%  select(id,english,science) %>%  filter(english < 90 | science < 50)
# id english science
# 1   3      86      78
# 2   4      98      58
# 3   5      80      65
# 4   6      89      98
# 5   8      78      25
# 6  11      65      65
# 7  12      85      32
# 8  14      87      12
# 9  15      56      78
# 10 16      98      65
# 11 17      68      98
# 12 18      78      90
# 13 19      68      87
# 14 20      83      58
#--------------------------------------------
exam %>%  
  select(id,english,science) %>%
  filter(english < 90 | math < 50) %>%
  head(2)  # 줄넘겨 코드를 연결하고싶을떈 shift +enter로 연결해야함
# id english science
# 1  3      86      78
# 2  4      98      58

exam %>% filter(class %in% c(1,3,5)) #  A %in% B :A내에 B값이 포함된 개수의 합
#   id class math english science
# 1   1     1   50      98      50
# 2   2     1   60      97      60
# 3   3     1   45      86      78
# 4   4     1   30      98      58
# 5   9     3   20      98      15
# 6  10     3   50      98      45
# 7  11     3   65      65      65
# 8  12     3   45      85      32
# 9  17     5   65      68      98
# 10 18     5   80      78      90
# 11 19     5   89      68      87
# 12 20     5   78      83      58

#QUIZ] 1반 학생의 수학점수 평균을 구하라
exam %>%  filter(class==1) %>% select(math) %>% mean() # 불가 #[1] NA
#!!!! 데이터프레임은 mean() 연산 바로 불가함 

###################case1)

exam %>%  filter(class==1) %>% select(math)
# math
# 1   50
# 2   60
# 3   45
# 4   30

exam %>%  filter(class==1) %>% select(math) %>% sum()  #[1] 185


str(class1_math)1
# sum()이용해 데이터프레임의 열을 나누어주면 된다
dim(class1_math) # [1] 4 1 ; 4행 1열임

class1_math<-exam %>%  filter(class==1) %>% select(math)
class1_math
#  math
# 1   50
# 2   60
# 3   45
# 4   30
sum(class1_math) #[1] 185
nrow(class1_math) #[1] 4

sum(class1_math)/ nrow(class1_math) #[1] 46.25

##################case2) 

# 1반의 정보를 filter()을 이용해 미리 뽑는다
#mean()연산은 select()를 사용했을때 사용할 수 없음(select으로 뽑아도 데이터프레임임)
#->칼럼명을 이용해 연산함
class1 <- exam %>%  filter(class==1)
class2 <- exam %>%  filter(class==2)

mean(class1$math) #[1] 46.25
sum(class2$math) #[1] 245


#### 집단별로 요약하기 => 데이터를 요약(summarise() / group_by() 이용)하면 tibble형태!
fef<-exam %>%
  group_by(class) %>% 
  summarise(mean_math = mean(math))
fef
str(fef)

#case3)######################################################하는중 푸는중
exam %>%  filter(class==1) %>% summarise()
###################################################

## 종합변수 추가 : mutate(새로운 함수 = 칼럼명으로이루어진 수식)

exam %>% mutate(total = math + english + science) %>%
  head()  # 종합변수 추가 # 일부추출

exam

#통합변수 total ,  mean 2개 추가
exam %>% mutate(total = math + english + science,
       mean = (math + english + science)/ 3 ) %>%
         head  

########################

# mutate()에 ifelse()적용하기
# 과학점수가 60점이상이면 pass, 아니면 fail이 나오는 파생변수test를 만들어라 
exam %>%  mutate(test = ifelse(science >= 60, "pass","fail"))
#   id class math english science test
# 1   1     1   50      98      50 fail
# 2   2     1   60      97      60 pass
# 3   3     1   45      86      78 pass
# 4   4     1   30      98      58 fail
# 5   5     2   25      80      65 pass
# 6   6     2   50      89      98 pass
# 7   7     2   80      90      45 fail
# 8   8     2   90      78      25 fail
# 9   9     3   20      98      15 fail
# 10 10     3   50      98      45 fail
# 11 11     3   65      65      65 pass
# 12 12     3   45      85      32 fail
# 13 13     4   46      98      65 pass
# 14 14     4   48      87      12 fail
# 15 15     4   75      56      78 pass
# 16 16     4   58      98      65 pass
# 17 17     5   65      68      98 pass
# 18 18     5   80      78      90 pass
# 19 19     5   89      68      87 pass
# 20 20     5   78      83      58 fail


#추가한 변수를 dplyr 코드에 바로 활용하기
exam %>%  
  mutate(total = math + english + science ) %>% 
  arrange(total) %>% 
  head # head() 괄호 쳐도 되고 안쳐도됨! 

#  id class math english science total
# 1  9     3   20      98      15   133
# 2 14     4   48      87      12   147
# 3 12     3   45      85      32   162
# 4  5     2   25      80      65   170
# 5  4     1   30      98      58   186
# 6  8     2   90      78      25   193

#--------------------------------

#!!!! 데이터프레임은 mean() 연산 바로 불가함 -> tibble형식으로 요약하여 변경해야함
# => summarise() 이용!

#실습 자료 exdata1 만들기
library(readxl)
exdata1 <- read_excel("data/Sample1.xlsx" )
exdata1
exdata1 <- rename(exdata1, Y17_AMT= AMT17, Y16_AMT=AMT16) # 변수명 바꿈
exdata1$AMT <- exdata1$Y17_AMT +exdata1$Y16_AMT #새로운 파생변수 생성
exdata1$CNT <- exdata1$Y17_CNT + exdata1$Y16_CNT #새로운 파생변수 생성
View(exdata1)

#합계를 도출하는 summarise()함수 : summarise(새 변수명 = sum( 변수명))
#데이터 세트의 Y17_AMT 변수의 합계를 TOT_Y17_AMT 변수로 도출
exdata1 %>%  summarise(TOT_Y17_AMT = sum(Y17_AMT)) 
## A tibble: 1 x 1
# TOT_Y17_AMT
# <dbl>
#   1     5482900
#; tibble형태로 요약

#변수의 값을 그룹별로 합산하기 :  group_by ( 변수명) %>% summarise(새 변수명 = sum( 변수명))
#데이터세트의 지역변수를 기준으로 각 Y17_AMT의 합을 구해 SUM_Y17_AMT 새변수로 저장
exdata1 %>%  group_by(AREA) %>% summarise(SUM_Y17_AMT = sum(Y17_AMT))
# A tibble: 4 x 2
# AREA  SUM_Y17_AMT
# <chr>       <dbl>
#   1 경기      1120000
# 2 서울      3157900
# 3 인천       930000
# 4 제주       275000

######################################
#데이터 합치기 


#######옆으로 합치기
test1 <- data.frame(id= c(1,2,3,4,5),
                    midterm = c(60,80,70,90,85))

test2 <- data.frame(id= c(1,2,3,4,5),
                    final = c(70,83,65,95,80))
test1  
test2

#id기준으로 합치기(옆으로 더해짐) : left_join(합칠데이터1, 합칠데이터2, by="기준" )
total  <- left_join(test1,test2,by ='id') # id 기준으로 합치기 (옆으로 더해짐) 
total

# 반별 담임교사 명단 생성
name <- data.frame(class = c(1,2,3,4,5),
                   teacher = c("kim","lee","park","choi","jung"))
name

exam
exam_new <-left_join(exam, name, by="class") # class기준 합치기
exam_new


############아래로 합치기  :bind_rows(합칠데이터1, 합칠데이터2)
group_a <- data.frame(id= c(1,2,3,4,5),
                    test= c(60,80,70,90,85))

group_b <- data.frame(id= c(6,7,8,9,10),
                    test = c(70,83,65,95,80))

group_a
group_b

#세로로 합치기
group_all <- bind_rows(group_a, group_b)
group_all
