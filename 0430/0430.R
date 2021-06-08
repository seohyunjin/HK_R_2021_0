#¼­ÇöÁø#
###0430####

# µğ·ºÅÍ¸® ¼³Á¤
getwd()
setwd('C:\\Users\\CPB06GameN\\Documents\\practice1_0419\\hankyungr')

#¶óÀÌºê·¯¸® ¼³Ä¡
library(stringr)
library(KoNLP) #ÇÑ±ÛÆĞÄ¡
library(wordcloud)
library(wordcloud2) 
library(dplyr)  # rename()»ç¿ëÇÏ·Á°í

rm(list=ls())
#µ¥ÀÌÅÍ ºÒ·¯¿À±â ; ºñÁ¤Çüµ¥ÀÌÅÍ ÃßÃâ ¿¹Á¦
txt <- readLines('data/hiphop.txt')
head(txt)

#µ¥ÀÌÅÍ Á¤Á¦;  ±ÛÀÌ ¾Æ´Ñ°ÍÀ» ´Ù »èÁ¦ÇÏ°ÚÀ½
txt <- str_replace_all(txt,"\\W"," ")  #-> wordÁï, ´Ü¾î°¡ ¾Æ´Ñ°Í
# txt <- str_replace_all(txt,'[^[:alpha:]|[:blank:]]','')   #->¿µ¾î¸¸ ³²°ÔµÊ
# txt <- str_replace_all(txt,"[^[°¡-ÆR] ]|[:space:]" ,"") # ÀÌ¶§ space±îÁö ÇØ¹ö¸®¸é ¸ğµç space»ç¶óÁü
txt
head(txt)
### [^[°¡-ÆR] ] ¿¡ ¶ç¾î¾²±â¸¦ ¾²Áö ¾ÊÀ¸¸é [^[°¡-ÆR]] ¸ğµç ±ÛÀÚ°¡ ´Ù ºÙ¾î¹ö¸²



# ¸í»ç ÃßÃâ
nouns<- extractNoun(txt)
head(nouns,50)


#¸í»ç list¸¦ º¤ÅÍ·Î º¯È¯ ; ´Ü¾î ºóµµÇ¥»ı¼º
wordcount<- table(unlist(nouns)) ; wordcount 
head(wordcount)


#µ¥ÀÌÅÍ ÇÁ·¹ÀÓÀ¸·Î º¯È¯ # ¹®ÀÚ°¡ÆåÅÍ°¡ ¾ÈµÇ°Ô²û ¹æÁö : stringsAsFactors = F
df_word <- as.data.frame(wordcount, stringsAsFactors = F)

#º¯¼ö¸í ¼öÁ¤ : rename(µ¥ÀÌÅÍ, ½Å¹öÀü= ±¸¹öÀü, ½Å¹öÀü = ±¸¹öÀü)
df_word <- rename(df_word, word= Var1, freq= Freq)
df_word
head(df_word)

# µÎ±ÛÀÚ ÀÌ»ó ´Ü¾î ÃßÃâ
df_word <- filter(df_word, nchar(word) >= 2 )

# df_word ¿¡¼­ freq³»¸²Â÷¼øÀ¸·Î Á¤·ÄÈÄ 20°³ µ¥ÀÌÅÍ¸¦ ÇÒ´çÇÏ°Ú´Ù
top_20 <-df_word %>% 
  arrange(desc(freq)) %>% 
  head(20)

# ¿öµåÅ¬¶ó¿ìµå ¸¸µé±â

# ´Ü¾î »ö»ó ¸ñ·Ï ¸¸µé±â

dev.new() #»õÃ¢¶ç¿ì±â
display.brewer.all()  #»õÃ¢¶ç¿ì±â¿Í µ¿½Ã¿¡ ½ÇÇàÇÏ¿©¾ß Ãâ·ÂµÊ


pal <- brewer.pal(8,'Dark2')  #Dark2 »ö»ó ¸ñ·Ï¿¡¼­ 8°³ÀÇ »öÀ» ÃßÃâ
pal <- brewer.pal(9,'PuBu')
pal <- brewer.pal(9,'PuBu')[5:9]


#set.seed(1) # ³­¼ö °íÁ¤

wordcloud(words = df_word$word, #´Ü¾î
          freq = df_word$freq, # ºóµµ
          min.freq = 2, #ÃÖ¼Ò´Ü¾î ºóµµ
          max.words = 200, # Ç¥Çö ´Ü¾î¼ö
          random.order = F, # °íºóµµ ´Ü¾î Áß¾Ó¹èÄ¡
          rot.per = .1, # È¸Àü ´Ü¾î ºñÀ²
          scale = c(4,0.3),  # ´Ü¾î Å©±â ¹üÀ§
          colors = pal)  #»ö¸ñ·Ï



######dplyr ÆĞÅ°Áö º¹½ÀÇØº¸±â##############

