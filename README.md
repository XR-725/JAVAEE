# 民宿预约管理系统

> 全栈 Web 应用（前后端分离架构）· 三角色权限体系（管理员 / 房东 / 用户）

---

## 目录结构

```
民宿预约管理系统/
├── README.md                  ← 本文件（目录索引）
│
├── docs/                      ← 项目文档
│   ├── qd.md                      项目启动指南
│   ├── 用户账户信息.md              测试账户（管理员/房东/用户）
│   └── 民宿预约管理系统-技术详解文档.md  完整功能与代码实现文档
│
├── homestay-booking/          ← 后端项目（Spring Boot 2.7 + Java 17）
│   ├── pom.xml                    Maven 依赖配置
│   ├── start-backend.bat          Windows 一键启动脚本
│   ├── mvnw.cmd                   Maven Wrapper
│   ├── src/                       源代码
│   ├── target/                    构建产物（可由 mvnw 重新生成）
│   └── uploads/                   用户上传数据（⚠ 真实数据，勿删）
│
├── homestay-booking-web/      ← 前端项目（Vue 3 + Vite + Element Plus）
│   ├── package.json               npm 依赖配置
│   ├── vite.config.js             Vite 构建配置
│   ├── index.html                 入口 HTML
│   ├── src/                       源代码
│   ├── dist/                      构建产物（可由 npm run build 重新生成）
│   └── node_modules/              依赖包（可由 npm install 重新生成）
│
├── .idea/                     ← IntelliJ IDEA 配置
└── .vscode/                   ← VS Code 配置
```

---

## 技术栈速览

| 层级 | 技术 | 版本 |
|------|------|------|
| 后端框架 | Spring Boot | 2.7.18 |
| JDK | Java | 17 |
| ORM | MyBatis-Plus | 3.5.2 |
| 安全认证 | Spring Security + JWT | 4.4.0 |
| 数据库 | MySQL | 8.0+ |
| 缓存 | Redis | 6.0+ (Jedis) |
| 前端框架 | Vue 3 | 3.3.4 |
| 构建工具 | Vite | 4.4.9 |
| UI 组件库 | Element Plus | 2.3.9 |
| 状态管理 | Pinia | 2.1.6 |
| 路由 | Vue Router | 4.2.4 |
| HTTP | Axios | 1.5.0 |

---

## 快速启动

### 1. 环境准备
- JDK 17
- MySQL 8.0+
- Redis 6.0+
- Node.js 16+（前端构建）

### 2. 启动后端（homestay-booking）

```bash
# 方式一：双击启动脚本
start-backend.bat

# 方式二：命令行
cd homestay-booking
./mvnw.cmd spring-boot:run
```

首次启动会自动下载数据库初始化脚本并建表。

### 3. 启动前端（homestay-booking-web）

```bash
cd homestay-booking-web
npm install        # 首次需要安装依赖
npm run dev        # 启动开发服务器
```

### 4. 访问系统

测试账户详见 `docs/用户账户信息.md`。

---

## 文档入口

| 想看什么 | 看哪个文档 |
|---------|-----------|
| 怎么把项目跑起来 | `docs/qd.md` |
| 测试账号密码 | `docs/用户账户信息.md` |
| 系统功能/代码实现细节 | `docs/民宿预约管理系统-技术详解文档.md` |

---

## 备注

- `homestay-booking/target/`、`homestay-booking-web/dist/`、`homestay-booking-web/node_modules/` 均为构建产物，可随时重新生成，不影响源码。
- `homestay-booking/uploads/` 为用户上传的真实数据，请勿删除。
