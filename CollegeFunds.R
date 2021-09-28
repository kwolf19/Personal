#Select File
expenses <- read.csv(file.choose())
head(expenses)

print(expenses$Avg.Total.Expenses)

#Get rid of $ and commas in DF
expenses$Avg.Total.Expenses <- gsub("\\$","",expenses$Avg.Total.Expenses)
expenses$Avg.Operating.Expenses <- gsub("\\$","",expenses$Avg.Operating.Expenses)
expenses$Avg.Total.Expenses <- gsub(",","",expenses$Avg.Total.Expenses)
expenses$Avg.Operating.Expenses <- gsub(",","",expenses$Avg.Operating.Expenses)

str(expenses)
#convert strings to numeric to allow arithmetic
expenses$Avg.Total.Expenses <- as.numeric(expenses$Avg.Total.Expenses)
expenses$Avg.Operating.Expenses <- as.numeric(expenses$Avg.Operating.Expenses)

print((expenses$Avg.Total.Expenses - expenses$Avg.Operating.Expenses) > 350000)

#create new DF with differences of Operating Expenses and Total Expenses above 350000
aboveAverage <- data.frame(expenses[(expenses$Avg.Total.Expenses - expenses$Avg.Operating.Expenses) > 350000,])

#get rid of row 278
aboveAverage <- aboveAverage[-c(278), ]

#create vector of values for differences between Operating Expenses and Total Expenses
disposable <- aboveAverage$Avg.Total.Expenses - aboveAverage$Avg.Operating.Expenses

#Add column called "Disposable" to existing DF
aboveAverage["Disposable"] <- disposable

#Export new DF to an excel sheet
install.packages("writexl")
library("writexl")

write_xlsx(aboveAverage, "/Users/kobi/Documents/Liquid/AboveAverage.xlsx")