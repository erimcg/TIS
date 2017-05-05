## Section One

### TIS Overview
	
Biometrics are physical or biological traits that can be used to identify a subject. A biometric 
identification system uses biometric information to identify a subject. A thoracic identification 
system uses signals from the thoracic cavity, which encompasses everything inside the ribcage to 
identify a subject. A homogenous identification system trains and tests the classifier using the 
same types of data. For example using ECG signals to train and test the classifier. A heterogenous 
system uses one type of signal to train the classifier and another type of signal to test it. For 
example, using PCG signals to train and ECG signals to test. TIS (Thoracic Identification System) 
is a homogenous thoracic biometric identification system.
 
This program was developed by Dr. Eric McGregor and updated by his students, Tayseer O’Brien, 
Tray Souper and Dylan Tokotch. The thoracic identification system utilizes ECG, PGC and Carotid pulse 
signals as a biometric. 


### TIS Functionality

This software aims to map individuals in a testing dataset to individuals in a training dataset. TIS 
takes two data set, a training dataset and a testing data set. IT computes a feature set of each 
subject in each set. It then attempts to match a feature set from the testing dataset with a feature 
set in the training dataset using a classifier. 

### TIS Requirements

For users to use TIS they must have access to MatlabR 2015 or later. The DSP system and signal 
processing toolboxes must be available in Matlab.  The software can be downloaded here: 
http://github.com/erimcg/TIS. The software works on the assumption that the user’s data is structures 
in the same way that the data from the original TIS experiment was taken. For two sets of data there 
should be two different directories. Within these directories there needs to be a separate file for 
each subject, within these files the data should be sectioned out.
