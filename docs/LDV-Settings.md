## LDV Settings

![LDV Preprocessing Options](images/fig23_ldv_preprocessing_options.png) 
Figure 23

The `LDV Preprocessing Options` allow the user to alter the original LDV signals prior to computing feature sets for each subject. 

The `Downsample Method` drop-down menu allows the user to choose between two different methods to down-sampling the data: 'Chebyshev Filter` or `Median Slide`.

The 'Downsample Rate` setting specifies how many samples per second the software will use. This is helpful if the recording device collected data at a higer rate than needed.

When `High Pass Filter` is selected, the signal is transform by removing lower frequency (less than 3 hertz) components from the signal.  

`Apply Trim Filter` will cause a few samples at the ends of each segment to be remove.  This is usefull if down-sampling causes the tails of the segment to be corrupted.

If `Remove Dropouts` is selected a despecking filter is applied to the signal. 

There are two options for a 'Peak Detection Alg`: `Tokotch Method` and 'O’Brien Likelihood`. The Tokotch Method is based on an algorithm created by Dr.Verne Leininger and Jose Corona in 2015. while the O’Brien Likelihood method uses an iterative sliding window approach. 

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

[Next: Set Plot Options](Plot-Options.md)
 
