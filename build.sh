#!/bin/sh

### BEGIN INIT INFO
# Provides:          zhanghui
# Description:       fuel-main make commands
### END INIT INFO

SCRIPT=make
RUNAS=root

PIDFILE=/var/run/fuel-build.pid
LOGFILE=/var/log/fuel-build.log

TOP=/home/zhanghui/build/v1
TOP_DIR="${TOP}/iso" 
LOCAL_MIRROR="${TOP}/local_mirror" 
USE_MIRROR="usa"
MIRROR_CENTOS="http://mirror.fx-dev.com/mirrors.aliyun.com/centos/7" 
MIRROR_FUEL="http://mirror.fx-dev.com/mos-centos" 
EXTRA_RPM_REPOS="proposed,http://mirror.fx-dev.com/extra-repos/proposed"
EXTRA_RPM_BUILDDEP_REPO="http://mirror.fx-dev.com/extra-repos/proposed"
SANDBOX_MIRROR_EPEL="http://mirrors.aliyun.com/epel/"

MIRROR_MOS_UBUNTU="mirror.fx-dev.com"
MIRROR_MOS_UBUNTU_ROOT="ubuntu"
ISO_NAME=xcloudos

BUILD_ID=`date +%Y-%m-%d-%H-%M-%S-%3N`
echo "BUILD_ID: ${BUILD_ID}"

packages_rpm() {
    if [ "$1" = "--clean" ]; then
        make clean-rpm TOP_DIR="${TOP_DIR}" 
        sudo rm -rf "${TOP}/iso/build/packages/"
        make clean-repos TOP_DIR="${TOP_DIR}"
    else
        time make packages-rpm USE_MIRROR="no" TOP_DIR="${TOP_DIR}" LOCAL_MIRROR=${LOCAL_MIRROR} MIRROR_CENTOS=${MIRROR_CENTOS} MIRROR_FUEL=${MIRROR_FUEL} EXTRA_RPM_REPOS=${EXTRA_RPM_REPOS} SANDBOX_MIRROR_EPEL="${SANDBOX_MIRROR_EPEL}" EXTRA_RPM_BUILDDEP_REPO="${EXTRA_RPM_BUILDDEP_REPO}" BUILD_PACKAGES=1 ISO_NAME=${ISO_NAME} | tee make-packages-rpm.log
    fi   
}

clone_fuel_repo() {
    if [ "$1" = "--clean" ]; then
        make clean-repos TOP_DIR="${TOP_DIR}"
    else
        make repos TOP_DIR="${TOP_DIR}"
    fi
}

build_fuel_iso() {
    if [ "$1" = "--clean" ]; then
        make clean TOP_DIR="${TOP_DIR}"
    else
        time make iso USE_MIRROR="no" TOP_DIR="${TOP_DIR}" LOCAL_MIRROR=${LOCAL_MIRROR} MIRROR_CENTOS=${MIRROR_CENTOS} MIRROR_FUEL=${MIRROR_FUEL} EXTRA_RPM_REPOS=${EXTRA_RPM_REPOS} SANDBOX_MIRROR_EPEL="${SANDBOX_MIRROR_EPEL}" EXTRA_RPM_BUILDDEP_REPO="${EXTRA_RPM_BUILDDEP_REPO}" BUILD_PACKAGES=0 ISO_NAME=${ISO_NAME} MIRROR_MOS_UBUNTU="${MIRROR_MOS_UBUNTU}" MIRROR_MOS_UBUNTU_ROOT="${MIRROR_MOS_UBUNTU_ROOT}" BUILD_ID="${BUILD_ID}" | tee make-iso.log
    fi
}

mirror_centos() {
    if [ "$1" = "--clean" ]; then
        make clean-mirror TOP_DIR="${TOP_DIR}"
    else
        time make mirror-centos TOP_DIR="${TOP_DIR}" LOCAL_MIRROR=${LOCAL_MIRROR} MIRROR_CENTOS=${MIRROR_CENTOS} MIRROR_FUEL=${MIRROR_FUEL} EXTRA_RPM_REPOS=${EXTRA_RPM_REPOS} SANDBOX_MIRROR_EPEL="${SANDBOX_MIRROR_EPEL}" EXTRA_RPM_BUILDDEP_REPO="${EXTRA_RPM_BUILDDEP_REPO}" BUILD_PACKAGES=0 | tee make-mirror-centos.log
    fi
}

case "$1" in
  iso)
    build_fuel_iso $2
    ;;
  mirror-centos)
    mirror_centos $2
    ;;
  repos)
    clone_fuel_repo $2
    ;;
  packages-rpm)
    packages_rpm $2
    ;;
  clean-all)
    echo -n "Are you really sure to clean all build environment? That cannot be undone. [yes|No] "
    #local SURE
    read SURE
    if [ ${SURE} = "yes" ]; then
        clone_fuel_repo --clean
        packages_rpm --clean
        mirror_centos --clean
    else
        echo "cancel clean, we do nothing."
    fi
    ;;
  *)
    echo "Usage: $0 {mirror-centos|repos|packages-rpm|iso}"
esac
