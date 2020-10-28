# kuard ��ϰ
[root@knode-01 yaml]# kubectl apply -f kuard-pod.yaml 
[root@knode-01 yaml]# kubectl get pods
NAME                                    READY   STATUS    RESTARTS   AGE
kuard                                   1/1     Running   0          3m24s

[root@knode-01 yaml]# kubectl describe pods kuard
Name:         kuard
Namespace:    default
Priority:     0
Node:         knode-02/192.168.107.137
Start Time:   Fri, 25 Sep 2020 10:58:09 +0800
Labels:       <none>
Annotations:  Status:  Running
IP:           10.244.0.27
IPs:
  IP:  10.244.0.27
Containers:
  kuard:
    Container ID:   docker://ca678ff3548e4193e18d81a88e827834501395a6c1ab456b5c2a846d12d241ad
    Image:          docker.io/dlneintr/kuard:latest
    Image ID:       docker-pullable://dlneintr/kuard@sha256:b75431a757b55bfd00dd2f07b195656ee20f4ae3c2c681279c30ee54b812233f
    Port:           8080/TCP
    Host Port:      0/TCP
    State:          Running
      Started:      Fri, 25 Sep 2020 10:58:23 +0800
    Ready:          True
    Restart Count:  0
    Environment:    <none>
    Mounts:
      /var/run/secrets/kubernetes.io/serviceaccount from default-token-vdvp2 (ro)
Conditions:
  Type              Status
  Initialized       True 
  Ready             True 
  ContainersReady   True 
  PodScheduled      True 
Volumes:
  default-token-vdvp2:
    Type:        Secret (a volume populated by a Secret)
    SecretName:  default-token-vdvp2
    Optional:    false
QoS Class:       BestEffort
Node-Selectors:  <none>
Tolerations:     node.kubernetes.io/not-ready:NoExecute for 300s
                 node.kubernetes.io/unreachable:NoExecute for 300s
Events:
  Type    Reason     Age        From               Message
  ----    ------     ----       ----               -------
  Normal  Scheduled  <unknown>  default-scheduler  Successfully assigned default/kuard to knode-02
  Normal  Pulling    5m44s      kubelet, knode-02  Pulling image "docker.io/dlneintr/kuard:latest"
  Normal  Pulled     5m31s      kubelet, knode-02  Successfully pulled image "docker.io/dlneintr/kuard:latest"
  Normal  Created    5m31s      kubelet, knode-02  Created container kuard
  Normal  Started    5m31s      kubelet, knode-02  Started container kuard

ɾ��pods
[root@knode-01 yaml]# kubectl delete pods/kuard
pod "kuard" deleted

����Ҳ���� kubectl delete -f kuard-pod.yaml

����pods 
�˿�ת��
[root@knode-01 yaml]# kubectl port-forward kuard 8080:8080
Forwarding from 127.0.0.1:8080 -> 8080
Forwarding from [::1]:8080 -> 8080

Handling connection for 8080

# ���ӻ���̽��  ���kuard-pod-health.yaml�ļ�
 kubectl apply -f kuard-pod-health.yaml
pod/kuard created
[root@knode-01 yaml]# kubectl get pods
NAME                                   READY   STATUS    RESTARTS   AGE
kuard                                  1/1     Running   0          8s




kubectl port-forward <pod_name> <forward_port> --namespace <namespace> --address <IPĬ�ϣ�127.0.0.1>
[root@knode-01 yaml]# kubectl port-forward kuard 8080:8080 --address 192.168.107.136
Forwarding from 192.168.107.136:8080 -> 8080

����

[root@knode-01 yaml]# kubectl port-forward kuard 8080:8080
Forwarding from 127.0.0.1:8080 -> 8080
Forwarding from [::1]:8080 -> 8080

[root@knode-01 ~]# netstat -tlunp|grep 8080
tcp        0      0 127.0.0.1:8080          0.0.0.0:*               LISTEN      125896/kubectl      
tcp6       0      0 ::1:8080                :::*                    LISTEN      125896/kubectl   

[root@knode-01 ~]# curl http://localhost:8080
<!doctype html>

<html lang="en">
<head>
  <meta charset="utf-8">

  <title>KUAR Demo</title>
����������

