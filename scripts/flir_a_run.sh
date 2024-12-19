# UI permisions
serial=${1-18475176}

XSOCK=/tmp/.X11-unix
XAUTH=/tmp/.docker.xauth
touch $XAUTH
xauth nlist $DISPLAY | sed -e 's/^..../ffff/' | xauth -f $XAUTH nmerge -

xhost +local:docker


container_name="flir-$serial"
#
# remove old containers
if docker ps -a --format '{{.Names}}' | grep -q $container_name; then
  echo "removing existing container: $container_name"
  docker rm -f $container_name
fi


docker run \
  -d \
  --net=host \
  --ipc=host \
  --privileged \
  --name $container_name \
  -e "DISPLAY=$DISPLAY" \
  -e "QT_X11_NO_MITSHM=1" \
  -v "/tmp/.X11-unix:/tmp/.X11-unix:rw" \
  -e "XAUTHORITY=$XAUTH" \
  -v /dev:/dev \
  -v `pwd`/launch:/root/launch \
  humble:flir bash -c "ros2 launch /root/launch/driver_a_node.launch.py __name:=flir-$serial serial:=\"'$serial'\""




