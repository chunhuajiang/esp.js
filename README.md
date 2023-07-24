# 为 ESP32 设计的“玩具型” JavaScript\* Runtime 

esp.js 为 ESP32 提供了 JavaScript 运行时环境，让你可以直接使用 JavaScript 脚本控制整个开发板。

esp.js 当前仅支持 ESP32 和 Linux 两个平台 。在没有 ESP32 开发板的情况下可以直接使用 Linux 体验 esp.js，但是这有非常大的局限性 —— 只支持少量与硬件无关的功能。

事实上，Espruino 已经支持 ESP32 了，这里再设计一个 esp.js 只是为了消遣时光，Just for fun！

# 快速入门

本人使用的开发环境是 Ubuntu 16.04 LTS，但是理论上 Ubuntu/Debian 的常见发行版本均用于开发 esp.js 或者使用 esp.js 开发应用程序。

## 获取源码

安装必要的主机工具：
```
sudo apt-get install -y gcc gcc-arm-none-eabi cmake cppcheck vera++ git wget make libncurses-dev flex bison gperf python python-serial
```

由于仓库是通过 gitsubmodule 来管理依赖仓库的，所以必须通过 git 命令来获取 esp.js 的源代码：
```
git clone https://github.com/chunhuajiang/esp.js.git
```

克隆完成后，进入`esp.js`所在目录，执行`make update`命令更新依赖的仓库：
```
cd esp.js
make update
```
更新完后，你可以在`deps`目录下看到依赖仓库的源码。

## 编译和运行 

### Linux

在编译前，请先对项目下的 .env 文件执行 source 操作（每次打开一个新终端时均需要执行该操作）：
```
source .env
```

> 执行 source .env 操作是为了让编译系统能够定位 esp.js 的根目录 ROOT_DIR。如果不想每次都新开一个终端时都执行该操作，你可以直接将 ROOT_DIR 导出到 ~/.bashrc，例如 echo "ROOT_DIR=/path/to/esp.js" >> .bashrc。但是，如果你今后的仓库目录变更了，请记得在 ~/.bashrc 的默认更新该变量的值。

对于 Linux 平台，直接在`esp.js`根目录下输入下面的命令进行编译：
```
make BASE=linux
```

其中 BASE=linux 参数表示编译生成直接可在 linux 下运行的可执行文件。最终生成的可执行文件位于`outdir/linux/jslinux`。 运行：
```
./outdir/linux/jslinux samples/hello.js
```

### ESP32

在编译前，请先对项目下的 .env 文件执行 source 操作（每次打开一个新终端时均需要执行该操作）：
```
source .env
```

> 执行 source .env 操作是为了让编译系统能够定位 esp.js 的根目录 ROOT_DIR。如果不想每次都新开一个终端时都执行该操作，你可以直接将 ROOT_DIR 导出到 ~/.bashrc，例如 echo "ROOT_DIR=/path/to/esp.js" >> .bashrc。但是，如果你今后的仓库目录变更了，请记得在 ~/.bashrc 的默认更新该变量的值。

对于 esp-idf 平台，直接在`esp.js`根目录下输入下面的命令进行编译：
```
make BASE=esp-idf TARGET=esp32
```
其中，BASE=esp-idf 表示使用乐鑫官方提供的开发框架 ESP-IDF 来编译整个工程，TARGET=esp32 表示编译生成可直接在 esp32 下运行的可执行问。最终生成的可执行文件位于 `outdir/esp-idf/esp32js.elf`。

然后，执行下面的命令将生成的镜像文件烧写到 esp32 开发板上面：
```
make BASE=esp-idf flash
```

# 支持的功能


| Module      | UART                     | GPIO                     |
| :---:       | :---:                    | :---:                    |
|  Linux      | <ul><li>- [ ] </li></ul> | <ul><li>- [ ] </li></ul> |
|  ESP32      | <ul><li>- [ ] </li></ul> | <ul><li>- [ ] </li></ul> |


# 相关仓库
前人种树，后人乘凉，感谢开源给我们带来的便利，本仓库主要引用的其它开源代码仓库：
- [JerryScript](https://github.com/jerryscript-project/jerryscript)
- [ESP-IDF](https://github.com/espressif/esp-idf)

另外，由于本人太过于菜鸟，还严重无耻地抄袭了如下开源仓库的代码：
- [Zephyr.js](https://github.com/01org/zephyr.js)
- [IoT.js](https://github.com/Samsung/iotjs)


