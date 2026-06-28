# 民宿预约管理系统 — 项目启动指南

## 1. 项目概述

民宿预约管理系统是一个前后端分离的全栈 Web 应用，支持用户在线浏览、预订、收藏民宿，房东管理房源，管理员全量管控。系统包含民宿列表、详情、预订、评价、收藏、用户管理等核心功能模块。

### 技术栈

| 层级 | 技术 | 版本 |
|------|------|------|
| 后端框架 | Spring Boot | 2.7.18 |
| ORM | MyBatis-Plus | 3.5.2 |
| 安全认证 | Spring Security + JWT (auth0) | 4.4.0 |
| 数据库 | MySQL | 8.0+ |
| 缓存 | Redis (Jedis) | - |
| 工具库 | Hutool | 5.8.20 |
| API 文档 | Knife4j (Swagger) | 4.3.0 |
| 前端框架 | Vue 3 + Vite | 3.3 / 4.4 |
| UI 组件库 | Element Plus | 2.3.9 |
| 状态管理 | Pinia | 2.1.6 |
| HTTP 客户端 | Axios | 1.5.0 |

### 项目结构

```
├── homestay-booking/          # 后端 Spring Boot 项目
│   ├── src/main/java/com/homestay/
│   │   ├── controller/        # REST 控制器
│   │   ├── service/           # 业务逻辑层
│   │   ├── mapper/            # MyBatis Mapper 接口
│   │   ├── entity/            # 数据库实体
│   │   ├── dto/               # 数据传输对象
│   │   ├── vo/                # 视图对象
│   │   ├── config/            # Spring 配置
│   │   └── utils/             # 工具类
│   ├── src/main/resources/
│   │   ├── application.yml    # 主配置文件
│   │   └── init.sql           # 数据库初始化脚本
│   └── pom.xml
│
└── homestay-booking-web/      # 前端 Vue 3 项目
    ├── src/
    │   ├── api/               # API 调用
    │   ├── components/        # 公共组件
    │   ├── views/             # 页面视图
    │   ├── stores/            # Pinia 状态管理
    │   ├── utils/             # 工具函数
    │   └── layout/            # 布局组件
    ├── vite.config.js
    └── package.json
```

---

## 2. 环境要求

| 依赖 | 最低版本 | 用途 |
|------|---------|------|
| JDK | 17 | 编译运行后端 |
| Maven | 3.6+ | 后端构建 |
| Node.js | 16+ | 前端构建运行 |
| npm | 8+ | 前端包管理 |
| MySQL | 8.0+ | 主数据库 |
| Redis | 6.0+ | 缓存/JWT 黑名单 |

---

## 3. 前置依赖安装

### 3.1 安装 JDK 17

```bash
# 下载地址: https://www.oracle.com/java/technologies/javase/jdk17-archive-downloads.html
# 安装后验证
java -version
# 预期输出: openjdk version "17.x.x"
```

### 3.2 安装 Maven

```bash
# 下载地址: https://maven.apache.org/download.cgi
# 解压后添加到系统 PATH，验证
mvn -version
# 预期输出: Apache Maven 3.x.x
```

### 3.3 安装 Node.js

```bash
# 下载地址: https://nodejs.org/ (推荐 LTS 版本)
node -v   # >= 16
npm -v    # >= 8
```

### 3.4 安装并启动 MySQL

```bash
# 创建数据库用户（或使用 root）
mysql -u root -p
```

在 MySQL 中执行：

```sql
CREATE USER 'XRXRXR'@'localhost' IDENTIFIED BY 'XRXRXR';
GRANT ALL PRIVILEGES ON XRXRXR.* TO 'XRXRXR'@'localhost';
FLUSH PRIVILEGES;
EXIT;
```

> 也可直接修改 `application.yml` 中的 `datasource.username` / `datasource.password` 为你的 MySQL 凭据。

### 3.5 安装并启动 Redis

```bash
# Windows: https://github.com/tporadowski/redis/releases
# 启动 Redis (默认端口 6379)
redis-server
```

> 注意：如 Redis 设置了密码，修改 `application.yml` 中的 `spring.redis.password`。

---

## 4. 项目克隆与初始化

