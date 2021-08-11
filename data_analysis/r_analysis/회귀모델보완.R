#21.05.13
#Team Complete

#01. 데이터셋 불러오기.
library(readxl)
food_eol <- read_excel("d:/Rproject/Team_Complete/data/20210513_food_eol.xlsx")
weather <- read_excel("d:/Rproject/Team_Complete/data/weather.xlsx")

#02. weather 데이터셋의 주성분 분석 (차원축소)
weather_prcomp <- prcomp(weather[,-1])
weather_prcomp
summary(weather_prcomp)
plot(weather_prcomp, type="l",sub = "Scree Plot")
weather_pc1 <- predict(weather_prcomp)[,1] 
weather_pc2 <- predict(weather_prcomp)[,2] 
weather_pc3 <- predict(weather_prcomp)[,3] 
weather_pc4 <- predict(weather_prcomp)[,4] 
weather_pca <- data.frame(weather$date,
                          weather_pc1,
                          weather_pc2,
                          weather_pc3,
                          weather_pc4)
library(dplyr)
weather_pca <- rename(weather_pca,date=weather.date)

#03. food_eol 데이터셋의 제곱근 변환
food_sqrt <- sqrt(food_eol[,-1])
#sqrt(): 함수에 제곱근을 취하는 함수
food_sqrt <- data.frame(food_eol$date,
                        food_sqrt)
food_sqrt <- food_sqrt %>% 
  rename(date=food_eol.date)

#04. 상관관계 파악
cor(x=food_sqrt[,-1],y=weather_pca[,-1])

shapiro.test(food_eol$꼬막무침)

#05. weather_pca와 food_sqrt$꼬막무침의 인과관계 파악
lm_model_01 <- lm(formula=food_sqrt$꼬막무침~.,data=weather_pca[,-1])
glm_model_01 <- glm(formula=food_sqrt$꼬막무침~weather_pc1+weather_pc2,
                    data=weather_pca[,-1],family="poisson")

summary(lm_model_01)
summary(glm_model_01)

#06. 단계적 변수 선택법을 통한 최적회귀식 도출
step(lm_model_01,direction="both")
lm_model_01_fit <- lm(formula = food_sqrt$꼬막무침 ~ weather_pc1 + weather_pc2 + 
                        weather_pc4, data = weather_pca[, -1])
summary(lm_model_01_fit)

#07. 다중회귀분석모형 진단하기.
par(mfrow=c(2,2)) ; plot(lm_model_01_fit)

dev.new() ; plot(lm_model_01_fit)
?glm()
#step01. 다중공선성
library(car)
vif(lm_model_01_fit)

#step02. 잔차의 정규성
shapiro.test(lm_model_01_fit$residuals)

#step03. 잔차의 등분산성
library(lmtest)
bptest(lm_model_01_fit)

#step04. 잔차의 독립성
dwtest(lm_model_01_fit)

#result 등분산성, 독립성 불만족
