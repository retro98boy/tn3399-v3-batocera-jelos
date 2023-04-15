# batocera是什么

batocera是一个模拟器游戏系统，使用Linux内核，rootfs采用buildroot构建。项目[地址](https://github.com/batocera-linux/batocera.linux)

batocera集成了各种模拟器，例如RetroArch，PPSSPP等。并且带有EmulationStation模拟器游戏前端，使打开游戏从执行命令变成操作手柄/键盘

官方系统只带几个示例游戏的ROM，需要玩家自己导入外部ROM

# 本仓库作用

为TN3399_V3移植batocera系统，因为官方本来就支持RK3399的一些SBC，所以移植到TN3399_V3上很简单。仓库提供的patch给官方的源码添加TN3399_V3的支持

# 编译

编译非常耗时，本人I9 13900HX的笔记本也花了好几个小时。同时会从外网下载大约17GiB的源码，对网络要求比较高，且有时软件的来源会被删除导致下载会失败

[这里](https://pan.baidu.com/s/1SVf2VJm_b2v6fLpdQpce8w?pwd=zdxa)有打包的所有源码，包括编译时下载的额外源码，感兴趣的话可以自行下载编译。提取码为zdxa

## 编译步骤

官方提供了基于Dokcer的编译方法，所以不需要去搭建环境，可以使用任何Linux发行版搭配Docker

- 解压源码
  
  ```
  tar zxvf batocera.linux-36.tar.gz -C ~/Desktop
  cat dl.tar.gz.* | tar zxv -C ~/Desktop/batocera.linux
  ```

- 将patch复制到batocera.linux目录里，cd进入其中，打上补丁
  
  ```
  patch -p1 < batocera_36_add_tn3399_v3.patch
  ```

- 为RK3399平台SBC编译系统
  
  ```
  make rk3399-build
  ```

目标镜像在batocera.linux/output/images/batocera/images/<architecture>/batocera-<XXXX>.img.gz

# Bug？

当前36版本的batocera必须插键盘才能进到操作界面，不插外设或插USB手柄不行。拿出Rock Pi 4A的板子刷入对应的固件发现也一样。编译还在开发中的37再尝试，也是一样。所以这是特性？检测键盘便于后续操作？

编译一次花费大量的时间、网络流量和磁盘空间，所以后续的版本可能采取在官方预编译固件，例如RockPro64上修改dtb的办法来移植
