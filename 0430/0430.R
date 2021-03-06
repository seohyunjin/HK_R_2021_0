#서현진#
###0430####

# 디렉터리 설정
getwd()
setwd('C:\\Users\\CPB06GameN\\Documents\\practice1_0419\\hankyungr')

#라이브러리 설치
library(stringr)
library(KoNLP) #한글패치
library(wordcloud)
library(wordcloud2) 
library(dplyr)  # rename()사용하려고

rm(list=ls())
#데이터 불러오기 ; 비정형데이터 추출 예제
txt <- readLines('data/hiphop.txt')
head(txt)

#데이터 정제;  글이 아닌것을 다 삭제하겠음
txt <- str_replace_all(txt,"\\W"," ")  #-> word즉, 단어가 아닌것
# txt <- str_replace_all(txt,'[^[:alpha:]|[:blank:]]','')   #->영어만 남게됨
# txt <- str_replace_all(txt,"[^[가-힣] ]|[:space:]" ,"") # 이때 space까지 해버리면 모든 space사라짐
txt
head(txt)
### [^[가-힣] ] 에 띄어쓰기를 쓰지 않으면 [^[가-힣]] 모든 글자가 다 붙어버림



# 명사 추출
nouns<- extractNoun(txt)
head(nouns,50)


#명사 list를 벡터로 변환 ; 단어 빈도표생성
wordcount<- table(unlist(nouns)) ; wordcount 
head(wordcount)


#데이터 프레임으로 변환 # 문자가펙터가 안되게끔 방지 : stringsAsFactors = F
df_word <- as.data.frame(wordcount, stringsAsFactors = F)

#변수명 수정 : rename(데이터, 신버전= 구버전, 신버전 = 구버전)
df_word <- rename(df_word, word= Var1, freq= Freq)
df_word
head(df_word)

# 두글자 이상 단어 추출
df_word <- filter(df_word, nchar(word) >= 2 )

# df_word 에서 freq내림차순으로 정렬후 20개 데이터를 할당하겠다
top_20 <-df_word %>% 
  arrange(desc(freq)) %>% 
  head(20)

# 워드클라우드 만들기

# 단어 색상 목록 만들기

dev.new() #새창띄우기
display.brewer.all()  #새창띄우기와 동시에 실행하여야 출력됨


pal <- brewer.pal(8,'Dark2')  #Dark2 색상 목록에서 8개의 색을 추출
pal <- brewer.pal(9,'PuBu')
pal <- brewer.pal(9,'PuBu')[5:9]


#set.seed(1) # 난수 고정

wordcloud(words = df_word$word, #단어
          freq = df_word$freq, # 빈도
          min.freq = 2, #최소단어 빈도
          max.words = 200, # 표현 단어수
          random.order = F, # 고빈도 단어 중앙배치
          rot.per = .1, # 회전 단어 비율
          scale = c(4,0.3),  # 단어 크기 범위
          colors = pal)  #색목록



######dplyr 패키지 복습해보기##############

data(mtcars)
head(mtcars)
mtcars %>% filter(cyl==6) %>% 
  mutate(mean_gear = mean(gear)) %>% 
  summarise(mean_carb = mean(carb)) #summarise하면 설정한 함수만 나옴

summarise(mtcars, mean_carb=mean(carb)) # 파이프 쓰나 안쓰나 똑같은 결과나옴
    

######################QUIZ]
# 연습문제248
#1)
library(readxl)
middle_mid_exam <- read_excel('data/middle_mid_exam.xlsx') 
head(middle_mid_exam)


#3)
middle_mid_exam %>% group_by(CLASS) %>%
  mutate(mean_english=mean(ENGLISH)) %>% 
  mutate(sum_english = sum(ENGLISH)) %>% 
  mutate(mean_math = mean(MATHEMATICS)) %>%
  mutate(sum_math = sum(MATHEMATICS)) %>% 
  summarise(mean_english,sum_english,mean_math,sum_math) %>% 
  unique()
  
#4)
num4<-middle_mid_exam %>%  filter(CLASS== 'class1'& MATHEMATICS >= 80 )
nrow(num4)  # 3명

#5)
middle_mid_exam %>%  arrange(desc(MATHEMATICS),ENGLISH)

#6)
num6<-middle_mid_exam %>%  filter(ENGLISH>=85& MATHEMATICS >= 80 )
nrow(num6)  #3명

###tibble형식 자료도 nrow() 사용 가능

#######################  트리맵만들기################
#데이터 불러오기
ck<- read_excel('data/치킨집_가공.xlsx')
ck

