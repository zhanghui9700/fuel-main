
### fuel mirror

#### centos mirror

> sync fule-mirror to build env ubuntu1404. hosted by apache2.

##### 1. yum.conf

`$ cat /etc/yum/yum.conf`

    [main]
    cachedir=/var/cache/yum
    keepcache=1
    debuglevel=2
    logfile=/var/log/yum.log
    exactarch=1
    obsoletes=1

    # PUT YOUR REPOS HERE OR IN separate files named file.repo
    # in /etc/yum/repos.d

`$ ll /etc/yum/repos.d`

    -rw-r--r-- 1 root root 1.7K Apr 11 14:41 base.repo
    -rw-r--r-- 1 root root   93 Apr 12 13:47 epel.repo
    -rw-r--r-- 1 root root  200 Apr 11 14:42 extra.repo

##### 2. reposync

	reposync --downloadcomps --plugins --delete --arch=x86_64  -c /etc/yum/yum.conf --repoid=proposed -p /tmp/build/v1/local_mirror/extra-repos/;

##### 3. createrepo

> if update mirror, add --update tag.

	createrepo --update -g /var/www/mirror/extra-repos/proposed/comps.xml -o /var/www/mirror/extra-repos/proposed/ /var/www/mirror/extra-repos/proposed/

#### WARNING
    
    0. build iso need extro-repo support
    1. make packages-rpm
    2. copy rpms to extro-repo/proposed/Packages
    3. createrepo --update

##### base.repo

    [base]
    name=CentOS-7 - Base
    #mirrorlist=http://mirrorlist.centos.org/?release=7&arch=x86_64&repo=os
    baseurl=http://mirrors.aliyun.com/centos/7/os/x86_64
    gpgcheck=0
    enabled=1
    exclude=*i686 syslinux*
    priority=90

    [updates]
    name=CentOS-7 - Updates
    #mirrorlist=http://mirrorlist.centos.org/?release=7&arch=x86_64&repo=updates
    baseurl=http://mirrors.aliyun.com/centos/7/updates/x86_64
    gpgcheck=0
    enabled=1
    exclude=*i686 syslinux*
    priority=90

    [base_i686_whitelisted]
    name=CentOS-7 - Base
    #mirrorlist=http://mirrorlist.centos.org/?release=7&arch=x86_64&repo=os
    baseurl=http://mirrors.aliyun.com/centos/7/os/x86_64
    gpgcheck=0
    enabled=1
    includepkgs=syslinux*
    priority=90

    [updates_i686_whitelisted]
    name=CentOS-7 - Updates
    #mirrorlist=http://mirrorlist.centos.org/?release=7&arch=x86_64&repo=updates
    baseurl=http://mirrors.aliyun.com/centos/7/updates/x86_64
    gpgcheck=0
    enabled=1
    includepkgs=syslinux*
    priority=90
     
    [extras]
    name=CentOS-7 - Extras
    #mirrorlist=http://mirrorlist.centos.org/?release=7&arch=x86_64&repo=extras
    baseurl=http://mirrors.aliyun.com/centos/7/extras/x86_64
    gpgcheck=0
    enabled=1
    exclude=*i686
    priority=90

    [centosplus]
    name=CentOS-7 - Plus
    #mirrorlist=http://mirrorlist.centos.org/?release=7&arch=x86_64&repo=centosplus
    baseurl=http://mirrors.aliyun.com/centos/7/centosplus/x86_64
    gpgcheck=0
    enabled=0
    priority=90

    [contrib]
    name=CentOS-7 - Contrib
    #mirrorlist=http://mirrorlist.centos.org/?release=7&arch=x86_64&repo=contrib
    baseurl=http://mirrors.aliyun.com/centos/7/contrib/x86_64
    gpgcheck=0
    enabled=0
    priority=90
     
    [fuel]
    name=Fuel Packages
    baseurl=http://mirror.seed-us1.fuel-infra.org/mos-repos/centos/mos9.0-centos7/os/x86_64/
    gpgcheck=0
    enabled=1
    priority=20
    exclude=*debuginfo*

##### epel.repo (change this to aliyun)
    
    [epel]
    name=epel mirror
    baseurl=http://mirror.yandex.ru/epel/7/x86_64/
    gpgcheck=0
    priority=3

##### extra.repo

    [proposed]
    name = Repo "proposed"
    baseurl = http://mirror.fuel-infra.org/mos-repos/centos/mos9.0-centos7/snapshots/proposed-latest/x86_64/
    gpgcheck = 0
    enabled = 1
    priority = 10
    exclude=*debuginfo*
