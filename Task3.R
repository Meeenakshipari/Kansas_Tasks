library(R.utils)
gunzip("Homo_sapiens.gene_info.gz",remove=FALSE)
library(readr)
df <- read_delim("Homo_sapiens.gene_info",delim="\t" ,col_types = cols_only(
  Symbol = col_character(),
  chromosome = col_character()
))


library(ggplot2)
library(dplyr)
x<-table(unlist(df$chromosome))
newdf<-as.data.frame(x)
newdf

final_df<-filter(newdf,Var1 %in% c("1","2","3","4","5","6","7","8","9","10","11","12","13","14","15","16","17","18","19","20","21","22","X","Y","MT","Un"))
final_df$Var1
final_Df2 <- data.frame(Var1 = final_df$Var1, Freq = final_df$Freq)

final_Df2$Var1 <- factor(final_df$Var1, levels = c("1", "2", "3", "4", "5", "6", "7", "8", "9", "10", "11", "12", "13", "14", "15", "16", "17", "18", "19", "20", "21", "22", "X", "Y", "MT", "Un"))
final_Df2

ggplot(final_Df2, aes(x = Var1, y = Freq)) + 
  geom_bar(stat = "identity") + 
  labs(x = "Chromosomes", y = "Gene Count")

