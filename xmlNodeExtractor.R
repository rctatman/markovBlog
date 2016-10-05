# This script will take a wordpress download and remove only blog posts

# make sure you have libxml2-dev insalled (for Debian/Ubuntu) before installing xml2 and XML
# you will also need your java version (32 or 64 bit) to match your R version (32 or 64 bit)
library(xml2)
library(XML)
library(rJava)
library(tm.plugin.webmining)

# read in your xml file
doc <- xmlTreeParse("wordpress.2016-10-04.xml", useInternalNodes = TRUE)
# get all contenet from the node "<content:encoded>" 
nbrelation.set <- getNodeSet(doc, "//content:encoded") 

# Now to remove all the HTML tags
texts <- NULL
numberOfNodes <- length(nbrelation.set)
for(x in 1:numberOfNodes){
  text <- extractHTMLStrip(as(nbrelation.set[[x]], "character"))
  texts <- c(text, texts)
}

# save our extracted/scrubbed text to file
write(texts, file = "extractedText.txt")

# function to remove things we don't want
extractHTMLStrip <- function(htmlString) {
  htmlString <- gsub("<.*?>", "", htmlString)
  htmlString <- gsub("\n", "", htmlString)
  htmlString <- gsub("\"", "", htmlString)
  return(htmlString)
}

