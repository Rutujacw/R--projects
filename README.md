# R--projects
A Web crawler project using R language

There are 3 R scripts for crawling, parsing, and reading the articles from Mobile DNA Journal.

Please install the following packages: tidyverse, stringr, rvest

In line 35 of Crawler.r, just enter a year between 2010 to 2019 in the function called "enter" and all journal articles from that year 
will download.

Crawler.R
1) We created a function entitled "enter" with year as parameter. Please enter a year between 2010 and 2019 only. 
   The Journal did not exist prior to 2010.
2) We used a paste command to take the url and a switch statement for the year.
3) Created a folder entitled "articles" to download all the html files. (Creates on its own).

Parser.R
1) Change the file path in line 5 of Parser.
2) Split the data and analyze according to the attributes required. Note Correspondence Author's Email did not exist for our journal.

Read.R
1) Read the following attributes parsed from the downloaded html files.
'Title, "Authors", "Author Affiliations", "Correspondence Author", "Publish Date","Abstract", "Keywords", "Full Paper"

