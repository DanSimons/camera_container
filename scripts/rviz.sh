XSOCK=/tmp/.X11-unix
XAUTH=/tmp/.docker.xauth
touch $XAUTH
xauth nlist $DISPLAY | sed -e 's/^..../ffff/' | xauth -f $XAUTH nmerge -

xhost +local:docker

container_name="rviz"
# remove old containers
if docker ps -a --format '{{.Names}}' | grep -q $container_name; then
  echo "removing existing container: $container_name"
  docker rm -f $container_name
fi

docker run -it \
  --network=host \
  --ipc=host \
  --env=DISPLAY \
  --name "$container_name" \
  osrf/ros:noetic-desktop-full  bash -c "export export LIBGL_ALWAYS_SOFTWARE=1 && export MESA_LOADER_DRIVER_OVERRIDE=llvmpipe && source /opt/ros/noetic/setup.bash && rosrun rviz rviz"
