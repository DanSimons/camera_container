xhost +local:

cam=0

container_name="cam$cam"
if docker ps -a --format '{{.Names}}' | grep -q $container_name; then
  echo "removing existing container: $container_name"
  docker rm -f $container_name
fi


docker run \
  -d \
  --name $container_name \
  --network=host \
  --ipc=host \
  --gpus=all \
  --memory=4g \
  --memory-swap=-1 \
  -v /tmp/.X11-unix/:/tmp/.X11-unix/:rw \
  --env=DISPLAY \
  --device=/dev/video$cam:/dev/video0 \
  noetic:camera bash -c "rosrun usb_cam usb_cam_node /usb_cam/image_raw:=/camera/left/image_raw __name:=aa"
