
# 랜덤값 고정할때 같이 사용 : set.seed()
set.seed(1) #set.seed() 같이 사용하면 다음 랜덤값이 같이 저장된다
Vec1<-round(rnorm(100,80,5), 2) ; Vec1


library(ggplot2)
#상자그림 : boxplot
# 상자 밖 점 표식 : 극단치,이상치 outlier  / 상자위 세로선 : 윗수염 :하위 75%~100%
# 굵은선 : 평균x중앙값o
# 중앙 십자가 표시 : 평균o 
# 가운데축 최상단 : 최대값 , 가운데축 최하단 : 최소값

##중앙값 : 홀수일때는 가운데 있는 값, 짝수 있때는 가운데 위치한 두 값의 평균

ggplot(data= mpg, aes(x=drv, y=hwy)) + geom_boxplot()


#
par(mfrow = c(1,3))
y1<-c(1,2,3,4,5,6,7,8,9,10,20,25)
median(y1) #6.5 ;중앙값은 값들의 정가운데를 의미
summary(y1)
boxplot(y1,las=1) # y1 변수의 상자그림 

y2<-c(50,20,3,45,5,20,15,30,9,10,20,25)
median(y2) #20
summary(y2)
boxplot(y2)

y3<-c(50,20,3,45,5,20,15,30,9,10,20,100)
median(y3) #20
summary(y3)
boxplot(y3)


#QUIZ]
#class가 compact, subcompact, suv인 자동차의 cty가 어떻게 다른지 비교
#세종의 cty를 상자그림으로 나타내어라
data(mpg)
library(dplyr)
class_compact<-mpg %>% filter(class=='compact')
class_subcompact<-mpg %>% filter(class=='subcompact')
class_suv<-mpg %>% filter(class=='suv')

par(mfrow = c(1,3))
class_compact
boxplot(class_compact$cty)
boxplot(class_subcompact$cty)
boxplot(class_suv$cty)

## 중복조건 필터걸기
class_mpg<-mpg %>% filter(class %in% c('compact','subcompact','suv'))
class_mpg<-mpg %>% filter(class == 'compact'|class =='subcompact'|class =='suv')
class_mpg

# %>% 연산자 쓸떄 dplyr 불러와도 오류가 뜰때 :
if (!require(dplyr)) {
  install.packages('dplyr')
}

# mode : 최빈값

par(mfrow = c(1,1))
ls(mpg) # 변수명 확인 : ls()
distinct(mpg,manufacturer)  # 중복된 값은 제거해서 알려줘!
boxplot(hwy~manufacturer,data=mpg)


#QUIZ]
abc<-c(100,300,150,280,310)
def<-c(180,200,210,190,170)
ghi<-c(210,150,260,210,70)
df_box <-data.frame(A=abc,B=def,C=ghi)
df_box

#아래 두함수를 이용하여 해석을 제출하시오
summary(df_box)
boxplot(df_box, col=cm.colors(3)) # heat.colors(3)

# 애플매장 a,b,c,에서 팔리는 제품(아이패드, 아이폰, 애플와치, 맥북, 에어팟)
# 들에 대한 판매대수가 존재한다.


grep_ex <- c('a.txt','A.txt','ab.txt','123.txt','ba123.txt')
grep("^a",grep_ex) # 위치번째  # a가 들어간 값들의 '위치' 나옴 
# 1 3

# value 위치번쨰 '값'이 나옴 :value= TRUE
grep("^a",grep_ex,value= TRUE)
#"a.txt"  "ab.txt"

grep("[0-9]",grep_ex,value= TRUE)  #숫자를 포함하는 값들 다 나옴옴
# "123.txt"   "ba123.txt"


grep("^[0-9]",grep_ex, value= TRUE) #'숫자로 시작하는' 데이터
 # "123.txt"

#'숫자로 시작하는' 데이터 제외시켜라
grep("^[^0-9]",grep_ex, value= TRUE)
 # "a.txt"     "A.txt"     "ab.txt"    "ba123.txt"

ptn <- c('^a','^A') 
grep (paste(ptn, collapse='|'),grep_ex, value =TRUE) #A랑 a모두 
#"a.txt"  "A.txt"  "ab.txt"

nchar_ex1 <-"먹어도 먹어도 배고파요 ㅜㅜ... 정상입니다. "
nchar(nchar_ex1)  # 26 #; 공백도 센다


#paste 예제
paste(1,2,3) #"1 2 3"
paste(1,2,3,sep ='') #"123"
paste0(1,2,3) #"123"
paste('a','b','c') #"a b c"
paste('a','b','c',sep='') #"abc"
paste('a','b','c',sep='-')  #"a-b-c"

#단어 특정위치의 값을 가져오기: substr(데이터,가져올인덱스 시작,가져올인데스마지막)
substr('820715',3,4)  #"07"
substr('820715',1,4)  #"8207"

#값을 기준으로 정해 분리시키기 : strsplit(데이터, '기준값')
tel <- '031)123-4567'
strsplit(tel,')')  # "031"      "123-4567"
strsplit(tel,'-')  # "031)123" "4567"   


#####stringr 패키지
install.packages('stringr')
library(stringr)




#string_vec<-('','','','')
#string_vec

#string_extract('문자열데이터','정규표현식')
string <- 'hongkd105leess1002you25강감찬2005'
str_extract_all(string,'[a-z]{3}') #"hon" "gkd" "lee" "you"  #;리스트형태

str_extract_all(string,'[a-z]{4,}') # "hongkd" "leess"     #;리스트형태
str_extract_all(string,'[a-z]{3,4}') # "hong" "lees" "you"  #;리스트형태

c<-str_extract_all(string,'[a-z]{3,5}')
c 
#[[1]] #;즉 리스트 형태임
#[1] "hongk" "leess" "you"  

c<-unlist(c)
c <- paste(c,collapse ="") ;c
substr(c,3,4)

#
txt5 <-'사랑 사랑 누가 말했나~~' 
#문자열 부분 바꾸기 : str_replace(데이터,전단어, 바꿀단어)
str_replace(txt5,'사랑','간식')  #"간식 사랑 누가 말했나~~"
#문자열 모두 바꾸기 : str_replace_all(데이터, 전단어, 바꿀단어) 
str_replace_all(txt5,'사랑','간식') #"간식 간식 누가 말했나~~

#^[] : 대괄호 앞 ^은 시작하는 것을 의미하고, [^] : 대괄호 안의 ^은 제외하는 것의미


#대문자로 변경하기
string_sub <-str_sub(string,1,30) ; string_sub  #"hongkd105leess1002you25강감찬2005"
str_length(string) # 30 # 문자열의 길이 : str_length()
#데이터에서 특정문자열의 위치 : str_locate(데이터, '특정문자열' )
str_locate(string,'강감찬') #특정 문자열의 위치알려줌
#     start end
#[1,]    24  26

string_sub <-str_sub(string,1,23) # 강감찬 이전까지의 데이터(1~23) 활용함 
ustr <-str_to_upper(string_sub) ; ustr  # 대문자로 바꾸기 #"HONGKD105LEESS1002YOU25"
str_to_lower(ustr)  # 소문자로 바꾸기 # "hongkd105leess1002you25"

#연습문제 91 4)

data2 <- c('2017-02-05 수입3000원',
           '2017-02-06 수입4500원',
           '2017-02-07 수입2500원')
library(stringr)


# 생략--ㄱ
# grep("[^0-9]",data2, value= TRUE)
# grep("[0-9]",data2, value= TRUE)
# str_extract_all(data2,'[^0-9]{3}')
#생략 -/
#조건 1) "3000원" "4500원" "2500원" 출력되도록 하라
str_extract(data2,'[0-9]{4,5}[가-힣]')  #"3000원" "4500원" "2500원"

#조건2) '--수입원' '--수입원' '--수입원' 형식으로 나오도록 하라

str_replace_all(data2,'[0-9]{1}','')  # "-- 수입원" "-- 수입원" "-- 수입원"
#조건3) -을 /로 바꾸어라
str_replace_all(data2,'-','/')

# scan()
num <-scan()  # 데이터를 직접 input함
num
sum(num)

name <- scan(what = character())
name

