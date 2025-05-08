source /root/DevSecOps/shell_scripts/common.sh
user=roboshop
app_name=cart
current_dir=${PWD}
create_user $user
install_dependencies nodejs
cart_setup