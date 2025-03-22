echo 正在初始化Git仓库...
git init
echo 初始化完成!
echo 尝试拉取Alien源码...
git pull https://github.com/im4dcat/alien
echo 拉取完成!
echo 移动到~目录准备创建Fabric-Loom
cd ~
mkdir .gradle
cd .gradle
mkdir caches
cd caches
mkdir fabric-loom
cd fabric-loom
echo 初始化Git仓库...
git init
echo 拉取...
git pull https://github.com/r1-hasher/cc
echo 合并分卷压缩包
zip -FF cc.zip --out cv.zip
echo 解压+移动目录
unzip cv.zip
sudo rm -rf ./cc.z*
sudo rm -rf ./cv.zip
mv together/1.20.4 ./
mv together/minecraftMaven ./
mv together/version_manifest.json ./
