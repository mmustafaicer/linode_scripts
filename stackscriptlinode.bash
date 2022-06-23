#!bin/sh

#####################################################
#   Author: Matt Icer                               s                 
#   Description: Stackscript for quick Jupyter Lab  
#                Deployment                         
#   Date: 06/23/2022                                
#####################################################

### update system
if [ -f /etc/apt/sources.list ]; then
    sudo apt update && sudo apt -y upgrade
    echo "System has been updated"

fi 

### add non-root user
# useradd -mG sudo -s /bin/bash -p $(awk -F: '$1 ~ /^root$/ {print $2}' /etc/shadow) jupyterlab
# su jupyterlab 

### install python pip package manager and venv
sleep 30
echo "Installing pip and venv"
sudo apt install python3-pip -y
sudo apt install python3-venv -y

### create venv and activate it
sleep 10
python3 -m venv jupyterlab 
source jupyterlab/bin/activate

### some requirements
echo "numpy" >> requirements.txt
echo "pandas" >> requirements.txt
echo "jupyterlab" >> requirements.txt

pip install -r requirements.txt 

### catch your ip address
sudo apt install net-tools
IPADDR=$(ifconfig | grep -E "([0-9]{1,3}\.){3}[0-9]{1,3}" | grep -v 127.0.0.1 | awk '{ print $2 }' | cut -f2 -d:)

### start jupyterlab
jupyter lab --ip $IPADDR --port 8888 --no-browser --allow-root

### go to your web browser xx.xxx.xx.xx:8888 to see Jupyter Lab