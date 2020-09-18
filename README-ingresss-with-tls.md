# Configurando TLS

Há duas maneiras de abordar esse tema:

1. Configurar no Ingress o certificado.
2. Configurar o Ingress Controller para utilizar certificado.

A primeira abordagem torna o certificado disponível para todas as configurações de Ingress, porém, limita as opções, já na segunda opção, cada configuração pode ter um certificado diferente, deixando o Ingress Controller para uso geral, porém, cada configuração de Ingress deverá lidar com questões de renovação de certificados.

Em resumo, as opções são centralizar ou descentralizar a configuração de certificados.

> No workshop não foi configurado o TLS porque o domínio kdop.net e seu certificado estão registrados na AWS e não há uma opção de exportá-lo para ser utilizado em outro ambiente.

## 1. Configurando TLS no Ingress

Ref: [Ingress - TLS](https://kubernetes.io/docs/concepts/services-networking/ingress/#tls) e [Nginx - TLS termination](https://kubernetes.github.io/ingress-nginx/examples/tls-termination/)

Configurar TLS no Ingress é bem simples, precisando apenas criar um segredo (secret) com o conteúdo od certificado e referênciá-lo na configuração do Ingress, como segue:

```yaml
# Source: front-app/templates/ingress.yaml
apiVersion: networking.k8s.io/v1beta1
kind: Ingress
metadata:
  name: front-app
  labels:
    helm.sh/chart: front-app-0.1.0
    app.kubernetes.io/name: front-app
    app.kubernetes.io/instance: front-app
    app.kubernetes.io/version: "1.16.0"
    app.kubernetes.io/managed-by: Helm
  annotations:
    nginx.ingress.kubernetes.io/rewrite-target: /$2
spec:
  tls:
  - hosts:
    - kdop.net
    secretName: kdop-net-secret-tls
  rules:
    - host: "learn.kdop.net"
      http:
        paths:
          - path: /adsantos/front-app(/|$)(.*)
            backend:
              serviceName: front-app
              servicePort: 5000
```

E criaria um secret (um template para ser criado com o helm) com o nome `kdop-net-secret-tls` no mesmo namespace.

```yaml
apiVerision: v1
kind: Secret
metadata:
  name: kdop-net-secret-tls
  labels:
    helm.sh/chart: front-app-0.1.0
    app.kubernetes.io/name: front-app
    app.kubernetes.io/instance: front-app
    app.kubernetes.io/version: "1.16.0"
    app.kubernetes.io/managed-by: Helm
data:
  tls.crt: base64 encoded cert
  tls.key: base64 encoded cert
type: kubernetes.io/tls
```

Neste exemplo o certificado é um certificado curinga e após o deploy, sua aplicação já terá uma terminação TLS válida.

### Configurar Ingress no AKS usando Application Gateway

```yaml
kind: Ingress
metadata:
  annotations:
    kubernetes.io/ingress.class: nginx
    nginx.ingress.kubernetes.io/rewrite-target: /$2
  name: front-app
  namespace: adsantos
spec:
  rules:
    - host: "kcluster-front-app.krthomolog.com.br"
      http:
        paths:
          - path: /adsantos/front-app(/|$)(.*)
            backend:
              serviceName: front-app
              servicePort: 5000
  tls:
  - hosts:
    - "*.krthomolog.com.br"
    secretName: krthomolog-secret
```

Como você pode ver, não há diferença na configuração usando o Azure Application Gateway.

Neste namespace, há um segredo com o certificado do krtmolog.com.br.

```bash
kubectl describe secret/krthomolog-secret -n adsantos
Name:         krthomolog-secret
Namespace:    adsantos
Labels:       <none>
Annotations:  <none>

Type:  kubernetes.io/tls

Data
====
tls.crt:  2324 bytes
tls.key:  1679 bytes
```

## 2. Configurando o Ingress Controller com TLS

Há também algumas alternatinas nesta opção, vamos destacar duas:

* Configurar o LoadBalancer da nuvem e utiliar um certificado gerenciado pela nuvem.
* Configurar o ingress controller com certificado padrão
* Instalar o cert-manager no cluster e configurar para utilizar o Let's Encrypt.

### Configurar o LoadBalancer

É diferente para cada provedor de nuvem, em [Ingress - TLS support on AWS](https://kubernetes.io/docs/concepts/services-networking/service/#ssl-support-on-aws) há um exemplo de como configurar na AWS.

Na Azure, o LoadBalancer é L4, não tendo configuração de TLS, sendo necessário utilizar o Application Gateway e as configurações sugeridas pela Microsoft é de utilizá-lo como um Ingress Controller[Application Gateway Ingress Controller](https://github.com/Azure/application-gateway-kubernetes-ingress) e [Create an Application Gateway ingress controller in Azure Kubernetes Service](https://docs.microsoft.com/en-us/azure/developer/terraform/create-k8s-cluster-with-aks-applicationgateway-ingress), substituindo o Nginx Ingress Controller.

### Configurar o ingress controller com certificado padrão

Ref: [Nginx Ingress - Default SSL Certificate](https://kubernetes.github.io/ingress-nginx/user-guide/tls/)

No deployment do nginx controller `kubectl get deployment.apps/ingress-nginx-controller -n ingress-nginx -o yaml > nginx-controller-deploy.yaml`

Há uma seção de argumentos a serem passados para o controller

```yaml
    spec:
      containers:
      - args:
        - /nginx-ingress-controller
        - --publish-service=$(POD_NAMESPACE)/ingress-nginx-controller
        - --election-id=ingress-controller-leader
        - --ingress-class=nginx
        - --configmap=$(POD_NAMESPACE)/ingress-nginx-controller
        - --validating-webhook=:8443
        - --validating-webhook-certificate=/usr/local/certificates/cert
        - --validating-webhook-key=/usr/local/certificates/key
        - --default-ssl-certificate=ingress-nginx/krthomolog-secret
```

Adicione a linha `--default-ssl-certificate=ingress-nginx/krthomolog-secret` com a localização do secret-tls.

No workshop as URLs que usam o certificado padrão são:

https://kdop-learn.krthomolog.com.br/adsantos/cert-app/get-cert?p=As
https://kdop-learn.krthomolog.com.br/adsantos/front-app/index

E sem certificado

http://learn.kdop.net/adsantos/cert-app/get-cert?p=As
http://learn.kdop.net/adsantos/front-app/index

### Instalar o cert-manager

Esta é a opção mais barata, siga as instuções em [Secure Kubernetes Services with Ingress, TLS and Let's Encrypt](https://docs.bitnami.com/tutorials/secure-kubernetes-services-with-ingress-tls-letsencrypt), [AKS - Install cert-manager](https://docs.microsoft.com/en-us/azure/aks/ingress-tls#install-cert-manager) e [How to set up SSL certificates for free on Azure Kubernetes Service with Let’s Encrypt](https://medium.com/@GeoffreyDV/how-to-set-up-ssl-certificates-for-free-on-azure-kubernetes-service-with-lets-encrypt-c7daca4e9385). Verifique se é necessário instalar um Ingress Controller, caso não salte essas etapas.
