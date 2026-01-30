# PH718 Data Management and Visualization in R
# Part 1: R Basic Syntax
# Zhiyang Zhou (zhou67@uwm.edu, zhiyanggeezhou.github.io)

# This is a R script with ".r" as the file extension, commonly used to save R code.
# However, Rstudio may handle other file formats,
# providing additional features like a script editor, console, debugging tools, and more.
# That is why RStudio is an integrated development environment (IDE).

# Words following pound signs (#) are comments, which provide annotations or explanations in your code.

#------------------------------------------------------------------------------------------
## Generating an EHR-style dataset with the given prompt at a GenAI platform
#------------------------------------------------------------------------------------------
# "Generate a realistic simulated electronic health records (EHR) dataset for 1,000 patients 
# with demographic, clinical, behavioral, and mental health variables. 
# Include a binary outcome related to substance use disorder. 
# Introduce realistic missing values in selected variables. 
# Save the dataset in CSV format."

# My generated dataset is saved as "sim_ehr_1000.csv" on Canvas.

#------------------------------------------------------------------
## Working directory: where inputs are found and outputs are sent
#------------------------------------------------------------------
getwd() # The current working directory

# Change the current working directory using function setwd('C:/file/path')
setwd('c:/PH717') # Error due to the nonexisting path "c:/PH717"
setwd('c:/PH718')
getwd()

# ------------------------------------------------------------------
## Load simulated EHR dataset
# ------------------------------------------------------------------
# Read data (place sim_ehr_1000.csv in your working directory)
ehr <- read.csv("sim_ehr_1000.csv", header = TRUE, stringsAsFactors = FALSE)

# First look at the data
dim(ehr)
head(ehr)
summary(ehr)

#------------------------------------------------------------------
## How to help yourself when exploring unfamiliar functions
#------------------------------------------------------------------
# Help manual of specific functions

?dim
?summary
?head
?read.csv

#------------------------------------------------------------------
## Assigning values to objects
#------------------------------------------------------------------
# The left arrow (<-) or equals sign (=) assigns the value at the right-hand side to the left-hand side.
n_patients <- nrow(ehr) # equiv. n_patients = nrow(ehr)
n_vars = ncol(ehr)

n_patients
n_vars

#------------------------------------------------------------------
## Data types: let str() or class() tell you
#------------------------------------------------------------------

str(ehr)
class(ehr$`age`) # ehr$`age` equiv. ehr$age equiv. ehr[,'age']
class(ehr$sex)
class(ehr$sud_dx)

# Convert to factors where appropriate
ehr$sex_f <- factor(ehr$sex)
ehr$sud_dx_f <- factor(ehr$sud_dx, levels = c(0,1), labels = c("NoSUD","SUD"))
class(ehr$sud_dx_f)

# Data frame: each column is a variable, each row is an observation
class(ehr)

ehr[1, ] # the 1st row
ehr[, 1] # the 1st column
ehr[, 'age'] # the column with name == "age"
ehr$age # the column with name == "age"
ehr[1:10, c("age","sex","sud_dx")]

# Vector: entries should share the SAME data type
# vector of characters
ehr[, 1]
str(ehr[, 1])
class(ehr[, 1])

# vector of numbers
ehr[, "age"]
str(ehr[, "age"])
class(ehr[, "age"])

# Matrix: entries should share the SAME data type
m1 <- as.matrix(ehr[, c("age","bmi","sbp")])
m1
dim(m1)
class(m1)
str(m1)

m1[1,3] # the (1,3)-entry
m1[1, ] # return the 1st row
m1[, 2] # return the 2nd column

#------------------------------------------------------------------
## Checking for missing values
#------------------------------------------------------------------
anyNA(ehr)
ehr_complete_bmi <- ehr[!is.na(ehr$aic), ] # remove rows with missing a1c values; exclamation mark "!" means "not"

#------------------------------------------------------------------
## Exporting data
#------------------------------------------------------------------
write.csv(ehr, "ehr_clean.csv", row.names = FALSE)

#------------------------------------------------------------------
## Logic and control
#------------------------------------------------------------------
# Simple logical operations: 
# exclamation mark "!" means "not"
# ampersand '&' means 'and'
# vertical bar '|' means 'or'

ehr$age >= 65
ehr$older_adult <- ifelse(ehr$age >= 65, 1, 0)
table(ehr$older_adult)

