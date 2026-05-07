library(shiny)
library(tidyverse)
# Get the data
# An .RData file is a file format used in R to save and store R objects
# (such as data 3 frames, lists, vectors, functions, or entire workspaces)
# E.g., use save.image(file = "workspace.RData") to save the entire workspace.
url <- "https://github.com/rstudio-education/shiny-course/raw/main/movies.RData"
destfile <- "movies.RData"
download.file(url, destfile) # save movies.RData in a temporary dir
load(destfile)
ui = fluidPage(sidebarLayout(
  sidebarPanel(
    selectInput(
      inputId = "x",
      label = "X-axis:",
      choices = c(
        "IMDB rating" = "imdb_rating",
        "IMDB number of votes" = "imdb_num_votes",
        "Critics score" = "critics_score",
        "Audience score" = "audience_score",
        "Runtime" = "runtime"
      ),
      selected = "audience_score"
    ),
    selectInput(
      inputId = "y",
      label = "Y-axis:",
      choices = c(
        "IMDB rating" = "imdb_rating",
        "IMDB number of votes" = "imdb_num_votes",
        "Critics score" = "critics_score",
        "Audience score" = "audience_score",
        "Runtime" = "runtime"
      ),
      selected = "critics_score"
    ),
    selectInput(
      inputId = "z",
      label = "Color by:",
      choices = c(
        "Title type" = "title_type",
        "Genre" = "genre",
        "MPAA rating" = "mpaa_rating",
        "Critics rating" = "critics_rating",
        "Audience rating" = "audience_rating"
      ),
      selected = "mpaa_rating"
    ),
    sliderInput(
      inputId = "opacity",
      label = "Opacity:",
      min = 0, max = 1,
      value = 0.5
    ),
    dateRangeInput(
      inputId = "date",
      label = "Select dates:",
      start = min(as.Date(movies$thtr_rel_date)),
      end = max(as.Date(movies$thtr_rel_date)),
      min = min(as.Date(movies$thtr_rel_date)),
      max = max(as.Date(movies$thtr_rel_date)),
      startview = "year"
    ),
    checkboxInput(
      inputId = "show_data",
      label = "Show data table",
      value = TRUE
    ),
    downloadButton(outputId = "download_data", label = "Download Data")
  ),
  mainPanel(
    plotOutput(outputId = "scatterplot"),
    plotOutput(outputId = "densityplot", height = 200),
    DT::dataTableOutput(outputId = "moviestable")
  )
))
server <- function(input, output) {
  output$scatterplot <- renderPlot({
    movies |> filter(
      thtr_rel_date >= as.POSIXct(input$date[1]) &
        thtr_rel_date <= as.POSIXct(input$date[2])
    ) |> ggplot(
      aes(x = .data[[input$x]], y = .data[[input$y]], color = .data[[input$z]])
    ) +
      geom_point(alpha = input$opacity)
  })
  output$densityplot <- renderPlot({
    movies |> filter(
      thtr_rel_date >= as.POSIXct(input$date[1]) &
        thtr_rel_date <= as.POSIXct(input$date[2])
    ) |>
      ggplot(aes(x = .data[[input$x]])) +
      geom_density()
  })
  output$moviestable <- DT::renderDT({
    if(input$show_data == T){
      movies |> filter(
        thtr_rel_date >= as.POSIXct(input$date[1]) &
          thtr_rel_date <= as.POSIXct(input$date[2])
      ) |> DT::datatable(
        options = list(pageLength = 10), rownames = FALSE)
    }
  })
  output$download_data <- downloadHandler(
    filename = function() {
      paste("movies_filtered_", Sys.Date(), ".csv", sep = "")
    },
    content = function(file) {
      write.csv(
        movies |> filter(
          thtr_rel_date >= as.POSIXct(input$date[1]) &
            thtr_rel_date <= as.POSIXct(input$date[2])
        ),
        file,
        row.names = FALSE
      )
    }
  )
}
shinyApp(ui = ui, server = server)