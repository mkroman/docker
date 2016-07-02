# Factorio

Headless factorio server in a docker container.


## Running

### Create a data container

`docker run --name factorio-data -v /srv/factorio/saves mkroman/factorio --create saves/<save_name>.zip`
`docker run --rm --volumes-from factorio-data mkroman/factorio --create saves/<save_name>.zip`

### Run the latest version 

`docker run -d --volumes-from factorio-data -p 34197:31497/udp --name factorio mkroman/factorio-server --start-server saves/<save_name>.zip --autosave-interval 6`

### Handy command for updating to latest image
```
docker pull mkroman/factorio && \
  docker stop factorio-server && \
  docker rm factorio-server && \
  docker run -d --volumes-from factorio-data -p 34197:31497/udp --name factorio-server mkroman/factorio --start-server saves/<save_name>.zip --autosave-interval 6
 ```