ehr$sbp >= 130
ehr$dbp >= 80
ehr$sbp >= 130 | ehr$dbp >= 80
ehr$high_bp <- ifelse(ehr$sbp >= 130 | ehr$dbp >= 80, 1, 0)
table(ehr$high_bp)

ehr$sud_dx_f == "SUD"
ehr_sud <- ehr[ehr$sud_dx_f == "SUD", ]
summary(ehr_sud$age)

ehr[ehr$age > 50 & ehr$high_bp == 1, c("age","sbp","dbp")]

#------------------------------------------------------------------
## Defining functions
#------------------------------------------------------------------
# A simple example
flag_high_bp <- function(sbp, dbp) {
  ifelse(sbp >= 130 | dbp >= 80, 1, 0)
}

ehr$high_bp2 <- flag_high_bp(ehr$sbp, ehr$dbp)

#------------------------------------------------------------------
## Loops: for-loop
#------------------------------------------------------------------
# If you need to replicate something for multiple times, then
# a loop is readable and save your time in coding.

# Example 1: Create a simple SUD risk score using a for-loop

risk_score <- rep(NA, nrow(ehr))  # pre-allocate space for risk_score
for (i in 1:nrow(ehr)) {
  score <- 0
  
  # Add points based on conditions (adjust variables to match your dataset)
  if (!is.na(ehr$age[i]) && ehr$age[i] < 25) score <- score + 1
  if (!is.na(ehr$phq9[i]) && ehr$phq9[i] >= 10) score <- score + 1
  if (!is.na(ehr$alcohol_use[i]) && ehr$alcohol_use[i] %in% c("Moderate","Heavy")) score <- score + 1
  if (!is.na(ehr$smoking[i]) && ehr$smoking[i] == "Current") score <- score + 1
  
  risk_score[i] <- score
}
ehr$risk_score <- risk_score

# Example 2: Count missing values per column
na_count <- rep(NA, ncol(ehr))
names(na_count) <- colnames(ehr)

for (j in 1:ncol(ehr)) {
  na_count[j] <- sum(is.na(ehr[, j]))
}
sort(na_count, decreasing = TRUE) # return the sorted na_count in decreasing order

# Example 3: Nested for-loops to build a contingency table (sex x sud_dx)
sex_levels <- sort(unique(ehr$sex))
out_levels <- sort(unique(ehr$sud_dx))

tab <- matrix(0, nrow = length(sex_levels), ncol = length(out_levels),
              dimnames = list(sex = sex_levels, sud_dx = out_levels))

for (r in 1:length(sex_levels)) {
  for (c in 1:length(out_levels)) {
    tab[r, c] <- sum(ehr$sex == sex_levels[r] & ehr$sud_dx == out_levels[c], na.rm = TRUE)
  }
}
tab
prop.table(tab, margin = 1)  # row proportions

# Example 4: Compute BMI category but skip rows with missing BMI using `next`
bmi_cat <- rep(NA, nrow(ehr))

for (i in 1:nrow(ehr)) {
  if (is.na(ehr$bmi[i])) next  # skip if missing
  
  if (ehr$bmi[i] < 18.5) bmi_cat[i] <- "Underweight"
  else if (ehr$bmi[i] < 25) bmi_cat[i] <- "Normal"
  else if (ehr$bmi[i] < 30) bmi_cat[i] <- "Overweight"
  else bmi_cat[i] <- "Obese"
}
ehr$bmi_cat <- factor(bmi_cat, levels = c("Underweight","Normal","Overweight","Obese"))

# Example 5: Find the first patient with very high PHQ-9 AND SUD
first_index <- NA
for (i in 1:nrow(ehr)) {
  if (!is.na(ehr$phq9[i]) && ehr$phq9[i] >= 20 && ehr$sud_dx[i] == 1) {
    first_index <- i
    break
  }
}
first_index
ehr[first_index, ]

#------------------------------------------------------------------
## Loops: while-loop
#------------------------------------------------------------------
# Find a minimum sample size where mean value of SUD stabilizes
n <- 1
prev_old <- mean(ehr$sud_dx[1:n] == 1, na.rm = TRUE)
diff <- 1
while (diff > 0.005 && n < nrow(ehr)) {
  n <- n + 1
  prev_new <- mean(ehr$sud_dx[1:n] == 1, na.rm = TRUE)
  diff <- abs(prev_new - prev_old)
  prev_old <- prev_new
}
n

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
for (i in 1:10^4){
  result1 = result1 + i^2
}
result1
## The summation may be implemented by the following vectorization
result2 = sum((1:1e4)^2)
result2

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
     
