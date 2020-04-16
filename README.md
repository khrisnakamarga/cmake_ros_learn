# cmake_ros_learn
Learn how to use CMake for a ROS catkin project

## Goal
This package serves as a template package on how to properly create custom messages, define a library, and create an executable.

# Instructions

## Docker
To run pre-configured environment in a container:
1. `./ros-workspace-build.sh`
2. `./ros-workspace-launch.sh`
3. `catkin_make
4. `source devel/setup.bash`

## Running the publisher
1. Split tmux to 3 panes.
2. `roscore` on one pane.
3. `rosrun custom_package hello_node`
4. `rostopic echo /custom_topic`
5. Observe that custom messages are being published
