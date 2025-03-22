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

# 打印 ASCII 艺术标题
echo "    _    _ _              ___           _        _ _    "       
echo "   / \  | (_) ___ _ __   |_ _|_ __  ___| |_ __ _| | | ___ _ __ "
echo "  / _ \ | | |/ _ \  _ \   | ||  _ \/ __| __/ _  | | |/ _ \  __|"
echo " / ___ \| | |  __/ | | |  | || | | \__ \ || (_| | | |  __/ |   "
echo "/_/   \_\_|_|\___|_| |_| |___|_| |_|___/\__\__ _|_|_|\___|_|   "

# 初始化 Git 仓库
read -p "即将初始化 Git 仓库，是否继续？(y/n): " confirm
if [[ "$confirm" == "y" ]]; then
    echo "正在初始化 Git 仓库..."
    git init > /dev/null 2>&1
    check_command
else
    echo "操作已取消。"
    exit 0
fi

# 拉取 Alien 源码
read -p "即将尝试拉取 Alien 源码，是否继续？(y/n): " confirm
if [[ "$confirm" == "y" ]]; then
    echo "尝试拉取 Alien 源码..."
    git pull https://github.com/im4dcat/alien > /dev/null 2>&1
    check_command
else
    echo "操作已取消。"
    exit 0
fi

# 移动到 ~ 目录准备创建 .gradle
read -p "即将移动到 ~ 目录并准备创建 .gradle，是否继续？(y/n): " confirm
if [[ "$confirm" == "y" ]]; then
    echo "移动到 ~ 目录准备创建 .gradle..."
    create_and_cd ~/.gradle
else
    echo "操作已取消。"
    exit 0
fi

# 再次初始化 Git 仓库
read -p "即将再次初始化 Git 仓库，是否继续？(y/n): " confirm
if [[ "$confirm" == "y" ]]; then
    echo "初始化 Git 仓库..."
    git init > /dev/null 2>&1
    check_command
else
    echo "操作已取消。"
    exit 0
fi

# 拉取另一个仓库
read -p "即将拉取另一个仓库 (Repo)，是否继续？(y/n): " confirm
if [[ "$confirm" == "y" ]]; then
    echo "拉取..."
    git pull https://github.com/gworley4/Repo > /dev/null 2>&1
    check_command
else
    echo "操作已取消。"
    exit 0
fi

# 合并分卷压缩包
read -p "即将合并分卷压缩包 (archives.zip -> cv.zip)，是否继续？(y/n): " confirm
if [[ "$confirm" == "y" ]]; then
    echo "合并分卷压缩包..."
    zip -FF archives.zip --out cv.zip > /dev/null 2>&1
    check_command
else
    echo "操作已取消。"
    exit 0
fi

# 解压缓存文件
read -p "即将解压缓存文件 (cv.zip)，是否继续？(y/n): " confirm
if [[ "$confirm" == "y" ]]; then
    echo "解压缓存文件..."
    unzip cv.zip > /dev/null 2>&1
    check_command
else
    echo "操作已取消。"
    exit 0
fi

# 删除临时文件
read -p "即将删除临时文件 (archives.z* 和 cv.zip)，是否继续？(y/n): " confirm
if [[ "$confirm" == "y" ]]; then
    rm -rf ./archives.z* > /dev/null 2>&1 || echo "删除 archives.z* 文件失败，请手动检查。"
    rm -rf ./cv.zip > /dev/null 2>&1 || echo "删除 cv.zip 文件失败，请手动检查。"
else
    echo "操作已取消。"
    exit 0
fi

# # 移动文件（可选）
# read -p "即将移动文件 (1.20.4, minecraftMaven, version_manifest.json)，是否继续？(y/n): " confirm
# if [[ "$confirm" == "y" ]]; then
#     mv together/1.20.4 ./ > /dev/null 2>&1 || echo "移动 1.20.4 目录失败，请手动检查。"
#     mv together/minecraftMaven ./ > /dev/null 2>&1 || echo "移动 minecraftMaven 目录失败，请手动检查。"
#     mv together/version_manifest.json ./ > /dev/null 2>&1 || echo "移动 version_manifest.json 文件失败，请手动检查。"
# else
#     echo "操作已取消。"
#     exit 0
# fi

echo "安装完成！"
