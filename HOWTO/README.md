### fuel build system

#### prepare build local repo (TODO: varnish/squid for CEONTOS/MOS-CENTOS/SANDBOX)
    - build local centos repo
    `$ wget -Nx -i aliyun-url.list`

#### fuel build mirror

    # local mirror(ubuntu/centos)
    make mirror USE_MIRROR=usa TOP_DIR="/opt/fuel/iso" LOCAL_MIRROR="/opt/fuel/local_mirror/"  BUILD_PACKAGES=1 MIRROR_CENTOS="http://mirrors.aliyun.com/centos/7"  ISO_NAME="cloudos"

    # local mirror only centos
    nohup make mirror-centos USE_MIRROR=usa TOP_DIR="/home/zhanghui/build/v1/iso" LOCAL_MIRROR="/home/zhanghui/build/v1/local_mirror/"   BUILD_PACKAGES=1  ISO_NAME="cloudos" > make-mirror-centos.log  2>&1 &

    78.30s user 2.86s system 124% cpu 1:05.15 total

### fuel components source code

	# git clone
	$ time make repos USE_MIRROR=usa TOP_DIR="/home/zhanghui/build/v2/iso" LOCAL_MIRROR="/home/zhanghui/build/v2/local_mirror/" MIRROR_CENTOS="http://git.fx-dev.com/mirrror/mirrors.aliyun.com/centos/7" MIRROR_FUEL="http://git.fx-dev.com/fuel-build/mirror/mos-centos/" EXTRA_RPM_REPOS="proposed,http://git.fx-dev.com/fuel-build/mirror/extra-repos/proposed/"  BUILD_PACKAGES=1  ISO_NAME="cloudos"

    7.94s user 2.47s system 88% cpu 11.730 total

    # clean repo
    $ TOP=/home/zhanghui/build/v1 make clean-repo USE_MIRROR=usa TOP_DIR="${TOP}/iso" LOCAL_MIRROR="${TOP}/local_mirror/" MIRROR_CENTOS="http://mirror.fx-dev.com/mirrors.aliyun.com/centos/7" MIRROR_FUEL="http://mirror.fx-dev.com/mos-centos/" EXTRA_RPM_REPOS="proposed,http://mirror.fx-dev.com/extra-repos/proposed/"


#### show sandbox repo info

    $ TOP=/home/zhanghui/build/v1 make show-centos-sandbox-repos USE_MIRROR=usa TOP_DIR="${TOP}/iso" LOCAL_MIRROR="${TOP}/local_mirror/" MIRROR_CENTOS="http://mirror.fx-dev.com/mirrors.aliyun.com/centos/7" MIRROR_FUEL="http://mirror.fx-dev.com/mos-centos/" EXTRA_RPM_REPOS="proposed,http://mirror.fx-dev.com/extra-repos/proposed/"


#### fuel components source code build to rpm

    # build
    make packages-rpm USE_MIRROR=usa TOP_DIR="/opt/fuel/iso" LOCAL_MIRROR="/opt/fuel/local_mirror/"  BUILD_PACKAGES=1 MIRROR_CENTOS="http://mirrors.aliyun.com/centos/7"  ISO_NAME="cloudos"

    # when build error we should clean first
    make clean-rpm USE_MIRROR=usa TOP_DIR="/opt/fuel/iso" LOCAL_MIRROR="/opt/fuel/local_mirror/"  BUILD_PACKAGES=1 MIRROR_CENTOS="http://mirrors.aliyun.com/centos/7"  ISO_NAME="cloudos"

#### build iso

    # iso
    make iso USE_MIRROR=usa TOP_DIR="/opt/fuel/iso" LOCAL_MIRROR="/opt/fuel/local_mirror/"  BUILD_PACKAGES=0 MIRROR_CENTOS="http://mirrors.aliyun.com/centos/7"  ISO_NAME="cloudos"
