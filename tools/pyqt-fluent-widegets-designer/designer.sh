#!/bin/zsh
source /opt/miniconda3/etc/profile.d/conda.sh
export PYQTDESIGNERPATH="/home/chenkeyz/git/PyQt-Fluent-Widgets/plugins"
conda activate pyqt
echo "进入conda环境pyqt"
echo "启动designer"
pyqt5-tools designer &
