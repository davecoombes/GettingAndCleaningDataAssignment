# GettingAndCleaningDataAssignment

The repository contains a script run_analysis.R that performs the following steps:

1. install and load 'dplyr' package
2. load activity and feature names
3. load accelerometer, subject and activity data sets for both training and test data
4. add meaningful names to data sets
5. merge accelerometer, subject and activity data for both training and test data
6. combines training and test data
7. extract variables that relate to mean and standard deviation of measurements
8. group, summarise and order data by subject and acitivity and output to file 'tidy.txt'