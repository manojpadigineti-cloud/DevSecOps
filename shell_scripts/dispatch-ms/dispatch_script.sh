app_name=dispatch
current_dir=$(pwd)
user=roboshop
source $current_dir/../common.sh

install_dependencies golang
create_user $user
dispatch_setup
