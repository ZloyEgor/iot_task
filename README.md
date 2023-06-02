# Предварительная инициализация
___
### Инициализация `docker swarm`
Первым делом инициализируем `docker swarm`.
```shell
docker swarm init
```
### Создание overlay сети для сервисов
```shell
docker network create --driver overlay --attachable iot-task-overlay
```
# Запуск
___
### Запуск `docker-compose.yml`
Открыть терминал в директории проекта, ввести следующую команду: 
```shell
docker compose up
```
### Настройка коннекторов баз данных к kafka
Откроем оболочку `shell` внутри контейнера `iot-connector-setter`:
```shell
docker compose exec -it iot-connector-setter sh
```
Внутри оболочки выполним последовательность команд для подключения коннекторов к `iot-db-source` и `iot-db-target`:
```shell
cd ~
./set-connectors.sh
```
# Работа с БД
___
### Работа с `iot-db-source`:
Подключимся к `mongosh` внутри контейнера БД:
```shell
docker compose exec -it iot-db-source mongosh
```
Добавим тестовые данные:
```mongosh
db.users.insertOne({
  "firstname": String("biba"),
  "age": Number(6),
  "email": String("biba@niuitmo.ru")
})

db.users.insertOne({
  "firstname": String("boba"),
  "age": Number(7),
  "email": String("boba@itmo.ru")
})

db.users.insertOne({
  "firstname": String("Amogus"),
  "lastname": String("Amogusovich"),
  "age": Number(777),
  "email": String("amogus@test.com")
})
```
### Проверка данных в `iot-db-target`:
Аналогично подключимся к `mongosh` внутри `iot-db-target`:
```shell
docker compose exec -it iot-db-target mongosh
```
Проверим наличие тестовых данных:
```mongosh
db.users.find()
```
# Дополнительно: `kafka-ui`
___
На порту `8080` работает `kafka-ui`. 
В нем можно просматривать и управлять топиками, сообщениями и группами потребителей в Apache Kafka.
