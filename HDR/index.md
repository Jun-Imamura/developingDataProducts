---
title       : Gender Inequality Index
subtitle    : Visualize on GoogleVis GeoCharts
author      : Jun Imamura
job         : Engineer
framework   : io2012        # {io2012, html5slides, shower, dzslides, ...}
highlighter : highlight.js  # {highlight.js, prettify, highlight}
hitheme     : tomorrow      # 
widgets     : []            # {mathjax, quiz, bootstrap}
mode        : selfcontained # {standalone, draft}
knit        : slidify::knit2slides
---

## Gender Inequality
GII is defined by United Nations, as the index of gender inequalities defined by three important aspects of human development.  

1. Reproductive Health
2. Empowerment
3. Economic Status

Further description is available [here](http://hdr.undp.org/en/content/gender-inequality-index-gii).

This app visualize these aspects using geoCharts offered by googleVis API. Shiny application is uploaded to [shinyapps.io](https://junimamura.shinyapps.io/courseProj), hosting service managed by RStudio.

---

## Data Cleaning
* In the [dataset](http://hdr.undp.org/en/content/table-4-gender-inequality-index), some data are missing, and contains meaningless rows.


```r
# read data, missing values are denoted by ".."
genData <- read.csv("./data/GenderEquality.csv", na.strings = "..", stringsAsFactors = F)
# omit non-informative rows
genData <- genData[!is.na(genData$HDI.rank),]
```

* And more, some country name are inapproplicately contained for googleVis geoChart API.


```r
# e.g. Korea (Republic of) cannot be identified by GeoChart locationVar
countryName = "Korea (Republic of)"
substr(countryName, 1, str_locate(countryName, " \\(")[,1] -1)
```

```
## [1] "Korea"
```

---

## Example Result
Following figure shows geographic chart rendered by my shiny app.
<p><img src = "./assets/img/GII.png" alt="GII_images" width="600" height="400"></img></p>

GII value is higher, geoCharts get darker. And some countries are written in white because values are missing.

---

## Appendix

External link

* Dataset: Downloaded from [United Nations Development Programme](http://hdr.undp.org/en)
* Reference 1: Widgets example from [Shiny Gallery](http://shiny.rstudio.com/gallery/)
* Reference 2:[renderGVis](http://rpackages.ianhowson.com/cran/googleVis/man/renderGvis.html) is used to render a figure generated via googleVis API
* Find dataset: [google public data](http://www.google.com/publicdata/directory?hl=en_US&dl=en_US#!) helped so much

