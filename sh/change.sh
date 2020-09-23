mkdir -p ~/work/inovacao
cd ~/work/inovacao

if [ -z "$myNamespace" ]
then
    echo "Informe um Nome para o Namespace"
else
    sed -i -e  "s/<seu namespace>/$myNamespace/g" front-app/helm/front-app/values.yaml
    sed -i -e  "s/<seu namespace>/$myNamespace/g" back-app/helm/back-app/values.yaml    
    sed -i -e  "s/<seu namespace>/$myNamespace/g" cert-app/helm/cert-app/values.yaml
    sed -i -e  "s/<seu namespace>/$myNamespace/g" ~/sh/preparacao.sh
fi

echo $PWD