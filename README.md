# DEPRECATION NOTICE

This repository has been deprecated, development continues at
https://gitlab.com/lunik1/docker-tt-rss.

The container image is now hosted at registry.gitlab.com/lunik1/docker-tt-rss.

# Original README

A fork of the deprecated linuxserver.io tt-rss container. Uses latest master of tt-rss when built and rebuilds are triggered when commits are added to the tt-rss master branch or the base container is updated.

Find the Image on Docker Hub: [https://hub.docker.com/r/lunik1/tt-rss](https://hub.docker.com/r/lunik1/tt-rss)

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

## Application Configuration
The container can configure itself using environment variables, this is now preferred over using `config.php`. The most common variables to set are a URL for the application and a database endpoint. IE:
* -e TTRSS_DB_TYPE=mysql
* -e TTRSS_DB_HOST=host
* -e TTRSS_DB_USER=user
* -e TTRSS_DB_NAME=name
* -e TTRSS_DB_PASS=password
* -e TTRSS_DB_PORT=3306
* -e TTRSS_SELF_URL_PATH=http://localhost/

For a full list of supported variables and their defaults see [here](https://git.tt-rss.org/fox/tt-rss/src/branch/master/classes/config.php#L57).

Please note you need to have an already initialized database endpoint.
