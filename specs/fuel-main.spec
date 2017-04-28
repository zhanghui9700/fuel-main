#TEMP fixme
%define repo_name fuel-main

%define name fuel
%{!?version: %define version 9.0.0}
%{!?fuel_release: %define fuel_release 9.0}
%{!?release: %define release 1}

Name: %{name}
Summary: Fuel for OpenStack
URL:     http://mirantis.com
Version: %{version}
Release: %{release}
Source0: %{name}-%{version}.tar.gz
License: Apache
BuildRoot: %{_tmppath}/%{name}-%{version}-buildroot
Prefix: %{_prefix}
BuildArch: noarch
Requires: fuel-library9.0
Requires: fuelmenu >= %{version}
Requires: fuel-provisioning-scripts >= %{version}
Requires: fuel-release >= %{version}
Requires: network-checker >= %{version}
Requires: python-fuelclient >= %{version}
Requires: fuel-mirror >= %{version}
Requires: shotgun >= %{version}
Requires: yum

%description
Fuel for OpenStack is a lifecycle management utility for
managing OpenStack.

%prep
%setup -cq -n %{name}-%{version}

%build

%install
rm -rf %{buildroot}
mkdir -p %{buildroot}/etc
mkdir -p %{buildroot}/etc/yum/vars/
mkdir -p %{buildroot}/etc/yum.repos.d
echo %{fuel_release} > %{buildroot}%{_sysconfdir}/fuel_release
echo %{fuel_release} > %{buildroot}%{_sysconfdir}/yum/vars/fuelver
# copy GPG key
install -D -m 644 %{_builddir}/%{name}-%{version}/fuel-release/RPM-GPG-KEY-mos %{buildroot}/etc/pki/fuel-gpg/RPM-GPG-KEY-mos
# copy yum repos and mirror lists to /etc/yum.repos.d
for file in %{_builddir}/%{name}-%{version}/fuel-release/*.repo ; do
    install -D -m 644 "$file" %{buildroot}/etc/yum.repos.d
done
install -D -p -m 755 %{_builddir}/%{name}-%{version}/iso/bootstrap_admin_node.sh %{buildroot}%{_sbindir}/bootstrap_admin_node.sh
install -D -p -m 755 %{_builddir}/%{name}-%{version}/iso/fix_default_repos.py %{buildroot}%{_sbindir}/fix_default_repos.py

%clean
rm -rf %{buildroot}

%files
%defattr(-,root,root)


%package -n fuel-release

Summary:   Fuel release package
Version:   %{version}
Release:   %{release}
License:   Apache
BuildRoot: %{_tmppath}/%{name}-%{version}-%{release}-buildroot
URL:       http://github.com/Mirantis

%description -n fuel-release
This packages provides /etc/fuel_release file
and Yum configuration for Fuel online repositories.

%files -n fuel-release
%defattr(-,root,root)
%{_sysconfdir}/fuel_release
%config(noreplace) %attr(0644,root,root) /etc/yum/vars/fuelver
%config(noreplace) %attr(0644,root,root) /etc/yum.repos.d/*
%dir /etc/pki/fuel-gpg
/etc/pki/fuel-gpg/*

%package -n fuel-setup

Summary:   Fuel deployment script package
Version:   %{version}
Release:   %{release}
License:   Apache
BuildRoot: %{_tmppath}/%{name}-%{version}-%{release}-buildroot
URL:       http://github.com/Mirantis

%description -n fuel-setup
This packages provides script to deploy Fuel components.

%files -n fuel-setup
%defattr(-,root,root)
%{_sbindir}/bootstrap_admin_node.sh
%{_sbindir}/fix_default_repos.py
%changelog
* Thu Apr 13 2017 zhanghui9700 <zhanghui9700@gmail.com> - 9.0.0-1.mos6359
- 98f76e7 custom build xcloudos iso
- 4e4d96c Add holdback and hotfix repos into custom isos
- 642e1c0 Use mos and proposed repos during centos install
- 363fff0 Modify default repos for fuel and fuelmenu
- cbb8fa3 Set default EXTRA_RPM_REPOS to use proposed repo
- 7c45cbe Make sure the ISO tracks the latest merged code
- 55d7236 Merge "Revert "Make sure the ISO tracks the latest merged code"" into stable/mitaka
- c3f8090 Revert "Make sure the ISO tracks the latest merged code"
- ef5acbb Merge "Allow to pass RPM repos to build-sandbox" into stable/mitaka
- 9e8ae96 Allow to pass RPM repos to build-sandbox
