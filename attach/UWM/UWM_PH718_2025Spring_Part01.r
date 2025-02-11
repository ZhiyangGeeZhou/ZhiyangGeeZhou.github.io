# PH718 Data Management and Visualization in R
# Part 1: R Basic Syntax
# Zhiyang Zhou (zhou67@uwm.edu, zhiyanggeezhou.github.io)
# Acknowledgment: Dr. Kourosh Ravvaz
# Reference: ISL Sec 2.3

# This is a R script with ".r" as the file extension, commonly used to save R code.
# However, Rstudio may handle other file formats,
# providing additional features like a script editor, console, debugging tools, and more.
# That is why RStudio is an integrated development environment (IDE).

# Words following pound signs (#) are comments, which provide annotations or explanations in your code.

#------------------------------------------------------------------
## Help manual
#------------------------------------------------------------------
# Homepage of the help manual
help.start()

# Help manual of a specific function
help('lm')
?lm
help('lm', package='stats') # In case functions belonging to different packages share the idential name
?stats::lm

# Get help of a package
help(package='stats')

#------------------------------------------------------------------
## Assigning a value to an object
#------------------------------------------------------------------
# The left arrow (<-) or equation sign (=) assigns the value at the right-hand side to the left-hand side.
a1 = 10 # The name of object is up to the programmer but cannot start with a number or contain spaces
a1
a2 <- a1
a2

# What is the following code for?
?rm
rm(a2)

#------------------------------------------------------------------
## Loading datasets in package ‘datasets’
#------------------------------------------------------------------
# All the datasets in package ‘datasets’
data()

# Load a specific dataset
?mtcars
data(mtcars)
data(iris)

#------------------------------------------------------------------
## Data types: let str() or class() tell you
#------------------------------------------------------------------
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
a4 != a5 # !:not
a1 > a3
a6 = (a4 == a5)
a6
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
a8 <- as.POSIXct('2025-01-21 16:23:45')
class(a8)
# If time is included, the numeric form is the number of seconds since 1/1/1970.
as.numeric(a8)

# Factor: character strings with preset levels
# Used to represent categorical data
old = iris$Species
class(old)
str(old)
levels(old) # displays the original levels
new = factor(old, levels = c("versicolor","setosa","virginica")) # Modify factor levels
levels(new) # displays the original levels

# Special Values
1/0
0/0

#------------------------------------------------------------------
## Data Structures: let str() or class() tell you
#------------------------------------------------------------------
# Vector: entries should share the SAME data type
# vector of numbers
v1 <- c(1, 2, 3, 4, 5, 6, 7, 8)
# or equiv. 
v1 <- 1:8
v1 <- seq(from = 1, to = 8, by = 1)
v1
# A vector with ties
v2 = c(3,5,5,2)
length(v2)
unique(v2)
rev(v2)
# Extract certain entries of a vector
v2[c(1,1)]
v2[c(1,6)]
v2[-(2:4)]
v2[c(-3,-4)]
v2[order(v2)]
v2[v2 > 3]
v2[v2 == 5]
v2[v2 %in% c(1, 2, 5)]
v2[v2 < 5] # equiv. v2[which(v2 < 5)]
# sort(), order() & rank()
sort(v2, decreasing = F)
order(v2, decreasing = F)
sort(v2, decreasing = T)
order(v2, decreasing = T)
rank(v2, ties.method = "last")

# vector of characters
v2 <- c('Sarah', 'Tracy', 'Jon')
v2 <- c(v2, 'Annette') # Adding elements
v2 <- c('Greg', v2) # Adding elements
v2
v2[v2 != 'Tracy']

# vector with missingness
v3 <- c(0.5, NA, 0.7)
v3
v3 <- c(TRUE, FALSE, NA)
v3 <- c('a', NA, 'c', 'd', 'e')
anyNA(v3)
is.na(v3)
v3[!is.na(v3)] # remove NA

# Matrix: entries should share the SAME data type
m1 <- matrix(0, nrow = 2, ncol = 4)
m1
dim(m1)
class(m1)
str(m1)

m2 <- matrix(1:6, nrow = 2, ncol = 3)
m2

m3 <- matrix(1:6, nrow = 2, ncol = 3, byrow = TRUE)
m3