```bash
# 克隆或解压项目到本地
cd c:\Users\xr\Desktop\民宿预约管理系统

# 项目包含两个子目录:
#   homestay-booking/      — 后端
#   homestay-booking-web/  — 前端
```

### 4.1 初始化数据库

方式一：直接执行 SQL 脚本（包含建表 + 20个民宿 + 49个房型 + 测试用户 + 评价数据）

```bash
mysql -u XRXRXR -pXRXRXR < homestay-booking/src/main/resources/init.sql
```

方式二：项目首次启动时通过 `DatabaseMigration` 自动补齐缺失数据（推荐）。

---

## 5. 配置文件说明

### 5.1 后端配置 `application.yml`

```yaml
# 服务端口
server.port: 8080                      # 可修改

# 数据库连接
spring.datasource.url                   # 默认 jdbc:mysql://localhost:3306/XRXRXR
spring.datasource.username              # 默认 XRXRXR
spring.datasource.password              # 默认 XRXRXR

# Redis 连接
spring.redis.host: localhost
spring.redis.port: 6379
spring.redis.password: 204725           # 按实际修改

# JWT 配置
jwt.secret: homestay_secret_key_2024    # 生产环境请更换
jwt.expiration: 604800000               # 7 天 (毫秒)

# 文件上传路径
upload.path: ./uploads                  # 本地存储路径，按需修改

# 邮件配置（可选，不配置不影响核心功能）
spring.mail.host: smtp.qq.com
spring.mail.username:                   # 留空则禁用
spring.mail.password:                   # 留空则禁用
```

### 5.2 前端配置 `vite.config.js`

```js
server: {
  port: 3000,                           // 前端开发端口
  proxy: {
    '/api': { target: 'http://localhost:8080' },    // API 代理到后端
    '/uploads': { target: 'http://localhost:8080' }  // 静态资源代理
  }
}
```

---

## 6. 开发环境启动

### 6.1 启动后端

```bash
# Windows PowerShell
cd homestay-booking

# 编译 + 启动
mvn.cmd clean package -DskipTests -q
java -jar target/homestay-booking-1.0.0.jar
```

后端启动成功标志：

```
Started HomestayApplication in X.XXX seconds
Database migration: refreshed 20 homestay ratings/counts.
```

### 6.2 启动前端

```bash
# 新开一个终端
cd homestay-booking-web

# 安装依赖（首次运行）
npm install

# 启动开发服务器
npm run dev
```

前端启动成功标志：

```
VITE v4.x.x  ready in xxx ms
➜  Local:   http://localhost:3000/
```

### 6.3 访问系统

| 服务 | 地址 |
|------|------|
| 前端页面 | http://localhost:3000 |
| 后端 API | http://localhost:8080/api |
| API 文档 (Knife4j) | http://localhost:8080/doc.html |

---

## 7. 生产环境部署

### 7.1 后端打包

```bash
cd homestay-booking
mvn.cmd clean package -DskipTests
# 产物: target/homestay-booking-1.0.0.jar
```

运行：

```bash
# 指定外部配置文件
java -jar homestay-booking-1.0.0.jar --spring.config.location=./application-prod.yml

# 或使用环境变量覆盖关键配置
java -jar homestay-booking-1.0.0.jar \
  -Dspring.datasource.password=your_password \
  -Dspring.redis.password=your_redis_password \
  -Djwt.secret=your_secret_key
```

### 7.2 前端打包

```bash
cd homestay-booking-web
npm run build
# 产物: dist/ 目录
```

将 `dist/` 目录部署到 Nginx 或与后端 jar 包同目录。Nginx 配置示例：

```nginx
server {
    listen       80;
    server_name  localhost;

    # 前端静态资源
    location / {
        root   /path/to/dist;
        index  index.html;
        try_files $uri $uri/ /index.html;
    }

    # API 代理到后端
    location /api/ {
        proxy_pass http://127.0.0.1:8080;
        proxy_set_header Host $host;
        proxy_set_header X-Real-IP $remote_addr;
    }

    # 上传文件代理
    location /uploads/ {
        proxy_pass http://127.0.0.1:8080;
    }
}
```

### 7.3 生产环境检查清单

