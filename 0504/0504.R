getwd()
setwd('C:\\Users\\CPB06GameN\\Documents\\practice1_0419\\hankyungr')
dataset<-read.csv('data/data3/dataset.csv')
head(dataset)
tail(dataset)

names(dataset)
attributes(dataset)
str(dataset)

dataset$age
dataset$resident
length(dataset$age)
x<-dataset$gender
y<-dataset$price
x
y

plot(dataset$price)

dataset['gender']
dataset['price']
dataset[2]
dataset[6]
dataset[3, ]
dataset[, 3]

dataset[c('job','price')]
dataset[c(2,6)]
dataset[c(1,2,3)]
dataset[c(2,4:6,3,1)]

dataset[,c(2:4)] #모든행의 2부터 4열 조회

dataset[c(2:4),] #모든 열의 2부터 4행 조회
dataset[-c(1:290),]

#결측치 확인
summary(dataset$price)
sum(dataset$price)
sum(dataset$price,na.rm=T)

price2<-na.omit(dataset$price)
sum(price2)
length(price2)

#결측치 대체
#0 으로 결측치 대체
x<-dataset$price
x[1:30]
#결측치가 아니라면 x 그대로 넣고, 결측치면 0으로 대체해줘 #부등호=한개 주의!!!
dataset$price2 = ifelse(!is.na(x),x,0)

dataset$price2[1:30]

#평균으로 대체
x<-dataset$price
round(mean(x,na.rm=TRUE),2) # 8.75 평균값
dataset$price3 = ifelse(!is.na(x),x,round(mean(x,na.rm=TRUE),2)) #결측치면 
dataset$price3[1:30]

dataset[c('price','price2','price3')]

#극단치 처리
table(dataset$gender)
pie(table(dataset$gender))

#
dataset <-subset(dataset,gender==1|gender==2)
dataset
length(dataset$gender)
pie(table(dataset$gender))
pie(table(dataset$gender),col=c('red','blue'))

dataset <- read.csv('data/data3/dataset.csv',header=T)
dataset$price
length(dataset$price)
plot(dataset$price)
summary(dataset$price)

dataset2<-subset(dataset,price>=2 & price <=8)
length(dataset2$price)
stem(dataset2$price)

summary(dataset2$age) #NA 발견

length(dataset$age)
dataset2 <-subset(dataset2, age>=20 &age <=69)
length(dataset2)
boxplot(dataset2$age)

#극단치를 찾기 어려운 경우
#- 극단치 통계확인
boxplot(dataset$price)
boxplot(dataset$price)$stats

dataset_sub <- subset(dataset,price >=2.1 & price <=7.9)
summary(dataset_sub$price)

#가독성을 위한 코딩 변경
dataset2$resident2[dataset2$resident==1] <-'1.서울특별시'
dataset2$resident2[dataset2$resident==2] <-'2.인천광역시'
dataset2$resident2[dataset2$resident==3] <-'3.대전광역시'
dataset2$resident2[dataset2$resident==4] <-'4.대구광역시'
dataset2$resident2[dataset2$resident==5] <-'5.시구군'

dataset2[c('resident','resident2')]



#
#데이터프레임만들기
promote <-c(220,210,170,180,70,45,52,10,8,9)
price <- c(2500,2100,1500,1200,650,540,480,220,150,125)
df<-data.frame(promote,price)

#데이터프레임 csv파일로 저장
write.csv(df,file='data/promote.csv',row.names = FALSE)

#엑셀 >파일 >옵션 > 추가기능 > 분석기구 추가

#라면 promote.csv 불러와서 pro_df로 저장

pro_df <- read.csv('data/promote.csv')
head(pro_df)
str(pro_df)

# 정규성검정 : shapiro.test()  #; 분석전에 해야함!
shapiro.test(pro_df$price) # 0.05보다 큼 -> 정규성 o #; 종속변수
shapiro.test(pro_df$promote) # 0.05보다 작음 -> 정규성 x

shapiro.test(resid(pro_lm))  #W = 0.88428, p-value = 0.1461 #;p가 0.05보다 큼: 정규성 띈다
#정규성파악 : shapiro.test (resid(리디어 모델변수))

#상관관계 //엑셀의 상관분석과 동일
cor(pro_df)

#lm('데이터셋명',종속변수 ~독립변수)
lm(data= pro_df, price ~ promote )
pro_lm <-lm(data= pro_df, price ~ promote )  #1) 리니어모델하기
pro_lm
summary(pro_lm) #2) summary하기

par(mfrow = c(2,2))
plot(pro_lm)  #3) plot하기

#광고비가 한 단위 증가하면 매출액은 9배인 9억 정도 증가한다


#
head(cars)
lm(data=cars,dist ~speed)  #거리를 얼마만큼 

lm.dist <- lm(data=cars, dist ~speed)
lm.dist
summary(lm.dist)
plot(lm.dist)


