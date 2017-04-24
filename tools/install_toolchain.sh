#!/bin/sh

toolchain_dir="/opt/"
$(xtensa-esp32-elf-gcc -v)

if [ "$?" -ne "0" ]; then

	echo "Installing esp32 tool chain xtensa-esp32-elf to ${toolchain_dir}/xtensa-esp32-elf"

	os_version=$(uname -m)	
	if [ "$os_version" = "x86_64" ]; then
		wget https://dl.espressif.com/dl/xtensa-esp32-elf-linux64-1.22.0-61-gab8375a-5.2.0.tar.gz || \
		echo "Download tool-chain failed, please check your network and try again"	
		tar xf xtensa-esp32-elf-linux64-1.22.0-61-gab8375a-5.2.0.tar.gz
	else
		wget https://dl.espressif.com/dl/xtensa-esp32-elf-linux32-1.22.0-61-gab8375a-5.2.0.tar.gz || \
		echo "Download tool-chain failed, please check your network and try again"	
		tar xf xtensa-esp32-elf-linux32-1.22.0-61-gab8375a-5.2.0.tar.gz
	fi
	sudo mv xtensa-esp-elf/ ${toolchain_dir}/

	echo "export PATH=$PATH:${toolchain_dir}/xtensa-esp-elf/bin" >> ~/.bashrc
fi