Events:
  Type     Reason     Age                From               Message
  ----     ------     ----               ----               -------
  Normal   Scheduled  11m                default-scheduler  Successfully assigned default/kuard to knode-02
  Normal   Pulling    22s (x2 over 11m)  kubelet, knode-02  Pulling image "docker.io/dlneintr/kuard:latest"
  Warning  Unhealthy  22s (x3 over 42s)  kubelet, knode-02  Liveness probe failed: HTTP probe failed with statuscode: 500
  Normal   Killing    22s                kubelet, knode-02  Container kuard failed liveness probe, will be restarted

[root@knode-01 ~]# kubectl get pods  kuard
NAME    READY   STATUS    RESTARTS   AGE
kuard   1/1     Running   1          12m


# ����̽�� ����ʵ�� ��������

# ��Դ����  ������Դ����
������λ��һ��CPU�����õĻ����ϣ�������128m���ڴ�
[root@knode-01 yaml]# kubectl delete pods kuard
pod "kuard" deleted
[root@knode-01 yaml]# kubectl apply -f kuard-pod-resreq.yaml 
pod/kuard created
[root@knode-01 yaml]# kubectl get pods
NAME                                   READY   STATUS    RESTARTS   AGE
kuard                                  1/1     Running   0          6s



# ��Դ����
[root@knode-01 yaml]# kubectl delete pods kuard
pod "kuard" deleted

[root@knode-01 yaml]# kubectl describe pods kuard
Name:         kuard
Namespace:    default
Priority:     0

������

    Limits:
      cpu:     1
      memory:  256Mi
    Requests:
      cpu:        500m
      memory:     128Mi

# ���þ�ʵ�����ݳ־û���
[root@knode-01 yaml]# kubectl apply -f kuard-pod-vol.yaml 

#podʹ�þ�Ĳ�ͬ��ʽ
1.ͨ��/ ͬ��
ʹ��emptyDir �����Ч�����ڸ�pod�����൱
2.����
3.�־�������
4.���������ļ�ϵͳ


#��pods����
kubectl exec [POD] -- [COMMAND]
kubectl exec -it kuard -- /bin/sh
kubectl exec kuard ls /var/lib/


# ����configmap
kubectl create configmap my-config --from-file=my-config.txt --from-literal=extra-param=extra-value --from-literal=another-param=another-value
configmap/my-config created
## ��ȡconfigmap
[root@knode-01 yaml]# kubectl get configmap my-config -o yaml
apiVersion: v1
data:
  another-param: another-value
  extra-param: extra-value
  my-config.txt: |+
    # This is a sample config file that I might use to configure an application
    parameter1 = value1
    parameter2 = value2

kind: ConfigMap
metadata:
  creationTimestamp: "2020-10-26T14:10:35Z"
  managedFields:
  - apiVersion: v1
    fieldsType: FieldsV1
    fieldsV1:
      f:data:
        .: {}
        f:another-param: {}
        f:extra-param: {}
        f:my-config.txt: {}
    manager: kubectl
    operation: Update
    time: "2020-10-26T14:10:35Z"
  name: my-config
  namespace: default
  resourceVersion: "773348"
  selfLink: /api/v1/namespaces/default/configmaps/my-config
  uid: a13b103d-d607-4749-85ee-cba51f7ac672

#configmap���÷���Ҫ��3��
- �ļ�ϵͳ
- ��������
- �����в���

#kuard-secret
[root@knode-01 kuard]# kubectl create secret generic kuard-tls --from-file=./cert/kuard.crt --from-file=./cert/kuard.key
secret/kuard-tls created
[root@knode-01 kuard]# kubectl describe secrets kuard-tls
Name:         kuard-tls
Namespace:    default
Labels:       <none>
Annotations:  <none>

Type:  Opaque

Data
====
kuard.crt:  1050 bytes
kuard.key:  1679 bytes

[root@knode-01 kuard]# kubectl apply -f kuard-secret.yaml 
pod/kuard-tls created

