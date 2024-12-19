xhost +local:


container_name="interactive_shell"
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
  -v `pwd`/config:/root/config \
  --env=DISPLAY \
<<<<<<< HEAD
  noetic:camera bash 
=======
  -v `pwd`/config:/root/config \
  humble:flir bash
>>>>>>> 6e01bc97a7173c31fd587988418a3678b9bf750c
