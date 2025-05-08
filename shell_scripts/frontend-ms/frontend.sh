current_dir=$(pwd)
source $current_dir/../common.sh
app_name=nginx
install_dependencies $app_name
nginx_setup
