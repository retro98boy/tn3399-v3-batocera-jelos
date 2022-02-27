为TN3399_V3广告板移植了batocera,在batocera已支持rk3399 SoC的前提下移植非常简单，
起初直接下载rockpro64的镜像直接修改dtb并烧录TN3399的U-Boot,结果wifi不能工作，
干脆直接修改源码编译。
AP6255不能正常工作是因为batocera在rockchip的内核方面选择了[mrfixit2001](https://github.com/mrfixit2001/rockchip-kernel)维护的BSP内核，
在某个版本后，关于bcmdhd驱动的位置和Kconfig发生了变化，而rk3399_linux_defconfig却没有更新，导致驱动加载失败。
batocera的版本是33，顺便提供了修改源码前后的diff,可以看看都修改了哪些地方，爱好者可以参考自己尝试将batocera简单移植到相同SoC的平台上。
源码的编译看batocera的[wiki](https://wiki.batocera.org/compile_batocera.linux)，推荐使用docker来编译，确定安装好docker后，执行make batocera-docker-image&&make rk3399-build -j12来编译。

拿到板子已经有几个月了，最近下决心把东西整理整理发出来，主要还是太懒。TN3399_V3的BSP/mainline的dts,AP6255的固件等也会稍后整理发出。
目前板子上还有ALC5640声卡没有调通，只能使用HDMI、蓝牙或者外插USB声卡播放声音，之前尝试过调试ALC5640,在系统中通过aplay -l能识别，alsamixer能调音量，但一直没有声音，也就懒的深究，如果有人能提供帮助可以在issues界面提出来。
