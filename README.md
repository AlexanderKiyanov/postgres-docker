Postgres-docker
=======================

Run PostgreSQL in Docker using docker-compose and customize the configuration file of the official PostgreSQL Docker image.


Run docker-compose
=======================

- [ ] Pull the repository to some directory
```
pull https://github.com/AlexanderKiyanov/postgres-docker.git
```

- [ ] Change the initial user and password
```
vim config/env.prod.db
```

- [ ] Insert any action that has to be executed after database start, for ex. create another user , database and tables.
```
vim config/init.sql
```

- [ ] Change the host ip that shoud have an access to database
```
vim config/pg_hba.conf
```

if you're going to switch scram-sha-256 to md5 you need also to change the line password_encryption = scram-sha-256 in postgresql.conf

- [ ] Run docker container
```
docker-compose up -d
```

- [ ] We can not connect from host directly if there is no psql installed, from other hosts you can connect typing command:
```
psql -h <host-ip> -p 5432 -U name
```

- [ ] also we being able to connect directly from inside the container
```
docker-compose exec -it db psql -h localhost -U name
```

- [ ] To re run container you can type:
```
docker-compose down
rm -rf pg-data
docker-compose up -d
# or
docker-compose up -d --force-recreate --no-deps --build db
```

- [ ] To clean up completely
```
docker system prune
```


Configuration content
=======================

- [ ] Here in docker-compose.yml we set a new custom location /etc/postgresql/postgresql.conf for the postgresql.conf file
```
command: postgres -c 'config_file=/etc/postgresql/postgresql.conf'
```

and also mount this config file from host config directory to container
```
volumes:
  - ./config/postgresql.conf:/etc/postgresql/postgresql.conf
```

- [ ] The postgresql.conf point to our new custom pg_hba.conf
```
hba_file = '/etc/postgresql/pg_hba.conf'# host-based authentication file
```
and also in docker-compose.yml we mount pg_hba.conf from host to container
```
volumes:
   - ./config/pg_hba.conf:/etc/postgresql/pg_hba.conf
```



