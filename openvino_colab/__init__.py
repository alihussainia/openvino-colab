# -*- coding: utf-8 -*-
from subprocess import call
call("pip install pyngrok==4.1.12", shell=True)
from .code import server

#Defining the Important Paths

file_name = "l_openvino_toolkit_p_2021.3.394.tgz" #change the filename if version does not match
dir_name = file_name[:-4]
install_dir = "/opt/intel/openvino_2021/"
deployment_tools = install_dir+"deployment_tools/"
model_optimizer = install_dir+"deployment_tools/model_optimizer/"
model_zoo = deployment_tools+"open_model_zoo/"

call("wget 'https://objectstorage.ap-mumbai-1.oraclecloud.com/n/bms8xv0rrykq/b/opendevlibrary/o/l_openvino_toolkit_p_2021.3.394.tgz'", shell=True)

call('tar -xzf l_openvino_toolkit_p_2021.3.394.tgz', shell=True)
call('sudo -E %s/install_openvino_dependencies.sh'%(dir_name), shell=True)
call("sed -i 's/decline/accept/g' %s/silent.cfg && sed -i 's/#INTEL_SW_IMPROVEMENT/INTEL_SW_IMPROVEMENT/g' %s/silent.cfg"%(dir_name,dir_name), shell=True)
print("Installed OpenVINO Dependencies. Installing OpenVINO...")
call("sudo %s/install.sh --silent %s/silent.cfg"%(dir_name,dir_name), shell=True)
call("sudo -E %s/install_dependencies/install_openvino_dependencies.sh"%(install_dir), shell=True)
call("source %s/bin/setupvars.sh"%(install_dir), shell=True)
print("ENV Variables Set!")
frameworks = ['tf','tf2','mxnet','onnx','kaldi','all']
choices = dict(zip(range(1,7),frameworks))

print("""Please enter the Choice of framework you want to work with:
\n(Note: You should only install for the ones you would be using.
Incase of needing to install for more than one but not all, rerun this cell and 
install the pre-requisites one by one.)
""")

for x in choices:
  print(x,choices[x])


choice = input("Please enter your choice (Default Option - 6): ")
choice_status=False

while choice_status==False:
    if len(choice) == 0:
        choice = 6
        choice_status=True
    else:
        choice=float(choice)
        if choice>6 or choice<=0:
            print("You have entered an invalid choice! Please rerun the script.")
            choice = input("Please enter your choice (Default Option - 6): ")
        else:
            choice_status=True
            
print("Choice is",choice,":",choices[choice])
if choice != 6:
   pre_install = model_optimizer + "install_prerequisites/install_prerequisites.sh "+choices[choice]
   call("sudo %s"%(pre_install), shell=True)
elif choice == 6:
  # for x in choices:
  #   pre_install = model_optimizer + "install_prerequisites/install_prerequisites.sh "+choices[x]
  #   !sudo $pre_install
   call("sudo %s/install_prerequisites/install_prerequisites.sh"%(model_optimizer), shell=True)
else:
  print("Wrong Choice! Please rerun this cell and enter the correct choice!")

call("sudo %s/demo/demo_squeezenet_download_convert_run.sh"%(deployment_tools), shell=True)

print("\n\nIntel OpenVINO Installation Finished!")
