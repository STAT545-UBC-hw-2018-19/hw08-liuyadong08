# This is the github repository of STAT545 Homework 08

This repo contains the BC Liquor app as a boilerplate, and I edited and added some features on it.

## Description
This app shows the price, type, and country of the liquors sold in BC Liquor Stores, and a checkbox asks whether to sort a table by price on the left pannel. On the right side, a histogram and a table is presented. Users can manipulate the input of the table and plot by changing the value in the widges on the left side. 

## Changes that were made 
I changes the radioButtons of "typeInput" as a selectInput and set the multiple argument as TRUE, so that users can look at data of multiple types of liquor at the same time. Also, I modified the plot in the server so that it shows differet types of liquor in different color. I added a checkbox to let the user decide whether to sort the table by price, and I added a picture of liquors, which I own the copyright. Finally, I edited the table as a DT table, so that users can reorder the table by clicking variable names. 

## The app is hosted here: https://yadong.shinyapps.io/bcl-yd/

## Code and data source
The original code and data are from [Dean Attali's tutorial](https://deanattali.com/blog/building-shiny-apps-tutorial). The code can specifically be found [here](https://deanattali.com/blog/building-shiny-apps-tutorial/#12-final-shiny-app-code).

The modified code and the bcl data can also be found in this repository


