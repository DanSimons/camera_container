xhost +local:


container_name="humble-interactive"
if docker ps -a --format '{{.Names}}' | grep -q $container_name; then
  echo "removing existing container: $container_name"
  docker rm -f $container_name
fi


docker run \
  -it \
  --name $container_name \
  --network=host \
  --ipc=host \
  --memory=4g \
  --memory-swap=-1 \
  -v /tmp/.X11-unix/:/tmp/.X11-unix/:rw \
  --env=DISPLAY \
  -v `pwd`/config:/root/config \
  humble:flir bash
