## app.R ##
library(shinydashboard)
library(shiny)

ui <- dashboardPage(skin="green",
  dashboardHeader(title = "Stacja pogodowa"),
  ## Sidebar content
  dashboardSidebar(
    sidebarMenu(
      menuItem("Strona Główna", tabName = "main", icon = icon("th")),
      menuItem("Temperatura", tabName = "temp", icon = icon("thermometer-three-quarters")),
      menuItem("Wilgotność", tabName="wilgotnosc", icon = icon("tint")),
      menuItem("Jakość powietrza", tabName = "jakosc", icon= icon("heart")),
      menuItem("PM 1.0", tabName="PM1", icon = icon("heart")),
      menuItem("PM 2.5", tabName="PM2", icon = icon("heart")),
      menuItem("PM 10", tabName="PM10", icon = icon("heart"))
    )
  ),)
## Body content
dashboardBody(
  tabItems(
    tabItem(tabName = "main",
            h2("Strona Główna")
    ),
    tabItem(tabName = "temp",
            h2("Temperatura")
    ),
    tabItem(tabName = "wilgotnosc",
            h2("Wilgotność")
    ),
    tabItem(tabName = "jakosc",
            h2("Jakość powietrza")
    ),
    tabItem(tabName = "PM1",
            h2("PM 1")
    ),
    tabItem(tabName = "PM2",
            h2("PM 2.5")
    ),
    tabItem(tabName = "PM10",
            h2("PM 10")
    )
  )
)
shinyApp(ui, server)