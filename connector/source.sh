curl -X POST \
     -H "Content-Type: application/json" \
     --data '
{
  "name": "mongodb-test-users-source",
  "config": {
    "connector.class": "com.mongodb.kafka.connect.MongoSourceConnector",
    "connection.uri": "mongodb://iot-db-source:27017/?replicaSet=myRS",
    "change.stream.full.document": "updateLookup",
    "database": "test",
    "collection": "users"
  }
}
' \
http://iot-kafka-connect:8083/connectors -w "\n"
