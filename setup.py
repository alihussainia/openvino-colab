from setuptools import setup

setup(long_description="""This package provides Intel's OpenVINO Toolkit installation and easy usage in the Google Colab Notebooks.

The OpenVINO Toolkit allows edge AI application optimization and deployment on Google Colab using Colab Notebooks. It is also possible to choose to download all 5 or individual supported model dependencies directly in the notebook along with the option to start a Visual Studio Code instance and work interactively in a VS Code environment on the web using the Google Colab Container and provided resources to build and test Edge AI applications. 

This package also supports some basic configuration of vs code server (i.e. To choose different port, password or mounting the drive options.""",
      name='openvino_colab',
      version='3.0.0',
      description='OpenVINO toolkit package for Google Colab',
      packages=['openvino_colab'],
      author = 'Muhammad Ali',
      author_email = 'malirashid1994@gmail.com',
      zip_safe=False)