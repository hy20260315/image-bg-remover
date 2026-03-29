#!/bin/bash

# Cloudflare Pages 部署脚本

echo "🚀 开始 Cloudflare Pages 部署..."

# 配置变量
CLOUDFLARE_API_TOKEN="cfut_GYQpkKyR3ajYtawPstD7RFjBWNckfaQ1KCNUqy9226c7fb14"
ACCOUNT_ID="f86e13b5d44cb8bf4ecc8e85bddc0e9b"
PROJECT_NAME="image-bg-remover"

# 检查必要工具
echo "📋 检查工具..."
if ! command -v curl &> /dev/null; then
    echo "❌ curl 未安装"
    exit 1
fi
if ! command -v jq &> /dev/null; then
    echo "❌ jq 未安装"
    exit 1
fi

echo "✅ 工具检查通过"

# 创建 GitHub 仓库（如果需要）
echo "📂 检查项目结构..."
if [ ! -f "index.html" ]; then
    echo "❌ index.html 不存在"
    exit 1
fi

echo "✅ 项目结构检查通过"

# 验证 Cloudflare API Token
echo "🔐 验证 Cloudflare API Token..."
response=$(curl -s -H "Authorization: Bearer $CLOUDFLARE_API_TOKEN" \
  -H "Content-Type: application/json" \
  "https://api.cloudflare.com/client/v4/accounts/$ACCOUNT_ID")

if ! echo "$response" | jq -e '.success' >/dev/null; then
    echo "❌ API Token 无效或账户权限不足"
    echo "响应: $response"
    exit 1
fi

echo "✅ API Token 验证成功"

# 检查是否已存在 Pages 项目
echo "📋 检查 Pages 项目..."
project_check=$(curl -s -H "Authorization: Bearer $CLOUDFLARE_API_TOKEN" \
  -H "Content-Type: application/json" \
  "https://api.cloudflare.com/client/v4/accounts/$ACCOUNT_ID/pages/projects")

if echo "$project_check" | jq -e ".result[] | select(.name == \"$PROJECT_NAME\")" >/dev/null; then
    echo "⚠️  Pages 项目 $PROJECT_NAME 已存在，跳过创建"
else
    echo "🆕 创建新的 Pages 项目..."
    create_response=$(curl -s -X POST "https://api.cloudflare.com/client/v4/accounts/$ACCOUNT_ID/pages/projects" \
      -H "Authorization: Bearer $CLOUDFLARE_API_TOKEN" \
      -H "Content-Type: application/json" \
      --data "{
        \"name\": \"$PROJECT_NAME\",
        \"source\": {
          \"type\": \"git\",
          \"config\": {
            \"repo_provider\": \"github\",
            \"repo_owner\": \"YOUR_USERNAME\",
            \"repo_name\": \"$PROJECT_NAME\",
            \"production_branch\": \"main\"
          }
        },
        \"build_config\": {
          \"build_command\": \"echo 'Static site ready'\",
          \"output_directory\": \".\"
        }
      }")
    
    if echo "$create_response" | jq -e '.success' >/dev/null; then
        echo "✅ Pages 项目创建成功"
        echo "📝 请在 GitHub 上创建仓库 $PROJECT_NAME，然后连接 Cloudflare"
    else
        echo "❌ Pages 项目创建失败: $create_response"
        exit 1
    fi
fi

# 生成部署指南
cat << EOF

🎉 Cloudflare Pages 部署准备完成！

## 📋 下一步操作：

### 1. 创建 GitHub 仓库
1. 访问 https://github.com/new
2. 仓库名称: \`image-bg-remover\`
3. 设为 Public（Cloudflare Pages 需要 Public 仓库）
4. 点击 "Create repository"

### 2. 上传项目文件
\`\`\`bash
# 克隆项目到本地
cd /tmp
git clone https://github.com/YOUR_USERNAME/image-bg-remover.git
cd image-bg-remover

# 复制项目文件
cp -r /root/.openclaw/workspace/cloudflare-pages-deploy/* .

# 提交并推送
git add .
git commit -m "Initial commit: Image Background Remover"
git branch -M main
git push -u origin main
\`\`\`

### 3. 连接 Cloudflare Pages
1. 登录 Cloudflare Dashboard: https://dash.cloudflare.com
2. 进入 Pages 部分
3. 点击 "Create project"
4. 选择 "Connect to Git"
5. 选择 image-bg-remover 仓库
6. 配置构建设置：
   - Build command: \`echo 'Static site ready'\`
   - Output directory: \`.`
   - Root directory: \`.`
7. 点击 "Deploy"

### 4. 验证部署
部署完成后，您的网站将在以下地址可用：
- https://image-bg-remover.pages.dev/

## 🎯 功能特性

✅ **真实 Remove.bg API 集成**
✅ **多种背景处理选项**
✅ **全球 CDN 加速**
✅ **自动 HTTPS 加密**
✅ **DDoS 防护**

## 📱 使用说明

1. 访问部署后的网站
2. 上传图片（支持拖拽）
3. 选择背景处理类型
4. 点击处理并等待完成
5. 下载处理后的图片

---
🚀 部署完成！享受专业的图片背景移除服务！
EOF