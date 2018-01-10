#!/bin/sh

conda install update
conda create --name django-2.0
source activate django-2.0
conda install pip
pip install django
pip install django update
source deactivate
