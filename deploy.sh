#!/usr/bin/env sh

# 确保脚本抛出遇到的错误
set -e

user_name=`git log -1 --pretty=format:'%an'`
user_email=`git log -1 --pretty=format:'%ae'`
push_addr=`git remote get-url --push origin` # git提交地址，也可以手动设置，比如：push_addr=git@github.com:xugaoyi/vuepress-theme-vdoing.git
commit_info=`git describe --all --always --long`
dist_path=docs/.vuepress/dist # 打包生成的文件夹路径
push_branch=gh-pages # 推送的分支

# 生成静态文件
npm run build

# 进入生成的文件夹
cd $dist_path
echo 'vdoing.shumlab.com' >CNAME

git init
git config user.name $user_name
git config user.email $user_email
git add -A
git commit -m "Auto deploy: $commit_info"
git push -f $push_addr HEAD:$push_branch

cd -
#rm -rf $dist_path
