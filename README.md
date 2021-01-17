# MySQL
```bash
version: "3.5"
services:
  mysql:
    image: mysql:5.7
    hostname: mysql
    container_name: mysql
    restart: always
    ports:
      - "3306:3306"
    environment:
      MYSQL_ROOT_PASSWORD: "dev@123"
      MYSQL_USER: 'dev'
      MYSQL_PASSWORD: 'dev@123'
    volumes:
      - /etc/db-data-dev:/var/lib/mysql
```
# Postgresql
```bash
version: "3.5"
services:
  postgres:
    image: postgres
    hostname: postgres
    container_name: postgres
    restart: always
    ports:
      - "5432:5432"
    environment:
      POSTGRES_USER: "dev"
      POSTGRES_PASSWORD: "dev@123"
    volumes:
      - /etc/db-data:/var/lib/postgresql/data
```
# Mongo
```bash
version: "3.5"
services:
  mongo:
    image: mongo:3.4.18
    container_name: mongo
    volumes:
      - /usr/data/mongodb/db:/data/db
    ports:
      - "27017:27017"
    environment:
      - MONGO_INITDB_ROOT_USERNAME=dev
      - MONGO_INITDB_ROOT_PASSWORD=dev@123
```
# Mongo Replication
```bash
version: "3.5"
services:
  mongo1:
    container_name: mongo1
    image: mongo:4.0.6
    networks:
      - mongo_cluster
    volumes:
      - /usr/data/mongodb_1:/data/db
    ports:
      - 30011:27017
    command: mongod --replSet rs1 --port 27017 --shardsvr --bind_ip_all  --oplogSize 16 --noprealloc --smallfiles
  mongo2:
    container_name: mongo2
    image: mongo:4.0.6
    volumes:
      - /usr/data/mongodb_2:/data/db
    networks:
      - mongo_cluster
    ports:
      - 30012:27017
    command: mongod --replSet rs1 --port 27017 --shardsvr --bind_ip_all  --oplogSize 16 --noprealloc --smallfiles
  mongo3:
    container_name: mongo3
    image: mongo:4.0.6
    volumes:
      - /usr/data/mongodb_3:/data/db
    networks:
      - mongo_cluster
    ports:
      - 30013:27017
    command: mongod --replSet rs1 --port 27017 --shardsvr --bind_ip_all  --oplogSize 16 --noprealloc --smallfiles
  mongo_abiter:
    container_name: mongo_abiter
    image: mongo:4.0.6
    volumes:
      - /usr/data/mongodb_abiter:/data/db
    networks:
      - mongo_cluster
    ports:
      - 30014:27017
    command: mongod --replSet rs1 --port 27017 --shardsvr --bind_ip_all  --oplogSize 16 --noprealloc --smallfiles
  mongo_setup:
    container_name: mongo_setup
    image: mongo:4.0.6
    depends_on:
      - mongo1
      - mongo2
      - mongo3
      - mongo_abiter
    networks:
      - mongo_cluster
    volumes:
      - /root/:/scripts
    environment:
      - HOST=192.168.0.202
    entrypoint: ["bash", "/scripts/replica_initial.sh"]
    
networks:
  mongo_cluster:
    driver: bridge
```
# Redis
```bash
version: "3.5"
services:
  redis:
    container_name: redis
    image: redis
    restart: always
    command: redis-server --requirepass dev@123
    sysctls:
      net.core.somaxconn: '511'
    ports:
      - '6379:6379'
```
# RabitMQ
```bash
version: "3.5"
services:
  rabbitmq:
    image: rabbitmq:3-management
    hostname: rabbit
    container_name: rabbit
    restart: always
    environment:
      RABBITMQ_DEFAULT_USER: "dev"
      RABBITMQ_DEFAULT_PASS: "dev@123"
    ports:
      - "15672:15672"
      - "5672:5672"
```
# Elasticsearch
```bash

```
# APM
```bash

```
# Kibana
```bash

```
# Jaeger
```bash
version: "3.5"
services:
  jaeger:
    image: jaegertracing/all-in-one:1.13
    container_name: jaeger
    hostname: jaeger
    restart: always
    environment:
      COLLECTOR_ZIPKIN_HTTP_PORT: "9411"
    ports:
      - "5775:5775/udp"
      - "6831:6831/udp"
      - "6832:6832/udp"
      - "5778:5778"
      - "16686:16686"
      - "14268:14268"
      - "9411:9411"
```
