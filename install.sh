git init
git pull https://github.com/suiq-hash/backup
unzip backup.zip && sudo rm -rf backup.zip
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
sudo rm -rf ./cc.zip.*
sudo rm -rf ./cv.zip
mv together/1.20.4 ./
mv together/minecraftMaven ./
mv together/version_manifest.json ./
sudo rm -rf together
