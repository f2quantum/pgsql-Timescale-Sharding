# 技术方案参见：
雨雀公开文档
https://www.yuque.com/yuque-nepic/bu6df4/hgmuhq9192h2yn32/

## 启动指令
在测试目录中，执行以下命令来启动应用程序：

``` shell
docker-compose up --remove-orphans
```

如果你想在后台执行该服务可以加上 -d 参数：

``` shell
docker-compose up -d --remove-orphans
```

停机参数：

```
docker-compose down
```

## 测试手段：

使用pgbench压测，请参见如下命令：

