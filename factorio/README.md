# Factorio

Headless factorio server in a docker container.

## Running the server

### Create a data container

```
docker run --name factorio-data -v /srv/factorio/saves mkroman/factorio --create saves/world.zip
```

### Run the latest version 

```
docker run -d --name factorio-server --volumes-from factorio-data -p 34197:34197/udp mkroman/factorio --start-server saves/world.zip --autosave-interval 6
```

### Handy command for updating to latest image
```
docker pull mkroman/factorio && \
  docker stop factorio-server && \
  docker rm factorio-server && \
  docker run -d --name factorio-server --volumes-from factorio-data -p 34197:34197/udp mkroman/factorio --start-server saves/world.zip --autosave-interval 6
 ```