m3[1,3] # the (1,3)-entry
m3[1, ] # return the 1st row
m3[, 2] # return the 2nd column

cbind(m2, m3)
rbind(m2, m3)

# Data frame: each column is a variable, each row is an observation
# Create a data frame
d1 <- data.frame(id = letters[1:10], x = 1:10, y = 11:20)
d1
class(d1)
str(d1)
# A data frame with numbers only
data(mtcars)
class(mtcars)
str(mtcars)
head(mtcars, 10)
tail(mtcars, 3)
# A data frame with both numbers and characters
data(iris)
class(iris)
str(iris)
head(iris)
tail(iris)
# Extract certain entries of a data frame
iris[1,3]
iris[1, ]
iris[, 3]
iris[['Species']] # return the variable with name == 'Species'
iris$Species
iris$'Species'

# List: entries of a list are NOT restricted to the same data type
l1 <- list(1, 'a', c(TRUE, FALSE))
l1
length(l1)
l1[[2]]
class(l1)
class(l1[[2]])
str(l1)

l2 <- list(a = 'MLM', b = 1:10, data = head(mtcars))
l2
l2$a
length(l2)
str(l2)

#------------------------------------------------------------------
## Working directory: where inputs are found and outputs are sent
#------------------------------------------------------------------
getwd() # The current working directory

# Change the current working directory using function setwd('C:/file/path')
setwd('c:/PH717') # Error due to the nonexisting path "c:/PH717"
setwd('c:/PH718')
getwd()

# Open a new R script and enter the following three lines
x <- 1:10
y <- 1:10
plot(x,y)
# Save this script as "inclass_file.r" to PH718 directory
source("inclass_file.r") # execute/run the code in a R script

#------------------------------------------------------------------
## Importing and exporting data
#------------------------------------------------------------------
# Put data files in the current working directory
# Import Data from a CSV file
csv_data <- read.csv("example_csv_file.csv", header = T) 
# or
csv_data = read.table("example_csv_file.csv", sep = ",", header = T)
head(csv_data)  # display the first few rows
# Export data to a CSV File
write.csv(csv_data, file = "exported_data.csv", row.names = T) 

# Import data from a tab-delimited text file
tab_delimited_data <- read.delim("example_tab_delimited_file.txt", header = T)
# or
tab_delimited_data = read.table("example_tab_delimited_file.txt", sep="\t", header = T)
head(tab_delimited_data)
# Export data to a tab-delimited text file
write.table(tab_delimited_data, file="exported_tab_data.txt", sep="\t", row.names = FALSE)

# Import data without headers
data_without_headers <- read.csv("example_cvs_file_without_headers.csv", header = F)
data_without_headers
colnames(data_without_headers) <- c("Name","Age","Sex")
rownames(data_without_headers) = c('subject1','subject2','subject3')
data_without_headers

# Import data with missingness
data_with_missing_values <- read.csv("example_csv_file_with_missing.csv", na.strings = c('','NA'))
is.na(data_with_missing_values)
# Export data with customized missingness label
write.csv(data_with_missing_values, file = "exported_data_with_custom_missing_value.csv", na='nothing', row.names = F)

#------------------------------------------------------------------
## Vectorized arithmetic
#------------------------------------------------------------------
# For an arbitrary vector, say
x <- c(0.5, 3.6, 3)

x + 3 # Addition
4 - x # Subtraction
7 * x # Multiplication
3/x  # Division
2^x  # Exponentiation
x^(-5)  # Exponentiation
x %% 3  # Modulus (remainder of division)

# For one more vector, say
y <- c(4.1, 5, 6)

x + y
x - y
x * y
x / y

# Entry-wise operations are allowed btw one scalar and one vector (or two vectors of the same length)
# Entry-wise operations are allowed btw one scalar and one matrix (or two matrices of the same dimension)

x = matrix(1:6, 2, 3)
y = matrix(3:8, 2, 3)

x + y
x - y
x * y
x / y

x %*% t(y)

# Mathematical functions
sqrt(x)  # Square root
x^(0.5)
abs(x)  # Absolute value
log(x)  # Natural logarithm 
exp(x)  # Exponentiation (with base e)
round(x, 2)  # Rounding numbers

