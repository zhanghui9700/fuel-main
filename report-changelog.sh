#!/bin/bash -e
CENTOS_CHANGELOG=${LOCAL_MIRROR}/centos-packages.changelog
UBUNTU_CHANGELOG=${LOCAL_MIRROR}/ubuntu-packages.changelog

### QUICK BUILD
[ -f ${CENTOS_CHANGELOG} ] && rm ${CENTOS_CHANGELOG}
echo '' >> ${CENTOS_CHANGELOG}

[ -f ${UBUNTU_CHANGELOG} ] && rm ${UBUNTU_CHANGELOG}
### QUICK BUILD
echo '' >> ${UBUNTU_CHANGELOG}
