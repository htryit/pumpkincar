#pumpkincar

基于Raspberry  Pi (Model B)+ adafruit Motor Sheild (L293D) 的智能4驱小车

## 配件元件
* Raspberry Pi (Model B)
* USB无线网卡 
* Adafruit Motor Sheild (L293D) 可驱动4路直流电机或2路步进电机 + 2部舵机
* 电源
  * 移动电源 输出5V，Pi供电
  * 电池组 输出7.2V，接电机驱动板供电机使用。
* 4驱小车底盘一部
* USB摄像头一个
* 杜邦线若干条


## 控制、监控方案
* Pi作为控制中心，是一个小型的Web服务器，在WIFI环境下，控制端可以使用手机、PC的浏览器来监控或控制，如果做NAT映射外网，则可以通过外部网络来控制和监控。
  * 视频监控：使用mjpg-stream，直接在控制页面嵌入视频流。
  * 控制小车的前、左、右、退：通过页面操作，Pi根据不同参数控制GPIO输出到 Motor Shield板，进而控制知能小车的电机，达到4个方向的行动。
* Pi 使用语言及库
  * nodejs:简单实现Web服务器：
    * 输出控制界面
    * 视频监控画面
    * 处理页面控制操作
    * 启动 mjpg-stream服务
    * 调用 程序控制 gpio端口，进而控制 motor的信号输出，达到控制电机的目的。
  * adafruit 驱动库 / wiringPi库
    * 使用wiringPi库实现对GPIO的控制。
    * 使用 adafruit提供的驱动库简单封对4路电机的控制。


## TODO 
* 使用1路舵机+超声波模块，及时躲避、绕过前方的障碍物。
* 使用2路舵机+小型云台，对摄像头进行水平和垂直方向的控制。
* 使用光线传感器 根据环境光线情况开启LED灯，以及在转向时开启转向LED灯。

