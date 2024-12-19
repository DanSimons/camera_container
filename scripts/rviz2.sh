XSOCK=/tmp/.X11-unix
XAUTH=/tmp/.docker.xauth
touch $XAUTH
xauth nlist $DISPLAY | sed -e 's/^..../ffff/' | xauth -f $XAUTH nmerge -

xhost +local:docker

container_name="rviz2"
# remove old containers
if docker ps -a --format '{{.Names}}' | grep -q $container_name; then
  echo "removing existing container: $container_name"
  docker rm -f $container_name
fi

docker run -id \
  --network=host \
  --ipc=host \
  --env=DISPLAY \
  --name "$conatiner_name" \
  osrf/ros:humble-desktop-full  bash -c "source /opt/ros/humble/setup.bash && ros2 run rviz2 rviz2"
