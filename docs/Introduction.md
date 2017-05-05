## Introduction 

### Overview
	
Biometrics are physical or biological traits that can be used to identify a subject. A biometric identification system uses biometric information to identify a subject. A thoracic identification system uses signals from the thoracic cavity, which encompasses everything inside the ribcage to identify a subject. A homogenous identification system trains and tests the classifier using the same types of data. For example using ECG signals to train and test the classifier. A heterogenous system uses one type of signal to train the classifier and another type of signal to test it. For example, using PCG signals to train and ECG signals to test. TIS (Thoracic Identification System) is a homogenous thoracic biometric identification system.
 
### TIS Functionality

TIS requires two data set, a training dataset and a testing data set.  This software attempts to map individuals in a testing dataset to individuals in a training dataset.  IT computes a feature set of each subject in each set. It then attempts to match a feature set from the testing dataset with a feature set in the training dataset using a classifier. 
 
### System Requirements

For users to use TIS they must have MatlabR 2015 or later installed on the host machine. In addition, the DSP system and signal processing toolboxes must be available in Matlab.  The software can be downloaded [here](http://github.com/erimcg/TIS). 

The software works on the assumption that the user’s data is structures in the same way that the data from the original TIS experiment was taken. For two sets of data there should be two different directories. Within these directories there needs to be a separate file for each subject, within these files the data should be sectioned out.

### Running TIS

There are six steps when using TIS. 

1. Install and Load TIS
2. Select a classifier
3. Choose the training and testing input data 
4. Configure the preprocessing and feature set settings. 
5. Calculate the training feature sets 
6. Calculate the testing feature sets 
7. Classify the testing feature sets against the training feature sets 

Details for each of these steps are discussed in other pages of this document.

[Next: Installing and Loading TIS](Loading-TIS.md)
