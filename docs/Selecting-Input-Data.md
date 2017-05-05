## Running TIS

### Overview
There are six steps to running TIS. 

1. Install TIS 
2. Configure the setting for training 
3. Calculate the training feature sets 
4. Modify the setting for testing (optional) 
5. Calculate the testing feature sets 
6. Classify the testing feature sets against the training feature sets 

Following classification, the system will provide the user an identification rate. ![]()

###### Opening TIS
To open the TIS software, open Matlab and click on the Browse for folder icon that is shown in **Figure 1.** ![]()
 
**Figure 1**

Next choose the file where the TIS software is saved. ![]()

 **Figure 2**

After opening TIS, you will see a list of files and folders in the Current Folder list on the side bar. If some of these are greyed out add these files and folders to the path in Matlab. 
![]()

**Figure 3**

To do add these files to the path pick on the icon that says add to path. 
![]()

**Figure 4**

When the dialogue box opens click “Add with Subfolders…” and select the contents of the TIS folder. ![]()
 
**Figure 5**
 
Click save to save the files and folders to the Matlab path and press Close to exit the dialouge box and return to Matlab. The previously grey areas should be black
To run TIS, type TIS into the Command Window and press enter as shown in **Figure 6.** ![]()

**Figure 6**

Matlab will open the TIS Graphical User Interface (GUI) as shown in Figure C. The TIS GUI displays a menu bar (A) across the top of the screen that allow the user to change various settings pertaining to the user’s data. Below the menu bar are options to calculate or classify the data (B). 
![]() 

**Figure 7**
























######Model Settings ![]() 

**Figure 8**
	
When you click on the Model options in the toolbar, the left pane will display a set of Modeling Options.![]() 

**Figure 9**

The first option is Algorithm Type which defaults to Homogenous. In the future there may be an option for heterogeneous identification, but it is disabled at this time. 

	The second option, System Mode defaults to Identification. In the future there may be an option for authentication, but it is disabled at this time.

	The third option allows the user choose between a probabilistic classifier and support vector machine (SVM) classifier.  The probabilistic classifier is based on the algorithm found in (1). The SVM classifier is from (2). When SVM is selected the SVM Options field will cease to be greyed out. The user may change the C and G dimensions. For our experiments, the probabilistic classifier is more accurate

	The three directories fields allow the user to enter where they would like the system to store files that are created when the system is running. To change a directory, right click on the field and choose a directory. 

(1) Chen reference
(2) other reference



######IO Settings ![]() 

**Figure 10**

Training Options menu option allows the user to select the settings for the training dataset. There are two options under IO Settings however their functionalities are similar. Testing Options menu option offers the same options for sitting the testing dataset Right Click on the Data Directory to select your data. Use the .CVS File Delineation option denote how the data is delineated. For data that is separated by tabs select the Tab option, and for data that is separated by commas choose the Comma option. ![]() 

**Figure 11**

Set the Sample Rate to user preference. The next set of options asks the user to set the .CVS File Layout. Under .CVS File Layout indicate the Column number of where the data is located. For example type 0 into the box next to the Time Stamp label to indicate where the Time Stamp is on your spreadsheet. Under Trial Selection you can pick points to train the classifier with. The data points will coincide with your spreadsheet. ![]() 

**Figure 12**

The testing settings are the same as the training settings. The same process will be followed. After setting the options the user can select points to test on.

######ECG Settings ![]()  

**Figure 13**

Click on Preprocessing Options under the ECG menu to adjust the settings for the ECG signal. The Downsample Rate determines how many samples per second the software will use. The extra information will be cut off. Set the Downsample Rate for your data. Window Size means (skipped).

**Figure 14**

Figure 15 shows an example of an ECG signal. When Apply Trim Filter is selected the data that was corrupted during downsampling will be cut off. This is shown by the red lines. Apply 180 Hz Notch Filter means (skipped).

**Figure 15**

Feature Set Options are the second option under the ECG icon in the menu bar. The Segmentation Options allow the user to segment their signals into individual heartbeats. Segments per Beat is (Skipped). Segmentation Boundaries allow the user to decide between two algorithms to determine heartbeats from the samples. Fixed Lengths Relative to Peaks uses an algorithm to find the R Peak. After finding it, the algorithm selects points (decimals?) before and after the peak. This is used as a heartbeat (See Figure 16).

**Figure 16** 

Use the Before Primary Peak Length (samples) field to determine how many samples before the R Peak should be selected. The number of samples after the R Peak can be indicated using the After Primary Peak Length (samples) field. 

Figure 17

The second option is under Segmentation Boundaries is Peak to Peak. The algorithms finds the peaks of the heartbeats and uses the information to determine the heartbeat. This beat will always be constant. These values were found to work the best. 


Train and Test Data Options allow the user to choose how many heartbeats are needed for each subject in order to create (define?) a feature set.

Figure 18

 	The Number of Segments per Training Subject determine how many heartbeats are needed to train the classifier. Twelve was found to be most effective. The Number of Segments Per Test Subject determine how many heartbeats are needed to test the classifier. The Number of Segments Per Test is (skipped). Segment Selection Options determine which segments as indicated by the user will be used to test and train the classifier. 

Figure 19

Random will select beats from various sections of data. The Consecutive option will pick the first twelve segments. The Manual option displays the heartbeat on the screen and asks the user if they would like to use it (Figure X, take Pic). 
	The Closest to Mean option an algorithm to calculate the average heartbeat for each subject then selects twelve heartbeats that are closest to the overall average to use. 
‘
Figure 20 

