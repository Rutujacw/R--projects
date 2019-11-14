############################################################################################################
This is the R scripts for crawling the articles from Mobile DNA Journal as per the given year when the article
was published. To run the code please install the following packages: tidyverse, stringr, rvest
############################################################################################################

library(rvest)
library(stringr)

enter<-function(year)
{

  ###################################################################
  Accessing the journal using its URL and extracting for a given year
  ###################################################################

  web=paste0('https://mobilednajournal.biomedcentral.com/articles?query=&volume=', 
             
             switch(year, "2019"=10, "2018" =9, "2017"=8, "2016"=7, "2015"=6, "2014"=5, "2013"=4, "2012"=3, "2011"=2, "2010"=1), 
             
             '&searchType=&tab=keyword')
  
  Titles<-web%>%read_html()%>%html_nodes(".c-listing__title a" )%>%html_text()
  
  L2<-web%>%read_html()%>%html_nodes(".c-listing__title a" )%>%html_attr("href")
  
  ##################################################################
  Storing the article's html links into a directory called articles
  ##################################################################
  dir.create("articles")
  
  for (i in 1:length(L2))
  {
    L2[i]<-substring(L2[i],11)
  }
  web2<-vector()
  save2<-vector()
  for (i in 1:length(L2))
  {
     web2[i]<-paste0('https://www.doi.org/',L2[i]
     save2[i]<-gsub("/","_",L2[i])
  
     download.file(web2[i], destfile=paste0("articles/",save2[i],".html"))
  }
  
}

##### Downloading all the articles for year 2015 #####

enter('2015')

