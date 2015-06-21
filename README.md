# Getting and Cleaning Data Course Project 2

## Contents of repo:

run_analysis.R  - R script to generate a data set containing the averages of the means and std variables
                  from the test and train data files.  This script performs the following:
                  * reads in the data files for the Human Activity Recognition Using Smartphones Data Set
                  * Combines both the test and training data into one data set
                  * Extracts the mena and standard deviation fields
                  * Calculates the averages of eahc of the means and standard deviation variable for each
                       subject and activity type
                  * Generates a output file (averages.txt) containing the resulting data set.
                  
  CoookBook.md  - describes the contents of the avregaes.txt file generated by the run_analysis.R script.
