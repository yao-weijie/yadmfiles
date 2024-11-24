# 清华源
sed "s/archive.ubuntu.com/mirrors.tuna.tsinghua.edu.cn/g" /etc/apt/sources.list    # not inplace
sed -i "s/archive.ubuntu.com/mirrors.tuna.tsinghua.edu.cn/g" /etc/apt/sources.list # inplace

sed -e "s/__MIRROR__/mirrors.tuna.tsinghua.edu.cn/g" -e "s/__VERSION__/jammy/g" ./ubuntu.list.tmpl
