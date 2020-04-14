# parser.R
# This will open a "raw" HTML subtitle file and parse it into a neat bilingual table.

library(rvest)  # rvest will do the actual scraping
library("data.table")

parseHTML <- function(pathAndFile) {
  subfile <- read_html(pathAndFile, encoding = "UTF8") 
  ep.id <- html_nodes(subfile, "div") %>% .[[2]] %>% html_nodes("span") %>% html_text()
  raw.tables <- html_nodes(subfile, "table") %>% html_table(fill = true) %>% .[[1]]
  
  ep.number <- ep.id[1]
  ep.title <- ep.id[2]
  
  dt.text <- data.table(
    epId = ep.number,
    epTitle = ep.title,
    japanese = raw.tables$X1,
    english = raw.tables$X2
  )
  
  return (dt.text)
}


path = "./Corpus_data"

# we read the file list in the path folder

# we parse all the files, appending the resulting tables to the large data.table object
dt.subtitles <- dt.text

# saving....
save(dt.subtitles, file = "./Parsed_data/dt_subtitles.Rda")