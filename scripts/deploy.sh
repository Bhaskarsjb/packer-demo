#!bin/bash
sudo su
wget http://apt.puppetlabs.com/puppetlabs-release-trusty.deb
apt-get update
apt-get install -y puppet
cd /etc/puppet/
rm -r puppet.conf
echo "[main]
logdir=/var/log/puppet
vardir=/var/lib/puppet
ssldir=/var/lib/puppet/ssl
rundir=/var/run/puppet
factpath=$confdir/facter" >> puppet.conf
puppet module install puppetlabs-mysql --version 3.10.0
puppet module install mayflower-php --version 4.0.0-beta1
cd /etc/puppet/manifests/
echo " include '::mysql::server'
include '::php'" >> site.pp
puppet apply /etc/puppet/manifests/site.pp