#------------------------------------------------------------------
## Logic and control
#------------------------------------------------------------------
# Simple logical operations: !: not; &: and; |: or
a = TRUE
b = FALSE

a & b
a | b
!a & b # equiv. (!a) & b
!(a & b)
!a | !b # equiv. (!a) | (!b)

x <- 10
x < 20

x <- 1:10
x < 5
x == 6

# Control: "ifelse" function
x <- 5
ifelse((0<x & x<4) | x>5, 1, 0)

x <- 1:10
ifelse(x<=4, 1, 0)

# Control: "if" and "else"
x <- .2
if(x < 0.5 & x<9 & x>0){
  y <- x^2	
}else{
  y <- sqrt(x)
}
y 

#------------------------------------------------------------------
## Loops: "for" loop
#------------------------------------------------------------------
# If you need to replicate something for multiple times, then
# a loop is more readable and save your time in coding.

w = c() # or w <- NULL; initiate an empty vector to store the result

# A for loop is implemented by using function 'for'
for(i in 1:10){ # "i" is a loop variable taking on each value from 1:10.
  w[i] <- i+10
}
w

# What do you think the following w looks like?
for(hello in 1:10){
  w[hello] <- hello+10
}
w

# Nested loops
w = c()
counter <- 1
for(j in 11:20){
  for(i in 1:10){
    w[counter] <- i + j
    counter <- counter + 1
  }
}
w


# What is the difference between the following w and the previous one?
w = c()
counter <- 1
for (j in 11:20) {
  for (i in 1:10){
    w[counter] <- i + j
  }
  counter <- counter + 1
}
w

# It is better to specify the length of w beforehand.
# Otherwise, R has to reallocate memory at each iteration.
# Compare the running times of the following two code trunks.
system.time({
  w <- c()
  for(i in 1:10^6){
    w[i] <- i+10}
}
)

system.time({
  w <- rep(NA, times=10^6)
  for(i in 1:10^6){
    w[i] <- i+10}
}
)

# Example: construct a 10 x 10 multiplication table using a nested loop.
my_mat <- matrix(NA, nrow=10, ncol=10)
for(rows in 1:10) {
  for(cols in 1:10) {
    my_mat[rows, cols] <- rows * cols
  }
}
my_mat

# Example: sum_{i=1}^{10^4} i^2
result = 0 
for (i in 1:10^4){
  result = result + i^2
}
result

#------------------------------------------------------------------
## Loops: "while" loop
#------------------------------------------------------------------
# Keep looping if a logical condition holds
w <- 100
z <- 5
while(w > 20){
  w.plus.z <- w + z
  w <- w - 1
}
w

# Make sure the while loop can be terminated.
# Otherwise it will runs forever.
w <- 100
z <- 5
while(w > 20){
  w.plus.z <- w + z
  w <- w + 1
}

# Example: sum_{i=1}^{10^4} i^2
result = 0 
i = 10^4
while (i >= 1){
  result = result + i^2
  i = i - 1
}
result

#------------------------------------------------------------------
## Loops: using "next" and "break"
#------------------------------------------------------------------
# A "next" statement is used when we want to skip the current iteration without terminating the loop. 
# When encountering "next", R skips further evaluation and starts the next iteration.
m = 20
for(k in 1:m) {
  if(!(k %% 2)) # "%%" indicates "x modulo y", i.e., computes the remainder when x is divided by y.
    next
  print(k)
}

# A "break" statement terminates the current loop. 
# When encountering "break", R terminates the current loop.
m = 20
for(k in 1:m) {
  if(!(k %% 2))
    break
  print(k)
}

# Example created by Copilot
# with prompt "help me generate an example of r code of 2 nested loops with "break" function involved in the inner loop"
for (i in 1:5) {
  cat("Outer loop iteration:", i, "\n") # printing
  for (j in 1:5) {
    if (j == 3) {
      cat("  Inner loop iteration:", j, " - Break condition met! Breaking inner loop.\n")
      break
    }
    cat("  Inner loop iteration:", j, "\n")
  }
}


# Example: construct the lower triangular of a 10 x 10 multiplication table.
my_mat <- matrix(NA, nrow=10, ncol=10)
for(rows in 1:10) {
  for(cols in 1:10) {
    if(rows < cols) next
    my_mat[rows, cols] <- rows * cols
  }
}
my_mat

