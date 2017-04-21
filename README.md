# 为 ESP32 设计的“玩具型” JavaScript\* Runtime 

前人种树，后人乘凉，感谢开源给我们带来的便利，本仓库主要引用的其它开源代码仓库：
- [JerryScript](https://github.com/jerryscript-project/jerryscript)
- [ESP-IDF](https://github.com/espressif/esp-idf)

另外，由于本人太过于菜鸟，还严重无耻地抄袭了如下开源仓库的代码：
- [Zephyr.js](https://github.com/01org/zephyr.js)
- [IoT.js](https://github.com/Samsung/iotjs)


# 快速入门

本人使用的开发环境是 Ubuntu 16.04 LTS，理论上 Ubuntu/Debian 的常见发行版本均支持。

esp.js 支持 ESP32 和 Linux 两个平台。在没有 ESP32 开发板的情况下可以直接使用 Linux 体验 esp.js，但是这有非常大的局限性 —— 只支持少量与硬件无关的功能。

## 获取源码

安装依赖：
```
sudo apt-get install -y gcc gcc-arm-none-eabi cmake cppcheck vera++ python
```

由于仓库是通过 gitsubmodule 来管理依赖仓库的，所以必须通过 git 命令来获取代码：
```
git clone https://github.com/tidyjiang8/esp.js.git
```
克隆完成后，进入`esp.js`所在目录，执行`make update`命令更新依赖的仓库：
```
cd esp.js
make update
```
更新完后，你将在`deps`目录下看到依赖仓库的源码。

## 编译和运行 

### Linux

对于 Linux 平台，直接在`esp.js`根目录下输入下面的命令进行编译：
```
make BOARD=linux
```

其中 BOARD 参数表示编译生成直接可在 linux 下运行的可执行文件。最终生成的可执行文件位于`outdir/linux/jslinux`。 运行：
```
./outdir/linux/jslinux samples/hello.js
```

### ESP32

未完待续。。。

## 源码结构


# 支持的功能


| Module      | UART                     | GPIO                     |
| :---:       | :---:                    | :---:                    |
|  Linux      | <ul><li>- [ ] </li></ul> | <ul><li>- [ ] </li></ul> |
|  ESP32      | <ul><li>- [ ] </li></ul> | <ul><li>- [ ] </li></ul> |





