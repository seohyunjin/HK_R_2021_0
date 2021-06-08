#2021.05.10 Data Analytics
#Team Complete 
#00. 시스템 언어 설정
Sys.setlocale("LC_ALL","C")
Sys.setlocale("LC_ALL","korean")

#01. food 데이터셋 불러오기 및 전처리하기. 
library(readxl)
food <- read_excel("c:/Rproject/Team_Complete/data/food.xlsx")

food
library(dplyr)
food <- rename(food,date='일')

#02. rain_dummy_2 데이터셋 불러오기 및 전처리하기.
rain_dummy <- read.csv("C:/Rproject/Team_Complete/data/rain_2019_dummy_2.csv")
rain_dummy$date <- as.Date(rain_dummy$date)

#03. 데이터 취합하기.
project_data <- left_join(food,rain_dummy,id="date")

#04. rain_yn변수를 기준으로 그룹 분류하기.
group_rn <- project_data[project_data$rain_yn==0,] #비가 안왔을 때(rain-no)의 그룹
group_ry <- project_data[project_data$rain_yn==1,] #비가 왔을 때(rain-yes)의 그룹

#05. 두 그룹의 김치찌개 변수의 평균 비교하기.
mean(group_rn$김치찌개) ; mean(group_ry$김치찌개)

#06. 가설 설정하기.
#H0: 비가 안올 때와 비올 때, 김치찌개의 검색빈도 평균은 차이가 없다.
#H1: 비 올 때 김치찌개의 검색빈도 평균은 비가 안올 때 검색빈도 평균보다 크다. (단측검정)

#07. 등분산 검정하기.
var.test(group_rn$김치찌개,group_ry$김치찌개)
#result, p-value=0.1563 > alpha=0.05이므로, 귀무가설 채택
#두 그룹의 김치찌개 변수는 등분산이다.

#08. t-test
t.test(group_rn$김치찌개,group_ry$김치찌개,alternative ="less",var.equal=T)
#result, p-value=0.01570 < 0.05이므로, 대립가설 채택
#비 올 때 김치찌개의 검색빈도 평균은 비가 안올 때 검색빈도 평균보다 크다.