#------------------------------------------------------------------
## Defining functions
#------------------------------------------------------------------
# A simple example
example.sum <- function(a, b){
  return(a + b)
}
x <- 1:10
y <- 11:20
example.sum(b=y,a=x)

## Write a function to convert Celsius to Fahrenheit and vice versa
C_to_F <- function(temp) {
  return((temp * 1.8) + 32)
}

F_to_C<- function(temp) {
  return((temp - 32)/1.8)
}

par(mfrow=c(2,1))
plot(1:100, C_to_F(1:100))
plot(-40:212, F_to_C(-40:212))
par(mfrow=c(1,1))

## Combine above two functions by adding argument type_of_conversion
temp_conversion <- function(temp, type_of_conversion) {
  if(!type_of_conversion %in% c("F_to_C", "C_to_F")) {
    stop("STOP!!! I can only convert C to F or F to C.")
  }
  if(type_of_conversion == "F_to_C") {
    new_temp <- F_to_C(temp)
  }
  if(type_of_conversion == "C_to_F") {
    new_temp <- C_to_F(temp)
  }
  return(list(temp=new_temp, conversion=type_of_conversion))
}
temp_conversion(50:100, type="C_to_F")

################################################################
# Loops in functions
################################################################
# Example: a function calculating the factorial of a number via a "for" loop
calculate_factorial <- function(n) {
  if (n %% 1 != 0){
    stop("wrong n")
  }
  factorial_result <- 1
  for (i in 1:n) {
    factorial_result <- factorial_result * i
  }
  return(factorial_result)
}
calculate_factorial(5.1)

#------------------------------------------------------------------
## Debugging
#------------------------------------------------------------------
# What is the error/warning in each of the following examples? 
# How should the code be fixed?

# Example 1
data(cars)
plot(cars[,2], cars[,3])

# Example 2
new_data <- cars[which(cars$speed == 4)]
plot(new_data$speed, new_data$dist)
     
# Example 3
index <- which(cars$speed < 20 & cars$dist > 100)
new_data2 <- cars[index,]
plot(new_data2$speed, new_data2$dist)

# Example 4
find_column <- which(colnames(cars) == "Speed")
find_column

# Example 5
data(iris)
data_bind <- rbind(iris, cars)

# Example 6
ggplot(cars) + geom_point(aes(x=speed, y=dist))
qplot(mpg, wt, data=mtcars)

# Example 7
log(-1:10)
     
# Example 8: Debugging in user-defined functions
# Example 8a
 
my_fun <- function(x) {
  y <- x^2 
  # browser() # Interrupt the execution and allow the inspection of the environment
  y <- y*2 
  # browser()
  y 
}
my_fun(x = 7)
 
# Example 8b
fcn <- function(x, y) {
  z <- x * y
  # browser()
  z1 <- z
  # browser()
  z2 <- z1
  # browser()
  z3 <- z2 + "a"
  # browser()
  return(z3 * exp(z3))
}
fcn(2, 1.3)
     
#------------------------------------------------------------------
## Vectorization outperforming loops
#------------------------------------------------------------------
# In R, many loops can be implemented faster by using vectorization.
# Simply speaking, R has been optimized for vectorization.
# Example 1
# via loop
A <- matrix(1:2e5, nrow=500, ncol=400)
B <- matrix((2e5+1):4e5, nrow=500, ncol=400)
system.time({
  matsum <- matrix(0, nrow=500, ncol=400)
  for(i in 1:500) {
    for(j in 1:400) {
      matsum[i,j] <- A[i,j] + B[i,j]
    }
  }
})
# via vectorization
system.time({
  matsum <- A + B
})

# Example 2
# via loop
system.time({
  x <- 1:1e6
  result <- numeric(length(x))
  for (i in x) {
    result[i] <- x[i] * 2
  }
})
# via vectorization
system.time(
  {
    x <- 1:1e6
    result <- x*2
  }
)

# Example 3: sum_{i=1}^{10^4} i^2

result1 = 0 
for (i in 1:10^3){
  result1 = result1 + i^2
}
result1

result2 = sum((1:1e3)^2)
result2