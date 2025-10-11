for app in cart catalogue frontend payment shipping user; do
  cd /home/ec2-user/DevSecOps/eks
  git pull
  helm uninstall -i ${app}-deployment . -f env-dev/${app}.yaml
done