#원하는 데이터 열에서 원하는 문자열 부분추출 : substr(데이터$칼럼명,시작부분인덱스,끝부분인덱스)
addr <- substr(ck$소재지전체주소,11,16)
head(addr)
str(addr) # chr [1:1515]  벡터임

# 가져온 벡터데이터를 원하는대로 가공 : gsub('없애고 싶은 문자 정규식표현','',데이터) 
addr_num <- gsub('[0-9]','',addr) 
head(addr_num) #숫자 제거함
addr_trim <- gsub(' ','',addr_num) ; 
head(addr_trim) #문자안에 공백 제거함

library(dplyr)

#문자열데이터 빈도를 구하여 treemap 만들예정 -> table()통해 집계하기
# 업종개수 집계하여 데이터 프레임으로 확인하기
addr_count <-addr_trim %>% table() %>% data.frame()
head(addr_count)

#트리맵 설치 
install.packages('treemap')
library(treemap)

#트리맵 표현 : treemap(데이터, index='인덱스 열이름',vSize='빈도수 열이름',title='제목설정')
treemap(addr_count, index='.', vSize = 'Freq',title='서대문구 동별 치킨집 분포')


#############QUIZ]
#데이터 불러옴
hs<-read_excel('hos_data.xlsx')
hs

#원하는 데이터 열에서 원하는 부분문자를 가져옴 : substr()
addr2 <- substr(hs$소재지전체주소,11,16)
head(addr2)

#숫자 제거
addr_num2 <- gsub('[0-9]','',addr2) 
head(addr_num2)

#공백제거
addr_trim2 <- gsub(' ','',addr_num2) ; 
head(addr_trim2)

#집계하여 데이터프레임 만들기 ; 동별 빈도 파악하기 위해
addr_count2 <-addr_trim2 %>% table() %>% data.frame()
head(addr_count2)

# 팔레트 명 알아보기
display.brewer.all()  #새창띄우기와 동시에 실행하여야 출력됨

# 색 속성 바꾸고 싶으면 : palette='필레트명' 넣어주면됨 
treemap(addr_count2, index='.', vSize = 'Freq',title='강남구 병원 분포',
        palette='RdYlBu')
## 색상 범위 세부속성 설정할 수 있음
treemap(addr_count2, index='.', vSize = 'Freq',title='강남구 병원 분포',
        vColor='some',palette='Dark2',mapping=c(-10, 10, 30), range=c(-10, 30))

##트리맵 폰트 사이즈 변경 속성 : fontsize.labels=c(크기숫자, 크기숫자)
treemap(addr_count2, index='.', vSize = 'Freq',title='강남구 병원 분포',
        palette='RdYlBu',fontsize.labels=c(15, 5))

#########################QUIZ]
data(GNI2014)
ls() # 변수명 확인  
head(GNI2014)  #;이 데이터는 인구수치를 나타내는 수치 데이터가 존재함

# 값을 수치로 넣기떄문에 빈도를 구하는 것이 아님 따라서 table()안해도 됨
# vSize = '수치형변수명'
treemap(GNI2014,
        index = c('continent','iso3'),
        vSize = "population",
        title = '세계인구',
        bg.labels='blue')


#############QUIZ]
#GNI = 국민 총소득 ; 단위:조

# GNI2014 데이터를 인구순이 높은 순으로 나열하여 20개를 GNI2014_po로 저장하시오
GNI2014_po<-head(arrange(GNI2014,desc(population)),20)
GNI2014_po

#트리맵 만들기
treemap(GNI2014_po,
        index = c('continent','iso3'),
        vSize = "population",
        title = '인구높은순위 Top 20',
        bg.labels='blue')


############QUIZ]
#mutate()함수를 이용하여 파생변수 생성 후 1인당 국민 소득을 작성
head(GNI2014)

GNI2014_per_pop<-mutate(GNI2014,per_pop=GNI/population)
# sol=>
GNI2014_per_pop<- head(arrange(mutate(GNI2014,per_pop=GNI/population),desc(per_pop)),20)
#treemap은 데이터 정제후 arrange()해야 큰 부분부터 시각적으로 확인 가능
#head(데이터,20)을 통해 top20 을 보여주여야 함 

treemap(GNI2014_per_pop,
        index = c('continent','iso3'),
        vSize = "per_pop",
        title = '1인당 국민소득 TOP 20',
        bg.labels='white')  #bg.labels='white' 라벨명 배경색 설정 