[root@knode-01 kuard]# kubectl exec kuard-tls -- ls /tls
kuard.crt
kuard.key
[root@knode-01 studyk8s]# kubectl exec kuard-tls -- cat /tls/kuard.crt
-----BEGIN CERTIFICATE-----
MIIC2zCCAcOgAwIBAgIJAI2AxVznPQNNMA0GCSqGSIb3DQEBCwUAMBwxGjAYBgNV
BAMMEWt1YXJkLmV4YW1wbGUuY29tMB4XDTE3MDMxOTIwMTQyMVoXDTE4MDMxOTIw
MTQyMVowHDEaMBgGA1UEAwwRa3VhcmQuZXhhbXBsZS5jb20wggEiMA0GCSqGSIb3
DQEBAQUAA4IBDwAwggEKAoIBAQDO6HjeVc/OzCqCKTb9ESB4fOuHywM5R93q3ssl
5uFy6sooOvRfpQ1ADLZjNwfNaEkVcNEssHWCH+Dhbvsta90zTXYdPFWvVaXc32uy
dQDR+FIRxl5c1oHrhD6yYJJop9Nyw0hwrfOyj7+NUW0fgSaVtbdrLlhQP0VuoQUG
RlHpl7imqP3PlgQLmo8xnNQ1+R072l0rB/BqUGdG6MA6RXf9NixaECNVgSxuu+BB
wx1upL/6c0rJaqjLpcEqoyp5FGo8ttOvWqwDukMATJD/7Ei5MzS6RdQjFC19rh88
1zpQ5hBPxcy3Lkj/Xaf6ehX5nrPcuRx4vadGagLnrxTgjk7XAgMBAAGjIDAeMBwG
A1UdEQQVMBOCEWt1YXJkLmV4YW1wbGUuY29tMA0GCSqGSIb3DQEBCwUAA4IBAQCb
vOa6pCLJw9K2/929Wsn6CEuZrZfhXUrNGT87cVibQSj2a48sMdblIjxbvkAHtmbg
mMxMOMgea1hCwZCaJw3ECEmCB4LHlBTnFDWbdqnRvs+/UiLhpaq4x5j2spf4VysY
1XqgkdHI+JQ1II07poqB/LkmpBPy3p/vCnHl5qgZ5ShS3GCZF45lHrMrwmq8ujJc
nCa0CCZpjzYRp8pT5W/88OL+toeb9rN3ckKmBtws5q7J3Dbfkmv1sCPwSusBfATZ
z4sKe4mopBMwE5yJzcjoPeiY6dhMZ2FsmOE9b4XaMkDPVIzeZS3S/0nUD36vCWsP
jkFJS9Y6uqIRF7Tp7+q3
-----END CERTIFICATE-----







#service �޷�����nodeport
iptables -P FORWARD ACCEPT


[root@knode-01 yaml]# kubectl describe services kuard-config-frontend
Name:                     kuard-config-frontend
Namespace:                default
Labels:                   app=kuard-config
                          tier=kuard-config
Annotations:              Selector:  app=kuard-config
Type:                     NodePort
IP:                       10.99.236.214
Port:                     <unset>  8080/TCP
TargetPort:               8080/TCP
NodePort:                 <unset>  32680/TCP
Endpoints:                10.244.0.36:8080
Session Affinity:         None
External Traffic Policy:  Cluster
Events:                   <none>

[root@knode-01 yaml]# iptables-save|grep 32354
-A KUBE-NODEPORTS -p tcp -m comment --comment "default/kuard-config-frontend:" -m tcp --dport 32354 -j KUBE-MARK-MASQ
-A KUBE-NODEPORTS -p tcp -m comment --comment "default/kuard-config-frontend:" -m tcp --dport 32354 -j KUBE-SVC-CZ6DXG7527ZN6I2D




ServiceType�ֶεĺϷ�ֵ�ǣ�

l  ClusterIP: ����ʹ��һ����Ⱥ�ڲ���IP��ַ - ����Ĭ��ֵ��ѡ�����ֵ��ζ����ֻ����������ڼ�Ⱥ�ڲ��ſ��Ա����ʵ���

l  NodePort: �ڼ�Ⱥ�ڲ�IP�Ļ����ϣ��ڼ�Ⱥ��ÿһ���ڵ�Ķ˿��Ͽ���������������������<NodeIP>:NodePort��ַ�Ϸ��ʵ��������

l  LoadBalancer: ��ʹ��һ����Ⱥ�ڲ�IP��ַ����NodePort�Ͽ���һ������֮�⣬�����ṩ������һ�����ؾ���������������ת���������ÿ���ڵ�����<NodeIP>:NodePort����ʽ���ŵķ����ϡ�

��ʹ��һ����Ⱥ�ڲ�IP��ַ����NodePort�Ͽ���һ��Service�Ļ����ϣ������������ṩ������һ�����ؾ�������������ת�����Ѿ���NodePort��ʽ������Service�ϡ�


