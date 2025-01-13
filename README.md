# 仓库作用

为TN3399_V3移植Batocera和ROCKNIX，提供补丁让Batocera和ROCKNIX的源码能编译出TN3399_V3的镜像

# Batocera

## Batocera是什么

Batocera是一个基于Linux的开源模拟器游戏系统，rootfs采用Buildroot构建。原项目[地址](https://github.com/batocera-linux/batocera.linux)

Batocera集成了RetroArch和一些独立模拟器如PPSSPP，并且带有EmulationStation模拟器前端，使打开游戏从执行命令变成操作手柄/键盘。同时Batocera还附带Kodi媒体播放器

PS：Batocera镜像只附带几个示例游戏ROM，需要玩家自己导入外部ROM

## 如何编译

[这里](https://pan.baidu.com/s/1vD1iyD0hk2TpH0c3WGPV-w?pwd=elp1)打包了编译过程中需要下载的源码，解压完大小在26GiB

官方提供了基于Dokcer的编译方法，方便在任何Linux发行版上编译，步骤如下

### 下载源码
  
```
cd Desktop
git clone -b 41 --recursive https://github.com/batocera-linux/batocera.linux.git
# 将提供的额外源码解压，免去编译过程中再下载
cat dl.tar.zst* | unzstd -T0 -c | tar -xv -C ~/Desktop/batocera.linux
```

### 打补丁

将patch复制到batocera.linux目录里，cd进入其中，打上补丁：

```
patch -p1 < batocera-41-add-tn3399-v3.patch
```

### 编译
  
```
make rk3399-build
```

目标镜像在batocera.linux/output/rk3399/images/batocera/images/tn3399-v3

# ROCKNIX

## ROCKNIX是什么

ROCKNIX是一个基于Linux的开源模拟器游戏系统，rootfs采用CoreELEC/LibreELEC构建。原项目[地址](https://github.com/ROCKNIX/distribution)

ROCKNIX集成了RetroArch和一些独立模拟器如PPSSPP，并且带有EmulationStation模拟器前端，使打开游戏从执行命令变成操作手柄/键盘

PS：ROCKNIX是JELOS部分开发人员创建的一个新项目，而原JELOS已经归档

## 如何编译

官方提供了基于Dokcer的编译方法，方便在任何Linux发行版上编译，步骤如下

### 下载源码

从github拉取ROCKNIX的源码：

```
cd Desktop
git clone -b main https://github.com/ROCKNIX/distribution.git
cd distribution
# 切换到20240702版本
git checkout 74e0aa3bcefd139376201550df2af68257eab834
```

### 打补丁

将patch复制到distribution目录里，cd进入其中，打上补丁：

```
patch -p1 < rocknix-20240702-add-tn3399-v3.patch
```

### 编译

理论上执行`make docker-RK3399`即可完成编译，但是在编译过程中有概率会出错，所以推荐基于Docker手动编译

执行`make docker-shell`进入编译环境的shell，然后执行`make RK3399`编译，如果有错误（几乎都是包源码下载失败导致）导致停止编译，查看报错信息得知是哪一个包编译出错，单独编译：

```
export PROJECT=Rockchip DEVICE=RK3399 ARCH=arm
# 或者
export PROJECT=Rockchip DEVICE=RK3399 ARCH=aarch64
# 取决于正在编译32 bit还是64 bit的二进制

# 删除不全的源码
rm -rf sources/报错的包名

# 清除旧的编译
./scripts/clean 报错的包名

# 重新编译
./scripts/build 报错的包名
```

单独的包编译成功后，接着继续执行`make RK3399`编译即可

目标镜像在distribution/release，img.gz文件用于烧录镜像，tar文件用于从旧版本OTA
