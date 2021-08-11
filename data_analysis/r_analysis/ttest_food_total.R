#현진

#분석
#01. food 데이터셋 불러오기 및 전처리하기. 
library(readxl)
food <- read_excel("c:/Rproject/Team_Complete/data/0514food.xlsx")
library(dplyr) # rename()사용하려고
food <- rename(food,date='일')

#02. rain_dummy_2 데이터셋 불러오기 및 전처리하기.
rain_dummy <- read.csv("C:/Rproject/Team_Complete/data/rain_2019_dummy_2.csv")
rain_dummy$date <- as.Date(rain_dummy$date)
# str(rain_dummy)

#03. 데이터 취합하기. left_join(취합하고싶은 데이터셋1, 데이터셋2, id='기준칼럼명')
project_data <- left_join(food,rain_dummy,id="date")
# View(project_data)

#04. rain_yn변수를 기준으로 그룹 분류하기.
group_rn <- project_data[project_data$rain_yn==0,] #비가 안왔을 때(rain-no)의 그룹
group_ry <- project_data[project_data$rain_yn==1,] #비가 왔을 때(rain-yes)의 그룹


##############################수박
#평균비교
mean(group_rn$수박); mean(group_ry$수박) #ry의 평균이 더 크다. -> less이용

var.test(group_rn$수박, group_ry$수박) #0.92이므로 0.05보다 크므로 귀무가설 채택. 등분산이다
#var.test의 귀무가설(0.05보다 큼) : 등분산이다. 대립가설(0.05보다 작음) : 이분산이다. 

t.test(group_rn$수박, group_ry$수박, alternative = 'less',var.equal=T) 
#rn_수박이 더 작았으므로 alternative = 'less'
#등분산이므로 var.equal=T
# p-value = 0.04016 이므로 0.05보다 작으므로 영가설 기각, 대립가설 채택
#해석 : 대립가설 선택이므로, 비가 안올때 수박의 검색빈도 평균은 비가 올때 검색빈도 평균보다 작다.
#즉, 비올떄 검색빈도가 더 크다.


###############################참외
#평균비교
mean(group_rn$참외); mean(group_ry$참외) #ry의 평균이 더 크다. -> less 이용

var.test(group_rn$참외, group_ry$참외) #0.92이므로 0.05보다 크므로 귀무가설 채택. 등분산이다
#var.test의 귀무가설(0.05보다 큼) : 등분산이다. 대립가설(0.05보다 작음) : 이분산이다. 

t.test(group_rn$참외, group_ry$참외, alternative = 'less',var.equal=T) 
#rn_참외이 더 작았으므로 alternative = 'less'
#등분산이므로 var.equal=T
# p-value = 0.07194 이므로 0.05보다 크므로 영가설 채택, 대립가설 기각
# 즉 차이가 없다.

###########################메론
#평균비교
mean(group_rn$메론); mean(group_ry$메론) #ry의 평균이 더 크다. -> less 이용

var.test(group_rn$메론, group_ry$메론) #4.138e-05이므로 0.05보다 작으므로 대립가설 채택. 이분산이다
#var.test의 귀무가설(0.05보다 큼) : 등분산이다. 대립가설(0.05보다 작음) : 이분산이다. 

t.test(group_rn$메론, group_ry$메론, alternative = 'less',var.equal=F) 
#rn_메론이 더 작았으므로 alternative = 'less'
#이분산이므로 var.equal=F
# p-value = 0.0008922 이므로 0.05보다 작으므로 영가설 기각, 대립가설 채택
#해석 : 대립가설 선택이므로, 비가 안올때 메론의 검색빈도 평균은 비가 올때 검색빈도 평균보다 작다.
#즉, 비올때 검색빈도가 더 크다.

###########################오렌지
#05. 두 그룹의 오렌지 변수의 평균 비교하기.
mean(group_rn$오렌지) ; mean(group_ry$오렌지) #rn의 평균이 더 크다 ->greater

#가설 설정하기.
#H0: 비가 안올 때와 비올 때, 오렌지의 검색빈도 평균은 차이가 없다.
#H1: 비 올 때 오렌지의 검색빈도 평균은 비가 안올 때 검색빈도 평균보다 작다. (단측검정)

#등분산 검정하기. 
var.test(group_rn$오렌지,group_ry$오렌지)
#result, p-value=0.2101 > alpha=0.05이므로, 귀무가설 채택
#두 그룹의 오렌지 변수는 등분산이다.

# t-test #평균비교
t.test(group_rn$오렌지,group_ry$오렌지,alternative ="greater",var.equal=T)
#오렌지의 경우,  p >0.05이므로 영가설 채택, 대립가설 기각
#해석 : 영가설 채택이므로, 비에 따라 오렌지검색빈도 차이에 평균은 없다. 

###########################매실짱아찌 
#평균비교
mean(group_rn$매실짱아찌); mean(group_ry$매실짱아찌) #ry의 평균이 더 크다. -> less 이용