- [ ] 修改 `jwt.secret` 为随机强密钥
- [ ] 修改数据库密码，不使用默认凭据
- [ ] Redis 设置强密码
- [ ] 配置邮件服务 (smtp)
- [ ] `upload.path` 指向持久化存储路径
- [ ] 关闭 MyBatis SQL 日志：删除 `mybatis-plus.configuration.log-impl`
- [ ] 修改 `logging.level` 为 `INFO` 或 `WARN`

---

## 8. 测试账号

| 角色 | 用户名 | 密码 |
|------|--------|------|
| 管理员 | admin | 123456 |
| 副管理员 | admin2 | 123456 |
| 房东 | host_beijing | 123456 |
| 房东 | host_dali | 123456 |
| 房东 | host_hangzhou | 123456 |
| 房东 | host_chengdu | 123456 |
| 房东 | host_xiamen | 123456 |
| 用户 | zhangsan | 123456 |
| 用户 | lisi | 123456 |
| 用户 | wangwu | 123456 |
| 用户 | zhaoliu | 123456 |
| 用户 | sunqi | 123456 |

---

## 9. 常见问题排查

### 9.1 后端启动失败

**端口被占用 (8080)**

```bash
# 查找并停止占用进程
netstat -ano | findstr 8080
taskkill /PID <PID> /F
```

**MySQL 连接失败**

```
Communications link failure
```

- 确认 MySQL 服务已启动
- 确认 `application.yml` 中数据库地址、用户名、密码正确
- 确认数据库 `XRXRXR` 已创建

**Redis 连接失败**

```
Unable to connect to Redis
```

- 确认 Redis 服务已启动
- 确认 `spring.redis.password` 配置正确

**Maven 编译失败 (jar 文件被占用)**

```bash
# 先停止后端进程再编译
taskkill /F /IM java.exe 2>$null
mvn.cmd clean package -DskipTests
```

### 9.2 前端启动失败

**npm install 报错**

```bash
# 清除缓存重试
npm cache clean --force
rm -r node_modules package-lock.json
npm install
```

**Vite 启动后页面空白**

- 确认后端已启动且可访问 http://localhost:8080/api
- 检查浏览器控制台是否有 CORS 错误
- 确认 `vite.config.js` 中 proxy target 指向正确的后端地址

### 9.3 登录失败

- 确认数据库已执行 `init.sql`
- 所有测试账号密码均为 `123456`
- 如数据库重新初始化，密码已 Bcrypt 加密，无法直接修改为明文

### 9.4 上传文件失败

- 确认 `upload.path` 目录可写
- 文件大小限制：单文件 10MB (FileController) / 头像 2MB (UserController)
- 仅支持 `image/*` 和 `video/*` MIME 类型

### 9.5 评价数量与星级不一致

系统每次启动时会通过 `DatabaseMigration` 自动同步：
- 根据 `review` 表实际数据重新计算 `homestay.review_count`
- 根据实际评分的平均值更新 `homestay.rating`

---

## 10. 启动验证方法

### 10.1 后端健康检查

```bash
# 登录获取 Token
curl -X POST http://localhost:8080/api/user/login \
  -H "Content-Type: application/json" \
  -d '{"username":"zhangsan","password":"123456"}'

# 获取民宿列表（公开接口）
curl http://localhost:8080/api/homestay/list?page=1&size=5
```

预期返回包含 20 个民宿的分页数据。

### 10.2 前端功能验证

1. 打开 http://localhost:3000
2. 首页应展示民宿列表卡片（含封面图、名称、评分、评价数）
3. 点击卡片进入详情页
4. 切换"写评价"按钮可弹出写评价弹窗
5. 点击"收藏"图标（需登录）
6. 点击房间图片可查看该房型评价

### 10.3 成功标准

| 检查项 | 预期结果 |
|--------|---------|
| 后端启动 | `Started HomestayApplication` 日志 + 端口 8080 监听 |
| 前端启动 | Vite dev server 运行在 3000 端口 |
| 首页加载 | 展示 20 个民宿卡片 |
| 民宿详情 | 展示图片、房型、设施、评价 |
| 用户登录 | 使用测试账号可成功登录 |
| API 文档 | http://localhost:8080/doc.html 可访问 |
| 文件上传 | 头像/图片上传返回 `/uploads/...` URL |
| 评价功能 | 登录用户可提交评价、查看房间评价 |
