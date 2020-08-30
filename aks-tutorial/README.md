# Configuração helm

```bash
helm install aks-tutorial --create-namespace --namespace adsantos --set service.port=31800 ./aks-tutorial

# NOTES
  export NODE_PORT=$(kubectl get --namespace adsantos -o jsonpath="{.spec.ports[0].nodePort}" services aks-tutorial)
  export JUPYTER_LINK=$(kubectl exec svc/aks-tutorial -namespace adsantos jupyter notebook list | sed -n '2 p'| cut -d " " -f1)
  export TOKEN=$(echo $JUPYTER_LINK | cut -d "?" -f2)
  export NODE_IP=$(hostname -I | awk '{print $1}')
  export NOTEBOOK_URL=$(echo http://$NODE_IP:$NODE_PORT?$TOKEN)
  echo $NOTEBOOK_URL
```

> Se você precisar ver novamente as notas entre com o comand `helm get notes aks-tutorial -n adsantos`

```bash
helm install aks-tutorial --create-namespace --namespace leonardoosse --set service.port=31801 ./aks-tutorial

# NOTES.txt
export NODE_PORT=$(kubectl get --namespace leonardoosse -o jsonpath="{.spec.ports[0].nodePort}" services aks-tutorial)
export JUPYTER_LINK=$(kubectl exec svc/aks-tutorial --namespace leonardoosse jupyter notebook list | sed -n '2 p'| cut -d " " -f1)
export TOKEN=$(echo $JUPYTER_LINK | cut -d "?" -f2)
export NODE_IP=$(hostname -I | awk '{print $1}')
export NOTEBOOK_URL=$(echo http://$NODE_IP:$NODE_PORT?$TOKEN)
echo $NOTEBOOK_URL
```

Listando as aplicações instaladas

```bash
helm list --all-namespaces
```

Excluindo as aplicações

```bash
for NS in $(helm list --all-namespaces | awk '{print $2}' | tail -n+2)
do
  helm uninstall aks-tutorial -n $NS
done
```

## TODO

* Persistent Volumes: https://kubernetes.io/docs/tasks/configure-pod-container/configure-persistent-volume-storage/