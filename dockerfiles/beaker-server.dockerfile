# from fedora

# run curl https://beaker-project.org/yum/beaker-server-Fedora.repo > /etc/yum.repos.d/beaker-server-Fedora.repo

# Using fedora doesn't work, you get an ugly error https://pastebin.com/wjqKezya

from centos

run curl https://beaker-project.org/yum/beaker-server-RedHatEnterpriseLinux.repo > /etc/yum.repos.d/beaker-server-RedHatEnterpriseLinux.repo

run yum install beaker-server MySQL-python --nogpgcheck -y

# vim: set syntax=dockerfile:
