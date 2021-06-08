#0507


## 4.2 분산분석(F 검정) 


# (1) 데이터 전처리 

# 단계 1. 파일 가져오기
getwd()
setwd('C:\\Users\\CPB06GameN\\Documents\\practice1_0419\\hankyungr')

data <- read.csv('data/data3/three_sample.csv',header= TRUE)
head(data)

summary(data$method)
ls(data)
str(data)

# 단계 2. 데이터 정제/전처리 - NA, outline 제거
data <- subset(data, !is.na(score), c(method, score)) 
data # method, score

# 단계 3. 차트이용 - ontlier 보기(데이터 분포 현황 분석)
plot(data$score) # 차트로 outlier 확인 : 50이상과 음수값
barplot(data$score) # 바 차트
mean(data$score) #14.44725
boxplot(data$score)

# 단계 4. outlier 제거 - 평균(14) 이상 제거
length(data$score)
data2 <- subset(data, score <= 14) # 14이하만 data2

# 단계 5. 정제된 데이터 보기 

boxplot(data2$score)
length(data2$score)  # 88


# (2) 세 집단 subset 작성과 기술 통계량 

# 단계 1. 세 집단 subset 작성
data2$method2[data2$method==1] <- "방법1" 
data2$method2[data2$method==2] <- "방법2"
data2$method2[data2$method==3] <- "방법3"

# 단계 2. 교육방법 별 빈도수
table(data2$method2)  
  #방법1 방법2 방법3 
  #31    27    30 

# 단계 3. 교육방법을 x 변수에 저장
x <- table(data2$method2) 
x
# 단계 4. 교육방법에 따른 시험성적 평균 구하기
tapply(data2$score, data2$method2, mean)

tapply(data2$score, data2$method2, shapiro.test)
# 단계 5. 교육방법과 시험성적으로 데이터프레임 생성
df <- data.frame(교육방법 = x, 성적 = y)
df

# (3) 세 집단 간 동질성 검정443 : bartlett.test(종속변수 ~ 독립변수, data=dataset)
bartlett.test(score ~ method2, data=data2)
head(data2)

# (4) 분산분석(세 집단 간 평균 차이 검정) 
head(data2)
result <- aov(score ~ method2, data=data2)
result
names(result)
summary(result) 
result$residuals # 각 잔차
result$coefficient 


plot(result)  # 잔차들의 분산이 일정 p491

abline(result, col=red)


#히스토그램의 시작점과 끝점에 따라 그래프 모양이 달라지는 단점을 보안하기 위한
#대안으로 밀도함수를 이용해보자 
#밀도도표 : density()
density()
plot()
str(iris)

hist(iris$Sepal.Width)
ds_iris <-density(iris$Sepal.Width)
plot(ds_iris) #기본 형태의 밀도 곡선 완성

#내부 색상을 위해서는 먼저 기존 데이터 갖고오기
iris
ds_iris <- density(iris$Sepal.Width)
plot(ds_iris, main='확률 밀도')
polygon(ds_iris,col='lightblue',border='purple')
rug(iris$Sepal.Width, col='blue')


##Q-Q plot
x <- iris$Sepal.Length
par(mfrow=c(1,2))
qqnorm(x)
qqline(x, col= 'red',lwd =2)

#######



#3#################################3 kakao 3api  실습

# curl -v -X GET "https://dapi.kakao.com/v3/search/book?target=title" \
# --data-urlencode "query=미움받을 용기" \
# -H "Authorization: KakaoAK {REST_API_KEY}"


rm(list = ls())

url <- "https://dapi.kakao.com/v3/search/book"
query <- "빅데이터분석"  # "빅데이터분석"과 관련된 책을 찾고 싶을 때 


# 한글로 변환
query <- URLencode(iconv(query, to='UTF-8')) 

#사이트 url %s ?인자 넘기기 # ?인자 넘기기
query_str <- sprintf("%s?target=title&query=%s", url, query)  

query_str
ls()

# 카카오 인증키 넣기
#################################################################
kakao_api_key <-"a6b6735fc9f59b88acdc81b77a1c1cfb"
################################################################
auth_key_no <- sprintf("KakaoAK %s",kakao_api_key)  # 아래 원본 보고 복사
# -H "Authorization: KakaoAK {REST_API_KEY}" # 대소문자 주의!

#사이트 요청
install.packages("httr") # 사이트 요청 패키지
library(httr)

resp <-GET(query_str, add_headers("Authorization"=auth_key_no)) #쿼리로 인증번호 넘김
resp

# 클래스 확인
class(resp)
#[1] "response"
# 문자로 강제 변환

resp_char <-  as.character(resp)

# install.packages('jsonlite') 
library(jsonlite)

d = fromJSON(resp_char)
class(d)
df <- data.frame(d) 
# list를 매트릭스로 변환
txt_1 <- as.matrix(df)

write.csv(txt_1,"kakao_api.csv", row.names = F)


########################### 불러올때 에러 (괄호 및 여러 이름 다음칸에 )
# 카카오 책 이름 갖고 오기
a<-read.csv("kakao_api.csv")

View(a)  # 에러 나야하는데 에러 안남....;;데이터 나오긴 나옴.
View(df)


############################

#Error in read.table(file = file, header = header, sep = sep, quote = quote,  : 
# 열의 개수가 열의 이름들보다 많습니다
View(df)
df[1,1]
df[1,2]

df[2,1]


library(stringr)


for (r in 1:nrow(df)) {  # nrow행의 개수
  for (c in 1:col(df)) {  # 열의수
    df[r,c] = paste(df[r,c], collapse = " ")     # 문자열 하나로 합칠때
    df[r,c] = str_replace_all(df[r,c], "," , ":") # ,를 :로 바꿔라
    
  }
}

View(df)

###################


df2 <- as.matrix(df)
write.csv(df2, "kakao_api_final.csv", row.names = F)
getwd()

