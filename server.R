library(shiny)


server <- function(input, output,session) {
  
  ss <- gs4_get("https://docs.google.com/spreadsheets/d/1mDcGACDd4YCfBl-OWdWDAzRzgFooyMSXUM-08JfrYBY/edit#gid=0")
  
  output$coverage <- renderText({ input$coverage })
  output$crack_width <- renderText({ input$crack_width })
  
  
  observeEvent(input$myBtn,{
    
    output$lf <- renderLeaflet({
      req(input$myBtn_lon)
      req(input$myBtn_lat)
      leaflet()
    })
    
    mylocation <- renderText(c(as.numeric(input$myBtn_lon),as.numeric(input$myBtn_lat)))
    output$location <- mylocation
    
  })


  sheet <- read_sheet("https://docs.google.com/spreadsheets/d/1mDcGACDd4YCfBl-OWdWDAzRzgFooyMSXUM-08JfrYBY/edit#gid=0")
  values <- reactiveValues(countervalue = length(sheet$id)+1,
                           idList = vector(),
                           latList = vector(),
                           longList = vector(),
                           coverageList = vector(),
                           widthList = vector(),
                           coverfromlastList = vector())
  
  output$count <- renderText({values$countervalue})
  
  observeEvent(input$addButton,{

    values$idList <- append(isolate(values$idList),values$countervalue)
    values$latList <- append(isolate(values$latList),isolate(input$myBtn_lat))
    values$longList <- append(isolate(values$longList),isolate(input$myBtn_lon))
    values$coverageList <- append(isolate(values$coverageList),isolate(input$coverage))
    values$widthList <- append(isolate(values$widthList),isolate(input$crack_width))
    values$coverfromlastList <- append(isolate(values$coverfromlastList),isolate(input$cover_from_last))
    
    if(1>0){
      
    data <- data.frame(values$idList,values$latList,values$longList,values$coverageList,values$widthList,values$coverfromlastList)
    
    names(data) <- c("id","latitude","longitude","ind_number","crack_width","from last")
    
    sheet_append(ss,data)
    
    output$table <- renderTable(data)
      
    output$message <- renderText({paste(c("added entry ",values$countervalue - 1, "successfully"))})
    
    values$countervalue <- values$countervalue + 1
    
    mylocation <- renderText({"enter new"})
    output$location <- mylocation
    
    #output$location <- renderText({"enter new"})
    updateTextInput(session,"coverage",value = "")
    updateTextInput(session,"crack_width",value = "")
    }
  })
  

}
