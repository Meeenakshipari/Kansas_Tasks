library(readr)
library(tidyr)
library(dplyr)
library(stringr)

df <- read_delim("Homo_sapiens.gene_info", delim = "\t", col_types = cols_only(
  GeneID = col_character(),
  Symbol = col_character(),
  Synonyms = col_character()
))

newdf <- df %>%
  mutate(Synonyms = strsplit(as.character(Synonyms), "\\|")) %>%
  unnest(Synonyms) %>%
  select(GeneID, Symbol = Synonyms) %>%
  bind_rows(df %>% select(GeneID, Symbol))

gmtdf <- read_delim("h.all.v2023.1.Hs.symbols.gmt", delim = "\t", col_names = FALSE)

max_cols <- max(sapply(gmtdf, function(x) sum(!is.na(x))))

# Ensure all rows have the same number of columns
gmtdf <- gmtdf %>%
  mutate(across(everything(), as.character)) %>%
  mutate(across(everything(), ~ replace(., is.na(.), "")))

gmtdf <- gmtdf %>%
  mutate(across(everything(), ~ replace(., . == "", NA)))

for (i in 3:ncol(gmtdf)) {
  gmtdf[[i]] <- ifelse(gmtdf[[i]] %in% newdf$Symbol, newdf$GeneID[match(gmtdf[[i]], newdf$Symbol)], gmtdf[[i]])
}

write.csv(gmtdf, "out.csv", row.names = FALSE)
