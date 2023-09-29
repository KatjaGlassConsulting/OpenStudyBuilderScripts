# Use Case - Metadata repository

This documentation should help you in case you want to use the OpenStudyBuilder as a metadata repository and not to setup studies and similar. This shows how to setup the metdata starting with a clean database.

## Docker installation & fresh database

When using the docker-installation approach, the example data is always installed along. But the content can be removed afterwards to start with a clean empty database (containing all required items).

```
git clone https://gitlab.com/Novo-Nordisk/nn-public/openstudybuilder/OpenStudyBuilder-Solution.git
cd OpenStudyBuilder

docker compose build
docker compose up
```

To cleanup the database, a script can be used which is located in the neo4j-mdr-db. To run the scripts, prepare the environment as described in the README of neo4j-mdr-db.

```
cd neo4j-mdr-db
pip install pipenv
```

Create .env - copy the first values from your root/.env file, set the CLEAR variable to true and the backup to true (unless you want differently)

```
NEO4J_MDR_HTTP_PORT=7474
NEO4J_MDR_BOLT_PORT=7687
NEO4J_MDR_HTTPS_PORT=443
NEO4J_MDR_HOST=localhost
NEO4J_MDR_AUTH_USER=neo4j
NEO4J_MDR_AUTH_PASSWORD=changeme1234
NEO4J_MDR_DATABASE=mdrdb

NEO4J_MDR_CLEAR_DATABASE=true
NEO4J_MDR_BACKUP_DATABASE=true
```

Install environment and run the init program

```
pipenv install
pipenv run init_neo4j
```