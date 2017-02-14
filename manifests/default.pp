class vagrant {

	$pkgs = ['kubernetes','etcd','flannel','vim-enhanced','nmap','bash-completion']

  $master_svcs = ['kube-apiserver', 'kube-controller-manager', 'kube-scheduler', 'flanneld']

  $minion_svcs = ['kube-proxy', 'kubelet', 'flanneld', 'docker']

  $flannel_network_script = 'etcd_flanneld_kube_centos_config'

  File {
    owner => 'root',
    group => 'root',
  }

  Service {
    ensure => running,
    enable => true,
  }

  file {'repo' :
    ensure => present,
    source => '/vagrant/files/virt7-docker-common-release.repo',
    path   => '/etc/yum.repos.d/virt7-docker-common-release.repo',
    mode   => 0644,
  }

  package { 'epel-release' :
    ensure => installed,
  }

  package { $pkgs :
    ensure  => installed,
    require => [File['repo'],Package['epel-release']],
    allow_virtual => false,
  }

  file { '/etc/kubernetes/config' :
    ensure => link,
    source => '/vagrant/files/config',
  }

  file { '/etc/kubernetes/apiserver' :
    ensure => link,
    source => '/vagrant/files/apiserver',
  }

  file { '/etc/etcd/etcd.conf' :
    ensure => link,
    source => '/vagrant/files/etcd.conf',
  }

  file { '/etc/sysconfig/flanneld' :
    ensure => link,
    source => '/vagrant/files/flanneld'
  }

  service { 'etcd.service' :
    subscribe => File['/etc/etcd/etcd.conf'],
  }

  file { $flannel_network_script :
    path   => "/root/${etcd_flanneld_kube_centos_config}.sh",
    mode   => '0755',
    source => "/vagrant/files/${etcd_flanneld_kube_centos_config}.sh",
  }

  exec { 'flannel-network' :
    command => "/root/${etcd_flanneld_kube_centos_config}.sh",
    require => File['flannel-network-script'],
    after   => Service['etcd.service'],
  }

  if $::hostname == 'centos1' {

    service { $master_svcs :
      subscribe => File[
      '/etc/kubernetes/apiserver',
      '/etc/kubernetes/config',
      '/etc/sysconfig/flanneld'],
      after     => Exec['flannel-network'],
    }
 
  } else {

    file { '/etc/kubernetes/kubelet' :
      ensure => link,
      source => '/vagrant/files/kubelet',
    }

    service { $minion_svcs :
      subscribe => File['/etc/sysconfig/flanneld','/etc/kubernetes/kubelet'],
    }

  }

  service { ['iptables.service','firewalld.service'] :
    ensure => stopped,
    enable => false,
  }

}

include vagrant
