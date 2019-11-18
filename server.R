library(shiny)

shinyServer(function(input, output) {
    
    output$distPlot <- renderPlot({
        x    <- faithful[, 2]
        bins <- seq(min(x), max(x), length.out = input$bins + 1)
        hist(x, breaks = bins, col = 'darkgray', border = 'white')
    })
    output$dlPDF <- downloadHandler(
        filename = function() {
            paste('test-PDF-', format(Sys.Date(), "%d-%m-%Y"), '.pdf', sep='')
        },
        content = function(con) {
            fileRmd   <- paste0("templatePDF/", "rmarkdownTest.Rmd")
            fileTex   <- paste("templatePDF/pdfTest_", Sys.Date(), ".tex", sep = "")
            folderTex <- paste0("templatePDF/pdfTest_", Sys.Date(), "_files")
            
            try(detach("package:kableExtra", unload = TRUE))
            try(detach("package:rmarkdown", unload = TRUE))
            
            options(kableExtra.latex.load_packages = FALSE)
            library(kableExtra)
            library(rmarkdown)
            
            try(rmarkdown::render(fileRmd,
                                  pdf_document(latex_engine = "pdflatex"),
                                  output_file = con,
                                  encoding = "UTF-8",
                                  clean = TRUE))
            
            unlink(folderTex, recursive = T)
            
        }
    )
    
})
