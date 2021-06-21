#hive data
list<-dbGetQuery(conn,"show tables")
list

#buylist
buy2018_1<-dbGetQuery(conn,'select * from buy2018_1')
buy2018_2<-dbGetQuery(conn,'select * from buy2018_2')
buy2019_1<-dbGetQuery(conn,'select * from buy2019_1')
buy2019_2<-dbGetQuery(conn,'select * from buy2019_2')

#head(buy2018_1)
#ls(buy2018_1)

#finedust


ta <-dbGetQuery(conn,'select * from db_sfc_td_dd where 1=1 limit 1000')
ta <- dbGetQuery(conn, "SELECT * FROM db_sfc_ta_dd WHERE 1=1 limit 1000")
head(finedust)
