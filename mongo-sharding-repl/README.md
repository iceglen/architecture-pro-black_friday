# mongo-sharding

## Запуск контейнеров

Запуск mongodb и приложения

```shell
docker compose up -d
```

Инициализируем конфигурационный сервер и шарды

```shell
./utils/mongo-docker-init.sh
```

## Проверка работы шардов

Запускаем вывод количества записей на шардах

```shell
./utils/mongo-docker-test.sh
```

Должны получить вывод с количеством реплик, названием шарда, его типом и количество записей

```log
shard1 [direct: secondary] test> Replicas count: 3
shard1 [direct: secondary] test>

shard2 [direct: primary] test> Replicas count: 3
shard2 [direct: primary] test>

shard1 [direct: primary] test> switched to db somedb
shard1 [direct: primary] somedb> 508
shard1 [direct: primary] somedb>

shard2 [direct: primary] test> switched to db somedb
shard2 [direct: primary] somedb> 492
shard2 [direct: primary] somedb>
```