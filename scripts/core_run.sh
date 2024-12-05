container_name="roscore"
if docker ps -a --format '{{.Names}}' | grep -q $container_name; then
  echo "removing existing container: $container_name"
  docker rm -f $container_name
fi

docker run \
  -d \
  --network=host \
  --ipc=host \
  --name=roscore \
  ros:noetic bash -c $container_name

docker exec -it $container_name bash -c "echo 'source /opt/ros/noetic/setup.bash' >> /root/.bashrc"
