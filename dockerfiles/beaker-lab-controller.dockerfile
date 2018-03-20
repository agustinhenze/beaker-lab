from centos

run curl https://beaker-project.org/yum/beaker-server-RedHatEnterpriseLinux.repo > /etc/yum.repos.d/beaker-server-RedHatEnterpriseLinux.repo

run yum install beaker-lab-controller beaker-client -y

run yum install xinetd tftp-server -y

# vim: set syntax=dockerfile:
