#서현진 21.04.20


#문제1 : 1부터 10사이의 벡터를 만들어서 V1이라는 벡터에 저장한다.
v1<-c(1:10)
v2<-v1*2 ; v2

max_v <- max(v2)
min_v <- min(v2)
avg_v <- mean(v2)
sum_v <- sum(v2)
v3 <- v2[-5]; v3

v1; v2; v3; max_v; min_v; avg_v; sum_v


#문제2 : seq() 또는 rep()함수를 이용하여 다음과 같이 구성되는 벡터를 생성하여 
#각 v4,v5,v6,v7,v8에 저장후에 출력한다
V4 <- seq(1,9,by=2)
V5 <- rep(1,5)
V6 <- rep(c(1,2,3),3)
V7 <- rep(c(1,2,3,4),each=2)
V8 <- rep(c("A","B"),each=2)

#문제3 : 1부터 100으로 구성되는 10개의 중복되지 않는 데이터를 추출하여 num이라는 변수를 만든다.
nums<-sample(1:100,10,replace=F)
nums
#1) 50부터 큰 원소 값들만 출력한다
nums[which(nums>50)]
#2) 50보다 작거나 같은 원소들의 인덱스를 출력한다
which(nums<=50)
#3) 최대값을 저장하고 있는 원소의 인덱스를 출력한다
which.max(nums)
#4) 최소값을 저장하고 있는 원소의 인덱스를 출력한다.
which.min(nums)
#5) 오름차순으로 정렬한 결과를 출력한다
sort(nums) 
#6) 내림차순으로 정렬한 결과를 출력한다 : name()
sort(nums, decreasing = T) 

#7) 항목에 이름('A','B','C','D','E','F','G','H','I','J')을 부여한다 
names(nums) <- c('A','B','C','D','E','F','G','H','I','J')
nums

#문제 4: 1부터 10까지 출력하는데 3씩 증가되는 형태로 (1 4 7 10) 저장되는 
#벡터를 정의하여 v9 변수에 저장한 다름 r의 내장 벡터를 활용하여 v9의 각 원소에 
# 'A','B','C','D'라는 이름을 부여한다.

v9<-seq(1,10,by=3)
data.frame(v9,name=c('A','B','C','D'))



#문제5: 1부터 20으로 구성되는 5개의 중복되지 않는 데이터를 추출하여 
#score1 이라는 벡터를 만든다.
score1<-sample(1:20,5,replace=F) ; score1

#1) Friends 이라는 이름으로 '둘리' '또치''도우너''희동''듀크'값으로 벡터를 만든다
Friends <- c('둘리', '또치','도우너','희동','듀크'); Friends
df <- data.frame(Friends,score1)
df
#2) 점수가 가장 높은 친구의 이름을 출력한다
df[which.max(score1),1]
#3) 점수가 가장 낮은 친구의 이름을 출력한다
df[which.min(score1),1]
#4) 점수가 10점보다 높은 친구의 이름들을 출력한다.
df[which(score1>10),1]

#문제5번 case2] df에 굳이 연결하지 않아도 됨.
score1<-sample(1:20,5,replace=F) ; score1
Friends <- c('둘리', '또치','도우너','희동','듀크'); Friends
Friends[which.max(score1)]
Friends[which.min(score1)]
Friends[which(score1>10)]


