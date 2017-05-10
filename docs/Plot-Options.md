## Plot Options

![Plot Options Menu](fig26_menu_plot_options.png)
After setting the options, select Plot Options.  

![Plot Options](fig27_plot_options.png)
Click on Calculate Training Features to show the plots for trials selected in the Trial Selection option under the Training Options in the IO menu. Press enter and the first plot will show in the Modeling screen. Check the Pause Between Plots option, then press enter to scroll through the graphs for various subjects. When you reach the end of the data the next plot type will be displayed or you can uncheck the previous box and press enter to switch to the next plot. For example, if you are looking at Plot Preprocessing and you want to switch to Plot Peak Detection, uncheck Plot Preprocessing and press enter. The Modeling window will change. To make the plots show in full screen check the Undock Plots box. 

Figure 29

![]()
Plot Preprocessing displays the original signal of the subject and the signal after extra information is removed. The Y axis represents the hertz of the signal (See notes) while the x axis represents samples per second. X104  stands for seconds to the 10,000. 


Figure 30

![]()
Peak Detection option uses the method selected in the ECG or LDV menu for Peak Detection. The top graph displays the original signal for the subject number at the top of the screen. The bottom graph shows the peaks of the signal in the green circles. 

Figure 31
![]()
The Plot Spectrogram shows the decimated signal. The first graph shows the signal as determined by the Segmentation Boundaries option in the LDV and ECG menus. The second graph shows the sample after removing the extra information over a set frequency. The bottom graph shows the spectrogram for the data. The various shades of grey show intensity. These graphs should be similar for the individual subjects. 

Figure 32
![]()
Plot Maximum Likelihood tells the software to analyze each spectrogram for the individuals and show the variances or range between the values. The second plot shows the mean spectrogram for the population allowing the user to compare the individual to the group. 


Figure 33
![]()
In Plot Segmentation Selection the first graph identifies which segments are being selected. This is dependent on the selection modes chosen in the Train and Test Options.The second graph shows the heartbeat after the filters are added. The third shows the computed spectrograms for the particular segment per subject. The fourth plot shows the nominal spectrogram for the subject. 


Figure 34
![]()
Plot Entropy Scores shows the different spectrograms. The subject mean spectrogram shows the mean of all of the spectrograms for the individual. The Nominal Mean Spectrogram shows the mean spectrogram of the population. The entropy scores are determined by the how much data is in each bin. A low score is ideal for picking individual bins, because it means that the data is dissimilar to the nominal mean. 

Figure 35
![]()
Plot Train and Test Data shows the actual feature set. This shows the bins that weren't zeroed out, and show the bins that were chosen for the subjects feature set.
After calculating the training and testing features, press calculate and return to the command window in Matlab. This is where the software will give the identification rate. Figure 35 shows whether each subject was a true or false match. The number following the rank_k_counts shows how many subjects were correctly matched at the first rank. Figure 36 shows the rate of identification at each rank.

Figure 36
![]()

Figure 37
![]()


[Next: Train and Test the Classifier](Train-Test.md)
