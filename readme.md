# 技术方案参见：
雨雀公开文档

## 简介
https://www.yuque.com/yuque-nepic/bu6df4/hgmuhq9192h2yn32/

## 基于R树的Megre操作的调研
https://www.yuque.com/yuque-nepic/bu6df4/vkc6omgpin22yf8c?singleDoc
## 启动指令
在测试目录中，执行以下命令来启动应用程序：

``` shell
docker-compose up --remove-orphans
```

如果你想在后台执行该服务可以加上 -d 参数：

``` shell
docker-compose up -d --remove-orphans
```

客户端连接：

```shell
docker run --rm --name psql-client -v ./data/:/opt/data/ --network db-networks -it postgres:9.6.16 psql -h sharding-sphere-proxy -U gisdb -p 3308 postgres

password: gisdb

\c gisdb
```

数据批量导入

``` shell
docker run --rm -v ./data/:/opt/data/ --network db-networks -it postgres:9.6.16 psql -h sharding-sphere-proxy -U gisdb -p 3308 -f /opt/data/data.sql postgres

```

停机参数：

```
docker-compose down
```

## 测试手段：

使用pgbench压测，请参见如下命令：

## 文件目录说明

``` shell

├─conf 配置文件
├─conf-template 配置文件模板没啥用
├─resources 资源文件
│  └─timescaledb01
├─scripts python脚本库
└─tools 辅助脚本

```

## 执行查询

``` sql

/* ShardingSphere hint: disableAuditNames=sharding_key_required_auditor */
select * from time_series;
/* ShardingSphere hint: disableAuditNames=sharding_key_required_auditor */
select * from job;
/* ShardingSphere hint: disableAuditNames=sharding_key_required_auditor */
SELECT count(*)
FROM (
	SELECT lon, lat
	FROM time_series
	WHERE EXISTS (
		SELECT *
		FROM job
		WHERE job.id = 1
			AND time_series.time BETWEEN job.start_time AND job.end_time
	)
) time_series;

/* ShardingSphere hint: disableAuditNames=sharding_key_required_auditor */

SELECT count(*)
FROM time_series
WHERE EXISTS (
    SELECT *
    FROM job
    WHERE job.id = 1
);

```


# Q&A
## 1. /usr/bin/env: 'bash\r' : NO such file or directory.

此问题常见于Windows机器下，遇到请检查 `./tools/wait-for-it.sh` 的文件编码是LF而不是CRLF 格式。