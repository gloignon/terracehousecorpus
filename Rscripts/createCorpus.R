# createCorpus.R
# 
# Uses UDPipe to create a corpus from a subtitle file.

library(udpipe)
library(tidyverse)
library("data.table")

# Run the line below if you don't have a udpipe model for the japanese language
# udpipe_model <- udpipe_download_model(language = "japanese")

udmodel_japanese <- udpipe_load_model(file = "japanese-gsd-ud-2.4-190531.udpipe")

load("./Parsed_data/dt_subtitles.Rda")

dt.parsed <-
  udpipe(x = dt.subtitles$japanese,
         object = udmodel_japanese,
         trace = TRUE) %>% data.table()
dt.corpus <- dt.parsed[upos != "PUNCT", .(.N), by = c("lemma", "token")]
