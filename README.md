# Install jupyter binder

Ref: <https://binderhub.readthedocs.io/en/latest/zero-to-binderhub/setup-binderhub.html>

## Install

```bash
helm repo add jupyterhub https://jupyterhub.github.io/helm-chart

helm repo update

# Version https://jupyterhub.github.io/helm-chart/#development-releases-binderhub
helm install kdop jupyterhub/binderhub --version=0.2.0-n217.h35366ea --namespace=kdop --create-namespace -f secret.yaml -f config.yaml
```

## Public IP

```bash
kubectl --namespace=kdop get svc proxy-public
```

## Upgrade

```bash
# Version https://jupyterhub.github.io/helm-chart/#development-releases-binderhub
helm upgrade kdop jupyterhub/binderhub --version=0.2.0-n217.h35366ea --namespace kdop -f secret.yaml -f config.yaml
```

## Access

```bash
kubectl --namespace=kdop get svc binder
NAME     TYPE           CLUSTER-IP     EXTERNAL-IP   PORT(S)        AGE
binder   LoadBalancer   10.111.0.158   localhost     80:30590/TCP   8m31s
```

### Launch

[![Binder](http://localhost/badge_logo.svg)](http://localhost/v2/gh/kdop-dev/pilula-inovacao-kubernetes.git/master?filepath=AKS.ipynb)

### Run locally

```bash
docker run -p 8888:8888 kdop/learn-kdop-2ddev-2dconda-e13954:577865357337eb0b562fc747afb9e98b4a7bcacc
```