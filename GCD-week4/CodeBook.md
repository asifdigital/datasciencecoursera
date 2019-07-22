---
title: "CodeBook"
author: "Asif Hameed"
date: "7/22/2019"
output: html_document
---

## Run_Analysis.R

Code is divided into sections
 1. Downloading of zip file and its unziped (uncoment only if you want to download data fields again)  
 2. Read all data files  
 3. Apply 5 step solution (commentd in code)  
 4. save to result to file
 
# Variables used, in reverse order
-X4 has the final resutl, dcasted with Activity and Subject  
-X3 has the melted data set  
-X2 has the merged data set  

# Tidy data
I chose to dcast my data set wide, meaning variable and subject were represented with one column e.g 1_tBodyAcc.mean...X where 1 is subject

