######################################################################################################
This file reads the plain text that we receieve from the Parser.R file and puts it in a tabular format
#######################################################################################################

colns=c("DOI","Title", "Authors","Authors Affiliation","Corresponding Author", "Publication Date", "Abstract", "Keywords", "Full Text")

data<-read.table('C:/Users/rutuj/OneDrive/Documents/JOURNAL_NAME.txt',sep = '\t',col.names = colns )

view(data)

