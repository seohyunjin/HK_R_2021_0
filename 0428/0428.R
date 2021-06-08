#0428
#비정형데이터를 워드클라우딩 : 텍스트마이닝의 일종  \

#지난시간 복습 _ KoNLP 패키지 + 워드클라우드
Sys.getenv("JAVA_HOME")  # ""
Sys.setenv(JAVA_HOME='C:\\Program Files\\Java\\jre1.8.0_291')#자바설정
#### 역슬래시는 한번만 있을 때 에러뜸 :'\P'는 인식할 수 없는 이스케이프~
#=> 따라서 /슬래시 아니면 \\역슬래시 2번써주어야함
Sys.getenv("JAVA_HOME") # "C:\\Program Files\\Java\\jre1.8.0_291"

install.packages('rJava')#자바패키지 설치
library(rJava)
install.packages('KoNLP') #한글 패키지 설치
library(KoNLP)

# 설치되면 다음 안해도됨! #; 깃허브에서 받는 작업
# install.packages('remotes') #한글 패키지 설치
# remotes::install_github('haven-jeon/KoNLP',upgrade='never',INSTALL_opts = c('--no-multiarch'))

library(KoNLP)  # KoNLP는 한국어를 분석하는 패키지


#wordcloud2 는 워드클라우드 만드는 패키지
install.packages('wordcloud2') 
library(wordcloud2)

#KoNLP- 사전설정
useSystemDic()
useSejongDic() #세종 사전

# 텍스틀마이닝 작업순서
#= 문장 -> 단어-> 키워드 -> 필터링-> 집계 -> 시각화

getwd()
#텍스트파일 데이터를 word_data에 할당
word_data <- readLines("data/애국가(가사).txt")
word_data  # 원본

# 명사추출 : extractNoun  
# 열이름 나타내는 속성 설정 : USE.NAMES = T(;나타냄) / F(;안나타냄)
word_data2<-sapply(word_data,extractNoun,USE.NAMES = F)
word_data2  #서브본

add_words <-c('백두산','남산','철갑','가을','하늘','달') ; add_words
# add_words 변수의 데이터를 사용자 정의 단어(user_dic )로 추가
buildDictionary(user_dic = data.frame(add_words,rep('ncn',length(add_words))),replace_usr_dic = T)


#데이터를 벡터로 변환 : unlist()
undata <-unlist(word_data2)
undata

#wordcloud는 빈도에 따라 굵기 표현을 해야하므로 집계를 계산
# 집계함수 : table()
#undata의 빈도 수 확인 후 word_table에 할당
word_table <- table(undata)
word_table

# function 앞에 filter만 f를 대문자로 씀!!
#원하는 것 골라 뽑아오기 : Filter(function(x){값x로 이루어진 조건식},데이터)
undata2<-Filter(function(x){nchar(x)>=2},undata)
word_table2<-table(undata2)
word_table2

# 데이터 정렬
sort(word_table2,decreasing=T)

# 특정단어 제외하거나 삭제하기 : gsub(찾는 단어, 바꿀 단어, 찾을 위치)

#워드 클라우드 만들기
library(wordcloud2)
wordcloud2(word_table2)
wordcloud2(word_table2, color = 'random-light',backgroundColor = 'black')
wordcloud2(word_table2,fontFamily = '맑은고딕',size=0.8 ,color = 'random-light',backgroundColor = 'black',shape='star')

#
alert11 <- readLines('data/oracle_alert_testdb.log')
alert12 <- grep('^ORA-+',alert11,value=T) # +의미 : 다가져오기 # ORA로 시작하는 것들 뒤에도 다 가져와
alert13 <- substr(alert12,1,9) 
alert13
word_alert13<-table(alert13) ; word_alert13
sort(word_alert13,decreasing=T)  # sort()안에다가 내림차순 설정할떄만 desc X decreasing= T O
wordcloud2(word_alert13,size=0.5)


#
install.packages("wordcloud")
library(wordcloud)
library(RColorBrewer)

palete <- brewer.pal(7,'Set1')
wordcloud(names(word_alert13),freq= word_alert13,scale=c(5,0.5),
          rot.per = 0.5,min.freq = 3,
          random.order = F, random.color = T, colors=palete)

getwd()
data1 <- readLines('data/좋아하는과일2.txt') ; data1
data1<-unique(data1) ; data1 # 중복되는 리뷰를 제거해야할 경우 : unique()
#== distinct 는 중복된 
#행이 완전 데이터가 똑같을 경우 제거되어 하나만 출력됨 : unique()

#특수기호를 모두 제거하기 : str_replace_all(데이터, '[^[:alpha:][:blank:]]','')
library(stringr)
data2 <- str_replace_all(data1, '[^[:alpha:][:blank:]]','')
data2

#명사 추출
data2<-extractNoun(data2)
data2

# 한 행에서 중복되는 단어를 제거 : lapply(데이터,unique)
data2<- lapply(data2,unique)
data2

#7) 띄어쓰기가 안되어있는 긴 문장(단어)을 제거해야 할 경우 아래 명령어
# 이작업을 하는 명령어는 filter()인데 벡터로 데이터를 넣어야함.
#그래서 unlist()함수로 list형태를 벡터형태로 변경해야함

data3<- unlist(data2)
head(data3,5)


data4 <- Filter(function(x){nchar(x) <= 20 & nchar(x)>1}, data3)
data4

