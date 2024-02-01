import:
	docker run --rm -e PGPASSWORD="gisdb" -v ./data/:/opt/data/ --network db-networks -it postgres:9.6.16  psql -h sharding-sphere-proxy -U gisdb -p 3308 -f /opt/data/data.sql postgres

gen_data_geo:
	python3 ./scripts/generate_data_geo.py

gen_data:
	python3 ./scripts/generate_data.py


client:
	docker run --rm --name psql-client -it -e PGPASSWORD="gisdb" --network db-networks postgres:9.6.16 psql -h sharding-sphere-proxy -U gisdb -p 3308 gisdb

clean:
	docker-compose down

deploy: clean
	docker-compose up -d --remove-orphans

wait:
	./tools/wait-for-it.sh localhost:3308 --timeout=60 --strict
	sleep 35

up: deploy wait import
