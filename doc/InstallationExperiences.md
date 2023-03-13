# Installation Experiences

The following experiences are based on OpenStudyBuilder v0.3. Details instructions and hints are available on the projects [readme file](https://gitlab.com/Novo-Nordisk/nn-public/openstudybuilder/OpenStudyBuilder-Solution/-/blob/main/README.md).

## System & pre-requisites 

I am using a Windows 10 system having Docker, php and composer and many other things installed. Also WSL had to be installed. Please checkout the [software dependencies](https://gitlab.com/Novo-Nordisk/nn-public/openstudybuilder/OpenStudyBuilder-Solution#software-dependencies) in the OpenStudyBuilder readme.

I need to remove old instances using the same names/ports from docker to install a new one (start docker, select the outdaten OpenStudyBuilder, delete). In case you get an issue `error during connect: this error may indicate that the docker daemon is not running:` - start Docker Desktop application.

## Install Solution

Open the command line and download + install via docker with the following steps in the console:

- change to your install location
- clone the repository (in the example I gave it a different name)
- change into that repository
- run the docker compose

```
cd c:\myInstallLocation
git clone https://gitlab.com/Novo-Nordisk/nn-public/openstudybuilder/OpenStudyBuilder-Solution.git OpenStudyBuilder-0.3
docker compose up -d --build
```

To check that the application is up and running you can start it [http://localhost:5005/](http://localhost:5005/).

## Install Test Data

The installation needed time and finished successfully. As documented, this does not contain the test data which needs to be installed additionally following the "data-import" instructions in that [readme](https://gitlab.com/Novo-Nordisk/nn-public/openstudybuilder/OpenStudyBuilder-Solution/-/blob/main/data-import/README.md). Make sure that the docker environment is up. 

The following steps needs to be performed:

- Change to data-import directory
- Install the environment
- create/update the .env file
- Import all test data

```
cd data-import
pip install pipenv
```

Copy the .env.import file to .env and change the URL to http://localhost:5003. You might have changed the ports before the install, then you need to use port numbers as choosen

```
pipenv run import_all
```

### Test data issues

In case the pipenv install did not install all required packages, you could install the package via an additional command. This might be required if you for example receive the following error: `ModuleNotFoundError: No module named 'aiohttp'`.

```
pipenv install aiohttp
```

The test data provision might not perfectly working when timeout issues arise. This does not have priority and for this not everything is running smoothly. 

My latest data-import run without any issues. Nethertheless, on my first installation I received the following error:

```
ConnectionResetError: [WinError 10054] Eine vorhandene Verbindung wurde vom Remotehost geschlossen
```

This error seems to be within the `mockdata_json` import (that had been the last one running).

When checking the import order on the readme, you could see that the `mockdatajson` is already the last step of the importing. It is not critical that the test data did not completely had been uploaded. If you script fails earlier, you might want to run the imports step by step

## Restart Docker

In windows I do not have the docker deamon up and running immediately. To start the docker environment, I use "Docker Desktop". As the containers have to start in a specific order, the automatic start does not work. You have to manually click "play" for all components:

![Start docker container](./img/install_docker_start.png)

## Issues with API Swagger documentation

The Swagger API documentation where you can directly execute API calls should be available via one or the other link:

- http://localhost:5003/docs
- http://localhost:5005/api/docs

There could either be messages like "openapi.json not found" or when you execute an API you get an HTML as return stating: "We're sorry but studybuilder doesn't work properly without JavaScript enabled. Please enable it to continue.".

If neither is working, then there are some issues with the root path of your container. To fix this, you can update the `apidockerfile` in the repository.

Change `CMD pipenv run uvicorn clinical_mdr_api.main:app` to `CMD pipenv run uvicorn clinical_mdr_api.main:app --root-path "/"`.

Then rebuild the container. Open the command line, go into the repositorys folder and run the following two commands:

```
docker compose build --no-cache api
docker-compose up --force-recreate api
```
