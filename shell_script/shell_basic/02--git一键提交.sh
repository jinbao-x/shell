:<<EOF
此文件用来给git配置别名，实现输入commit后可一键执行
git add .   git commit  git push等操作，稍微方便一些
windows->需要先在git的家目录创建.bash_profile文件并编辑添加别名设置
alias commit='/c/Users/金宝/....../commit.sh'
然后保存一下，重新启动git bash就可以使用commit一键完成提交了
linux->可以修改~/bashrc添加别名配置
alias commit='~/....../commit.sh'
EOF


git add .
read -p "Please enter submission information:" a
git commit -m "$a"
git push origin master


:<<EOF
配置好之后需要给commit.sh添加权限
另外，如果不想每次都输入密码，需要做global全局配置
git config --global credential.helper store
EOF
