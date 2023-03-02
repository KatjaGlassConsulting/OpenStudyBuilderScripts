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

## Install CDISC Controlled Terminology

The initial data does contain a few CDISC CTs, but not all. To load also other CTs, there scripts are available in the "mdr-standards-import" part of the repository (see [here](https://gitlab.com/Novo-Nordisk/nn-public/openstudybuilder/OpenStudyBuilder-Solution/-/tree/main/mdr-standards-import)).

To be able to use the CDISC Library API, you need to create an account and get an authentication token for this. You can register or log into the library here: https://library.cdisc.org/browser. In the CDISC Library browser, go to settings (top-right), then "API Portal". Under "API Key", the primary key is shown and can be copied.



Additionally create the folder "cdisc_data/packages" to store the CDISC library download intermediately. Please note the port numbers - when docker is used these are 5001 (HTTP) and 5002 (BOLT) and the default password is "changeme1234". Please note as well that you have to provide the full absolute path as parameter in the download call.


As in the explanation, we need to run `pipenv install` to setup the environment and install all required packages. We also need to create the folder. "cdisc_data/packages" to store the CDISC library download intermediately.

```
cd <path>/mdr-standards-import
pipenv install
mkdir cdisc_data\packages
```

Finally we also need to create the .env file - by using the docker environment, we have to use 5002 (BOLT) as port numbers and the default password of "changeme1234". Also include your personal library token (`<<Insert secret here>>`) and the concrete path (`<path>`). Please note that you have to provide the full absolute path as parameter in the download call.

.env file:

```
#
# Neo4j Database
#
NEO4J_MDR_BOLT_PORT=5002
NEO4J_MDR_HOST=localhost
NEO4J_MDR_AUTH_USER=neo4j
NEO4J_MDR_AUTH_PASSWORD=changeme1234
NEO4J_MDR_DATABASE=neo4j

NEO4J_CDISC_IMPORT_BOLT_PORT=5002
NEO4J_CDISC_IMPORT_HOST=localhost
NEO4J_CDISC_IMPORT_AUTH_USER=neo4j
NEO4J_CDISC_IMPORT_AUTH_PASSWORD=changeme1234
NEO4J_CDISC_IMPORT_DATABASE=cdisc-ct

#
# CDISC API
# API token is not mandatory as the package
# folder is now placed in the repository
#
CDISC_BASE_URL="https://library.cdisc.org/api"
CDISC_AUTH_TOKEN="<<Insert secret here>>"

#
# Download folder for the CDISC JSON package files
#
CDISC_DATA_DIR=

```

Now we can download the CTs from the library using the following command in our console:

```
pipenv run python -m mdr_standards_import.cdisc_ct.dev_scripts.download_json_data_from_cdisc_api cdisc_data\packages
```

We can see all related JSON files in our subfolder cdisc_data/packages. To omit version you do not need at all, you might want to move unneeded files into a subfolder. The next step is do import the CTs into a CT database and then into the MDR database (this one holds all OpenStudyBuilder data). That might take a while.

```
pipenv run python -m mdr_standards_import.cdisc_ct.dev_scripts.bulk_import 'TEST' cdisc_data\packages true
```

**hint** When loading too many standards, I got an out of memory issue. I recommend to load only very few files.

... to continue