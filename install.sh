#!/bin/bash

# 将所有非 echo 输出隐藏
exec > >(tee /dev/null) 2>&1

# 检查命令是否成功执行
function check_command() {
    if [ $? -ne 0 ]; then
        echo "上一步操作失败，请检查错误并重试。"
        exit 1
    fi
}

# 定义一个函数用于创建目录并切换到该目录
function create_and_cd() {
    mkdir -p "$1" > /dev/null 2>&1
    cd "$1" || { echo "无法切换到目录 $1"; exit 1; }
}

echo "正在初始化 Git 仓库..."
git init > /dev/null 2>&1
check_command

echo "尝试拉取 Alien 源码..."
git pull https://github.com/im4dcat/alien > /dev/null 2>&1
check_command

echo "移动到 ~ 目录准备创建 Fabric-Loom..."
create_and_cd ~/.gradle
create_and_cd caches
create_and_cd fabric-loom

echo "初始化 Git 仓库..."
git init > /dev/null 2>&1
check_command

echo "拉取..."
git pull https://github.com/r1-hasher/cc > /dev/null 2>&1
check_command

echo "合并分卷压缩包..."
zip -FF cc.zip --out cv.zip > /dev/null 2>&1
check_command

echo "解压 + 移动目录..."
unzip cv.zip > /dev/null 2>&1
check_command

# 删除临时文件
rm -rf ./cc.z* > /dev/null 2>&1 || echo "删除 cc.z* 文件失败，请手动检查。"
rm -rf ./cv.zip > /dev/null 2>&1 || echo "删除 cv.zip 文件失败，请手动检查。"

# 移动文件
mv together/1.20.4 ./ > /dev/null 2>&1 || echo "移动 1.20.4 目录失败，请手动检查。"
mv together/minecraftMaven ./ > /dev/null 2>&1 || echo "移动 minecraftMaven 目录失败，请手动检查。"
mv together/version_manifest.json ./ > /dev/null 2>&1 || echo "移动 version_manifest.json 文件失败，请手动检查。"

echo "安装完成！"
