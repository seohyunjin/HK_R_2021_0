# 서현진_21

# 내장함수인 mpg 데이터 세트를 불러오시오
#??mpg
library(ggplot2)
#data("mpg")

mpg<-as.data.frame(ggplot2::mpg)

# 1) mpg 데이터세트를 co_mpg 사본으로 저장
co_mpg <- mpg

# 저장한 co_mpg 데이터 세트를 이용하여  "suv"와 "compact"를 추출하시오
co_mpg[co_mpg$class=="compact" | co_mpg$class=="suv",]

# 2)(추출한 각 변수를 co_suv와 co_compact로 저장)
co_suv <- co_mpg[co_mpg$class=="compact",]
co_compact <- co_mpg[co_mpg$class=="suv",]

# 3)"suv"와 "compact"의 '도시 및 고속도로 통합 연비' 평균을 구해보세요.
#(co_suv$cty +co_suv$hwy)/nrow(co_suv)
#(co_compact$cty +co_compact$hwy)/nrow(co_compact)

(co_suv$cty +co_suv$hwy)/2
(co_compact$cty +co_compact$hwy)/2

#case2) 새로운 파생변수 만들고 mean() 함수 이용해도 되겠다!
tot_suv <- (co_suv$cty +co_suv$hwy)/2

tot_compact <- (co_compact$cty +co_compact$hwy)/2

mean(tot_suv)
mean(tot_compact)

