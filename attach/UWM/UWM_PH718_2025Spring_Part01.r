# PH718 Data Management and Visualization in R
# Part 1: R Basic Syntax
# Zhiyang Zhou (zhou67@uwm.edu, zhiyanggeezhou.github.io)
# Acknowledgment: Dr. Kourosh Ravvaz
# 2025/01/21

# This is a R script with ".r" as the file extension, commonly used to save R code.
# However, Rstudio may handle other file formats,
# providing additional features like a script editor, console, debugging tools, and more.
# That is why RStudio is an integrated development environment (IDE).

# Words following pound signs (#) are comments, which provide annotations or explanations in your code.

# Working directory: the directory where inputs are found and outputs are sent
# The current working directory
getwd()

# Change the current working directory using function setwd('C:/file/path')
setwd('c:/ph717') # Error due to the nonexisting path "c:/ph717"
setwd('c:/ph718')

# Homepage of the help manual
help.start()

# Help manual of a specific function
help('lm')
?lm
help('lm', package=stats) # In case functions belonging to different packages share the idential name
?stats::lm

# Get help of a package
help(package=stats)

# The left arrow (<-) or equation sign (=) assigns the value at the right-hand side to the left-hand side.
a1 = 10 # The name of object is up to the programmer but cannot start with a number or contain spaces
a1
a2 <- a1
a2

# What is the following code for?
rm(a2)

# All the data sets in package ‘datasets’
data()

# Load a specific dataset
data(mtcars)
data(iris)

## Data types: let str() or class() tell you
# Numeric (real number, or more specifically, double precision floating-point number)
class(a1)
str(a1)
is.numeric(a1)

# Integer
a3 = 10L
class(a3)
str(a3)

# Character
a4 <- '10'
a5 = "10"
class(a4)
is.character(a4)
str(a4)

# Logical (true or false)
# A logical value arising from a comparison
5 == 10
a4 == a5
a4 != a5
a1 > a2
a6 = (a4 == a5)
is.logical(a6)
class(a6)
str(a6)

# Date & time
a7 <- as.Date('2025-01-21')
class(a7)
str(a7)
# Internally, date objects are stored as the number of days since January 1, 1970.
# To convert a date object to its internal form
as.numeric(a7)
# Stores a date and time
a8 <- as.POSIXct('2025-01-21 16:00')
# If time is included, the numeric form is the number of seconds since 1/1/1970.
as.numeric(a8)

# Factor: character strings with preset levels
# Used to represent categorical data
# To be discussed later

# Special Values
1/0
0/0

## Data Structures: let str() or class() tell you
# Vector: entries should share the SAME type
# vector of numbers
v1 <- c(1, 2, 3, 4, 5, 6, 7, 8)
# or equiv. 
v1 <- 1:8
v1 <- seq(from = 1, to = 8, by = 1)
# More operations on vectors
length(v1)
unique(v1)
rev(v1)
v1[order(v1)]
v1[v1 > 3]
v1[1:3]
v1[c(1,6)]
v1[-(2:4)]
v1[v1 == 5]
v1[v1 %in% c(1, 2, 5)]
# vector of characters
v2 <- c('Sarah', 'Tracy', 'Jon')
v2 <- c(v2, 'Annette') # Adding elements
v2 <- c('Greg', v2) # Adding elements
# vector with missing Data
v3 <- c(0.5, NA, 0.7)
v3 <- c(TRUE, FALSE, NA)
v3 <- c('a', NA, 'c', 'd', 'e')
v3 <- c(1 + 5i, 2 - 3i, NA) # including complex numbers (real number + imaginary part)
is.na(v3)
anyNA(v3)

# Matrix: entries should share the SAME type
m1 <- matrix(0, nrow = 2, ncol = 2)
m1
dim(m1)
class(m1)
str(m1)

m2 <- matrix(1:6, nrow = 2, ncol = 3)
m2

m3 <- matrix(1:6, nrow = 2, ncol = 3, byrow = TRUE)
m3

m3[1,3] # the (1.3)-entry
m3[1, ] # return the 1st row
m3[, 3] # return the 3rd column

cbind(m2, m3)
rbind(m2, m3)

# Array

# Create a 3x3x3 array (3 dimensions) with random values
array1 <- array(data = 1:27, dim = c(3, 3, 3))
array1

array1[2, 1, 3]
array1[2, , 3]
array1[2, 1, ]

# Data frame: each column is a variable, each row is an observation
d1 <- data.frame(id = letters[1:10], x = 1:10, y = 11:20)
d1
class(d1)
str(d1)

d1[1,3]
d1[1, ]
d1[, 3]
d1[['y']] # return the variable with name == 'y'
d1$y
d1$'y'

str(mtcars)
head(mtcars)
tail(mtcars)

# List: entries of a list are not restricted to the same data type
l1 <- list(1, 'a', TRUE, 1 + 4i)
l1
length(l1)
l1[[2]]
class(l1)
class(l1[[2]])
str(l1)

l2 <- list(a = 'MLM', b = 1:10, data = head(mtcars))
l2
length(l2)
str(l2)
