## Installing, Loading and Running TIS

### Installing TIS

You can download the TIS software from [here](http://github.com/erimcg/tis).

If you intend on using LIBSVM to classify, you'll need to install the Matlab version of LIBSVM.  The code and installation instructions can be found [here](https://github.com/cjlin1/libsvm/tree/master/matlab).

### Loading TIS

To load the TIS software, open Matlab and click on the `Browse for folder` icon that is shown in **Figure 1.** 

![Browse for TIS](images/fig1_click_browse.png)
**Figure 1**

Next, choose the folder where the TIS software was saved and press `Select Folder`.

![Choose TIS Location](images/fig2_choose_tis_loc.png)
 **Figure 2**

After loading TIS, you will see a list of files and folders in the Current Folder list on the side bar. If some of the folders are greyed out you'll need to add these files and folders to the Matlab *path* as discussed below.
 
![Inactive Folders](images/fig3_inactive_folders.png)
**Figure 3**

To add these files to the path, press the icon labeled `Set path` located in the main toolbar. 

![Add to Path](images/fig4_add_to_path.png)
**Figure 4**

When the dialogue box opens, click `Add with Subfolders…`, then select the contents of the TIS folder. 

![Add with Subfolders](images/fig5_add_with_subfolders.png)
**Figure 5**
 
Click `Save` to save the files and folders to the Matlab path and press `Close` to exit the dialog box to return to Matlab. The previously grey areas should be black. 

### Running TIS

To run TIS, type `TIS` into the Command Window and press `Enter` as shown in **Figure 6.** 

![Start TIS](images/fig6_start_tis.png)
**Figure 6**

Matlab will open the TIS Graphical User Interface (GUI) as shown in **Figure 7**. The TIS GUI displays a menu bar (A) across the top of the screen that allows the user to change various settings in the left panel below the menu bar. The gray panel to the right of the green panel is used to display plots and classification results.  At the bottom of the screen is a button panel that allows the user to calculate feature sets and classify the feature sets (B).
 
![TIS GUI](images/fig7_tis_gui.png) 
**Figure 7**

You're now ready to setup TIS to calculate feature sets for your input data.

[Next: Configuring the Model and Classifier Options](Model-Classifier-Settings.md)
