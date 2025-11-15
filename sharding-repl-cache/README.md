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

При выполнении запроса GET http://localhost:8080/ получаем ответ следующего вида

```json
{
    "mongo_topology_type": "Sharded",
    "mongo_replicaset_name": null,
    "mongo_db": "somedb",
    "read_preference": "Primary()",
    "mongo_nodes": [
        [
            "mongo_router",
            27020
        ]
    ],
    "mongo_primary_host": null,
    "mongo_secondary_hosts": [],
    "mongo_is_primary": true,
    "mongo_is_mongos": true,
    "collections": {
        "helloDoc": {
            "documents_count": 1000
        }
    },
    "shards": {
        "shard1": "shard1/shard1-1:27018,shard1-2:27021,shard1-3:27022",
        "shard2": "shard2/shard2-1:27019,shard2-2:27023,shard2-3:27024"
    },
    "cache_enabled": true,
    "status": "OK"
}
```

Обращаем внимание на параметра "cache_enabled" и его значение "true".

При выполнении нескольких запросов GET http://localhost:8080/helloDoc/users самым медленным будет первый. Выполнение последующих запросов будет быстрее, так как данные будут кешироваться в REDIS.