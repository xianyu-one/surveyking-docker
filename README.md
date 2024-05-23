# surveyking-docker

surveyking(卷王)容器化构建

## 快速开始

下载初始化脚本，并自动部署至当前文件夹

```shell
https://raw.githubusercontent.com/xianyu-one/surveyking-docker/main/setup.sh -O setup.sh
chmod +x setup.sh
bash setup.sh
```

## 手工部署

### 步骤 1：创建目录并下载必要文件
首先，打开终端并执行以下命令以创建必要的目录结构：

```shell
mkdir -p ./surveyking/mysql
mkdir ./surveyking/sql
cd ./surveyking
```

### 步骤 2：下载初始化 SQL 文件和 Docker Compose 文件
接下来，我们将下载初始化 MySQL 数据库所需的 SQL 文件和 Docker Compose 配置文件：

```shell
wget https://raw.githubusercontent.com/xianyu-one/surveyking-docker/main/sqls/init-mysql.sql -O sqls/init-mysql.sql
wget https://raw.githubusercontent.com/xianyu-one/surveyking-docker/main/docker-compose.yml.example -O docker-compose.yml
```

### 步骤 3：启动 Docker 容器

现在，我们将使用 Docker Compose 启动 SurveyKing 应用程序的容器。确保已经安装了 Docker 和 Docker Compose。执行以下命令：

```shell
docker-compose up -d
```

这将启动 SurveyKing 应用程序的容器，并且该应用程序应该已经在运行中。


### 创建一个


```yaml
services:
  mysql:
    image: mysql:8
    container_name: mysql
    restart: unless-stopped
    environment:
      MYSQL_ROOT_PASSWORD: surveyking
      MYSQL_DATABASE: surveyking
    volumes:
      - ./mysql/conf:/etc/mysqul/conf.d
      - ./mysql/data:/var/lib/mysql
      - ./sqls:/docker-entrypoint-initdb.d
    networks:
      app_net:
        ipv4_address: 10.20.52.20
  surveyking:
    image: mrxianyu/surveyking:latest
    container_name: surveyking
    restart: unless-stopped
    environment:
      MYSQL_USER: root
      MYSQL_PASS: surveyking
      DB_URL: jdbc:mysql://mysql:3306/surveyking
      SERVER_PORT: 1991
    volumes:
      - ./files:/app/files
      - ./logs:/app/logs
    depends_on:
      - mysql
    networks:
      app_net:
        ipv4_address: 10.20.52.10

networks:
  app_net:
    driver: bridge
    enable_ipv6: true
    ipam:
      driver: default
      config:
        - subnet: 10.20.52.0/24
          gateway: 10.20.52.1
        - subnet: FD00:1:1::/64
          gateway: FD00:1:1::1
```