import:
	docker run --rm -v ./data/:/opt/data/ --network db-networks -it postgres:9.6.16 psql -h sharding-sphere-proxy -U gisdb -p 3308 -f /opt/data/data.sql postgres

gen_data:
	python ./scripts/generate_data.py

client:
	docker run --rm --name psql-client -v  --network db-networks -it postgres:9.6.16 psql -h sharding-sphere-proxy -U gisdb -p 3308 postgres


startup:
	docker-compose up -d --remove-orphans
