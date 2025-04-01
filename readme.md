Установка PostgreSQL на удаленный хост
=========

Установка, настройка и запуск PostgreSQL на удаленном хосте. Скрипт протестирован на дистрибутивах: Debian 11, 12; CentOS 7; CentOS Stream 9; Almalinux 8, 9.


Requirements
------------
Переименовать `.env.tmpl` в `.env`.

Variables
---------
Пароль от `postgres` передается в файле `.env`. В файле `ansible/roles/pg_inst/vars/main.yml` задать версию и каталог установки postgresql.

Example Playbook
----------------

Подготовка виртуального окружения для ansible и развертывание серверов с помощью terraform
```
make prepare
```

Установка postgres на наименее нагруженный сервер, из развернутых в облаке терраформом
```
make
```

Установка postgres на наименее нагруженный сервер из списка серверов
```
make pg_deploy inventory=ip1,ip2,...
```
