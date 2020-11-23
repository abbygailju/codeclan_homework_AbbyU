library(tidyverse)
library(here)
library(janitor)

ggplot(number_of_ingredients_indonesian)+
  aes(x = num_of_ingredients)+
  geom_histogram()


ggplot(number_of_ingredients_british)+
  aes(x = num_of_ingredients)+
  geom_histogram()

british_recipes %>% 
  group_by(aliased_ingredient_name) %>% 
  summarise(num_recipes = length((entity_id))) %>% 
  slice_max(num_recipes, n=10) %>% 
  ggplot()+
  aes(x = aliased_ingredient_name, y = num_recipes, fill = aliased_ingredient_name) +
  geom_col()+
  coord_flip()


recipes_indonesian %>% 
  group_by(aliased_ingredient_name) %>% 
  summarise(num_recipes = length((entity_id))) %>% 
  slice_max(num_recipes, n=10) %>% 
  ggplot()+
  aes(x = aliased_ingredient_name, y = num_recipes, fill = aliased_ingredient_name) +
  geom_col()+
  coord_flip()

mean_num_indo <-number_of_ingredients_indonesian %>% 
  ungroup() %>% 
  summarise(mean(num_of_ingredients)) %>% 
  pull()

recipes_joined %>% 
  filter(cuisine == "British") %>% 
  group_by(aliased_ingredient_name) %>% 
  summarise(num_recipes = length((entity_id))) %>% 
  slice_max(num_recipes, n = 10) %>% 
  ggplot()+
  aes(x = reorder(aliased_ingredient_name, -num_recipes), y = num_recipes, fill = aliased_ingredient_name) +
  geom_col()+
  coord_flip()+
  labs(x = "Ingredient", y = "Number of recipes featured")+
  scale_fill_discrete("Type of ingredient")