data(mtcars)
head(mtcars)
mtcars %>% filter(cyl==6) %>% 
  mutate(mean_gear = mean(gear)) %>% 
  summarise(mean_carb = mean(carb)) #summariseÇÏ¸é ¼³Á¤ÇÑ ÇÔ¼ö¸¸ ³ª¿È

summarise(mtcars, mean_carb=mean(carb)) # ÆÄÀÌÇÁ ¾²³ª ¾È¾²³ª ¶È°°Àº °á°ú³ª¿È
    

######################QUIZ]
# ¿¬½À¹®Á¦248
#1)
library(readxl)
middle_mid_exam <- read_excel('data/middle_mid_exam.xlsx') 
head(middle_mid_exam)


#3)
middle_mid_exam %>% group_by(CLASS) %>%
  mutate(mean_english=mean(ENGLISH)) %>% 
  mutate(sum_english = sum(ENGLISH)) %>% 
  mutate(mean_math = mean(MATHEMATICS)) %>%
  mutate(sum_math = sum(MATHEMATICS)) %>% 
  summarise(mean_english,sum_english,mean_math,sum_math) %>% 
  unique()
  
#4)
num4<-middle_mid_exam %>%  filter(CLASS== 'class1'& MATHEMATICS >= 80 )
nrow(num4)  # 3¸í

#5)
middle_mid_exam %>%  arrange(desc(MATHEMATICS),ENGLISH)

#6)
num6<-middle_mid_exam %>%  filter(ENGLISH>=85& MATHEMATICS >= 80 )
nrow(num6)  #3¸í

###tibbleÇü½Ä ÀÚ·áµµ nrow() »ç¿ë °¡´É

#######################  Æ®¸®¸Ê¸¸µé±â################
#µ¥ÀÌÅÍ ºÒ·¯¿À±â
ck<- read_excel('data/Ä¡Å²Áı_°¡°ø.xlsx')
ck

#¿øÇÏ´Â µ¥ÀÌÅÍ ¿­¿¡¼­ ¿øÇÏ´Â ¹®ÀÚ¿­ ºÎºĞÃßÃâ : substr(µ¥ÀÌÅÍ$Ä®·³¸í,½ÃÀÛºÎºĞÀÎµ¦½º,³¡ºÎºĞÀÎµ¦½º)
addr <- substr(ck$¼ÒÀçÁöÀüÃ¼ÁÖ¼Ò,11,16)
head(addr)
str(addr) # chr [1:1515]  º¤ÅÍÀÓ

# °¡Á®¿Â º¤ÅÍµ¥ÀÌÅÍ¸¦ ¿øÇÏ´Â´ë·Î °¡°ø : gsub('¾ø¾Ö°í ½ÍÀº ¹®ÀÚ Á¤±Ô½ÄÇ¥Çö','',µ¥ÀÌÅÍ) 
addr_num <- gsub('[0-9]','',addr) 
head(addr_num) #¼ıÀÚ Á¦°ÅÇÔ
addr_trim <- gsub(' ','',addr_num) ; 
head(addr_trim) #¹®ÀÚ¾È¿¡ °ø¹é Á¦°ÅÇÔ

library(dplyr)

#¹®ÀÚ¿­µ¥ÀÌÅÍ ºóµµ¸¦ ±¸ÇÏ¿© treemap ¸¸µé¿¹Á¤ -> table()ÅëÇØ Áı°èÇÏ±â
# ¾÷Á¾°³¼ö Áı°èÇÏ¿© µ¥ÀÌÅÍ ÇÁ·¹ÀÓÀ¸·Î È®ÀÎÇÏ±â
addr_count <-addr_trim %>% table() %>% data.frame()
head(addr_count)

#Æ®¸®¸Ê ¼³Ä¡ 
install.packages('treemap')
library(treemap)

#Æ®¸®¸Ê Ç¥Çö : treemap(µ¥ÀÌÅÍ, index='ÀÎµ¦½º ¿­ÀÌ¸§',vSize='ºóµµ¼ö ¿­ÀÌ¸§',title='Á¦¸ñ¼³Á¤')
treemap(addr_count, index='.', vSize = 'Freq',title='¼­´ë¹®±¸ µ¿º° Ä¡Å²Áı ºĞÆ÷')


#############QUIZ]
#µ¥ÀÌÅÍ ºÒ·¯¿È
hs<-read_excel('hos_data.xlsx')
hs

#¿øÇÏ´Â µ¥ÀÌÅÍ ¿­¿¡¼­ ¿øÇÏ´Â ºÎºĞ¹®ÀÚ¸¦ °¡Á®¿È : substr()
addr2 <- substr(hs$¼ÒÀçÁöÀüÃ¼ÁÖ¼Ò,11,16)
head(addr2)

#¼ıÀÚ Á¦°Å
addr_num2 <- gsub('[0-9]','',addr2) 
head(addr_num2)

