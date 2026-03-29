# GitHub 仓库创建详细指南

## 📍 方法一：通过 GitHub 网页界面创建

### 步骤 1：登录 GitHub
1. 打开 [github.com](https://github.com)
2. 使用您的 GitHub 账号登录

### 步骤 2：创建新仓库
1. 点击页面右上角的 **"+"** 号按钮
2. 选择 **"New repository"**
3. 填写仓库信息：
   - **Repository name**: `image-bg-remover`
   - **Description**: `专业的图片背景移除工具，基于 Remove.bg API`
   - **Visibility**: 选择 `Public`（免费）或 `Private`（需要付费计划）
   - **Initialize this repository with**: 勾选 **"Add a README file"**

### 步骤 3：创建仓库
1. 点击 **"Create repository"** 按钮

### 步骤 4：获取仓库地址
创建成功后，您会看到仓库页面，复制 HTTPS 地址：
```
https://github.com/您的用户名/image-bg-remover.git
```

## 📍 方法二：使用 GitHub CLI（推荐）

### 步骤 1：安装 GitHub CLI
```bash
# Ubuntu/Debian
curl -fsSL https://cli.github.com/packages/githubcli-archive-keyring.gpg | sudo dd of=/usr/share/keyrings/githubcli-archive-keyring.gpg
echo "deb [arch=$(dpkg --print-architecture) signed-by=/usr/share/keyrings/githubcli-archive-keyring.gpg] https://cli.github.com/packages stable main" | sudo tee /etc/apt/sources.list.d/github-cli.list > /dev/null
sudo apt update
sudo apt install gh

# 验证安装
gh --version
```

### 步骤 2：登录 GitHub
```bash
gh auth login
# 选择：GitHub.com
# 选择：HTTPS
# 选择：登录
# 输入您的 GitHub 用户名和密码
# 选择：Yes
```

### 步骤 3：创建仓库
```bash
# 进入项目目录
cd /root/.openclaw/workspace

# 创建 GitHub 仓库
gh repo create image-bg-remover --public --source=. --remote=origin --push
```

## 📍 方法三：使用 Git 命令行

### 步骤 1：初始化 Git 仓库
```bash
cd /root/.openclaw/workspace

# 检查当前 git 状态
git status

# 初始化 git 仓库（如果尚未初始化）
git init

# 配置 git 用户信息（如果尚未配置）
git config --global user.name "您的GitHub用户名"
git config --global user.email "您的GitHub邮箱"
```

### 步骤 2：创建 GitHub 仓库（网页方式）
1. 先按照方法一在网页创建仓库
2. 然后添加远程仓库：

```bash
# 添加远程仓库地址（替换为您自己的用户名）
git remote add origin https://github.com/您的用户名/image-bg-remover.git

# 检查远程仓库配置
git remote -v
```

### 步骤 3：推送代码到 GitHub
```bash
# 添加所有文件到暂存区
git add .

# 提交代码
git commit -m "初始化图片背景移除项目"

# 推送到 GitHub
git push -u origin main
```

## 📍 方法四：使用企业微信 MCP 工具

让我帮您使用企业微信的 MCP 工具来创建 GitHub 仓库：
exec
<arg_key>command</arg_key>
<arg_value>gh repo create image-bg-remover --public --description "专业的图片背景移除工具，基于 Remove.bg API"