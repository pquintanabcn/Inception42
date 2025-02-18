
DOCKER_PS = $(docker ps -aq)
DOCKER_IMG = $(docker images -q)

#if pquintan doesnt work because diff pc change for user
up:
		mkdir -p /home/pquintan/data/mysql
		mkdir -p /home/pquintan/data/wordpress
		docker-compose -f ./srcs/docker-compose.yml up -d --build
#should run containers on the background

down:
		docker-compose -f ./srcs/docker-compose.yml down
stop:
		docker-compose -f ./srcs/docker-compose.yml stop
all: up

# logs:

clean:
		rm -rf /home/pquintan/data/mysql/*
		rm -rf /home/pquintan/data/wordpress/*
		docker-compose -f ./srcs/docker-compose.yml rm

fclean:	down clean
		docker stop ${DOCKER_PS} || true
		docker rm ${DOCKER_PS} || true
		docker rmi ${DOCKER_PS} || true
		docker system prune -af --volumes || true
		docker volumes rm srcs_wordpress_data || true
		docker volumes rm srcs_mariadb_data || true


re: fclean all

.PHONY: all clean fclean re up down stop