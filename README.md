# 仓库作用

为TN3399_V3移植Batocera和JELOS，提供补丁让Batocera和JELOS的源码能编译出TN3399_V3的镜像

# Batocera

## Batocera是什么

Batocera是一个基于Linux的开源模拟器游戏系统，rootfs采用Buildroot构建。原项目[地址](https://github.com/batocera-linux/batocera.linux)

Batocera集成了RetroArch和一些独立模拟器如PPSSPP，并且带有EmulationStation模拟器前端，使打开游戏从执行命令变成操作手柄/键盘。同时Batocera还附带Kodi媒体播放器

PS:

- Batocera镜像只附带几个示例游戏ROM，需要玩家自己导入外部ROM

## 如何编译

编译非常耗时，亲测I9 13900HX也要好几个小时。会从外网下载大约18GiB的源码，且有时软件的来源会被删除导致下载会失败。编译完后整个工程目录占122GiB左右

[这里](https://pan.baidu.com/s/1SVf2VJm_b2v6fLpdQpce8w?pwd=zdxa)有打包的所有源码，感兴趣的话可以自行下载编译。提取码为zdxa

官方提供了基于Dokcer的编译方法，方便在任何Linux发行版上编译，步骤如下

### 解压源码
  
```
tar zxvf batocera.linux-37.tar.gz -C ~/Desktop
cat dl.tar.gz.* | tar zxv -C ~/Desktop/batocera.linux
```

### 打补丁

将patch复制到batocera.linux目录里，cd进入其中，打上补丁：

```
patch -p1 < batocera-37-add-tn3399_v3.patch
```

### 编译
  
```
make rk3399-build
```

目标镜像在batocera.linux/output/rk3399/images/batocera/images/tn3399-v3

PS：

- 自从36版本起，RK3399平台的Batocera存在需要插上键盘才能进到EmulationStation界面的Bug，暂时无法解决

- 37版本存在开机后HDMI一直黑屏的Bug，需要手动插拔一次HDMI，屏幕正常显示后，打开设置界面，将`system settings` -> `splash setting`设置成`batocera splash image`重启即可

# JELOS

## JELOS是什么

JELOS是一个基于Linux的开源模拟器游戏系统，rootfs采用CoreELEC/LibreELEC构建。原项目[地址](https://github.com/JustEnoughLinuxOS/distribution)

JELOS集成了RetroArch和一些独立模拟器如PPSSPP，并且带有EmulationStation模拟器前端，使打开游戏从执行命令变成操作手柄/键盘

## 如何编译

官方提供了基于Dokcer的编译方法，方便在任何Linux发行版上编译，步骤如下

### 下载源码

从github拉取JELOS的源码：

```
cd Desktop
git clone https://github.com/JustEnoughLinuxOS/distribution.git
cd distribution
# 切换到20230909版本
git checkout e43e80dc
```

### 打补丁

将patch复制到distribution目录里，cd进入其中，打上补丁：

```
patch -p1 < jelos-20230909-add-tn3399_v3.patch
```

### 编译

理论上执行`make docker-RK3399`即可完成编译，但是在编译过程中大概率会出错，所以推荐基于Docker手动编译

执行`make docker-shell`进入编译环境的shell，然后执行`make RK3399`编译，如果有错误（几乎都是包源码下载失败导致）导致停止编译，查看报错信息得知是哪一个包编译出错，单独编译：

```
export PROJECT=Rockchip DEVICE=RK3399 ARCH=aarch64
# 删除不全的源码
rm -rf sources/报错的包名
# 清除旧的编译
./scripts/clean 报错的包名
# 重新编译
./scripts/build 报错的包名
```

单独的包编译成功后，接着继续执行`make RK3399`编译即可

PS：

有时编译出来的镜像刻录后到TN3399_V3上后，开机后内核会卡住，屏幕坐上角的光标一直闪，尝试`CLEAN_PACKAGES="linux" make RK3399`重新编译试试，比较玄学