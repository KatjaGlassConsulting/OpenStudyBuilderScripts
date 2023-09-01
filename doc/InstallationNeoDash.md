# Installation of NeoDash

## Install and startup

[NeoDash](https://neo4j.com/labs/neodash/) is a nice tool to create dashboards for neo4j databases.

I am using the docker installation, as we have docker anyway. As our frontend is running on port 5005, I change the default port setting which is proposed and use the following:

```
# Run the application on http://localhost:5105
docker pull neo4jlabs/neodash:latest
docker run -it --rm -p 5105:5005 neo4jlabs/neodash
```

Now we can start http://localhost:5105/ in the browser to start the NeoDash. There we can create a "NEW DASHBOARD" using the settings. To figure out the settings of your database, you can open the Neo4j browser (http://localhost:5001/browser/). There you can see your username, the URL (localhost and a port properbly) and under "Use Database", you can see the OpenStudyBuilder used database name.

By using version 0.4 with the default, the following values can be used:

Setting Name | Value
-- | --
Protocol | neo4j
Hostname | localhost
Port | 5002
Database | mdrdb-2023.04.21-07.43
Username | neo4j
Password | changeme1234

After clicking "Connect", you can start working with the dashboard.