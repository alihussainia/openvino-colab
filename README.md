# OpenVINO-Colab
Open Source OpenVINO  Edge developement and deployment on Google Colab using Colab Notebooks

## USAGE STEPS:

### Step 1: Package installation on Google Colab. <a href="https://github.com/alihussainia/openvino-colab/blob/master/demo.ipynb" target=_blank>Ref: Demo.ipynb</a>
Run the command in the first cell of your Google Colab to install the `openvino-colab` package. 

```python3
!pip install openvino-colab
```
### Step 2: Importing openvino-colab into your notebook <a href="https://github.com/alihussainia/openvino-colab/blob/master/demo.ipynb" target=_blank>Ref: Demo.ipynb</a>
Run the below command in a new cell to install the OpenVINO toolkit in Google Colab.

```python3
import openvino_colab
```
### Step 3 (Optional): Importing server function into your notebook <a href="https://github.com/alihussainia/openvino-colab/blob/master/demo.ipynb" target=_blank>Ref: Demo.ipynb</a>

```python3
from openvino_colab import server
```
### Step 4 : Calling server function

```python3
server()
```
Server Function can take these optional arguments:

- port = `enter port no.` - the port you want to run server on, default 10000
    
- password = `enter password` - password to protect your server.
    
- mount_drive = `enter True or False` - to mount your drive.
  
- example of syntax: `server(port=10000, password='ali', mount_drive=True)`

### Tip for running server: (Optional but Recommended)
To Enable `Copy/Paste` in server terminals:

- Use Chrome Browser
  
- visit <a href="chrome://settings/content/clipboard" target=_blank>chrome://settings/content/clipboard</a> and add your xyz.ngork.io link there.

## REFERENCES:

### OpenVINO-Colab Demo Google Colab Notebook:
<a href="https://github.com/alihussainia/openvino-colab/blob/master/demo.ipynb" target=_blank>Demo.ipynb</a>

### Intel's Official Installation Guide for OpenVINO on linux: 
<a href="https://docs.openvinotoolkit.org/latest/_docs_install_guides_installing_openvino_linux.html#install-openvino" target=_blank>Link</a>

### OpenVINO-Colab package on PyPi Repository:
<a href="https://pypi.org/project/openvino-colab/" target=_blank>Link</a>

### Model used in Demo.ipynb i.e. vehicle-attributes-recognition-barrier-0039:
<a href="https://docs.openvinotoolkit.org/2019_R1/_vehicle_attributes_recognition_barrier_0039_description_vehicle_attributes_recognition_barrier_0039.html" target=_blank>Link</a>

### colabcode package
<a href="https://github.com/abhishekkrthakur/colabcode" target=_blank>Link</a>
