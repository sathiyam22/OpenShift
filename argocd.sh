#!/bin/bash
oc create namespace argocd
oc project argocd
mkdir argocd
cd argocd
wget https://raw.githubusercontent.com/argoproj/argo-cd/stable/manifests/install.yaml
oc apply -n argocd -f ./install.yaml
sleep 10
oc get pods -n argocd
sleep 20
oc get pods -n argocd
sleep 10
oc get pods -n argocd
oc -n argocd patch deployment argocd-dex-server  -p '{"spec": {"template":  {"spec": {"containers": [{"name": "dex","image": "quay.io/redhat-cop/dex:v2.22.0-openshift"}]}}}}'
oc get pods -l=app.kubernetes.io/name=argocd-dex-server
ARGOCD_SERVER_PASSWORD=$(oc -n argocd get pod -l "app.kubernetes.io/name=argocd-server" -o jsonpath='{.items[*].metadata.name}')
echo $ARGOCD_SERVER_PASSWORD
oc -n argocd patch deployment argocd-server -p '{"spec":{"template":{"spec":{"$setElementOrder/containers":[{"name":"argocd-server"}],"containers":[{"command":["argocd-server","--insecure","--staticassets","/shared/app"],"name":"argocd-server"}]}}}}'
oc -n argocd create route edge argocd-server --service=argocd-server --port=http --insecure-policy=Redirect
oc get route -n argocd-server
echo https://$(oc get routes argocd-server -o=jsonpath='{ .spec.host }')
sudo curl -sSL -o /usr/local/bin/argocd https://github.com/argoproj/argo-cd/releases/download/v2.0.3/argocd-linux-amd64
sudo chmod +x /usr/local/bin/argocd

#username admin
#kubectl -n argocd get secret argocd-initial-admin-secret -o jsonpath="{.data.password}" | base64 -d

