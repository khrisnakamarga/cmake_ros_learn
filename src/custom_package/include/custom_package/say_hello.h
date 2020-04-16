#pragma once

#include <custom_package/Custom.h>
#include <ros/ros.h>

class Hello {
 public:
  Hello(ros::NodeHandle& nh, ros::NodeHandle& pnh);
  ros::Publisher custom_pub;

 private:
  ros::NodeHandle &nh_, pnh_;
};