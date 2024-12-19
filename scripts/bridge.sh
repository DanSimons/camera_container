docker run \
  -d \
  --net=host \
  --ipc=host \
  --name "bridge" \
  ros:foxy-ros1-bridge bash \
  -c "ros2 run ros1_bridge dynamic_bridge"
