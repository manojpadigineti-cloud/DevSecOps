app_name=shipping
current_dir=$(pwd)
MY_SQL_IP=10.0.2.124
source $current_dir/../common.sh
user=roboshop

create_user $user
install_dependencies maven
shipping_setup