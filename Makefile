# Names of services to manage
NAME = inception

# File paths
COMPOSE_FILE = srcs/docker-compose.yml
DATA_DIR = /home/kpineda-/data

# Main rule: starts the containers in the background and builds them if necessary
all: up

up:
	@mkdir -p $(DATA_DIR)/mariadb
	@mkdir -p $(DATA_DIR)/wordpress
	sudo docker compose -f $(COMPOSE_FILE) up -d --build

# Stops containers without deleting data
down:
	sudo docker compose -f $(COMPOSE_FILE) down

# Stops containers and removes Docker images, networks, and volumes
clean: down
	sudo docker compose -f $(COMPOSE_FILE) down --rmi all --volumes

# Deep thorough clean: also removes the physical data folders on your local machine
fclean: clean
	sudo docker system prune -a --volumes -f
	sudo rm -rf $(DATA_DIR)/mariadb/*
	sudo rm -rf $(DATA_DIR)/wordpress/*

# Rebuilds everything from absolute scratch
re: fclean all

.PHONY: all up down clean fclean re
