XSOCK=/tmp/.X11-unix
XAUTH=/tmp/.docker.xauth
touch $XAUTH
xauth nlist $DISPLAY | sed -e 's/^..../ffff/' | xauth -f $XAUTH nmerge -

docker run \
  -it \
  --net=host \
  --ipc=host \
  -e "DISPLAY=$DISPLAY" \
  -e "QT_X11_NO_MITSHM=1" \
  -e "XAUTHORITY=$XAUTH" \
  -v `pwd`/config:/root/config \
  ros:humble bash
