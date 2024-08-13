library(tidyverse)
library(rvest)

# My data context is information about the performance of champions in League of Legends, and which champions are doing well currently.

# The information that I can scrape from web pages that would help for this context would be things like champion winrates, player winrates, and the leaderboards.

# URL: https://www.op.gg/ This website is appropriate for web scraping, the robots.txt file allows everything to be scraped for any user. In the Terms and Conditions of the website, it also just mentions that you should not scrape anything related to personal information of users, which I won't be doing that.

url <- "https://www.op.gg/statistics/tiers"

page <- read_html(url)

page_heading <- page %>%
  html_elements("h2") %>%
  html_text2()

regions <- page %>%
  html_elements(".server-list-container") %>%
  html_text2()

tier_dist_graph <- page %>%
  html_elements(".box") %>%
  html_text2()

graphs <- page %>%
  html_elements("#content-container") %>%
  html_text2()

page_heading
regions
tier_dist_graph
graphs
