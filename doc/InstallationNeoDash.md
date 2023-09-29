# Installation of NeoDash

## Install and startup

[NeoDash](https://neo4j.com/labs/neodash/) is a nice tool to create dashboards for neo4j databases.

I am using the docker installation, as we have docker anyway. As our frontend is running on port 5005, I change the default port setting which is proposed and use the following:

```
# Run the application on http://localhost:5105
docker pull neo4jlabs/neodash:2.3.4
docker run -it --rm -p 5105:5005 neo4jlabs/neodash:2.3.4
```

Remark: Theoretically you can also use the "latest", but sometimes this is not the desired version.

```
docker pull neo4jlabs/neodash:latest
docker run -it --rm -p 5105:5005 neo4jlabs/neodash
```

Now we can start http://localhost:5105/ in the browser to start the NeoDash. There we can create a "NEW DASHBOARD" using the settings. To figure out the settings of your database, you can open the Neo4j browser (http://localhost:5001/browser/). There you can see your username, the URL (localhost and a port properbly) and under "Use Database", you can see the OpenStudyBuilder used database name.

By using version 0.4 with the default, the following values can be used:

Setting Name | Value with OpenStudyBuilder 0.4 | Value with OpenStudyBuilder 0.6.1
-- | -- | --
Protocol | neo4j | neo4j
Hostname | localhost | localhost
Port | 5002 | 5002
Database | mdrdb-2023.04.21-07.43 | mdrdb-2023.09.26-14.35
Username | neo4j | neo4j
Password | changeme1234 | changeme1234

After clicking "Connect", you can start working with the dashboard.

## Comments to APOC

In Neo4j browser you can check that the custom apoc package is available with:

```
CALL apoc.help('custom')
```

