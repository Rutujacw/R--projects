########################################################################################################
This code parses the data that is extracted from the crawler.R code and stores it in a plain text file 
#########################################################################################################

library(rvest)
library(tidyverse)
library(stringr)

files <- list.files(path="C:/Users/rutuj/OneDrive/Documents/articles", pattern="*.html", full.names=TRUE, recursive=FALSE)

for(i in 1:length(files))
  {
  #####################
  Title of the journal 
  ######################
  
  title<-files[i]%>%read_html()%>%html_nodes("h1.c-article-title.u-h1")%>%html_text(trim=FALSE)
  if(length(title)==0)
    {
    title<-'NA'
    }
  else if(length(title)>1)
    {
    title<-paste(title,collapse = " ")
    }
  
  ############
  DOI URL 
  ############
  
  DOI_b<-files[i]%>%read_html()%>%html_nodes("li.c-bibliographic-information__list-item.c-bibliographic-information__list-item--doi")%>%html_text(trim = FALSE)
  #DOI_b<-sub("https://doi.org/","",DOI_b)
  DOI_b <- str_replace_all(DOI_b,"(DOI)","")
  if(length(DOI_b)==0)
  {
    DOI_b<-'NA'
  }
  else if(length(DOI_b)>1)
  {
    DOI_b<-paste(DOI_b,collapse = ",")
  }
  
  #################### 
  Author's Name 
  ####################
  
  authors<-files[i]%>%read_html()%>%html_nodes("h3.c-article-author-authors-search__title.u-h3.js-search-name")%>%html_text(trim = FALSE)
  authors<-str_replace_all(authors,"(Search for)|(in)","")
  authors<- str_replace_all(authors, "(:)", ",")
  if(length(authors)>1)
  {
    authors<-paste(authors,collapse = " ")
  }
  else if(length(authors)==0)
  {
    authors <-'NA'
  }
  
  ##################### 
  Author's Affiliations 
  #####################
  
  authors_aff<-files[i]%>%read_html()%>%html_nodes("h4.c-article-author-affiliation__address.u-h3")%>%html_text(trim = FALSE)
  authors_aff<-str_replace_all(authors_aff,"[\r\n]","")
  if(length(authors_aff)>1)
  {
    authors_aff<-paste(authors_aff,collapse = " ")
  }
  else if(length(authors_aff)==0)
  {
    authors_aff <-'NA'
  }
  
  #################### 
  Corresponding Author 
  #####################
  
  Corr_authors<-files[i]%>%read_html()%>%html_nodes("a#corresp-c1")%>%html_text(trim = FALSE)
  Corr_authors<-str_replace_all(Corr_authors,"[\r\n]","")
  if(length(Corr_authors)>1)
  {
    Corr_authors<-paste(Corr_authors,collapse = " ")
  }
  else if(length(Corr_authors)==0)
  {
    Corr_authors <-'NA'
  }
  
  #################### 
  Publication Dates 
  ####################
  
  publication_date<-files[i]%>%read_html()%>%html_nodes(xpath = "//li//a//time")%>%html_text(trim = FALSE)
  publication_date<-str_replace_all(publication_date,"[\r\n]"," ")
  #publication_date<-str_replace_all(publication_date,"DOI","")
  if(length(publication_date)==0){
    publication_date<-'NA'
  }
  else if(length(publication_date)>1){
    publication_date<-paste(publication_date,collapse = ",")
  }
  
  ############# 
  Absract
  #############
  
  abstract<-files[i]%>%read_html()%>%html_nodes("div#Abs1-content.c-article-section__content")%>%html_text(trim = FALSE)
  if(length(abstract)==0){
    abstract<-'NA'
  }
  else if(length(abstract)>1){
    abstract<-paste(abstract,collapse = ",")
  }
  
  ##############
  Keywords 
  ##############
  
  key_words<-files[i]%>%read_html()%>%html_nodes("ul.c-article-subject-list")%>%html_text(trim = FALSE)
  key_words<-str_replace_all(key_words,"[\r\n]","")
  if(length(key_words)>1){
    key_words<-paste(key_words,collapse = ",")
  }
  else if(length(key_words)==0){
    key_words<-'NA'
  }
  
  #######################
  Full Text of the paper 
  #######################
  
  full_text<-files[i]%>%read_html()%>%html_nodes("main.c-page-layout__main")%>%html_text(trim = FALSE)
  full_text<-str_replace_all(full_text,"[\r\n]"," ")
  full_text<-str_replace_all(full_text," "," ")
  if(length(full_text)==0){
    full_text<-'NA'
  }
  else if(length(full_text)>1){
    full_text<-paste(full_text,collapse = ",")
  }
  
  ########################### 
  Store the data in a Vector 
  ###########################
  
  information=c(DOI_b,title,authors,authors_aff,Corr_authors,publication_date,abstract,key_words,full_text)
  required_output <- matrix(information,1,9)
  
  ############################# 
  Write the data to a text file 
  #############################
 
  write.table(required_output, "JOURNAL_NAME.txt", row.names = FALSE, col.names = FALSE, sep = "\t", append = TRUE)
  
}