#DNS
[root@knode-01 yaml]# kubectl --namespace=kube-system get deployment
NAME      READY   UP-TO-DATE   AVAILABLE   AGE
coredns   2/2     2            2           200d

���񡢸��ؾ��������
Kubernetes �������ķ�������⣺

һ�� Pod �е�����֮��ͨ�����ػ�·��loopback��ͨ�š�
��Ⱥ�����ڲ�ͬ pod ֮���ṩͨ�š�
Service ��Դ��������Ⱪ¶ Pods �����е�Ӧ�ó�����֧�������ڼ�Ⱥ�ⲿ�ķ��ʡ�
����ʹ�� Services ������������Ⱥ�ڲ�ʹ�õķ���


# ��ȡ��Ⱥ��Ϣ
[root@knode-01 ~]# kubectl cluster-info
Kubernetes master is running at https://192.168.107.136:6443
KubeDNS is running at https://192.168.107.136:6443/api/v1/namespaces/kube-system/services/kube-dns:dns/proxy

# nginx deployments
[root@knode-01 yaml]# kubectl run nginx --image=nginx:1.7.12

[root@knode-01 yaml]# kubectl create deployment nginx --image=nginx:1.7.12   # ����һ��nginx��deployment
deployment.apps/nginx created
[root@knode-01 yaml]# kubectl get deployments nginx  #��ȡnginx�Ĳ���
NAME    READY   UP-TO-DATE   AVAILABLE   AGE
nginx   1/1     1            1           15s
[root@knode-01 yaml]# kubectl get deployments nginx -o jsonpath --template {.spec.selector.matchLabels}     # �鿴�ò���ƥ��ı�ǩ
map[app:nginx]
[root@knode-01 yaml]# kubectl get replicasets --selector=app=nginx   # ��ȡnginx�����replicasets
NAME              DESIRED   CURRENT   READY   AGE
nginx-b44bb7fbd   1         1         1       8m27s
[root@knode-01 yaml]# kubectl scale deployments nginx --replicas=2
deployment.apps/nginx scaled
[root@knode-01 yaml]# kubectl get replicasets --selector=app=nginx
NAME              DESIRED   CURRENT   READY   AGE
nginx-b44bb7fbd   2         2         2       13m

[root@knode-01 yaml]# kubectl get deployments nginx --export -o yaml > nginx-deployment.yaml  # ͨ��deployment ����һ��yaml�ļ�
Flag --export has been deprecated, This flag is deprecated and will be removed in future.
[root@knode-01 yaml]# kubectl replace -f nginx-deployment.yaml --save-config
deployment.apps/nginx replaced
[root@knode-01 yaml]# vim nginx-deployment.yaml 


[root@knode-01 yaml]# kubectl apply -f nginx-deployment.yaml   # ͨ���޸�yaml�ļ�����
deployment.apps/nginx configured
[root@knode-01 yaml]# kubectl rollout status deployments nginx
Waiting for deployment "nginx" rollout to finish: 1 out of 3 new replicas have been updated...
Waiting for deployment "nginx" rollout to finish: 1 out of 3 new replicas have been updated...
Waiting for deployment "nginx" rollout to finish: 1 out of 3 new replicas have been updated...
Waiting for deployment "nginx" rollout to finish: 2 out of 3 new replicas have been updated...
Waiting for deployment "nginx" rollout to finish: 2 out of 3 new replicas have been updated...
Waiting for deployment "nginx" rollout to finish: 2 out of 3 new replicas have been updated...
Waiting for deployment "nginx" rollout to finish: 1 old replicas are pending termination...
Waiting for deployment "nginx" rollout to finish: 1 old replicas are pending termination...
deployment "nginx" successfully rolled out
[root@knode-01 yaml]# 

[root@knode-01 yaml]# kubectl get replicasets -o wide  #�鿴���� replicasets
NAME              DESIRED   CURRENT   READY   AGE     CONTAINERS   IMAGES         SELECTOR
nginx-64f597fff   3         3         3       2m42s   nginx        nginx:1.9.10   app=nginx,pod-template-hash=64f597fff
nginx-b44bb7fbd   0         0         0       6h4m    nginx        nginx:1.7.12   app=nginx,pod-template-hash=b44bb7fbd


[root@knode-01 yaml]# kubectl rollout history deployment nginx # �鿴������ʷ
deployment.apps/nginx 
REVISION  CHANGE-CAUSE
1         <none>
2         Update nginx to 1.9.10

