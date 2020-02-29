#!/usr/bin/env bash

# Copyright (C) 2018-2019 Intel Corporation
# SPDX-License-Identifier: Apache-2.0

ROOT_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"

. "$ROOT_DIR/utils.sh"

usage() {
    echo "Speech recognition demo that showcases recognition of speech from wave file"
    exit 1
}

trap 'error ${LINENO}' ERR

target="CPU"

# parse command line options
while [[ $# -gt 0 ]]
do
key="$1"

case $key in
    -h | -help | --help)
    usage
    ;;
    *)
    # unknown option
    ;;
esac
shift
done


target_wave_path="$ROOT_DIR/how_are_you_doing.wav"

if [ -e "$ROOT_DIR/../../bin/setupvars.sh" ]; then
    setupvars_path="$ROOT_DIR/../../bin/setupvars.sh"
else
  OPENVINO_ROOT_FOLDER=`ls -1 -d /home/$USER/intel/openvino_20* | sort -r | head -1`
  if [ -e "$OPENVINO_ROOT_FOLDER/bin/setupvars.sh" ]; then
    setupvars_path="$OPENVINO_ROOT_FOLDER/bin/setupvars.sh"
  else
    printf "Error: setupvars.sh is not found\n"
  fi
fi
if ! . $setupvars_path ; then
    printf "Unable to run ./setupvars.sh. Please check its presence. ${run_again}"
    exit 1
fi


run_again="Then run the script again\n\n"
dashes="\n\n###################################################\n\n"

if [[ -f /etc/centos-release ]]; then
    DISTRO="centos"
elif [[ -f /etc/lsb-release ]]; then
    DISTRO="ubuntu"
elif [[ "$OSTYPE" == "darwin"* ]]; then
    DISTRO="macos"
fi

if [[ $DISTRO == "ubuntu" ]]; then
    sudo -E apt update
    print_and_run sudo -E apt -y install build-essential python3-pip virtualenv cmake libcairo2-dev libpango1.0-dev libglib2.0-dev libgtk2.0-dev libswscale-dev libavcodec-dev libavformat-dev libgstreamer1.0-0 gstreamer1.0-plugins-base pulseaudio-equalizer
    python_binary=python3
    pip_binary=pip3

    system_ver=`cat /etc/lsb-release | grep -i "DISTRIB_RELEASE" | cut -d "=" -f2`
    if [ $system_ver = "18.04" ]; then
        sudo -E apt-get install -y libpng-dev
    else
        sudo -E apt-get install -y libpng12-dev
    fi
    sudo -E $pip_binary install -r $INTEL_OPENVINO_DIR/deployment_tools/open_model_zoo/tools/downloader/requirements.in
else
    printf "\n\nDemo supports only Ubuntu distribution!"
    exit 1
fi

if ! command -v $python_binary &>/dev/null; then
    printf "\n\nPython 3.5 (x64) or higher is not installed. It is required to run Model Optimizer, please install it. ${run_again}"
    exit 1
fi


# Step 1. Downloading Intel models
printf "${dashes}"
printf "Downloading Intel models\n\n"


target_precision="FP32"

printf "target_precision = ${target_precision}\n"

downloader_dir="${INTEL_OPENVINO_DIR}/deployment_tools/open_model_zoo/tools/downloader"

model_name="lspeech_s5_ext"
downloader_path="$downloader_dir/downloader.py"
models_path="$HOME/openvino_models/ir"
models_cache="$HOME/openvino_models/cache"
yaml_model_config=$ROOT_DIR/../../data_processing/audio/speech_recognition/models/lspeech_s5_ext/lspeech_s5_ext.yml

declare -a model_args
print_and_run "$python_binary" "$downloader_path" --name "$model_name" --output_dir "$models_path" --cache_dir "$models_cache" --config "$yaml_model_config"

# Step 2. Build samples
printf "${dashes}"
printf "Build Inference Engine demos\n\n"

demos_path="${ROOT_DIR}/../../data_processing/audio/speech_recognition"

if ! command -v cmake &>/dev/null; then
    printf "\n\nCMAKE is not installed. It is required to build Inference Engine demos. Please install it. ${run_again}"
    exit 1
fi

OS_PATH=$(uname -m)
NUM_THREADS="-j2"

if [ $OS_PATH == "x86_64" ]; then
  OS_PATH="intel64"
  ARCH="x64"
  NUM_THREADS="-j8"
fi

build_dir="$HOME/data_processing_demos_build/audio/speech_recognition"
if [ -e $build_dir/CMakeCache.txt ]; then
	rm -rf $build_dir/CMakeCache.txt
fi
mkdir -p $build_dir
cd $build_dir
cmake -DCMAKE_BUILD_TYPE=Release $demos_path
make $NUM_THREADS

# Step 3. Run samples
printf "${dashes}"
printf "Create configuration file\n\n"

model_package_name="intel/lspeech_s5_ext/FP32"
configuration_file="$models_path/$model_package_name/speech_lib.cfg"
configuration_template="$models_path/$model_package_name/speech_recognition_config.template"
models_root="$models_path/$model_package_name"

echo "#Speech recognition configuration file" > $configuration_file
sed "s|__MODELS_ROOT__|${models_root}\/|g" $configuration_template >> $configuration_file
sed -i 's/\\/\//g' $configuration_file

printf "Run Inference Engine offline speech recognition demo\n\n"

binaries_dir="${build_dir}/${OS_PATH}/Release"
cd $binaries_dir
export LD_LIBRARY_PATH=$LD_LIBRARY_PATH:${build_dir}/${OS_PATH}/Release/lib:${ROOT_DIR}/../../data_processing/audio/speech_recognition/lib/${ARCH}
echo $LD_LIBRARY_PATH
print_and_run ./offline_speech_recognition_app -wave="$target_wave_path" -c="$configuration_file"

printf "${dashes}"
printf "Demo completed successfully.\n\n"

#printf "Run Inference Engine real time speech recognition demo\n\n"
#if [[ $DISTRO == "ubuntu" ]]; then
#    system_ver=`cat /etc/lsb-release | grep -i "DISTRIB_RELEASE" | cut -d "=" -f2`
#    if [ $system_ver = "18.04" ]; then
#        $python_binary -m pip install -r "$ROOT_DIR/../../data_processing/audio/speech_recognition/demos/live_speech_recognition_demo/requirements_ubuntu18.txt"
#    else
#        $python_binary -m pip install -r "$ROOT_DIR/../../data_processing/audio/speech_recognition/demos/live_speech_recognition_demo/requirements_ubuntu16.txt"
#    fi
#fi
#cp -R "$ROOT_DIR/../../data_processing/audio/speech_recognition/demos/live_speech_recognition_demo" "${build_dir}/demos/live_speech_recognition_demo"
#cd "${build_dir}/demos/live_speech_recognition_demo"
#mkdir -p "../models/en-us"
#cp $configuration_file ../models/en-us
#$python_binary speech_demo_app.py
cd "$ROOT_DIR"