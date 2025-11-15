#!/bin/bash

# replica count test

docker compose exec -T shard1-1 mongosh --port 27018 --quiet <<EOF
print("Replicas count:", rs.status().members.length);
exit();
EOF
echo

docker compose exec -T shard2-1 mongosh --port 27019 --quiet <<EOF
print("Replicas count:", rs.status().members.length);
exit();
EOF
echo

# shard1 test

docker compose exec -T shard1-1 mongosh --port 27018 --quiet <<EOF
use somedb;
db.helloDoc.countDocuments();
exit();
EOF
echo

# shard2 test

docker compose exec -T shard2-1 mongosh --port 27019 --quiet <<EOF
use somedb;
db.helloDoc.countDocuments();
exit();
EOF
echo