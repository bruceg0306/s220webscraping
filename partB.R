library(tidyverse)
library(rvest)

# The minister that I have selected is Hon David Seymour.

# One of the releases I looked at was titled Smarter lunch programme feeds more, costs less. It has quite formal language, and uses very many long words. It contains 515 words, and each paragraph on average contains 32 words in it. Also, the word government appears 7 times in the text, while Seymour only appears 3 times.

# The second release I looked at was called Daily school attendance data now available. This release contains 420 words, and each paragraph contains an average of 35 words. For this text, the word government appears 2 times, where as Seymour appears 2 times. 

url <- "https://www.beehive.govt.nz/minister/hon-david-seymour"

pages <- read_html(url) %>%
  html_elements(".release__wrapper") %>%
  html_elements("h2") %>%
  html_elements("a") %>%
  html_attr("href") %>%
  paste0("https://www.beehive.govt.nz", .)

page_url <- pages[1]

page <- read_html(page_url)

get_release <- function(page_url){
  Sys.sleep(2)
  page_url
  # print the page_url so if things go wrong
  # we can see which page caused issues
  print(page_url)
  page <- read_html(page_url)
  
  release_title <- page %>%
    html_elements(".article__title") %>%
    html_text2()
  
  release_content <- page %>%
    html_elements(".col-xs-12") %>%
    html_elements("p") %>%
    html_text2()
  
  tibble(release_title, release_content)
  
}

release_data <- map_df(pages, get_release)

release_data <- release_data %>%
  group_by(release_title) %>%
  summarise(mean_title_length = mean(nchar(release_title)),
            mean_content_length = mean(nchar(release_content)),
            max_content_length = max(nchar(release_content)),
            min_content_length = min(nchar(release_content)))