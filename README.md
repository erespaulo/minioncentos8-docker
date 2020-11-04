# minioncentos8-docker
Docker de SaltStack Minion - Centos8


# With Proxy
docker build --build-arg http_proxy=http://<IP_PROXY>:3128 --build-arg https_proxy=http://<IP_PROXY>:3128 master_IP=<MASTER_IP>  -t pelab/saltminion:v1 .

# Without Proxy
docker build --build-arg master_IP=<MASTER_IP>  -t pelab/saltminion:v1 .
