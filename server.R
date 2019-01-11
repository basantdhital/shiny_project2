
function(input, output) {
  
  reactthis <- reactive({
    head(crime %>%
           filter(YEAR == input$year) %>%
           filter(BOROUGH == input$borough) %>%
           select(PARK, TOTAL_CRIME) %>% 
           arrange(-TOTAL_CRIME), 20)
  })
  output$park <- renderPlot({
    ggplot(data=reactthis(), aes(x=PARK,y=TOTAL_CRIME)) +
      geom_bar(stat = "identity", fill = 'blue')+
      theme(axis.text.x = element_text(angle = 90, hjust = 1))
    
  })
  
  reactthis2 <- reactive({
      crime %>%
      filter(YEAR == input$year2) %>%
      group_by(BOROUGH,PARK) %>%
      summarise(TOTAL_CRIMES = sum(TOTAL_CRIME))  %>%
      arrange(-TOTAL_CRIMES)   %>%
      top_n(3,TOTAL_CRIMES)   %>%
      arrange(BOROUGH)
    
  })
  
  output$boro =renderPlotly({
    ggplot(reactthis2(), aes(x=PARK,y=TOTAL_CRIMES,fill=BOROUGH)) +
      geom_bar(stat = "identity")  +
      theme(axis.text.x = element_text(angle = 45, hjust = 1))
    
    
  })
  
  

  reactthis3 <- reactive({
        crime_park_year <- head(crime %>%
                                  group_by(PARK, YEAR) %>%
                                  summarise(TOTAL_CRIMES = sum(TOTAL_CRIME))  %>%
                                  arrange(-TOTAL_CRIMES),20)
        
      crime_year = crime %>%
        filter(BOROUGH == input$borough2) %>%
        group_by(YEAR, QUARTER ) %>%
        summarise(TOTAL_CRIMES = sum(TOTAL_CRIME))  %>%
        arrange(-TOTAL_CRIMES)

  })


  output$Total =renderPlotly({
    ggplot(reactthis3() , aes(x=YEAR,y=TOTAL_CRIMES, fill=QUARTER)) +
      geom_bar(stat = "identity") 
  })
  
  reactthis4 <- reactive({
      crime %>% 
      filter(YEAR == input$year3) %>%
      filter(BOROUGH == input$borough3) %>%
      gather(key = crime_type, value = count, `MURDER`:GRAND.LARCENY.OF.MV) %>% 
      group_by(crime_type) %>%
      summarise(count=sum(count)) %>%
      mutate(ratio = 100*count/sum(count))
  })
  
  output$CrimeType=renderPlot({
    #crime %>%
      # gather(key = crime_type, value = count, `MURDER`:GRAND.LARCENY.OF.MV) %>%
      # group_by(crime_type) %>%
      # summarise(count=sum(count)) %>%
      # mutate(ratio = 100*count/sum(count)) %>%
      ggplot(reactthis4()) +
      #ggplot() +
      geom_bar(
        aes(x=1 , y=ratio, fill=crime_type), 
        stat="identity", position="stack"
      ) + coord_polar(theta = "y")
  })

  
  
  
  
  output$plotScatter=renderPlotly({
  crime_size = crime %>%
    group_by(PARK) %>%
    summarise(TOTAL_CRIMES = sum(TOTAL_CRIME),SIZE.ACRES=first(SIZE.ACRES))  %>%
    arrange(-TOTAL_CRIMES)
  ggplot(crime_size , aes(x=SIZE.ACRES,y=TOTAL_CRIMES)) +
    geom_point() +
    geom_smooth(method = "lm")
  
  })
  
  
  output$table=DT::renderDataTable({
    datatable(crime, rownames=FALSE, options=list(scrollX=TRUE))
  })
}
