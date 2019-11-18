library(shiny)
options(Encoding="UTF-8")

shinyUI(fluidPage(
    titlePanel("Test déploiement Travis - ShinyApps.io"),
    shiny::tags$p("Ce déploiement est entièrement réalisé par un job Travis !"),
    sidebarLayout(
        sidebarPanel(
            sliderInput("bins", "Number of bins:", min = 1, max = 50, value = 30),
            hr(),
            downloadButton("dlPDF", "Télécharger PDF de test")
        ),
        mainPanel(
            plotOutput("distPlot")
        )
    )
))
