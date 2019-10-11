---
title: "CodeBook"
output: html_document
---

##CodeBook

    The original data consists of ~10,000 records, each one recording 561 variables containing data and measurements pertaining to the use of a smartphone acceleromter to capture data on test subjects performing multiple activities. A precise description of each variable is not relevant, because this analysis only extracts ~66.
    
    This analysis extracts the variables related to means and standard deviations of measurements of the accelerometer. The final data produced records the averages of each mean and standard deviation recorded, as calculated for each subject performing each subject. For example, in the final data, a row will contain the ID of the subject, the activity performed, and then the average of their means and standard deviations for that activity. This produces a very high level summary of the data for each subject and each activity.
    
    The steps to produce this final data are as follows:
    1. Load in the raw data for the test subjects and the training subjects
    2. Load in the "features" data, which contains which column corresponds to which variable
    3. Load in the activity and subject ID's for both the test and training subjects
    4. For simplicity of administration, rename the appropriate columns and combine the activity and subject ID vectors
    5. Using the "features vector", use the "grepl" command and a regular expression to identify which columns we need to extract from the raw data based on the words "mean" and "std"
    6. Filter out the needed columns using the results from step 5, then combine the test and training data into one dataset
    7. After combination, rename the generic column names in the combined dataset using the column names recorded in "features"
    8. Add on the columns containing the subject ID's and activity ID's; note that when combining these sets, great care is taken to ensure that the ID's for test and training align correctly
    9. Replace the activity ID numbers with descriptive strings describing which activity is which
    10. To produce final data, group the combined dataset by subject ID and then by activity, then compute the mean of all the other columns
    11. Write this data to a text file for transmission or later analysis
    