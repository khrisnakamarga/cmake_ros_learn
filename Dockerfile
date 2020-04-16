FROM osrf/ros:melodic-desktop-full

# USE BASH
SHELL ["/bin/bash", "-c"]


# Setup Locales
RUN apt-get update && apt-get install -y locales
ENV LANG="en_US.UTF-8" LC_ALL="en_US.UTF-8" LANGUAGE="en_US.UTF-8"

RUN echo "en_US.UTF-8 UTF-8" > /etc/locale.gen && \
    locale-gen --purge $LANG && \
    dpkg-reconfigure --frontend=noninteractive locales && \
    update-locale LANG=$LANG LC_ALL=$LC_ALL LANGUAGE=$LANGUAGE

# Install basic dev and utility tools
RUN apt-get update && \
    apt-get install -y apt-utils git lsb-release build-essential stow neovim tmux wget htop unzip nano && \
    rm -rf /var/lib/apt/lists/*

# Set up timezone
ENV TZ 'America/Los_Angeles'
RUN echo $TZ > /etc/timezone && \
    rm /etc/localtime && \
    ln -snf /usr/share/zoneinfo/$TZ /etc/localtime && \
    dpkg-reconfigure -f noninteractive tzdata

# Create a folder for a catkin workspace. 
ENV CATKIN_DIR=/catkin_ws
RUN source /opt/ros/melodic/setup.bash && \
    mkdir -p ${CATKIN_DIR}

# Sourcing ROS workspace on new terminal
RUN echo "source /opt/ros/melodic/setup.bash" >> /root/.bashrc


CMD ["tmux new -s CMAKE_ROS_LEARN"]