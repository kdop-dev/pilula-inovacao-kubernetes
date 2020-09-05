# Multi kernel notebook

## Install your environment

Create environment:

* create conda env `conda create -n py38 python=3.8`
* activate conda env `conda activate py38`
* install jupyter `python -m pip install jupyter`

To run bash:

* install ipykernel `pip install ipykernel`
* install bash_kernel `pip install bash_kernel`
* run `python -m bash_kernel.install`

To run R:

* install R `brew install r`
* open R console and run those commands:
  * `install.packages('IRkernel')`
  * `IRkernel::installspec()`
  * install bash_kernel `pip install numpy pandas rpy2`

Run jupyter notebook `jupyter notebook`

Open multi-kernel notebook or create using Bash or R kernels.

> Only python kernel can combine bash and R cells.

## Run as a docker image

```bash
docker build -t kdop/jupyter-bash:0.1 .

docker run -it -v $PWD:/home/jovyan/work -p 8888:8888 kdop/jupyter-bash:0.1
```

## References

* [Python, R, Bash in one Jupyter Notebook](https://evodify.com/python-r-bash-jupyter-notebook/)
* [Bash Notebooks in Jupyter](https://macintoshguy.wordpress.com/2016/04/09/bash-notebooks-in-jupyter/)
