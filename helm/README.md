#curl -O https://raw.githubusercontent.com/kubernetes/helm/master/scripts/get |bash

#https://helm.sh/docs/intro/install/
#https://github.com/helm/helm/releases


tar -zxvf helm-v3.0.0-linux-amd64.tar.gz
mv linux-amd64/helm /usr/local/bin/helm
#https://helm.sh/docs/intro/quickstart/#initialize-a-helm-chart-repository
#helm repo add stable https://charts.helm.sh/stable
helm repo remove stable
helm repo add stable https://kubernetes.oss-cn-hangzhou.aliyuncs.com/charts
helm repo update
helm search
helm search repo stable