[root@knode-01 yaml]# kubectl rollout history deployment nginx --revision=2  #�鿴������ϸ��Ϣ
deployment.apps/nginx with revision #2
Pod Template:
  Labels:	app=nginx
	pod-template-hash=64f597fff
  Annotations:	kubernetes.io/change-cause: Update nginx to 1.9.10
  Containers:
   nginx:
    Image:	nginx:1.9.10
    Port:	<none>
    Host Port:	<none>
    Environment:	<none>
    Mounts:	<none>
  Volumes:	<none>


[root@knode-01 yaml]# kubectl get replicasets -o wide    # �ع�����
NAME              DESIRED   CURRENT   READY   AGE    CONTAINERS   IMAGES         SELECTOR
nginx-64f597fff   0         0         0       8m9s   nginx        nginx:1.9.10   app=nginx,pod-template-hash=64f597fff
nginx-b44bb7fbd   3         3         3       6h9m   nginx        nginx:1.7.12   app=nginx,pod-template-hash=b44bb7fbd


[root@knode-01 yaml]# kubectl rollout history deployment nginx   # �ٴβ鿴��ʷ
deployment.apps/nginx 
REVISION  CHANGE-CAUSE
2         Update nginx to 1.9.10
3         <none>

[root@knode-01 yaml]# kubectl rollout undo  deployment nginx  --to-revision=2  # ͨ��revision ָ����Ӧ�İ汾
deployment.apps/nginx rolled back
[root@knode-01 yaml]# kubectl rollout history deployment nginx 
deployment.apps/nginx 
REVISION  CHANGE-CAUSE
3         <none>
4         Update nginx to 1.9.10



# �鿴iptables ת������
[root@knode-01 yaml]# iptables -nL -t nat -v

# ��ʱ����
kubectl -n kubernetes-dashboard create secret tls dashboard-ingress-secret --cert=tls.crt --key=tls.key
kubectl create ns kubernetes-dashboard
dash_tocken=$(kubectl get secret -n kubernetes-dashboard kubernetes-dashboard-token-nw9ff -o jsonpath={.data.token}|base64 -d)
kubectl config set-cluster kubernetes --server=192.168.107.136:6443 --kubeconfig=./dashboard-admin.conf
kubectl config set-credentials dashboard-admin --token=$dash_tocken --kubeconfig=./dashboard-admin.conf
kubectl config set-context dashboard-admin@kubernetes --cluster=kubernetes --user=dashboard-admin --kubeconfig=./dashboard-admin.conf
kubectl config use-context dashboard-admin@kubernetes --kubeconfig=./dashboard-admin.conf

# �����û�
kubectl create sa yuzhiyi -n kube-system


# ֤������
openssl genrsa -out tls.key 2048
openssl req -new -x509 -key tls.key -out tls.crt -subj /C=CN/ST=Shanghai/L=Shanghai/O=DevOps/CN=dashboard.00joy.com
kubectl -n kubernetes-dashboard create secret tls dashboard-ingress-secret --cert=tls.crt --key=tls.key

# config view
[root@knode-01 yaml]# kubectl config view
apiVersion: v1
clusters:
- cluster:
    certificate-authority-data: DATA+OMITTED
    server: https://192.168.107.136:6443
  name: kubernetes
contexts:
- context:
    cluster: kubernetes
    user: kubernetes-admin
  name: kubernetes-admin@kubernetes
current-context: kubernetes-admin@kubernetes
kind: Config
preferences: {}
users:
- name: kubernetes-admin
  user:
    client-certificate-data: REDACTED
    client-key-data: REDACTED


# �����Ľ���
[root@knode-01 tmp]# kubectl get service
NAME           TYPE        CLUSTER-IP       EXTERNAL-IP   PORT(S)          AGE
kuard-config   NodePort    10.100.122.198   <none>        8080:31789/TCP   35h
kubernetes     ClusterIP   10.96.0.1        <none>        443/TCP          202d
nginx          NodePort    10.102.13.36     <none>        80:30597/TCP     36h
[root@knode-01 tmp]# kubectl exec -it kuard-config-6b79545c7f-sq5dk nslookup nginx
kubectl exec [POD] [COMMAND] is DEPRECATED and will be removed in a future version. Use kubectl kubectl exec [POD] -- [COMMAND] instead.
nslookup: can't resolve '(null)': Name does not resolve

Name:      nginx
Address 1: 10.102.13.36 nginx.default.svc.cluster.local
