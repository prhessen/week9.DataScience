library(tidyverse)


for_shiny_tbl <- read_csv("data/week3.csv") %>%
    mutate(meanq1q5 = rowMeans(week9_tbl[5:9])) %>%
    mutate(meanq6q10 = rowMeans(week9_tbl[10:14])) %>%
    mutate(timeStart = as.POSIXct(week9_tbl$timeStart)) %>%
    mutate(gender = factor(week9_tbl$gender, labels = c("Female", "Male")))

saveRDS(for_shiny_tbl, "shiny/for_shiny.rds")
