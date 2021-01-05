library(tidyverse)
library(janitor)

scotland <- read_csv("../raw_data/scotland_wide.csv") %>% 
  clean_names()

health_boards <- read_csv("../raw_data/health_board.csv") %>% 
  clean_names()

health_board_codes <- read_csv("../cancer_mock_interview/raw_data/health_board_codes.csv") %>% 
  clean_names()

cancer_incidence_health_board <- left_join(health_boards, health_board_codes, by = "hb")

cancer_incidence_health_board <- cancer_incidence_health_board %>% 
  select(hb_name, cancer_site, sex, year, incidences_all_ages, crude_rate) %>% 
  rename("health_board" = "hb_name")

scotland <- scotland %>% 
  mutate(health_board = "scotland_wide") %>% 
  select(health_board, cancer_site, sex, year, incidences_all_ages, crude_rate)

write_csv(cancer_incidence_health_board, "../cancer_mock_interview/clean_data/cancer_incidence_scotland.csv")

write_csv(scotland, "../cancer_mock_interview/clean_data/scotland_wide.csv")