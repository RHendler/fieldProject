check.packages <- function(pkg){
  new.pkg <- pkg[!(pkg %in% installed.packages()[, "Package"])]
  if (length(new.pkg)) 
    install.packages(new.pkg, dependencies = TRUE)
  sapply(pkg, require, character.only = TRUE)
}

# Usage example
packages<-c("shiny", "leaflet", "DT", "devtools", "googlesheets4", "shinyjs","googledrive")
check.packages(packages)

remotes::install_github("ColinFay/geoloc")

library(shiny)
library(leaflet)
library(DT)
library(devtools)
library(shinyjs)
library(googlesheets4)
library(googledrive)

gs4_auth()

shinyApp(ui, server)