var.test(group_rn$매실짱아찌, group_ry$매실짱아찌) #1.34e-06이므로 0.05보다 작으므로 대립가설 채택. 이분산이다
#var.test의 귀무가설(0.05보다 큼) : 등분산이다. 대립가설(0.05보다 작음) : 이분산이다. 

t.test(group_rn$매실짱아찌, group_ry$매실짱아찌, alternative = 'less',var.equal=F) 
#rn_매실짱아찌이 더 작았으므로 alternative = 'less'
#이분산이므로 var.equal=F
# p-value = 0.09746 이므로 0.05보다 크므로 영가설 채택, 대립가설 기각
#해석 : 영가설 선택이므로, 비가 안올때 매실짱아찌의 검색빈도 평균은 비가 올때 검색빈도 평균보다 작다.
#즉, 차이가 없다.

###########################물회
#평균비교
mean(group_rn$물회); mean(group_ry$물회) #ry의 평균이 더 크다. -> less 이용

var.test(group_rn$물회, group_ry$물회) #p-value = 0.8529이므로 0.05보다 크므로 영가설 채택. 등분산이다
#var.test의 귀무가설(0.05보다 큼) : 등분산이다. 대립가설(0.05보다 작음) : 이분산이다. 

t.test(group_rn$물회, group_ry$물회, alternative = 'less',var.equal=T) 
#rn_물회이 더 작으므로 alternative = 'less'
#등분산이므로 var.equal=T
# p-value = 0.1383 이므로 0.05보다 크므로 영가설 채택, 대립가설 기각
# 비가 물회검색량의 평균에 영향을 미치지 않는다. 
#############################포도
#평균비교
mean(group_rn$포도); mean(group_ry$포도) #ry의 평균이 더 크다. -> less 이용

var.test(group_rn$포도, group_ry$포도) #0.02168이므로 0.05보다 작으므로 대립가설 채택. 이분산이다
#var.test의 귀무가설(0.05보다 큼) : 등분산이다. 대립가설(0.05보다 작음) : 이분산이다. 

t.test(group_rn$포도, group_ry$포도, alternative = 'less',var.equal=F) 
#rn_포도이 더 작았으므로 alternative = 'less'
#이분산이므로 var.equal=F
# p-value = 0.005403 이므로 0.05보다 작으므로 영가설 기각, 대립가설 채택
#해석 : 대립가설 선택이므로, 비가 안올때 포도의 검색빈도 평균은 비가 올때 검색빈도 평균보다 작다.
#즉, 비올때 검색빈도가 더 크다.

##################미숫가루 
#평균비교
mean(group_rn$미숫가루); mean(group_ry$미숫가루) #ry의 평균이 더 크다. -> less 이용

var.test(group_rn$미숫가루, group_ry$미숫가루) #p-value = 0.4837이므로 0.05보다 크므로 영가설 채택. 등분산이다
#var.test의 귀무가설(0.05보다 큼) : 등분산이다. 대립가설(0.05보다 작음) : 이분산이다. 

t.test(group_rn$미숫가루, group_ry$미숫가루, alternative = 'less',var.equal=T) 
#rn_미숫가루이 더 작았으므로 alternative = 'less'
#등분산이므로 var.equal=T
# p-value = 0.06916 이므로 0.05보다 크므로 영가설 채택, 대립가설 기각
#해석 : 영가설 선택이므로, 비가 안올때 미숫가루의 검색빈도 평균은 비가 올때 검색빈도 평균보다 작다.
#즉, 차이가 없다.

################## 해물찜 
#평균비교
mean(group_rn$해물찜); mean(group_ry$해물찜) #ry의 평균이 더 크다. -> less 이용

var.test(group_rn$해물찜, group_ry$해물찜) #p-value = 0.1138이므로 0.05보다 크므로 영가설 채택. 등분산이다
#var.test의 귀무가설(0.05보다 큼) : 등분산이다. 대립가설(0.05보다 작음) : 이분산이다. 

t.test(group_rn$해물찜, group_ry$해물찜, alternative = 'less',var.equal=T) 
#rn_해물찜이 더 작았으므로 alternative = 'less'
#등분산이므로 var.equal=T
# p-value = 0.005504 이므로 0.05보다 작으므로 영가설 기각, 대립가설 채택
# 비올때 해물찜 검색량의 평균이 더 크다.

##################꼬리곰탕
#평균비교
mean(group_rn$꼬리곰탕); mean(group_ry$꼬리곰탕) #ry의 평균이 더 작다. -> greater 이용

var.test(group_rn$꼬리곰탕, group_ry$꼬리곰탕) #p-value = 0.1037이므로 0.05보다 크므로 영가설 채택. 등분산이다
#var.test의 귀무가설(0.05보다 큼) : 등분산이다. 대립가설(0.05보다 작음) : 이분산이다. 

t.test(group_rn$꼬리곰탕, group_ry$꼬리곰탕, alternative = 'greater',var.equal=T) 
#rn_꼬리곰탕이 더 크므로 alternative = 'greater'
#등분산이므로 var.equal=T
# p-value = 0.2877 이므로 0.05보다 크므로 영가설 채택, 대립가설 기각
# 비가 꼬리곰탕검색량의 평균에 영향을 미치지 않는다. 