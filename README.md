# batocera是什么

batocera是一个开源游戏模拟器系统，使用Linux内核，rootfs采用buildroot构建。项目[地址](https://github.com/batocera-linux/batocera.linux)

batocera集成了各种模拟器，例如RetroArch，PPSSPP等。并且带有EmulationStation模拟器前端，使打开游戏从执行命令变成操作手柄/键盘

系统只带几个示例游戏的ROM，需要玩家自己导入外部ROM

# 本仓库作用

仓库提供的patch为官方的源码添加TN3399_V3支持，因为官方本来就支持RK3399的一些SBC，所以补丁很简单

# 如何编译

编译非常耗时，亲测I9 13900HX也要好几个小时。同时会从外网下载大约18GiB的源码，对网络要求比较高，且有时软件的来源会被删除导致下载会失败。编译完后整个工程目录占122GiB左右

[这里](https://pan.baidu.com/s/1SVf2VJm_b2v6fLpdQpce8w?pwd=zdxa)有打包的所有源码，包括编译时下载的额外源码，感兴趣的话可以自行下载编译。提取码为zdxa

## 编译步骤

官方提供了基于Dokcer的编译方法，可使用任何Linux发行版编译

- 解压源码
  
  ```
  tar zxvf batocera.linux-37.tar.gz -C ~/Desktop
  cat dl.tar.gz.* | tar zxv -C ~/Desktop/batocera.linux
  ```

- 将patch复制到batocera.linux目录里，cd进入其中，打上补丁
  
  ```
  patch -p1 < batocera_37_add_tn3399_v3.patch
  ```

- 为RK3399平台SBC编译系统
  
  ```
  make rk3399-build
  ```

目标镜像在batocera.linux/output/rk3399/images/batocera/images/tn3399-v3

# 注意

自从36版本起，batocera需要插上键盘才能进到EmulationStation界面

37版本的batocera目前有Bug，开机后HDMI一直黑屏，需要手动插拔一次HDMI，屏幕正常显示后，打开设置界面，将`system settings` -> `splash setting`设置成`batocera splash image`重启即可
