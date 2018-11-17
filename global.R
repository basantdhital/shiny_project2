library(leaflet.extras)
library(shiny)
library(ggplot2)
library(data.table)
library(leaflet)
library(shinydashboard)
library(dplyr)
library(plotly)
library(DT)
library(tidyr)

# convert matrix to dataframe
#crime=fread("data/crime.csv", stringsAsFactors=F)
crime=fread("data/full_data.csv", stringsAsFactors=F)
crime=as.data.frame(crime)
borolist=unique(crime$BOROUGH)
crime$QUARTER = ifelse(crime$MON_STAR=='Jan',1,ifelse(crime$MON_STAR=='Apr',2,ifelse(crime$MON_STAR=='Jul',3,4)))

# create variable subsets



# # count.park <- crime %>%
# #   group_by(PARK, YEAR) %>%
# #   summarise(Count=n(),TOTAL_CRIMES = sum(TOTAL_CRIME)) %>%
# #   filter(TOTAL_CRIMES>0)
# # 
# # 
# # crime_park_year <- head(crime %>%
# #                           group_by(PARK, YEAR) %>%
# #                           summarise(TOTAL_CRIMES = sum(TOTAL_CRIME))  %>%
# #                           arrange(-TOTAL_CRIMES),20)
# # ggplot(crime_park_year, aes(x=PARK,y=TOTAL_CRIMES,fill=YEAR)) +
# #   geom_bar(stat = "identity") +
# #   coord_flip() 
# 
# # crime_borough_year = crime %>%
# #   group_by(BOROUGH, YEAR) %>%
# #   summarise(TOTAL_CRIMES = sum(TOTAL_CRIME))
# # 
# # 
# # crime_maxPark_byBorough = crime %>%
# #   group_by(BOROUGH,PARK) %>%
# #   summarise(TOTAL_CRIMES = sum(TOTAL_CRIME))  %>%
# #   arrange(-TOTAL_CRIMES)   %>%
# #   top_n(3,TOTAL_CRIMES)   %>%
# #   arrange(BOROUGH) 
# # 
# # ggplot(crime_maxPark_byBorough, aes(x=PARK,y=TOTAL_CRIMES,fill=BOROUGH)) +
# #   geom_bar(stat = "identity") +
# #   coord_flip()
# 
# 
# #crime$QUARTER = ifelse(crime$MON_STAR=='Jan',1,ifelse(crime$MON_STAR=='Apr',2,ifelse(crime$MON_STAR=='Jul',3,4)))
# 
# crime_year = crime %>%
#   group_by(YEAR, QUARTER ) %>%
#   summarise(TOTAL_CRIMES = sum(TOTAL_CRIME))  %>%
#   arrange(-TOTAL_CRIMES)
# ggplot(crime_park_year, aes(x=PARK,y=TOTAL_CRIMES)) +
#   geom_bar(stat = "identity") +
#   coord_flip()
# 
# 
# 
# # crime_size = crime %>%
# #   group_by(PARK) %>%
# #   summarise(TOTAL_CRIMES = sum(TOTAL_CRIME),SIZE.ACRES=first(SIZE.ACRES))  %>%
# #   arrange(-TOTAL_CRIMES)
# # ggplot(crime_size , aes(x=SIZE.ACRES,y=TOTAL_CRIMES)) +
# #   geom_point() +
# #   geom_smooth(method = "lm")





