FROM osrf/ros:noetic-desktop-full

RUN apt-get update \
  && apt-get install -y \
  vim \
  git \
  ros-noetic-usb-cam \
  && rm -rf /var/lib/apt/lists/*

RUN echo "source /opt/ros/noetic/setup.bash" >> /root/.bashrc

COPY ros_entrypoint.sh /ros_entrypoint.sh
RUN chmod +x  /ros_entrypoint.sh
ENV ROS_DISTRO=noetic

ENTRYPOINT [ "/ros_entrypoint.sh" ]

CMD ["bash"]
