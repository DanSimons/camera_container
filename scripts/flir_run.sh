# UI permisions
serial=${1-18475182}
# serial=${1-18475176}

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
  -it \
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
  -v `pwd`/config:/root/config \
  humble:flir bash
  #-c "ros2 launch spinnaker_camera_driver driver_node.launch.py /flir_camera/image_raw/:=/$container_name/image_raw/ __name:=flir-$serial serial:=\"'$serial'\""


  # docker run \
#   -td \
#   --name $container_name \
#   --network=host \
#   --ipc=host \
#   --memory=4g \
#   --memory-swap=-1 \
#   -v /tmp/.X11-unix/:/tmp/.X11-unix/:rw \
#   --env=DISPLAY \
#   --device=/dev/video$cam:/dev/video0 \
#   noetic:flir bash



