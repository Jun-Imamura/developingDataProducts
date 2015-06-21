library(googleVis)
library(stringr)

# read data
genData <- read.csv("./data/GenderEquality.csv", na.strings = "..", stringsAsFactors = F)

# extract "Note.**"  not necessary
genData <- genData[,-grep("Note.",names(genData))]

# omit non-informative rows
genData <- genData[!is.na(genData$HDI.rank),]

GII <- "Gender Inequality Index in 2013: A composite measure reflecting inequality in achievement between women and men in three dimensions: reproductive health, empowerment and the labour market. See Technical note 3 at http://hdr.undp.org/en for details on how the Gender Inequality Index is calculated."
MMR <- "Maternal mortality ratio in 2010: Number of deaths due to pregnancy-related causes per 100,000 live births."
ABR <- "Adolescent birth rate from 2010 to 2015: Number of births to women ages 15–19 per 1,000 women ages 15–19."
SoSiNP <- "Share of seats in national parliament in 2013: Proportion of seats held by women in a lower/ single house or /and an upper house/ senate expressed as percentage of total seats. For countries with bicameral legislative systems, the share of seats is calculated based on both houses."
PwSE <- "Population with at least some secondary education from 2005 to 2012: Percentage of the population ages 25 and older who have reached (but not necessarily completed) a secondary level of education."
LFPR <- "Labour force participation rate in 2012: Proportion of a country’s working-age population (ages 15 and older) that engages in the labour market, either by working or actively looking for work, expressed as a percentage of the working-age population."

# some countries name improper for geoChart
i = 1
for(countryName in genData$Country){
  tmpName <- substr(countryName, 1, str_locate(countryName, " \\(")[,1] -1)
  if(!is.na(tmpName)){
    genData$Country[i] = (tmpName)
  }
  i=i+1
}

names(genData) <- c(
  "HDI.rank",                                                                                
  "Country",                                                                                 
  "GII.Value",                                                                              
  "GII.Rank",
  "MaternalMortalityRatio",
  "AdolescentBirthRate",
  "FeMaleShareInParliament",
  "HigherEducation_FeMale",
  "HigherEducation_Male",
  "LFPR_Female",   
  "LFPR_Male"
)

shinyServer(function(input, output){
  
    tmpData <- reactive({genData[!is.na(genData[input$Chosen]),]})
    output$genChart <- renderGvis({
    gvisGeoChart(tmpData(), locationvar="Country",
                 hovervar = "Country",
                 color=input$Chosen)
    })
    
    description <- reactive({
      switch(input$Chosen,                                                                            
             "GII.Value" = GII,                                                      
             "GII.Rank" = GII,                                                        
             "MaternalMortalityRatio" = MMR,                         
             "AdolescentBirthRate" = ABR,                     
             "FeMaleShareInParliament" = SoSiNP,                                     
             "HigherEducation_FeMale" = PwSE, 
             "HigherEducation_Male" = PwSE,   
             "LFPR_Female" = LFPR,                         
             "LFPR_Male" = LFPR
      )
    })
    
  output$description <- renderText({description()})
})