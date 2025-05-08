install_dependencies () {
 for dependencies in $@
  do
    if [ $dependencies == "nginx" ]; then
      dnf module disable nginx -y
      dnf module enable nginx:1.24 -y
      dnf install nginx -y
      nginx_setup
      systemd_start nginx
    fi
    if [ $dependencies == "nodejs" ]; then
      dnf module disable nodejs -y
      dnf module enable nodejs:20 -y
      dnf install nodejs -y
    fi
    if [ $dependencies == "mongodb" ]; then
      mongo_setup
      dnf install mongodb-org -y
      sed -i -e 's\127.0.0.1\0.0.0.0\g' /etc/mongod.conf
      systemd_start mongod
    fi
    if [ $dependencies == "mongodb-mongosh" ]; then
      mongo_setup
      dnf install mongodb-mongosh -y
    fi
    if [ $dependencies == "redis" ]; then
       dnf module disable redis -y
       dnf module enable redis:7 -y
       dnf install redis -y
       sed -i -e 's\127.0.0.1\0.0.0.0\g' /etc/redis/redis.conf
       sed -i -e 's\protected-mode yes\protected-mode no\g' /etc/redis/redis.conf
       systemd_start redis
    fi
    if [ $dependencies == "mysql" ]; then
      dnf install mysql-server -y
    fi
    if [ $dependencies == "maven" ]; then
      dnf install maven -y
    fi
    if [ $dependencies == "rabbitmq-server" ]; then
      dnf install rabbitmq-server -y
    fi
    if [ $dependencies == "python" ]; then
      dnf install python3 gcc python3-devel -y
    fi
    if [ $dependencies == "golang" ]; then
      dnf install golang -y
    fi
  done
}

systemd_start () {
  systemctl daemon-reload
  systemctl enable $1
  systemctl start $1
  systemctl restart $1
}

copy_systemd_conf () {
  if [ -f /etc/systemd/system/$app_name.service ]; then
    echo "Old service file exists. Removing..."
    rm -rf /etc/systemd/system/$app_name.service
  fi
echo "Copying new service file..."
cp "$current_dir/$app_name.service" /etc/systemd/system/$app_name.service
}

create_user () {
id $1
  if [ $? -eq 0 ]; then
    echo User is already available
  else
   useradd $1
  fi
}

########################
#### Microservices #####
########################

nginx_setup () {
current_dir=$(pwd)
ls /usr/share/nginx/html/* ;
   if [ $? -eq 0 ]; then
     rm -rf /usr/share/nginx/html/*
   fi
 ls /tmp/frontend.zip
   if [ $? -eq 0 ]; then
     rm -rf /tmp/frontend.zip
   fi
curl -o /tmp/frontend.zip https://roboshop-artifacts.s3.amazonaws.com/frontend-v3.zip
cd /usr/share/nginx/html
unzip /tmp/frontend.zip
cd $current_dir
pwd
   if [ -f /etc/nginx/nginx.conf ]; then
     echo nginx.conf file exist removing the file
     rm -rf /etc/nginx/nginx.conf
   fi
cp $current_dir/$app_name.conf /etc/nginx/nginx.conf
systemd_start $app_name
}

mongo_setup () {
cp -R $current_dir/mongo.repo /etc/yum.repos.d/mongo.repo
}


catalogue_setup () {
ls /app
 if [ $? -eq 0 ]; then
   rm -rf /app
 fi
mkdir /app
curl -o /tmp/catalogue.zip https://roboshop-artifacts.s3.amazonaws.com/catalogue-v3.zip
cd /app
unzip /tmp/catalogue.zip
npm install
copy_systemd_conf
}

user_setup () {
  if [ -f /app ]; then
    echo Directory /app exist
  else
    mkdir /app
  fi
  if [ -f /tmp/user.zip ]; then
    echo File exist removing the file
    rm -rf /tmp/user.zip
  fi
curl -L -o /tmp/user.zip https://roboshop-artifacts.s3.amazonaws.com/user-v3.zip
cd /app
unzip -o /tmp/user.zip
npm install
copy_systemd_conf
systemd_start $app_name
}

cart_setup () {
  if [ -f /app ]; then
    echo Directory /app exist
  else
    mkdir /app
  fi
  if [ -f /tmp/cart.zip ]; then
    echo File exist removing the file
    rm -rf /tmp/cart.zip
  fi
curl -L -o /tmp/cart.zip https://roboshop-artifacts.s3.amazonaws.com/cart-v3.zip
cd /app
unzip -o /tmp/cart.zip
npm install
copy_systemd_conf
systemd_start $app_name
}

mysql_setup () {
systemd_start $1
mysql_secure_installation --set-root-pass $password
}

shipping_setup () {
  if [ -f /app ]; then
    echo Directory /app exist
  else
    mkdir /app
  fi
  if [ -f /tmp/shipping.zip ]; then
    echo File exist removing the file
    rm -rf /tmp/shipping.zip
  fi
curl -L -o /tmp/shipping.zip https://roboshop-artifacts.s3.amazonaws.com/shipping-v3.zip
cd /app
unzip -o /tmp/shipping.zip
cd /app
mvn clean package
mv target/shipping-1.0.jar shipping.jar
install_dependencies mysql
for server in schema app-user master-data
 do
   mysql -h $MY_SQL_IP -uroot -pRoboShop@1 < "/app/db/$server.sql"
 done
copy_systemd_conf
systemd_start $app_name
}

rabbitmq_setup () {
ls $current_dir/$app_name.repo
cp "$current_dir/$app_name.repo" /etc/yum.repos.d/rabbitmq.repo
install_dependencies $app_name
systemd_start $app_name
create_user $user1
create_user $user2
rabbitmqctl add_user roboshop roboshop123
rabbitmqctl set_permissions -p / roboshop ".*" ".*" ".*"
}

payment_setup () {
  if [ -f /app ]; then
    echo Directory /app exist
  else
    mkdir /app
  fi
  if [ -f /tmp/payment.zip ]; then
    echo File exist removing the file
    rm -rf /tmp/payment.zip
  fi
curl -L -o /tmp/payment.zip https://roboshop-artifacts.s3.amazonaws.com/payment-v3.zip
cd /app
unzip -o /tmp/payment.zip
cd /app
pip3 install -r requirements.txt
copy_systemd_conf
systemd_start $app_name
}

dispatch_setup () {
  if [ -f /app ]; then
    echo Directory /app exist
  else
    mkdir /app
  fi
  if [ -f /tmp/dispatch.zip ]; then
    echo File exist removing the file
    rm -rf /tmp/dispatch.zip
  fi
curl -L -o /tmp/dispatch.zip https://roboshop-artifacts.s3.amazonaws.com/dispatch-v3.zip
cd /app
unzip -o /tmp/dispatch.zip
cd /app
go mod init dispatch
go get
go build
copy_systemd_conf
systemd_start $app_name
}