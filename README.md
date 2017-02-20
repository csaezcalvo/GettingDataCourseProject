# GettingDataCourseProject

This repo contains the Course Project for the Getting and Cleaning Data course in Coursera.
It includes 4 files:

* README.md : This file
* run_script.R : This script creates a tidy data frame starting with the given raw data
* CodeBook.md : This is the code book describing the variables of the tidy data frame contained in average_HAR.txt
* average_HAR.txt : the tidy data frame processed by the script in run_script.R

# What does the run_script.R do

This script performs the collection and cleaning of the data. It works following these steps:
* Reads training and test data
* Merges them to one data frame full_data
* Obtain the variable names
* Selects the columns on full_data corresponding to mean and standard deviation variables
* Creates a new data frame HAR by adding two new variables to the data frame: Subject and Activity
* Substitutes the number in Activity by the activity name
* Produces a tidy data frame average_HAR by averaging the measurements of HAR by subject and activity
* Exports average_HAR to a file average_HAR.txt
