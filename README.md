# Using jupyter binder

Classic
[![Binder](http://binder.kdop.net/badge_logo.svg)](http://binder.kdop.net/v2/gh/kdop-dev/pilula-inovacao-kubernetes.git/master?filepath=index.ipynb)

Lab
[![Binder](http://binder.kdop.net/badge_logo.svg)](http://binder.kdop.net/v2/gh/kdop-dev/pilula-inovacao-kubernetes.git/master?urlpath=lab)

urlpath=lab/tree/ipynb

After launch, save your URL to keep the same session and results on server. If you click on link above again, it will launch a new clean session (environment/pod).

> After an hour, all your results will be erased.

### Run locally

```bash
docker run -p 8888:8888 kdop/learn-kdop-2ddev-2dpilula-2dinovacao-2dkubernetes-731f2f:bac8895cd5c65bcea79efb0253075411d881f5da

Executing the command: jupyter notebook
[I 22:04:09.661 NotebookApp] Writing notebook server cookie secret to /home/jovyan/.local/share/jupyter/runtime/notebook_cookie_secret
[I 22:04:10.148 NotebookApp] JupyterLab extension loaded from /opt/conda/lib/python3.8/site-packages/jupyterlab
[I 22:04:10.149 NotebookApp] JupyterLab application directory is /opt/conda/share/jupyter/lab
[I 22:04:10.153 NotebookApp] Serving notebooks from local directory: /home/jovyan
[I 22:04:10.153 NotebookApp] Jupyter Notebook 6.1.3 is running at:
[I 22:04:10.153 NotebookApp] http://b7ce24ecf663:8888/?token=a20051ceebe822a97f3cad9dbbf464b58b26e7356f6d54e8
[I 22:04:10.153 NotebookApp]  or http://127.0.0.1:8888/?token=a20051ceebe822a97f3cad9dbbf464b58b26e7356f6d54e8
[I 22:04:10.153 NotebookApp] Use Control-C to stop this server and shut down all kernels (twice to skip confirmation).
[C 22:04:10.156 NotebookApp]

    To access the notebook, open this file in a browser:
        file:///home/jovyan/.local/share/jupyter/runtime/nbserver-6-open.html
    Or copy and paste one of these URLs:
        http://b7ce24ecf663:8888/?token=a20051ceebe822a97f3cad9dbbf464b58b26e7356f6d54e8
     or http://127.0.0.1:8888/?token=a20051ceebe822a97f3cad9dbbf464b58b26e7356f6d54e8
```
> Não use o terminal do VS Code, ele irá reiniciar o vs code para alterar as configurações de servidor, ou execute o docker em segundo plano `docker run -d ...`

#### Conectando o VS Code com seu servidor.

Quando você executa o jupyter-notebook ele exibe uma URL como esta: http://127.0.0.1:8888/?token=a20051ceebe822a97f3cad9dbbf464b58b26e7356f6d54e8. Copie esta URL para utilizar no VS Code.

Selecione o notebook (extensão ipynb) que deseja conectar. O VS Code automaticamente iniciará um servidor no plano de fundo e renderizará o notebook.

Troque o servidor, como exibido na figura abaixo.

![](media/code-jupyter-server.png)

Por padrão, o kernel selecionado será o Python, troque selecionando a opção kernel, como na figura abaixo.

![](media/code-jupyter-kernel.png)

## References

* [How to reduce mybinder.org repository startup time](https://discourse.jupyter.org/t/how-to-reduce-mybinder-org-repository-startup-time/4956)
* [Binder - How to guides](https://mybinder.readthedocs.io/en/latest/howto/index.html)
* [Zero to BinderHub](https://binderhub.readthedocs.io/en/latest/zero-to-binderhub/setup-binderhub.html)

## Treinamentos

* [free-programming-books](https://github.com/EbookFoundation/free-programming-books/blob/master/free-programming-books.md)
* [Katacoda](https://www.katacoda.com/)
* [Kubernetes Training and Certification](https://kubernetes.io/training/)
* [Learn Kubernetes Basics](https://kubernetes.io/docs/tutorials/kubernetes-basics/)
* [Introduction to Kubernetes](https://www.edx.org/course/introduction-to-kubernetes)
* [Linux Fundation - Kubernetes](https://training.linuxfoundation.org/training/course-catalog/?_sft_technology=kubernetes)