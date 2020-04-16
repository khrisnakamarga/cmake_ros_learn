#include <custom_package/say_hello.h>

Hello::Hello(ros::NodeHandle& nh, ros::NodeHandle& pnh) : nh_(nh), pnh_(pnh) {
  custom_pub = nh_.advertise<custom_package::Custom>("custom_topic", 1);
}