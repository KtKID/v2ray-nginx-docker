# v2ray-nginx-docker
v2ray配合nginx的一个docker，dddd
## 前提
需要一台外面的vps服务器，一个域名。
## 配置
基本都在build_run.sh和run.sh，build_run脚本会构建docker镜像和运行container。
run.sh是入口点，负责启动nginx和v2ray。
