Datas<-read_xlsx("Datas_071221.xlsx")
library(factoextra)
library(cluster)
library(dendextend)
library(ggplot2)
library(ggfortify)
library(purrr)
library(tidyverse)
set.seed(1)
df<-Datas[,c(7,5,6)]
fviz_nbclust(df, kmeans, method = "wss")
fviz_nbclust(df, kmeans, method = "silhouette")

set.seed(1)
final <- kmeans(df,5, nstart = 25)
print(final)
fviz_cluster(final, data = df)
Dataset1 <- mutate(Datas, Group = final$cluster)

Group1<-read_xlsx("Group1_071221.xlsx") 
Group2<-read_xlsx("Group2_071221.xlsx") 
Group3<-read_xlsx("Group3_071221.xlsx") 
setwd("F:/")
Crm<-read_xlsx("crm.xlsx")
Group1<-left_join(Group1,Crm,by="first_name")
Group2<-left_join(Group2,Crm,by="first_name")
Group3<-left_join(Group3,Crm,by="first_name")
colnames(Crm)[1]<-"first_name1"
Group1<-left_join(Group1,Crm,by="first_name1")
Group2<-left_join(Group2,Crm,by="first_name1")
Group3<-left_join(Group3,Crm,by="first_name1")
colnames(Crm)[1]<-"company_name"

Group1<-left_join(Group1,Crm,by="company_name")
Group2<-left_join(Group2,Crm,by="company_name")
Group3<-left_join(Group3,Crm,by="company_name")
write_xlsx(Group1,"group1.xlsx")
write_xlsx(Group2,"group2.xlsx")
write_xlsx(Group3,"group3.xlsx")
