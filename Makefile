up:
		docker-compose up -d
stop:
		docker-compose stop
app:
		docker exec -ti lara_lesson-app-1 bash
db:
		docker exec -ti lara_lesson-db-1 bash -c 'psql -h 127.0.0.1 -p 5432 -U docker -d laravel_development'