According to the Law of Blank. Any signal can be broken down into individual waves that when brought back together will recreate the original signal. (Discrete R Transform? -Algorithm?)
DRT transforms the heartbeat into a matrix with a certain number of columns and where each row corresponds to a range of frequencies. 
 Experiments show that after about 60 Hz information can be removed without interfering with the whole. Enter a number into the Max Frequency Bin (Hz) to tell the software to ignore any component of the decomposed signal that has a higher frequency than what is set in the field. 




Figure 21

The algorithm uses a running window approach meaning it makes computations then moves forward to make more computations until the end of the data is reached and a matrix is developed. The number entered into the Window Length (samples) Field determines how many samples the algorithm will use at a time while the Window Step (samples) determines how far forward the algorithm will move. It will then compute the next set of samples. 

Column over 1000-defined by length
Rows 20-defined by step

Window Type is an argument to the DRT. Hamming and Hanning maintain the same function. 


Figure 22

Use the Feature Selection Options to determine how features will be selected. The number of selected bins determines how many bins will be used. The rest will be zeroed out. An algorithm finds bins that are similar to the mean data but specific to the individual subject to use. 

ROUGH LDV
 
Figure 23

LDV Preprocessing Options allow the user to set preference for LDV signals. The Chebyshev Filter option on the Downsample Method was ___. The Median Slide option is ______. (Add in sentence about why ECG doesn’t have? I had one but removed it) These options tell the software how to extract information based on the Downsample Rate. The Downsample Rate is set by the user and maintains the same function as it did for ECG. LDV signals maintains the same Checking Apply High Pass Filter will tell the software to  remove data that is not within a certain range of hertz. Checking Apply Trim Filter will remove corrupted information from where the LDV signal was downsampled. With LDV signal there tends to be spikes in the data that are a result of mechanical recordings. The laser may turn off intermediately. Remove Dropouts will remove these spikes. There are two options for a Peak Detection Alg, the Tokotch Method and the O’Brien Likelihood. The Tokotch Method is based on an algorithm created by Dr.Verne Leininger and Jose Corona (Note to self, check spelling) in 2015. while the O’Brien Likelihood uses a sliding window algorithm. (Take pictures of hidden menu and explain more) 

 Figure 24 
 
The second option on the PCG menu is Segmentation Options. Under this the user can define what will be used as a PCG signal (heartbeat?) 
(Take pictures of hidden menu and explain more) 
(Picture of PCG signal?)
The Fixed Lengths Before and After Peak means that a set number of samples will be taken before and after the peak. Fixed Length Beginning From Peak means that a user set number of samples will be taken after a peak is found. Peak to Peak allows the user to define how many samples will be taken as the heartbeat between two peaks. This gives the user a fixed number of samples regardless of their subject’s heart rate. The third option is Feature Set Options. The user can use these settings to determine how the signal will be used.
 
Figure 25 

The Laser Doppler Vibrometer picks up the vibrations made by the movement of the skin which is caused by the pulse. If the device you are using to record the PCG signal is recording the velocity measure then you can incorporate the displacement signal by checking the box next to Use Displacement Signal. Spectrogram options creates a feature set for the PCG signal. It uses the same algorithms as the ECG Spectrogram Options. It uses a sliding window method to determine spectrograms. Set the Window Length (samples) to tell the algorithm to compute X amount of samples within a step. Setting the Window Step (samples) will tell the algorithm to move forward X amount and make computations. The Window Type determines an argumentation to DRT. Hamming and Hanning is maintain similar functions. Train and Test Options determine how many and which beats (?) the classifier will train and test on. Set the Number of Segments Per Training Subject. Set the Number of Segments Per Test Subject. It was found that less heartbeats were needed for PCG to train and test the classifier. The Selection Modes maintain the same function as they did for the ECG signal, these options allow to determine how to select bins for training and testing. 

There are two methods for selecting bins, the goal is to find which bins have the most information in them. Static and Dynamic. If Static is selected then the software will use the same amount of spectrograms for every subject. Choosing Dynamic picks which spectrograms from each individual have the most information. 
Max Frequency Bin (Hz) is ____. Entering a value into Number of Selection Bins, will tell the software how many bins to use. Threshold is greyed out because ____.

What is the difference between the Feature set options and the selection mode? 


ROUGH PLOT OPTIONS (STILL WORKING ON) 
 
Figure 26

After setting the options, select Plot Options.  

Figure 27

Plot Options allows the user to toggle through various plots of their data. Selecting the boxes next to the headings tells the system to displays these plots. 
Figure 28

Click on Calculate Training Features to show the plots for trials selected in the Trial Selection option under the Training Options in the IO menu. Press enter and the first plot will show in the Modeling screen. Check the Pause Between Plots option, then press enter to scroll through the graphs for various subjects. When you reach the end of the data the next plot type will be displayed or you can uncheck the previous box and press enter to switch to the next plot. For example, if you are looking at Plot Preprocessing and you want to switch to Plot Peak Detection, uncheck Plot Preprocessing and press enter. The Modeling window will change. 

Figure 29

Plot Preprocessing displays the original signal of the subject and the signal after extra information is removed. The Y axis represents the hertz of the signal (See notes) while the x axis represents samples per second. X104  stands for seconds to the 10,000. 


Figure 30

Peak Detection option uses the method selected in the ECG or LDV menu for Peak Detection. (Specifically reference back?) The top graph displays the original signal for the subject number at the top of the screen. The bottom graph shows the peaks of the signal in the green circles. 

Figure 31
The Plot Spectrogram shows the

