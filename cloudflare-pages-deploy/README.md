# 图片背景移除工具

专业的图片背景移除工具，基于 Remove.bg API 和 Cloudflare Pages 部署。

## 🚀 功能特点

- ✅ 一键移除图片背景
- ✅ 高质量 AI 处理
- ✅ 支持多种图片格式
- ✅ 多种背景选项（透明、白色、自定义）
- ✅ 全球 CDN 加速
- ✅ 免费使用
- ✅ 实时预览效果

## 🛠 技术栈

- **前端**: HTML5 + Tailwind CSS + JavaScript
- **AI服务**: Remove.bg API
- **部署平台**: Cloudflare Pages
- **CDN**: Cloudflare Global Network

## 📦 部署说明

### 本地预览

```bash
cd cloudflare-pages-deploy
npm install
npm run preview
```

### Cloudflare Pages 部署

1. 将此项目推送到 GitHub 仓库
2. 登录 Cloudflare Dashboard
3. 进入 Pages 部分
4. 点击 "Create project"
5. 选择 "Connect to Git"
6. 选择对应的 GitHub 仓库
7. 配置构建设置：
   - Build command: `echo 'Static site ready'`
   - Build output directory: `.`
8. 点击 "Deploy"

## 🎯 使用流程

1. 上传图片（拖拽或点击选择）
2. 预览图片并确认
3. 选择背景处理类型
4. 点击"开始处理"按钮
5. 等待 AI 处理完成
6. 下载处理后的图片

## 🔧 API 配置

Remove.bg API Key 已集成：
- API Key: `Dup5WHfQmPk7xwX9dZ1vHzSr`
- API Endpoint: `https://api.remove.bg/v1.0/removebg`

## 📱 兼容性

- ✅ Chrome 80+
- ✅ Firefox 75+
- ✅ Safari 13+
- ✅ Edge 80+

## 📄 许可证

MIT License

---
**部署状态**: 🚀 Ready for Cloudflare Pages  
**维护者**: 相见是缘  
**最后更新**: 2026-03-28