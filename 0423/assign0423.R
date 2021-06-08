#서현진 0423

#제조사별로 'suv'자동차의 도시 및 고속도로 통합연비 평균을 구해 내림차순으로 정렬하고
#1~5위 까지 출력하기
library(ggplot2)
mpg<- data.frame(ggplot2::mpg)
head(mpg)

library(dplyr)

mpg %>% 
  group_by(manufacturer) %>%  #group_by()를 먼저함으로써 mean()의 사용 가능
  filter(class=="suv") %>% 
  mutate(mean_cty_hwy= (cty+hwy)/2) %>% 
  summarise(mean_tot = mean((mean_cty_hwy) )  ) %>% 
  arrange(desc(mean_tot)) %>% 
  head(5)





            