#
titanic<- read.csv("https://vincentarelbundock.github.io/Rdatasets/csv/COUNT/titanic.csv")
head(titanic)
str(titanic)
# 'data.frame':	1316 obs. of  5 variables:
#   $ X       : int  1 2 3 4 5 6 7 8 9 10 ...
# $ class   : chr  "1st class" "1st class" "1st class" "1st class" ...
# $ age     : chr  "adults" "adults" "adults" "adults" ...
# $ sex     : chr  "man" "man" "man" "man" ...
# $ survived: chr  "yes" "yes" "yes" "yes" ...


table(titanic$age)
table(titanic$sex)
table(titanic$survived)
table(titanic$survived,titanic$sex)#교차분할표 : table( 데이터$행기준칼럼명, 데이터$열기준칼럼명)

tab<-table(titanic$survived,titanic$sex)
barplot(tab, col=rainbow(2),main='성별에 따른 생존여부')

#
getwd()
setwd('c:/Rwork')
write.table(titanic,'titanic.txt',row.names = FALSE)

#저장된 것 불러오기
titanic_df <- read.table(file = 'titanic.txt',sep='',header=T)
titanic_df

#연습문제 3장106p
#1)

# 해당폴더에 파일 저장
setwd('c:/Rwork/output') 
write.csv(titanic,'titanic.csv',row.names = FALSE)
# 해당파일 변수로 가져와 관측치와 칼럼수 확인
titanicData<-read.csv('titanic.csv')
str(titanicData)
#
head(titanicData)
head(filter(titanicData[,c(2,4,5)]))


#2번 ????????????????????????????????????????????????????????
data(CO2)
head(CO2)
CO2[3]
CO2$Treatment
if( CO2[,3]=='nonchilled'){
  write.csv(titanicData,file='CO2_df1.csv',row.names = F)
}else {write.csv(titanicData,file='CO2_df2.csv',row.names = F)}


# KoNLP 패키지 설치하기 -> 그전에 자바 설치되어야함
.libPaths() # 패키지 경로확인 :r이 저장된 경로 
#[1] "C:/Users/CPB06GameN/Documents/R/win-library/4.0"
# [2] "C:/Program Files/R/R-4.0.2/library"

#java 설치하기 #https://java.com/ko/download/manual.jsp
Sys.getenv("JAVA_HOME")  # ""
Sys.setenv(JAVA_HOME='C:\\Program Files\\Java\\jre1.8.0_291')#자바설정
#### 역슬래시는 한번만 있을 때 에러뜸 :'\P'는 인식할 수 없는 이스케이프~
#=> 따라서 /슬래시 아니면 \\역슬래시 2번써주어야함
Sys.getenv("JAVA_HOME") # "C:\\Program Files\\Java\\jre1.8.0_291"

install.packages('rJava')#자바패키지 설치
library(rJava)
install.packages('KoNLP') #한글 패키지 설치
library(KoNLP)
install.packages('remotes') #한글 패키지 설치
remotes::install_github('haven-jeon/KoNLP',upgrade='never',INSTALL_opts = c('--no-multiarch'))

library(KoNLP)  # KoNLP는 한국어를 분석하는 패키지


#wordcloud2 는 워드클라우드 만드는 패키지
install.packages('wordcloud2') 
library(wordcloud2)

#KoNLP- 사전설정
useSystemDic()
useSejongDic() #세종 사전

getwd()
setwd('C:\\Users\\CPB06GameN\\Documents\\practice1_0419\\hankyungr')
#텍스트파일 데이터를 word_data에 할당
word_data <- readLines("data/애국가(가사).txt")
word_data

# 명사추출 : extractNoun  
# 열이름 나타내는 속성 설정 : USE.NAMES = T(;나타냄) / F(;안나타냄)
word_data2<-sapply(word_data,extractNoun,USE.NAMES = F)
word_data2

# add_words 변수의 데이터를 사용자 정의 단어(user_dic )로 추가 
#:buildDictionary(user_dic = data.frame( 벡터데이터셋, rep('ncn',length(벡터데이터셋))), replace_usr_dic = T)
add_words <-c('백두산','남산','철갑','가을','하늘','달')
buildDictionary(user_dic = data.frame(add_words,rep('ncn',length(add_words))),replace_usr_dic = T)
#*덮어쓰기 허용 의미 : replace_usr_dic = T 
#--------------------------------------------------------다음날
