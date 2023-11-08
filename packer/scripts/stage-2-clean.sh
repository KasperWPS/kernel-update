#!/bin/bash

# Обновление и очистка всех ненужных пакетов
dnf update -y
dnf clean all


# Добавление ssh-ключа для пользователя vagrant
mkdir -pm 700 /home/vagrant/.ssh
curl -sL https://raw.githubusercontent.com/mitchellh/vagrant/master/keys/vagrant.pub -o /home/vagrant/.ssh/authorized_keys
# Добавил беспарольный sudo
echo "vagrant	ALL=(ALL)	NOPASSWD:ALL" > /etc/sudoers.d/vagrant
chmod 0600 /home/vagrant/.ssh/authorized_keys
chown -R vagrant:vagrant /home/vagrant/.ssh


# Удаление временных файлов
rm -rf /tmp/*
rm -f /var/log/wtmp /var/log/btmp
rm -rf /var/cache/* /usr/share/doc/*
rm -rf /var/cache/yum
# Исправил ошибку
rm -f /home/vagrant/*.iso
rm -f ~/.bash_history
rm -f /usr/src/*tar.xz
history -c

rm -rf /run/log/journal/*
sync
grub2-set-default 0
echo "###   Hi from second stage" >> /boot/grub2/grub.cfg