# 특정단어 제외하거나 삭제 : gsub('찾을before단어','바꿀after단어',찾을 위치데이터)
data4<- gsub('\\.','',data4); data4 #마침표 제거   
data4<- gsub("\\'","",data4); data4 #홑따옴표 제거
data4<- gsub('\\^','',data4); data4 #캐럿기호 제거


#저장 형식은 ANSI으로 저장 (ANSI로 저장하지 안으면 글씨 깨짐)
txt <- readLines('불용어만들기.txt') ; txt
cnt_txt <- length(txt) ; cnt_txt  #5
#불용어 첫행부터 마지막 행까지 cnt_txt 까지 gsub 반복실행
for(i in 1:cnt_txt){
  data4<- gsub((txt[i]),"",data4)
} #for문을 i가 1,2,3,4,5일때 총 5번 반복함
data4

data4 <- Filter(function(x){nchar(x) <= 10 & nchar(x)>1}, data4) ; data4

wordcount <- table(data4)
wordcount

sort(wordcount,decreasing= T)

palete <-brewer.pal(9,'Set3')
wordcloud(names(wordcount),freq= wordcount, scale= c(4,1), rot.per = 0.5,
          min.freq=1, random.order=F, random.color=T, colors=palete)


## 추가설명 : gsub()
place <- gsub('이모티콘','',place) #place에서 '이모티콘' 제거하기
place <- gsub('모델','model',place) # place에서'모델'을  'model'로 바꾸기
place <- gsub('감사합니','감사',place)# place에서 '감사합니' 를'감사'로 바꾸기

place <- gsub(paste(c('하드','하드에어'),collapse='|'),'하드웨어',place)
pce <-gsub('근데','',place)#place에서 '근데' 제거하기

place <- gsub(paste(c('딕셔너리로','리스트딕셔너리리리리','딕셔너리리','append딕셔',
                      collapse='|'),'딕셔너리',place))

###dplyr패키지 복습####
head(iris)
library(dplyr)
distinct(iris,Species)  #distinct()는 dyplr패키지 햠수임!

#filter() 함수로 추출하기 : filter(데이터셋, 조건절)
filter(mtcars,cyl==4)
filter(mtcars,cyl >=6 & mpg>20)

#arrange() 함수로 정렬하기 : arrange(데이터셋, 기준열1, 기준열2)
head(arrange(mtcars,wt))
head(arrange(mtcars,mpg,desc(wt)))

#select() 함수로 변수 선택하기 : select(데이터셋,추출열1, 추출열2)
head(select(mtcars,am,gear))

#mutate() 함수로 열 추가하기 : mutate(데이터셋, 추가할 열이름=조건)
head(mutate(mtcars,years='1974'))
head(mutate(mtcars,mpg_rank= rank(mpg)))

#distinct() 함수로 중복값 제거하기 : distinct(데이터셋, 기준열1, 기준열2 )
distinct(mtcars,cyl)
distinct(mtcars,cyl,gear)

#summarise() 함수로 데이터 요약하기 : summarise(데이토셋, 요약할열이름1=통계함수이용,요약할열이름2=통계함수이용)
summarise(mtcars,cyl_mean=mean(cyl),cyl_min=min(cyl),cyl_max=max(cyl)) #변수명 지정
summarise(mtcars,mean(cyl),min(cyl),max(cyl)) 

#group_by() 함수로 그룹별 묶기 : group_by(데이터셋, 묶을 기준열)
gr_cyl <- group_by(mtcars,cyl)
summarise(gr_cyl,n())

gr_cyl <- group_by(mtcars,cyl)
summarise(gr_cyl,n_distinct(gear))

#데이터 샘플 추출하기
# sample_n(데이터세트,추출할 샘플 개수)
sample_n(mtcars,10) # mtcars에서 10개만 샘플데이터로 추출할 것 
#sample_frac(데이터세트,추출할 샘플 비율) 
sample_frac(mtcars,0.2) # mtcars에서 20 %를 샘플데이터로 추출할것

# %>% 연산자 사용하기
group_by(mtcars,cyl) %>% summarise(n())

mp_rank <-mutate(mtcars, mpg_rank=rank(mpg))
head( arrange(mp_rank,mpg_rank) )

#== head( mutate(mtcars,mpg_rank=rank(mpg)) %>% arrange(mpg_rank) )



#########그래프 복습
library(ggplot2)

head(mtcars)
ggplot(data= mtcars, aes(x= gear, y=carb)) +geom_col() #geom_col()은 x축 y축 모두 존재!
ggplot(data= mpg, aes(x= drv)) +geom_bar()  #geom_bar()는 x축만 존재. 빈도만 계산함
ggplot(data)



# QUIZ]

# 자동차 중에서 어떤 class중 drv가 가장 많은 것을 확인하려고 한다
#자동차 종류별 빈도를 표현한 막대그래프를 만들어 본다.

head(mtcars)
head(mpg)# mpg데이터 이용할 것임
ggplot(data=mpg,aes(x= factor(class)))+geom_bar(aes(fill= factor(drv)))  

ggplot(data=mpg,aes(x= class))+geom_bar(aes(fill= drv))  #굳이 factor화 안해줘도 되더라
# ggplot(data=mpg,aes(x= class,fill= drv))+geom_bar()  #위와 동일한 결과 출력됨

