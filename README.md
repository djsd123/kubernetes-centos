# kubernetes-centos
#####kubernetes cluster with vagrant on centos 7.2

Usage
=====

I threw this together quickly, so it's far from slick.  I'm using vagrant 1.9.1 with virtualbox 5.1.4.

Unfortunately the versions of vagrant, virtualbox etc.. Which are the latest at the time of writing this, contain all sorts of weird and wonderful bugs and quirks.
In order to get something running quickly, I had to implement this quick and dirty.  Hence Separate booting and provisioning steps.

`centos1` acts as the Kubernetes master. `centos2` and `centos3` serve as agents. 

Create vms
```
vagrant up centos1 centos2 centos3 --no-provision
```

Provision Cluster
```
vagrant provision centos1 centos2 centos3
```
