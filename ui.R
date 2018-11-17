
dashboardPage(
  skin='green',
  dashboardHeader(title='NYC Park Crimes'),
  dashboardSidebar(
    sidebarUserPanel('Basant Dhital',
                     image="https://pbs.twimg.com/profile_images/451193293997875201/c2BxCEog_400x400.jpeg"),
    sidebarMenu(
      menuItem("Introduction", tabName = "intro", icon = icon("info")),
      menuItem("Overview", icon = icon("bar-chart"),
               menuSubItem('Crimes by Park',tabName='park',icon = icon("file-text-o")),
               menuSubItem('Crime by Borough',tabName='boro',icon = icon("calendar")),
               menuSubItem('Total Crime by Year',tabName='Total',icon = icon("clock-o")),
               menuSubItem('Distribution of crimes',tabName='CrimeType',icon = icon("hourglass")),
               menuSubItem('Scatter plot',tabName='plotScatter',icon = icon("institution"))),
      #menuItem("Crime type distriubtion", tabName = "Crime_Type", icon = icon("database")),
      menuItem("Data", tabName = "data", icon = icon("database")),
      menuItem("Future directions",tabName = "expand", icon = icon("hourglass-2"))
    )
  ),
 
  

  dashboardBody(
    
    tabItems(
      tabItem(tabName = "intro",
              div(class="outer2",
                  tags$head(
                    includeCSS("styles.css")),
              br(),
              h1("Background"),
              h3("---Parks place to go for rest, meet people, take your kids to play."),
              h3("---Satefy is a major concern wherever you go and what we do. So, we need a convinient crime visualization of the NYC parks"),
              br(),
              h1("The Dataset"),
              h3("---  Data Source: https://www1.nyc.gov/site/"),
              h3("---  Original Dataset Size: 1.5 Mb"),
              h3(""),
              br(),
              br(),
              br(),
              h5("---Author: Basant Dhital"),
              h5("---Email: dhital.basant1@gmail.com")
      )),
      tabItem(tabName='park',
              h2('Crime counts by park and year'),
              fluidRow
                
              (column(6,
                selectizeInput("year", "Select Year", 
                             c(2014, 2015, 2016, 2017, 2018), 
                             selected = 2014)),
                column(6,
              selectizeInput("borough", "Select borough", 
                             borolist, 
                             selected = "MANHATTAN"))),
              fluidRow(box(plotOutput("park"), width=300))
      ),
      tabItem(tabName='boro',
              selectizeInput("year2", "Select Year", 
                             c(2014, 2015, 2016, 2017, 2018), 
                             selected = 2014),
              h2('Top 3 parks in crimes by borough'),
              fluidRow(box(plotlyOutput("boro"), width=300))
      ),
      tabItem(tabName='Total',
              selectizeInput("borough2", "Select borough", 
                             borolist, 
                             selected = "MANHATTAN"),
              h2('Total Crimes in Parks by year and quarter '),
              fluidRow(box(plotlyOutput("Total"), width=300))
      ),
      
      tabItem(tabName='CrimeType',
              selectizeInput("year3", "Select Year",
                             c(2014, 2015, 2016, 2017, 2018),
                             selected = 2014),
              h2('Pie chart distribution of Various Crimes'),
              fluidRow(box(plotOutput("CrimeType"), width=300))
      ),
      
  
      tabItem(tabName='plotScatter',
              h2('Scatter plot of Area vs Total crimes'),
              fluidRow(box(plotlyOutput("plotScatter"), width=10))
      ),
      
      tabItem(tabName='data',
              fluidRow(box(DT::dataTableOutput("table"), width=100))
      ),
      tabItem(tabName = "expand",
              div(class="outer3",
                  tags$head(
                    includeCSS("styles.css")),
          br(),
          h2("Every quarter new data will be available on http://opendata.dc.gov/"),
          br(),
          h2("To figure out safe zones with safe parks by combining with crite data in NYC "),
          br(),
          h2(" Overlay with apartment/house rental rates info with safe zones")))
    )
  )
)