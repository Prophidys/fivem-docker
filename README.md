# fivem-docker

## How to use it

First, create your own local resources folder and put defaults citizenfx scripts in it.

    $ mdkir resources
    $ git clone https://github.com/citizenfx/cfx-server-data.git
    $ ln -s cfx-server-data/resources resources/[base]

Create a server.cfg following https://docs.fivem.net/docs/server-manual/setting-up-a-server/#a-nameservercfgexampleaservercfg

    $ touch resources/server.cfg
    $ vim resources/server.cfg

With docker :

    $ docker run --name=myfivemserver --restart=always --pull=always -id -p 30120:30120/tcp -v ./resources/:/opt/resources docker.io/prophidys/fivem:latest

With podman :

    $ podman run --name=myfivemserver --restart=always --pull=always -id -p 30120:30120/tcp -v ./resources:/opt/resources:Z docker.io/prophidys/fivem:latest