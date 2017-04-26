docker-machine start rdw-inspire
@FOR /f "tokens=*" %i IN ('docker-machine env rdw-inspire') DO @%i
SET COMPOSE_CONVERT_WINDOWS_PATHS=1
docker-compose -p rdw up -d