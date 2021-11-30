#!/bin/sh
. $PREFIX/etc/profile.d/conda.sh  # do not edit
conda activate $PREFIX            # do not edit

# add your pip packages here
pip install git+https://github.com/TigerGraph-DevLabs/tgml.git -f https://data.pyg.org/whl/torch-1.10.0+cpu.html
pip install pyTigerGraph

mv $PREFIX/share/jupyter/kernels/python3/kernel.json $PREFIX/share/jupyter/kernels/python3/temp.json
jq -r '.display_name |= "Python 3 (TG+PyG)"' $PREFIX/share/jupyter/kernels/python3/temp.json > $PREFIX/share/jupyter/kernels/python3/kernel.json
rm $PREFIX/share/jupyter/kernels/python3/temp.json

conda create --prefix $PREFIX/envs/sklearn python=3.8 scikit-learn ipykernel -y
conda activate $PREFIX/envs/sklearn
pip install git+https://github.com/TigerGraph-DevLabs/tgml.git -f https://data.pyg.org/whl/torch-1.10.0+cpu.html
pip install pyTigerGraph
python -m ipykernel install --user --name sklearn --display-name "Python 3 (TG+sklearn)"