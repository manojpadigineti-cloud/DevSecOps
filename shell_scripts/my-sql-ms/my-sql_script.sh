current_dir=$(pwd)
app_name=mysql
password=RoboShop@1
source $current_dir/../common.sh
install_dependencies $app_name
mysql_setup mysqld
