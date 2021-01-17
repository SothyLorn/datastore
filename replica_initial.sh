#!/bin/bash
echo "Started Replica Set Mapping ..."

echo "Waiting for startup.."
until mongo --host mongo1:27017 --eval 'quit(db.runCommand({ ping: 1 }).ok ? 0 : 2)' &>/dev/null; do
  printf '.'
  sleep 5
done

mongo --host mongo1:27017 <<EOF
    var c = {
        "_id": "rs1",
        "members": [
            {
                "_id": 0,
                "host": "${HOST}:30011",
                "priority": 3
            },
            {
                "_id": 1,
                "host": "${HOST}:30012",
                "priority": 2
            },
            {
                "_id": 2,
                "host": "${HOST}:30013",
                "priority": 1
            },
            {
                "_id": 3,
                "host": "${HOST}:30014",
                "arbiterOnly" : true,
                "priority": 0
            }
        ]
    };
    rs.initiate(c);
EOF