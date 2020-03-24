#
# This is a Shiny web application. You can run the application by clicking
# the 'Run App' button above.
#
# Find out more about building applications with Shiny here:
#
#    http://shiny.rstudio.com/
#

library(shiny)
library(ggplot2)
library(dplyr)
library(DT)

ui <- fluidPage(

    titlePanel("Week 9 Shiny"),

    sidebarLayout(
        sidebarPanel(
            
            selectInput("gender", "Gender:", choices = c("Male", "Female", "All"), selected = "All"),
            
            checkboxInput("include", "Include participants from before August 1, 2017", TRUE)
        ),
        
        mainPanel(
            plotOutput("plot"),
            dataTableOutput("dataset")
        )
    )
)

# Define server logic required to draw a histogram
server <- function(input, output) {

    output$plot <- renderPlot({
        
        for_shiny_tbl <- readRDS("for_shiny.rds")
        
        for_shiny_tbl1 <- 
            if (input$include == FALSE) {
            subset(for_shiny_tbl, timeStart >= "2017-08-01")
        } else {
            for_shiny_tbl 
        } 
        
        for_shiny <- if (input$gender != "All") {
            subset(for_shiny_tbl1, gender == input$gender)
        } else {
            for_shiny_tbl1
        }
        
        
        ggplot(for_shiny, aes(x = meanq1q5, y = meanq6q10)) +
            geom_point() +
            labs(x = "Mean of Q1-Q5", y = "Mean of Q6-Q10")
    })
    output$dataset <- renderDataTable({
        data <- readRDS("for_shiny.rds")
        data
    })
}

# Run the application 
shinyApp(ui = ui, server = server)

# App URL: https://phoebe-apps.shinyapps.io/shiny/



