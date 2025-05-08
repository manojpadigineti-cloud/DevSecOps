app_name=payment
current_dir=$(pwd)
user=roboshop
source $current_dir/../common.sh

install_dependencies python
create_user $user
payment_setup
