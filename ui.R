library(shiny)
library(lubridate)
library(astsa)
library(tseries)
library(TSA)
library(biwavelet)
library(TTR)
library(forecast)
load("shiny malaria.RData")
fluidPage(
  titlePanel("Plot pvax data in Baoshan!"),
  # Sidebar with a slider input for the number of bins
  sidebarLayout(
    sidebarPanel(
      selectInput("mal", "Choose a dataset:", 
                  choices = c("",colnames(maldata)),selected = "tengpv"),
      sliderInput("ty",
                  "Train data year:",min=2005,max=2012,value =c(2005,2010),step = 1),
      checkboxInput("im","import case",FALSE),
      selectInput("meth","Methods",
                  choices = c("Holt", "ARIMA"),selected="Holt"),
      sliderInput("py",
                  "forcast year:",min=2011,max=2013,value = 2011,step = 1)
    ),
    
    # Show a plot of the generated distribution
    
    mainPanel(
      tabsetPanel(type = "pills",
                  tabPanel("Plot for predict", plotOutput("plot")), 
                  tabPanel("Plot for county", plotOutput("summary")), 
                  tabPanel("Table", textOutput("table"))
      )
      
    )
  )
)