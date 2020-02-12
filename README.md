# OpenDevLibrary
Open Source OpenVINO  Edge developement and deployment on Google Colab using OpenNotebooks

## USAGE STEPS:

## **For Python Script Install**:

### Step 1:
Open your Colab Notebook.

### Step 2:
Execute in one cell _(Including the exclamation)_:

!wget "https://github.com/alihussainia/OpenDevLibrary/blob/master/openvino_initialization_script.py"

### Step 3:
Move to the next cell and execute _(Including the exclamation)_:

!python openvino_initialization_script.py

**Note**: You need to enter your choice of framework as the number marked against the framework in the due course of installation.
Et Voila! You have Intel OpenVINO installed. Happy Inferencing!


## **For Notebook**:

### Step 1: 
Download OpenVINO Toolkit's ***l_openvino_toolkit_p_version.tgz*** file locally.
Download link: https://software.intel.com/en-us/openvino-toolkit/choose-download/free-download-linux
Alternatively, you could use the **wget** method to download the toolkit directly into the workspace and even upload it to your drive using  **shutil**.

### Step 2:
Create a folder in the google drive with the name openvino and upload the downloaded the ***l_openvino_toolkit_p_version.tgz*** file to a google drive folder i.e. openvino. 

### Step 3: 
Add the "Open in Colab" Extension to your Browser.
Clone or Fork the repo and open the ***OpenDevNotebook-CPU.ipynb*** in colab. Make sure to change the *file_name* variable to suite your ***l_openvino_toolkit_p_version.tgz*** file version (copy and paste the name of the downloaded file including the .tgx extension).

### Step 4: 
Run all the cells till initialization of the environment to successfully install and initialize OpenVINO in the OpenDevNotebook Runtime Environment.

### Step 5: 
Click on the ***STAR BUTTON*** above and do Play with the OpenNotebook as you like!

## FUTURE WORK:

Currently trying to render the output within the cell, if you can help, PLEASE COME FORWARD AND CONTRIBUTE!!!!

## CONTACTS:

***NAME: MUHAMMAD ALI***

***SLACK USERNAME: Muhammad.Ali***

***EMAIL1: alikasbati@outlook.com***

***EMAIL2: malirashid1994@gmail.com***

***Linkedin: https://www.linkedin.com/in/alihussainia/*** 

## REFERENCES:
Intel's Official Installation Guide for OpenVINO on linux: https://docs.openvinotoolkit.org/latest/_docs_install_guides_installing_openvino_linux.html#install-openvino

