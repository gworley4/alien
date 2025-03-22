git init
git pull https://github.com/im4dcat/alien
cd ~
mkdir .gradle
cd .gradle
mkdir caches
cd caches
mkdir fabric-loom
cd fabric-loom
git init
git pull https://github.com/r1-hasher/cc
zip -FF cc.zip --out cv.zip
unzip cv.zip
sudo rm -rf ./cc.z*
sudo rm -rf ./cv.zip
mv together/1.20.4 ./
mv together/minecraftMaven ./
mv together/version_manifest.json ./
