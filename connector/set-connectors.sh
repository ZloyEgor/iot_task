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

curl -X POST \
     -H "Content-Type: application/json" \
     --data '
{
  "name": "mongo-test-users-sink",
  "config": {
    "connector.class":"com.mongodb.kafka.connect.MongoSinkConnector",
    "connection.uri":"mongodb://iot-db-target:27017/?replicaSet=myRS",
    "database":"test",
    "collection":"users",
    "topics":"test.users",
    "writemodel.strategy":"com.mongodb.kafka.connect.sink.writemodel.strategy.ReplaceOneDefaultStrategy",
    "change.data.capture.handler": "com.mongodb.kafka.connect.sink.cdc.mongodb.ChangeStreamHandler"
  }
}
' \
http://iot-kafka-connect:8083/connectors -w "\n"