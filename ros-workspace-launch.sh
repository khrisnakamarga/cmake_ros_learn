#!/bin/bash

xhost +local:root

if [ ! -d "$(pwd)/docker_share" ] 
then
    mkdir $(pwd)/docker_share
    touch $(pwd)/docker_share/bash_history
fi


XAUTH=/tmp/.docker.xauth
if [ ! -f $XAUTH ]
then
    xauth_list=$(xauth nlist :0 | sed -e 's/^..../ffff/')
    if [ ! -z "$xauth_list" ]
    then
        echo $xauth_list | xauth -f $XAUTH nmerge -
    else
        touch $XAUTH
    fi
    chmod a+r $XAUTH
fi

docker run -it \
    --env="DISPLAY" \
    --env="QT_X11_NO_MITSHM=1" \
    --volume="/tmp/.X11-unix:/tmp/.X11-unix:rw" \
    --env="XAUTHORITY=$XAUTH" \
    --volume="$XAUTH:$XAUTH" \
    --device /dev/snd \
	          -e PULSE_SERVER=unix:${XDG_RUNTIME_DIR}/pulse/native \
	          -v ${XDG_RUNTIME_DIR}/pulse/native:${XDG_RUNTIME_DIR}/pulse/native \
    --group-add $(getent group audio | cut -d: -f3) \
    --env HIST_FILE=/root/.bash_history \
    --mount type=bind,source=$(pwd)/docker_share/bash_history,target=/root/.bash_history \
    --mount type=bind,source=$(pwd)/src,target=/catkin_ws/src \
    --network host \
    --name cmake_learn_ws \
    khrisna/cmake_learn \
    bash
    
# --gpus=all \
# --mount type=bind,source=$(pwd)/build,target=/catkin_ws/build \

xhost -local:root