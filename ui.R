shinyUI(fluidPage(
  titlePanel(h1("GeoChart for Gender Inequality Index")
  ),
  sidebarLayout(
    fluidRow(
      column(12, offset = 0,
             HTML("<div align='center'>This graph shows Gender Inequality Index measured
                  by UNITED NATIONS DEVELOPMENT PROGRAMME </br>
                  Further description for the dataset is available 
                  <a href='http://hdr.undp.org/en/data'>here</a>
                  <br />
                  <p>Select index from dropdown list, then push Update View button.
                  <br />
                  Dark colored country means there's some inequality between each gender as to selected index.</p>
                  </div>
                  <br />")
      )
    ),
    fluidRow(
    sidebarPanel(
      selectInput("Chosen", "Choose a index:", 
                  choices = c("GII.Value",
                              "GII.Rank",
                              "MaternalMortalityRatio",
                              "AdolescentBirthRate",
                              "FeMaleShareInParliament",
                              "HigherEducation_FeMale",
                              "HigherEducation_Male",
                              "LFPR_Female",   
                              "LFPR_Male"
                              )),
      helpText("Note: data updated only when submit button is pressed."),
      
      submitButton("Update View"),
      HTML('<br /> <font color="red">Description</font> <br />'),
      textOutput("description")
    ),
    mainPanel(
      HTML("<br/>"),
      HTML("<br/>"),
      htmlOutput("genChart")
    )
    )
  )
))