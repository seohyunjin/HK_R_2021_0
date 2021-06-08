#0429
##################################################그래프

#줄기 잎 그림 
library(readxl)
exdata1 <-read_excel('data/Sample1.xlsx')
exdata1
stem(exdata1$AGE)

exdata2 <-read.csv('assign0429_exam4')
exdata2
stem(exdata2$science)

#rnorm(갯수,평균,표준편차)
#소수점자리수 정리하기 : round(데이터,소수점밑 자릿수 개수)

#
round( rnorm(50,75,3), 0) # 평균 75, 편차 3 
round( rnorm(50,75,20),0) # 평균 75, 편차 20

#
par(mfrow = c(2,1))
hist( round( rnorm(50,75,3), 0))
hist( round( rnorm(50,75,20), 0) )

#히스토그램 제목바꾸고싶을때 : hist()속성 _ main= '바꾸고 싶은 그래프명'
hist(exdata1$AGE, xlim= c(0,60), ylim=c(0,5))  # 이름 안정함
hist(exdata1$AGE, xlim= c(0,60), ylim=c(0,5),main= 'AGE분포') # 이름정함

#막대그래프 : 범주형 데이터에 대해 수량의 양을 나타낼때 적합한 그래프
#freq() / barplot()

par(mfrow = c(1,1))
install.packages('descr')
library(descr)
freq(exdata1$SEX, plot= T, main='성별(barplot)')

dist_sex <-table(exdata1$SEX)
dist_sex
barplot(dist_sex) 

#barplot(데이터, ylim=y축범위)
barplot(dist_sex,ylim=c(0,8))

#barplot(데이터, ylim=y축범위, main='그래프명 지정',xlab='x축 이름',ylab='y축이름',names=c('bar이름1','bar이름2'))
barplot(dist_sex,ylim=c(0,8),main='BARPLOT',xlab='SEX',ylab='FREQUNCY',names=c('female','male'))

# barplot_ bar색 지정 속성 :  col = c('bar1의 색상명1','bar2의 색상명2')
barplot(dist_sex,ylim=c(0,8),main='BARPLOT',xlab='SEX',ylab='FREQUNCY',names=c('female','male'),
        col = c('pink','navy'))  
barplot(dist_sex,ylim=c(0,8),main='BARPLOT',xlab='SEX',ylab='FREQUNCY',names=c('female','male'),
        col = c('pink','black'))  

#상자그림  : boxplot
boxplot(exdata1$Y17_CNT, exdata1$Y16_CNT)
summary(exdata1$Y17_CNT)
summary(exdata1$Y16_CNT)


#QUIZ]
y1<-c(1,2,3,4,5,6,7,8,9,10,20,25)
boxplot(y1)
y1
summary(y1)

for (i in 1:12){
  if(y1[i]>=20){y1[i]<-NA}  #'NA' 넣으면 수치가 아닌 인수로 저장됨, 이렇게 하면 안된다.
}
y1

boxplot(y1)

#####################크롤링 ############################
y2<-na.omit(y1); y2  #na.rm =T 말고도, na.omit()으로도 결측값 제거 가능
boxplot(y2) #위와 같은 그래프 출력

#정적 스크래핑(크롤링)

# - 웹 스크래핑 (web scraping)
# 
# : 웹 사이트 상에서 원하는 부분에 위치한 정보를 컴퓨터로 하여금 자동으로 추출하여 수집하는 기술
# 
# - 웹크롤링(web crawling)
# 
# : 자동화 봇인 웹 크롤러가 정해진 규칙에 따라 복수 개의 웹페이지를 브라우징하는 행위

# 패키지 설치 및 로드
install.packages("rvest")
library(rvest)
library(stringr)

# 데이터 가져올 URL 설정하기
main_url <-'https://movie.naver.com/movie/bi/mi/pointWriteFormList.nhn?code=192620&type=after&onlyActualPointYn=Y&isActualPointWriteExecute=false&isMileageSubscriptionAlready=false&isMileageSubscriptionReject=false&page='
main_url

#가져올 변수목록 형식 지정
reply_list <- character()
star_list <- numeric()
date_list <- character()

