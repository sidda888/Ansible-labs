# Variables
USERNAME=ansadmin
HOMEDIR="/home/ansadmin"

# Install EPEL Repository
sudo yum install -y epel-release 

# Update all packages
sudo yum update -y

## Create a new user for ansible without password
sudo useradd -m -d "$HOMEDIR" -s /bin/bash "$USERNAME"

## Install python3 and pip3 if they are not already installed 

if ! rpm -q python3; then
 sudo yum install -y python3
fi

# Ensure python3-venv is installed
if ! rpm -q python3-venv; then
 sudo yum install -y python3-virtualenv
fi

## Install pip if not already installed
if ! command -v pip3 &> /dev/null; then
 sudo yum install -y python3-pip
fi

## Upgrade pip using python -m to avoid old script wrapper issue
sudo -H python3 -m pip install --upgrade pip

## Switch to ansiblelord and setup the venv

sudo -i -u $USERNAME bash << EOF

## Create a Virtual environment for ansible in user's home directory 
python3 -m virtualenv "$HOMEDIR/ansible-env"

## Activate the virtual environment and install ansible
source "$HOMEDIR/ansible-env/bin/activate"
python3 -m pip install ansible

## Deactivate the virtual environment 
deactivate 

EOF

## Add environment activation to .bashrc for ease of use 
echo "source $HOMEDIR/ansible-env/bin/activate" >> "$HOMEDIR/.bashrc"

## Fixing permissions for ansiblelord 
sudo chown -R $USERNAME:$USERNAME "$HOMEDIR"



## Incase if you want to delete the current environment then deactivate the env 
## and rm -rf {dir_path}where you have created the env and then you can 
## create another environment.
# master pass for ansadmin -> ansadmin
# ansible-master pass for ansadmin -> passwd