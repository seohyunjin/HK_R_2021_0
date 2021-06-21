#0621_현진_다중회귀분석_ 굴 생물, 대게/킹크랩/랍스타, 딸기/복분자/블루베리, 문어


#1.데이터셋 가져오기
library(readxl)
food<- read_excel("C:/R_project/Team_Complete/data/2019_sns_hj.xlsx")
weather<- read_excel("C:/R_project/Team_Complete/data/weather_2.xlsx") #날씨12개속성데이터


#2. 데이터셋 합치기
library(dplyr)
regression_food_hj <- left_join(food,weather,by="date")


#3-0  다중선형회귀분석 

#3-1. 다중회귀 _굴/생물
lm_model_01 <- lm(formula=regression_food_hj$굴_생물~.,data=weather[,-1])
summary(lm_model_01)
 #p-value: < 2.2e-16  # Adjusted R-squared:  0.6783 

#3-2. 다중회귀 _대게/킹크랩/랍스타
lm_model_02 <- lm(formula=regression_food_hj$대게_킹크랩_랍스타~.,data=weather[,-1])
summary(lm_model_02)
#  p-value: < 2.2e-16  # Adjusted R-squared:  0.4044

#3-3. 다중회귀 _딸기_복분자_블루베리
lm_model_03 <- lm(formula=regression_food_hj$딸기_복분자_블루베리~.,data=weather[,-1])
summary(lm_model_03)
#p-value: < 2.2e-16  # Adjusted R-squared:  0.7055 

#3-4. 다중회귀 _문어
lm_model_04 <- lm(formula=regression_food_hj$문어~.,data=weather[,-1])
summary(lm_model_04)
#p-value: < 2.2e-16  # Adjusted R-squared:  0.4375 


#4-0. 단계적 변수 선택

#4-1. 최적회귀식 _굴/생물
step(lm_model_01,direction="both")

#stepwise 나온대로 # case1
lm_model_01_fit <-lm(formula = regression_food_hj$굴_생물 ~ 평균온도 + 최고기온 + 
     평균이슬점온도 + 최소상대습도 + 평균상대습도 + 합계일조시간 + 
     합계일사량 + 합계대형증발량, data = weather[, -1])
# 위 회귀 결과 유의성 띄는 것만 # case2
lm_model_01_fit <-lm(formula = regression_food_hj$굴_생물 ~ 평균온도 + 합계일조시간 +
                       합계일사량+ 최소상대습도 , data = weather[, -1])

summary(lm_model_01_fit)  # case1 # Adjusted R-squared:  0.679   # p-value: < 2.2e-16
summary(lm_model_01_fit)  # case2 # Adjusted R-squared:  0.6683  # p-value: < 2.2e-16

#4-2. 최적회귀식 _대게/킹크랩/랍스타
step(lm_model_02,direction="both")

#stepwise 나온대로 # case1
lm_model_02_fit <- lm(formula = regression_food_hj$대게_킹크랩_랍스타 ~ 평균이슬점온도 + 
                       평균상대습도 + 합계일조시간 + 합계일사량 + 평균지면온도, 
                     data = weather[, -1])
# 위 회귀 결과 유의성 띄는 것만 # case2
lm_model_02_fit <- lm(formula = regression_food_hj$대게_킹크랩_랍스타 ~평균지면온도
                      , data = weather[, -1])


summary(lm_model_02_fit) # case1 # Adjusted R-squared:  0.4125 # p-value: < 2.2e-16
summary(lm_model_02_fit) # case2 # Adjusted R-squared:  0.395  # p-value: < 2.2e-16
  
#4-3. 최적회귀식_딸기_복분자_블루베리
step(lm_model_03,direction="both")

#stepwise 나온대로 # case1
lm_model_03_fit <- lm(formula = regression_food_hj$딸기_복분자_블루베리 ~ 최저기온 + 
                        최고기온 + 평균이슬점온도 + 평균상대습도 + 합계일조시간 + 
                        합계일사량 + 평균지면온도 + 합계소형증발량, data = weather[,-1])
# 위 회귀 결과 유의성 띄는 것만 # case2 
lm_model_03_fit <- lm(formula = regression_food_hj$딸기_복분자_블루베리 ~
                        최저기온 + 평균이슬점온도 + 평균상대습도 + 합계일조시간 + 
                        합계일사량 + 평균지면온도 , data = weather[, -1])

summary(lm_model_03_fit) # case1 # Adjusted R-squared:  0.7078 # p-value: < 2.2e-16
summary(lm_model_03_fit) # case2 # Adjusted R-squared:  0.6974 # p-value: < 2.2e-16


#4-4. 최적회귀식_문어
step(lm_model_04,direction="both")

#stepwise 나온대로 # case1
lm_model_04_fit <- lm(formula = regression_food_hj$문어 ~ 평균이슬점온도 + 
                        평균상대습도 + 합계일조시간 + 합계일사량 + 평균지면온도, 
                      data = weather[, -1])
# 위 회귀 결과 유의성 띄는 것만 # case2
lm_model_04_fit <- lm(formula = regression_food_hj$문어 ~ 최저기온 + 합계일사량, 
                      data = weather[, -1])

summary(lm_model_04_fit) # case1 #Adjusted R-squared:  0.4129 #p-value: < 2.2e-16
summary(lm_model_04_fit) # case2 # Adjusted R-squared: 0.4237 #p-value: < 2.2e-16


#5-0 다중 공선성파악
# install.packages("car")
library(car)
# 최적회귀식 전에는 다중공선성 매우매우매우 많음.

#5-1. 최적회귀식에 대하여 다중공선성파악(ㅇ= 문제있음 / x = 문제없음)
vif(lm_model_01_fit)  #case1:o  // case2:x
vif(lm_model_02_fit) #case1:o  // case2: 변수1개이므로 x
vif(lm_model_03_fit) #case1:o  // case2:o
vif(lm_model_04_fit) #case1:o  // case2:x

