all :
		@if [ ! -f srcs/.env ]; then \
			echo ".env file not found, here is an exemple of what it should contains :";\
			echo "MARIADB_DATABASE= <= mariadb database name (default is mariadb)";\
			echo 'MARIADB_PORT= <= mariadb port \(default is 3306\)';\
			echo 'MARIADB_HOST= <= mariadb host \(default is mariadb\)';\
			echo 'DATADIR=/var/lib/mysql';\
			echo 'ROOT_PASSWORD= <= root password';\
			echo "";\
			echo '# wordpress';\
			echo 'WP_TITLE="" <= wordpress title';\
			echo 'WP_EMAIL="" <= admin email';\
			echo 'WP_ADMIN_USER="" <= admin user';\
			echo 'WP_ADMIN_PWD="" <= admin password';\
			echo "";\
			echo 'AUTHOR_NAME="" <= author name';\
			echo 'AUTHOR_PASS="" <= author password';\
			echo 'AUTHOR_EMAIL="" <= author email';\
			echo "";\
			exit 1; \
		fi
		@if [ -d /home/${USER}/data/mariadb ]; then \
        		echo "[✅] The directory mariadb in data already exists"; \
    		else \
        		mkdir -p /home/${USER}/data/mariadb; \
			echo "[✅] The directory mariadb in data just been created"; \
    		fi
		@if [ -d /home/${USER}/data/wordpress ]; then \
        		echo "[✅] The directory wordpress in data already exists"; \
    		else \
        		mkdir -p /home/${USER}/data/wordpress; \
			echo "[✅] The directory wordpress in data has just been created"; \
		fi
		cd srcs; docker-compose up
clean:
		cd srcs; docker-compose down

fclean: 	clean
		docker system prune --all --force
		sudo rm -rf /home/${USER}/data/*

re: 		fclean all

.PHONY: all clean fclean re
