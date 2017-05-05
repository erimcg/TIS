## LDV Settings

![LDV Preprocessing Options](images/fig23_ldv_preprocessing_options.png) 
Figure 23

The `LDV Preprocessing Options` allow the user to alter the original LDV signals prior to computing feature sets for each subject. 

The 'Chebyshev Filter option on the Downsample Method was ___. The Median Slide option is ______. (Add in sentence about why ECG doesn’t have? I had one but removed it) These options tell the software how to extract information based on the Downsample Rate. The Downsample Rate is set by the user and maintains the same function as it did for ECG. LDV signals maintains the same Checking Apply High Pass Filter will tell the software to  remove data that is not within a certain range of hertz. Checking Apply Trim Filter will remove corrupted information from where the LDV signal was downsampled. With LDV signal there tends to be spikes in the data that are a result of mechanical recordings. The laser may turn off intermediately. Remove Dropouts will remove these spikes. There are two options for a Peak Detection Alg, the Tokotch Method and the O’Brien Likelihood. The Tokotch Method is based on an algorithm created by Dr.Verne Leininger and Jose Corona (Note to self, check spelling) in 2015. while the O’Brien Likelihood uses a sliding window algorithm. (Take pictures of hidden menu and explain more) 


![LDV Segmentation Options](images/fig24_ldv_segmentation_options.png) 
Figure 24 
 
The second option on the PCG menu is Segmentation Options. Under this the user can define what will be used as a PCG signal (heartbeat?) 
(Take pictures of hidden menu and explain more) 
(Picture of PCG signal?)
The Fixed Lengths Before and After Peak means that a set number of samples will be taken before and after the peak. Fixed Length Beginning From Peak means that a user set number of samples will be taken after a peak is found. Peak to Peak allows the user to define how many samples will be taken as the heartbeat between two peaks. This gives the user a fixed number of samples regardless of their subject’s heart rate. The third option is Feature Set Options. The user can use these settings to determine how the signal will be used.
 
![LDV Spectrogram Options](images/fig25_ldv_spectrogram_options.png) 
Figure 25 

The Laser Doppler Vibrometer picks up the vibrations made by the movement of the skin which is caused by the pulse. If the device you are using to record the PCG signal is recording the velocity measure then you can incorporate the displacement signal by checking the box next to Use Displacement Signal. Spectrogram options creates a feature set for the PCG signal. It uses the same algorithms as the ECG Spectrogram Options. It uses a sliding window method to determine spectrograms. Set the Window Length (samples) to tell the algorithm to compute X amount of samples within a step. Setting the Window Step (samples) will tell the algorithm to move forward X amount and make computations. The Window Type determines an argumentation to DRT. Hamming and Hanning is maintain similar functions. Train and Test Options determine how many and which beats (?) the classifier will train and test on. Set the Number of Segments Per Training Subject. Set the Number of Segments Per Test Subject. It was found that less heartbeats were needed for PCG to train and test the classifier. The Selection Modes maintain the same function as they did for the ECG signal, these options allow to determine how to select bins for training and testing. 

There are two methods for selecting bins, the goal is to find which bins have the most information in them. Static and Dynamic. If Static is selected then the software will use the same amount of spectrograms for every subject. Choosing Dynamic picks which spectrograms from each individual have the most information. 
Max Frequency Bin (Hz) is ____. Entering a value into Number of Selection Bins, will tell the software how many bins to use. Threshold is greyed out because ____.

What is the difference between the Feature set options and the selection mode? 
