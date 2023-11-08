#!/bin/bash

# Установка репозитория elrepo
#dnf install -y https://www.elrepo.org/elrepo-release-8.el8.elrepo.noarch.rpm 
# Установка нового ядра из репозитория elrepo-kernel
#dnf --enablerepo elrepo-kernel install kernel-ml kernel-ml-devel -y


dnf install ncurses-devel openssl-devel gcc perl make flex bison elfutils-libelf-devel -y

cd /usr/src
wget https://cdn.kernel.org/pub/linux/kernel/v6.x/linux-6.5.10.tar.xz

if [ $? -eq 0 ]; then
	tar -xf /usr/src/linux-6.5.10.tar.xz
	cd /usr/src/linux-6.5.10
	echo "Get config linux kernel version 6.5.10 from: ${PACKER_HTTP_ADDR}"
	wget ${PACKER_HTTP_ADDR}/config-6.5.10 -O /usr/src/linux-6.5.10/.config
	wget ${PACKER_HTTP_ADDR}/signing_key.pem -O /usr/src/linux-6.5.10/certs/signing_key.pem

	# Здесь нужно делать проверки, либо make && make install && make modules_install
	# но так как это первое домашнее задание))
	echo "Make a linux kernel..."
	# Используем все имеющиеся ядра/"потоки"
	make -j$(cat /proc/cpuinfo | grep 'model name' | sed -e 's/.*: //' | wc -l)
	make modules_install
	make install
	make clean
fi


# Обновление параметров GRUB
grub2-mkconfig -o /boot/grub2/grub.cfg
#grub2-set-default 0
echo "Grub update done."
# Перезагрузка ВМ
shutdown -r now
