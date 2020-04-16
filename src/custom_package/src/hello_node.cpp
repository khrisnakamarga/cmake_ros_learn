#include <custom_package/say_hello.h>
#include <ros/ros.h>

int main(int argc, char** argv) {
  ros::init(argc, argv, "cmake_learn_node");
  ros::NodeHandle nh;
  ros::NodeHandle pnh("~");

  Hello hello_node(nh, pnh);
  ros::Rate loop_rate(10);

  while (ros::ok()) {
    custom_package::Custom msg;
    msg.message = "Hello, world!";
    msg.ros_string.data = "Fresh is Fresh!";
    hello_node.custom_pub.publish(msg);
    ros::spinOnce();
    loop_rate.sleep();
  }

  return 0;
}