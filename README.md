# surveyking-docker


```yaml
version: '3'
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
    build:
      context: .
      dockerfile: Dockerfile
    image: surveyking
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