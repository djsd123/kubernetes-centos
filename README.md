# kubernetes-centos
##### vagrant kubernetes cluster on centos 7.0

### Vagrant plugins
```
puppet
vagrant-cachier
vagrant-hostmanager
vagrant-vbguest
```

Usage
=====

I threw this together quickly, so it's far from slick.  I'm using vagrant 1.9.1 with virtualbox 5.1.4.

Unfortunately the versions of vagrant, virtualbox etc.. Which are the latest at the time of writing this, contain all sorts of weird and wonderful bugs and quirks.
In order to get something running quickly, I had to implement this quick and dirty.  Hence Separate bootstrapping and provisioning steps.

`centos1` acts as the Kubernetes master. `centos2` and `centos3` serve as agents. 

Create vms
```
vagrant up --no-provision
```

Provision Cluster
```
vagrant provision
```

Configure the Kubernetes client like so:
```
kubectl config set-cluster default-cluster --server=http://centos1.example.com:8080
kubectl config set-context default-context --cluster=default-cluster --user=default-admin
kubectl config use-context default-context
```
