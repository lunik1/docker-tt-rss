A fork of the deprecated linuxserver.io tt-rss container. Uses latest master of
tt-rss when built and rebuilds are triggered when commits are added to the
tt-rss master branch or the base container is updated.

NOT supported or endorsed by the linuxserver.io team.

## Usage

### docker

```
docker create \
  --name=tt-rss \
  -e PUID=1000 \
  -e PGID=1000 \
  -e TZ=Europe/London \
  -p 80:80 \
  -v <path to data>:/config \
  --restart unless-stopped \
  lunik1/tt-rss
```

### docker-compose

Compatible with docker-compose v2 schemas.

```
---
version: "2"
services:
  tt-rss:
    image: lunik1/tt-rss
    container_name: tt-rss
    environment:
      - PUID=1000
      - PGID=1000
      - TZ=Europe/London
    volumes:
      - <path to data>:/config
    ports:
      - 80:80
    restart: unless-stopped
```

## Parameters

| Parameter | Function |
| :----: | --- |
| `-p 80` | WebUI |
| `-e PUID=1000` | for UserID  |
| `-e PGID=1000` | for GroupID |
| `-e TZ=Europe/London` | Specify a timezone to use EG Europe/London. |
| `-v /config` | Where tt-rss should store it's config files and data. |

## Environment variables from files (Docker secrets)

You can set any environment variable from a file by using a special prepend `FILE__`. 

As an example:

```
-e FILE__PASSWORD=/run/secrets/mysecretpassword
```

Will set the environment variable `PASSWORD` based on the contents of the `/run/secrets/mysecretpassword` file.

&nbsp;
## Application Setup

You must create a user and database for tt-rss to use in a mysql/mariadb or postgresql server. A basic nginx configuration file can be found in /config/nginx/site-confs , edit the file to enable ssl (port 443 by default), set servername etc.. Self-signed keys are generated the first time you run the container and can be found in /config/keys , if needed, you can replace them with your own.

**The default username and password after initial configuration is admin/password**

## Power users
The container can configure itself using environment variables, the gaurd for this logic to run is if the variable `DB_TYPE` is set. The most common variables to set are a URL for the application and a database endpoint. IE:
* -e DB_TYPE=mysql
* -e DB_HOST=host
* -e DB_USER=user
* -e DB_NAME=name
* -e DB_PASS=password
* -e DB_PORT=3306
* -e SELF_URL_PATH=http://localhost/

Please note if you use this method you need to have an already initialized database endpoint.
