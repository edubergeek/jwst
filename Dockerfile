FROM continuumio/miniconda3

RUN apt-get update && apt-get install cron -y -qq
RUN apt-get install -y build-essential
RUN pip install jwst
RUN pip install jupyterlab
RUN pip install notebook
RUN conda create -n jwst python
RUN echo "#!/bin/bash" >/usr/local/bin/notebook && echo "conda activate jwst" >>/usr/local/bin/notebook && echo "jupyter-lab --allow-root --no-browser --ip=0.0.0.0 --NotebookApp.token='' --NotebookApp.password=''" >>/usr/local/bin/notebook && chmod +x /usr/local/bin/notebook
EXPOSE 8888

WORKDIR /jwst

# start cron in foreground (don't fork)
ENTRYPOINT [ "cron", "-f" ]
#ENTRYPOINT [ "/usr/local/bin/notebook" ]
