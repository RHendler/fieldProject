library(shiny)

ui <- fluidPage(
  
  tabsetPanel(
  
  tabPanel("New Data",
           
           column(5,subset = 2,
                  div(id="titlePanel",br(),
                      
                  titlePanel(h2("Field Observations")),br()),
                  
                  column(3,subset = 1,fluidRow(verbatimTextOutput("count")),
                  tags$head(tags$style("#count{color:black; font-size:14px; max-height: 40px; background: white;}")
                            )),
                  br(),br(),hr(),
                  
                  geoloc::button_geoloc("myBtn", "My Location",width = 100),br(),
                  textOutput("location"),
                  
                  textInput("coverage","coverage",width = 100),
                  
                  textInput("crack_width","crack_width",width = 100),
                  
                  radioButtons("cover_from_last", label = "cover from Last", 
                               choices = c("Low" = "low","Medium" = "medium", "High" = "high")),
                  
                  actionButton("addButton", "add"),
                  tags$br(),
                  div(style="width:200px;",fluidRow(verbatimTextOutput("message")))
                  )),
  
  tabPanel("collected Data",
           fluidRow(
             tableOutput("table")))
)
)
