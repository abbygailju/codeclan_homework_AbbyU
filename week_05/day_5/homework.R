library(tidyverse)
library(shiny)
library(shinythemes)


ui <-
fluidPage(themes = shinytheme("superhero"),
  titlePanel("Differences in cuisine between Indonesia and the British Isles"),
  sidebarLayout(
    sidebarPanel(
      h5("CulinaryDB is a database of recipes collected from multiple websites. Here I chose to analyse recipes and their constituent ingredients from the British Isles and Indonesia. I hope the data shows I'm not biased when I say that Indonesian food has more flavour - just look at the type of ingredients used!"),
      radioButtons("choice_of_cuisines",
                  "British or Indonesian?",
                  choices = c("British", "Indonesian")
      ),
      actionButton("cuisine_type", "Tell me about the cuisine!"),
      
      sliderInput("slider",
                  "Group by how many ingredients?",
                  min = 2,
                  max = 20,
                  value = 5)
    ,
    sliderInput("ingredtypes",
                "How many of the most used ingredients would you like to see?",
                min = 3,
                max = 15,
                value = 10),
   
    tags$a(href="https://cosylab.iiitd.edu.in/culinarydb/basic_stats.html", "Click here to find out more!")
    )
  ,
  mainPanel(
    tabsetPanel(type = "tabs",
    tabPanel("Ingredients",
             h3("These two plots show the number of ingredients in the recipes collected from CulinaryDB") ,
             plotOutput("indonesian_ingredient_numbers")),
    
    tabPanel("Types of ingredients",
             h3("These are the most used ingredients for the recipes featured"),
             plotOutput("indonesian_ingredient_types"))
  )
  )
)
)

server <- function(input, output){
  outputplot <- eventReactive(input$cuisine_type,{
    number_of_ingredients %>% 
      filter(cuisine == input$choice_of_cuisines) %>% 
    ggplot()+
      aes(x = ingrednum)+
      geom_histogram(binwidth = input$slider,fill = "#F49719")+
      labs(x = "Number of Ingredients in each recipe", y = "Number of recipes in the database")
  })
  
  output$indonesian_ingredient_numbers <- renderPlot({
   outputplot()
  })
  
  outputplottab <- eventReactive(input$cuisine_type, {
    recipes_joined %>% 
      filter(cuisine == input$choice_of_cuisines) %>% 
      group_by(aliased_ingredient_name) %>% 
      summarise(num_recipes = length((entity_id))) %>% 
      slice_max(num_recipes, n = input$ingredtypes) %>% 
      ggplot()+
      aes(x = reorder(aliased_ingredient_name, -num_recipes), y = num_recipes, fill = aliased_ingredient_name) +
      geom_col()+
      coord_flip()+
      labs(x = "Ingredient", y = "Number of recipes featured")+
      scale_fill_discrete("Type of ingredient")
  })
    
    output$indonesian_ingredient_types <- renderPlot({
      outputplottab()
    })
  
}
shinyApp(ui = ui, server = server)