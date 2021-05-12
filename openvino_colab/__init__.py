# -*- coding: utf-8 -*-
from subprocess import call
import os
from subprocess import check_output
import shutil
call("pip install pyngrok==4.1.12", shell=True)
#from code import server

call("wget -O openvino_key https://apt.repos.intel.com/openvino/2021/GPG-PUB-KEY-INTEL-OPENVINO-2021?elq_cid=6770273_ts1607381885691&erpm_id=9830841_ts1607381885691&elq_cid=6770273_ts1607381960247&erpm_id=9830841_ts1607381960247", shell=True)
call('apt-key add openvino_key', shell=True)
call('echo "deb https://apt.repos.intel.com/openvino/2021 all main" | tee /etc/apt/sources.list.d/intel-openvino-2021.list', shell=True)
call('apt update -q', shell=True)
call('apt-get install intel-openvino-dev-ubuntu18-2021.1.110 -y -q', shell=True)
call('pip install -U --no-deps --quiet openvino', shell=True)
call('cp /opt/intel/openvino_2021.1.110/deployment_tools/inference_engine/external/tbb/lib/libtbb.so /usr/lib/x86_64-linux-gnu/libtbb.so', shell=True)
call('cp /opt/intel/openvino_2021.1.110/deployment_tools/inference_engine/external/tbb/lib/libtbb.so.2 /usr/lib/x86_64-linux-gnu/libtbb.so.2', shell=True)
call('ldconfig', shell=True)

#Run the Validation Demo code.
demo_cmd = "/opt/intel/openvino_2021/deployment_tools/demo/demo_squeezenet_download_convert_run.sh"
output = check_output(demo_cmd, shell=True)
#print (output.decode("utf-8"))

print("\n\nIntel OpenVINO Installation Finished!")
