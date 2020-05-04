
library(shiny)
library(chron)


ui <- fluidPage(
    titlePanel("Test"),

        mainPanel(
           plotOutput("Last24HPlot")
        )
    )



server <- function(input, output) {
    
    File <- ({
        data <- data.frame(read.csv("./p.csv", header = T, sep = ";",row.names = NULL, encoding = 'UTF-8',stringsAsFactors = F))
    })
    
    #ActualTime <- {(
   #     strftime(times, format="%H:%M:%S")
    #)}
    
    #Zmienia format danych w dataframe
    DaysMatrix <- ({
        File$godzina <- chron(times=File$godzina)
        File$data <- as.Date(File$data)
        
    })
    NumberofUniqueDates <- ({
        length(unique(File$data))
    })
    
    LastUniqueDate <- ({
        tail(unique(File$data),n=1)
    })
    
    

    
    #Najnowszy wpis w pliku
    NewestEntry <- ({
        tail(File,n=1)
    })
    
    
    Last7DaysEntries <- ({
        subset(File, data >= NewestEntry$data -5)
    })
    
    Last24HEntries <- ({
        subset(File, data == NewestEntry$data)
    })
    

    output$Last24HPlot <- renderPlot({
        plot(Last24HEntries$godzina, Last24HEntries$temp)
    })
    
    #sprawdzana ilość wpisów z ostatnich 7dni
    L <- ({
        length(Last7DaysEntries$data)
    })
    
    #Średnie temp dla dnia i nocy na podstawie nowej rubryki Pora dnia
    MeanTempofLast7Days <- ({
        Stats <- aggregate(Last7DaysEntries$temp, FUN=mean, 
                           by=list(Data=Last7DaysEntries$data, PoraDnia=Last7DaysEntries$poradnia))
    })
    #Zwykłe średnie w ciągu całego dnia
    MeanCisnofLast7Days <- ({
        Stats <- aggregate(cisn ~ data, data = Last7DaysEntries, FUN = mean)
    })
    
    MeanWilgofLast7Days <- ({
        Stats <- aggregate(wilg ~ data, data = Last7DaysEntries, FUN = mean)
    })
    
    MeanIAQofLast7Days <- ({
        Stats <- aggregate(IAQ ~ data, data = Last7DaysEntries, FUN = mean)
    })
    
    
    
    output$TextTest <- renderText({
       # strtrim(toString(NewestEntry$data -1),10)
       # toString(Last7DaysEntries$data)
        
    })
}


shinyApp(ui = ui, server = server)
