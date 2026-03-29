# Cloudflare Pages 原生 GitHub 集成配置指南

## 🔧 当前状态
- Cloudflare API Token: cfut_GYQpkKyR3ajYtawPstD7RFjBWNckfaQ1KCNUqy9226c7fb14
- Cloudflare Account ID: f86e13b5d44cb8bf4ecc8e85bddc0e9b
- Token 验证状态: ❌ 需要重新验证

## 📋 手动配置步骤

### 1. 验证 Cloudflare 账户
1. 登录 Cloudflare Dashboard: https://dash.cloudflare.com
2. 检查账户 ID 是否正确: f86e13b5d44cb8bf4ecc8e85bddc0e9b
3. 确认有 Pages 权限

### 2. 创建 API Token
如果现有 token 无效，请创建新的 token：

1. 访问: https://dash.cloudflare.com/profile/api-tokens
2. 点击 "Create Token"
3. 选择 "Edit Cloudflare Workers" template
4. 配置权限：
   - Zone: DNS - Edit
   - Zone: Cache - Purge
   - Account: Cloudflare Workers - Edit
5. 生成 token 并保存

### 3. 配置 GitHub 仓库
为图片背景移除项目创建 GitHub 仓库：
1. 创建新仓库: `image-bg-remover`
2. 上传项目文件
3. 配置 GitHub Actions workflow

### 4. 部署到 Cloudflare Pages
1. 登录 Cloudflare Dashboard
2. 进入 Pages 部分
3. 点击 "Create project"
4. 选择 "Connect to Git"
5. 选择 GitHub 仓库
6. 配置构建设置

## 🛠 自动化脚本 (当 token 有效时)

```bash
#!/bin/bash
# Cloudflare Pages GitHub 集成脚本

CLOUDFLARE_API_TOKEN="cfut_GYQpkKyR3ajYtawPstD7RFjBWNckfaQ1KCNUqy9226c7fb14"
ACCOUNT_ID="f86e13b5d44cb8bf4ecc8e85bddc0e9b"

# 创建 Pages 项目
curl -X POST "https://api.cloudflare.com/client/v4/accounts/$ACCOUNT_ID/pages/projects" \
  -H "Authorization: Bearer $CLOUDFLARE_API_TOKEN" \
  -H "Content-Type: application/json" \
  --data '{
    "name": "image-bg-remover",
    "source": {
      "type": "git",
      "config": {
        "repo_provider": "github",
        "repo_owner": "your-username",
        "repo_name": "image-bg-remover",
        "production_branch": "main"
      }
    },
    "build_config": {
      "build_command": "npm run build",
      "output_directory": "dist",
      "root_dir": "public"
    }
  }'
```

## 📝 项目配置文件

### package.json
```json
{
  "name": "image-bg-remover",
  "version": "1.0.0",
  "scripts": {
    "build": "npm install && cp -r /root/.openclaw/workspace/* .",
    "dev": "npm run build"
  },
  "dependencies": {
    "tailwindcss": "^3.4.0"
  }
}
```

### _redirects (如果需要)
```
/*    /index.html   200
```

---
**配置时间**: 2026-03-28 14:57
**下一步**: 验证 API Token 有效性并完成配置