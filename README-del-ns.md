# Excluir NS

```bash
# Apagar um NS
kubectl delete ns <NS-NAME>

# Forçar a exclusão
kubectl delete ns <NS-NAME> --grace-period=0 --force

# Se não funcionar
(
NAMESPACE=kdop-learn
kubectl proxy &
kubectl get namespace $NAMESPACE -o json |jq '.spec = {"finalizers":[]}' >temp.json
curl -k -H "Content-Type: application/json" -X PUT --data-binary @temp.json 127.0.0.1:8001/api/v1/namespaces/$NAMESPACE/finalize
)
```
