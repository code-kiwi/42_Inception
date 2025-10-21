# **************************************************************************** #
#                                                                              #
#                                                         :::      ::::::::    #
#    Makefile                                           :+:      :+:    :+:    #
#                                                     +:+ +:+         +:+      #
#    By: mhotting <mhotting@student.42lyon.fr>      +#+  +:+       +#+         #
#                                                 +#+#+#+#+#+   +#+            #
#    Created: 2025/10/20 11:29:32 by mhotting          #+#    #+#              #
#    Updated: 2025/10/21 08:25:59 by mhotting         ###   ########.fr        #
#                                                                              #
# **************************************************************************** #

NAME				=	inception

DOCKER_COMPOSE_FILE	=	./srcs/docker-compose.yml
DOCKER_COMPOSE_CMD	=	docker compose -f $(DOCKER_COMPOSE_FILE) -p $(NAME)

DATA_DIR			=	$(HOME)/data/
DB_DIR				=	$(DATA_DIR)mariadb
WP_DIR				=	$(DATA_DIR)wordpress

all: up

up: $(DATA_DIR) $(WP_DIR)
	cp -n $(HOME)/.env ./srcs || true
	$(DOCKER_COMPOSE_CMD) up --build -d

down:
	$(DOCKER_COMPOSE_CMD) down

stop:
	$(DOCKER_COMPOSE_CMD) stop

restart:
	$(DOCKER_COMPOSE_CMD) restart

clean:
	$(DOCKER_COMPOSE_CMD) down --volumes --rmi all --remove-orphans

fclean: clean
	rm -rf $(DATA_DIR)

re: fclean all

$(DB_DIR):
	mkdir -p $(DB_DIR)

$(WP_DIR):
	mkdir -p $(WP_DIR)

.PHONY: all up down stop restart clean fclean re