#°ø¹éÁ¦°Å
addr_trim2 <- gsub(' ','',addr_num2) ; 
head(addr_trim2)

#Áı°èÇÏ¿© µ¥ÀÌÅÍÇÁ·¹ÀÓ ¸¸µé±â ; µ¿º° ºóµµ ÆÄ¾ÇÇÏ±â À§ÇØ
addr_count2 <-addr_trim2 %>% table() %>% data.frame()
head(addr_count2)

# ÆÈ·¹Æ® ¸í ¾Ë¾Æº¸±â
display.brewer.all()  #»õÃ¢¶ç¿ì±â¿Í µ¿½Ã¿¡ ½ÇÇàÇÏ¿©¾ß Ãâ·ÂµÊ

# »ö ¼Ó¼º ¹Ù²Ù°í ½ÍÀ¸¸é : palette='ÇÊ·¹Æ®¸í' ³Ö¾îÁÖ¸éµÊ 
treemap(addr_count2, index='.', vSize = 'Freq',title='°­³²±¸ º´¿ø ºĞÆ÷',
        palette='RdYlBu')
## »ö»ó ¹üÀ§ ¼¼ºÎ¼Ó¼º ¼³Á¤ÇÒ ¼ö ÀÖÀ½
treemap(addr_count2, index='.', vSize = 'Freq',title='°­³²±¸ º´¿ø ºĞÆ÷',
        vColor='some',palette='Dark2',mapping=c(-10, 10, 30), range=c(-10, 30))

##Æ®¸®¸Ê ÆùÆ® »çÀÌÁî º¯°æ ¼Ó¼º : fontsize.labels=c(Å©±â¼ıÀÚ, Å©±â¼ıÀÚ)
treemap(addr_count2, index='.', vSize = 'Freq',title='°­³²±¸ º´¿ø ºĞÆ÷',
        palette='RdYlBu',fontsize.labels=c(15, 5))

#########################QUIZ]
data(GNI2014)
ls() # º¯¼ö¸í È®ÀÎ  
head(GNI2014)  #;ÀÌ µ¥ÀÌÅÍ´Â ÀÎ±¸¼öÄ¡¸¦ ³ªÅ¸³»´Â ¼öÄ¡ µ¥ÀÌÅÍ°¡ Á¸ÀçÇÔ

# °ªÀ» ¼öÄ¡·Î ³Ö±â‹š¹®¿¡ ºóµµ¸¦ ±¸ÇÏ´Â °ÍÀÌ ¾Æ´Ô µû¶ó¼­ table()¾ÈÇØµµ µÊ
# vSize = '¼öÄ¡Çüº¯¼ö¸í'
treemap(GNI2014,
        index = c('continent','iso3'),
        vSize = "population",
        title = '¼¼°èÀÎ±¸',
        bg.labels='blue')


#############QUIZ]
#GNI = ±¹¹Î ÃÑ¼Òµæ ; ´ÜÀ§:Á¶

# GNI2014 µ¥ÀÌÅÍ¸¦ ÀÎ±¸¼øÀÌ ³ôÀº ¼øÀ¸·Î ³ª¿­ÇÏ¿© 20°³¸¦ GNI2014_po·Î ÀúÀåÇÏ½Ã¿À
GNI2014_po<-head(arrange(GNI2014,desc(population)),20)
GNI2014_po

#Æ®¸®¸Ê ¸¸µé±â
treemap(GNI2014_po,
        index = c('continent','iso3'),
        vSize = "population",
        title = 'ÀÎ±¸³ôÀº¼øÀ§ Top 20',
        bg.labels='blue')


############QUIZ]
#mutate()ÇÔ¼ö¸¦ ÀÌ¿ëÇÏ¿© ÆÄ»ıº¯¼ö »ı¼º ÈÄ 1ÀÎ´ç ±¹¹Î ¼ÒµæÀ» ÀÛ¼º
head(GNI2014)

GNI2014_per_pop<-mutate(GNI2014,per_pop=GNI/population)
# sol=>
GNI2014_per_pop<- head(arrange(mutate(GNI2014,per_pop=GNI/population),desc(per_pop)),20)
#treemapÀº µ¥ÀÌÅÍ Á¤Á¦ÈÄ arrange()ÇØ¾ß Å« ºÎºĞºÎÅÍ ½Ã°¢ÀûÀ¸·Î È®ÀÎ °¡´É
#head(µ¥ÀÌÅÍ,20)À» ÅëÇØ top20 À» º¸¿©ÁÖ¿©¾ß ÇÔ 

treemap(GNI2014_per_pop,
        index = c('continent','iso3'),
        vSize = "per_pop",
        title = '1ÀÎ´ç ±¹¹Î¼Òµæ TOP 20',
        bg.labels='white')  #bg.labels='white' ¶óº§¸í ¹è°æ»ö ¼³Á¤ 

