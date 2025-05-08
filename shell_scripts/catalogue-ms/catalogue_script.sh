# Catalogue Microservice Script
source /root/DevSecOps/shell_scripts/common.sh
app_name=catalogue
user=roboshop
current_dir=/root/DevSecOps/shell_scripts/$app_name-ms
MONGO_IP=10.0.2.194

install_dependencies nodejs
create_user $user
catalogue_setup
systemd_start $app_name
install_dependencies mongodb-mongosh
mongosh --host $MONGO_IP </app/db/master-data.js