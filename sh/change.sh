#!/bin/bash
cd ~/work/inovacao

if [ -z "$myNamespace" ]
then
    echo "Informe um Nome para o Namespace"
else
    sed -i -e  "s/<seu namespace>/$myNamespace/g" front-app/helm/front-app/values.yaml
    sed -i -e  "s/<seu namespace>/$myNamespace/g" back-app/helm/back-app/values.yaml    
    sed -i -e  "s/<seu namespace>/$myNamespace/g" cert-app/helm/cert-app/values.yaml
    sed -i -e  "s/<seu namespace>/$myNamespace/g" ~/sh/preparacao.sh
    sed -i -e  "s/<seu namespace>/$myNamespace/g" ~/02_Kubernetes.ipynb
    sed -i -e  "s/<seu namespace>/$myNamespace/g" ~/03_Helm.ipynb
    sed -i -e  "s/<seu namespace>/$myNamespace/g" ~/04_Back.ipynb
    sed -i -e  "s/<seu namespace>/$myNamespace/g" ~/05_Cert.ipynb    
fi

echo $PWD