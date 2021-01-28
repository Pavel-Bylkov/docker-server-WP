# docker-server-WP
Учебный проект - Цель: собрать докер коетейнер с сайтом на WordPress

Это проект системного администрирования. 
Веб-сервер, установленный с использованием технологии «докер», на котором работают Wordpress, phpMyAdmin и база данных SQL.

# Использование

```shell
# build image:
docker build -t server:final .

# launch container:
docker run --name server -p 80:80 -p 443:443 -it -d server:final

# run a command in running container (eg. to go "in" launched contaner):
docker exec -it server bash

# stop container:
docker stop server

# start previously stopped container:
docker start server

# remove container:
docker rm server

# remove image
docker rmi server:final

# stop all containers
docker stop $(docker ps -qa)

# remove all containers
docker rm $(docker container ls -qa)

# remove all images
docker rmi $(docker image ls -qa)