page_url = 1  # 페이지 넘어가는 기능을 for문으로 설정 
for(page_url in 1:10){
  url <-paste(main_url, page_url, sep="")  # main_url뒤에 페이지 설정하도록 paste()이용해 붙임
  
  content<-read_html(url)  #html연결시킴 : read_html()
  
  node_1 <-html_nodes(content,".score_reple p")   # 댓글부분  클래스명 가져옴
  node_2 <-html_nodes(content,".score_result .star_score em") # 평점부분
  # node_2 <-html_nodes(content,".star_score em") 위와같음  
  node_3 <-html_nodes(content,".score_reple em:nth-child(2)") # 날짜 부분
  # node_3 <-html_nodes(content,".score_result .score_reple em:last-child")
  # node_3 <-html_nodes(content,".score_result .score_reple dt em:last-child") #em 첫번쨰 줄 코드 가져옴
  node_3
  
  # 가져올 것을 변수로 지정함
  reply <-html_text(node_1)
  star <-html_text(node_2)
  date <-html_text(node_3)
  date <-as.Date(gsub("\\.", "-", date)) # 날.을 - 로 바꿈

  #변수를 저장하는 목록 만듬
  reply_list <- append(reply_list,reply)
  star_list <- append(star_list,star)
  date_list <- append(date_list,date)
  
  }


# 변수목록으로 데이터 프레임 만들기
df<- data.frame(reply_list, star_list, date_list)
colnames(df) = c("댓글","평점","날짜")
df

getwd() # 현재 디렉터리 확인

write.csv(df,file='movie_ex.csv')  # csv 파일 만들기


############QUIZ] 위 데이터로 워드클라우드 만드세요############33

movie_data<-read.csv('movie_ex.csv')  #CSV파일 불러옴
head(movie_data[,2],2)  
movie_data2<-movie_data[,2]  #특정 열 데이터만 불러옴

# 기본 패키지 안에 있는 unique()함수 이용하여 중복된 데이터행이 있다면 빼고 select함
movie_data2<-unique(movie_data2)

# library(stringr)  #str_replace_all 사용하려고
movie_data3 <- str_replace_all(movie_data2,'[^[:alpha:][:blank:]]','')  # head(movie_data3)
movie_data3

#정규식 표현ex
#(데이터,'[^[가-힣] ]|ㅎ+|관람객','') # 한글아닌것들 다 지우고 ㅎㅎㅎ이런식으로 나온것 지우고, '관람객' 지움


library(KoNLP)

#명사 추출
movie_data3<-extractNoun(movie_data3)

# unique() 단독으로 쓰면 반복되는 행 제거하는것
# lapply() 와 같이 쓰면 한 행내에서 반복되는 것 제거가능
movie_data3<- lapply(movie_data3,unique) #한 행에서 중복되는 단어를 제거 

#리스트 풀기
movie_data3<- unlist(movie_data3)

# 길이가 10이하거나 1초과인것만 데이터분석하겠음 의미
movie_data4<- Filter(function(x){nchar(x) <= 10 & nchar(x)>1}, movie_data3)

movie_data4<- gsub('\\^','',movie_data4)  # ^제거

#불용어 제거하려고 불용어사전 텍스트 파일  readLines로 읽음
txt <- readLines('movie_불용어.txt') #txt
cnt_txt <- length(txt) # ;cnt_txt

#불용어리스트값에 있는 값을 제거
for(i in 1:cnt_txt){
  movie_data4<- gsub((txt[i]),"",movie_data4)
} #for문을 i가 1,2,3,4,5일때 총 5번 반복함

# 워드 클라우드 만들려면 단어 빈도를 체크해야하므로 table()함수 이용하여 집계함
wordcount <- table(movie_data4)
wordcount <- head(sort(wordcount,decreasing=T),30)
wordcount

library(wordcloud2)
wordcloud2(wordcount)


#### 데이터 가공 예제#####

## 텍스트 삭제 or 변경  : str_replace_all (데이터, '정규식표현들|지우고싶은 단어','대치할 단어')
mo_txt <- str_replace_all(txt,'관람객','') #관람객 삭제함
mo_txt <- str_replace_all(txt,'[^[가-힣]]','')
mo_txt <- str_replace_all(txt,'[^[가-힣]]|관람객','')
head(mo_txt)

####