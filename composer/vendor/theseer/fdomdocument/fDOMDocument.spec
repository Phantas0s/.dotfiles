%define _pearDir /usr/share/pear/
%define _sourcedir src/

Summary: fDOMDocument - An Extension to PHP's standard DOM to add various convenience methods and exceptions by default
Name: fDOMDocument
Version: 1.1.0
Release: 1
Group: System Environment/Libraries
License: Arne Blankerts
Vendor: Arne Blankerts
URL: https://github.com/theseer/
#Source:
Provides: fDOMDocument-%{version}%{release}

BuildRoot: %{_tmppath}/%{name}-%{version}%{release}-root-%(%{__id_u} -n)
BuildArch: noarch

Requires: php-common, php-dom

%description
fDOMDocument - An Extension to PHP's standard DOM to add various convenience methods and exceptions by default

%install
[ "$RPM_BUILD_ROOT" != "/" ] && rm -rf $RPM_BUILD_ROOT

install -m 755 -d $RPM_BUILD_ROOT%{_pearDir}TheSeer
install -m 755 -d $RPM_BUILD_ROOT%{_pearDir}TheSeer/fDOMDocument
install -m 755 -d $RPM_BUILD_ROOT%{_pearDir}TheSeer/fDOMDocument/fDOMFilter

cp %{_sourcedir}fDOMDocument.php $RPM_BUILD_ROOT%{_pearDir}TheSeer/fDOMDocument/fDOMDocument.php
cp %{_sourcedir}fDOMDocumentFragment.php $RPM_BUILD_ROOT%{_pearDir}TheSeer/fDOMDocument/fDOMDocumentFragment.php
cp %{_sourcedir}fDOMElement.php $RPM_BUILD_ROOT%{_pearDir}TheSeer/fDOMDocument/fDOMElement.php
cp %{_sourcedir}fDOMException.php $RPM_BUILD_ROOT%{_pearDir}TheSeer/fDOMDocument/fDOMException.php
cp %{_sourcedir}fDOMFilter.php $RPM_BUILD_ROOT%{_pearDir}TheSeer/fDOMDocument/fDOMFilter.php
cp %{_sourcedir}fDOMNode.php $RPM_BUILD_ROOT%{_pearDir}TheSeer/fDOMDocument/fDOMNode.php
cp %{_sourcedir}fDOMXPath.php $RPM_BUILD_ROOT%{_pearDir}TheSeer/fDOMDocument/fDOMXPath.php
cp %{_sourcedir}fDOMFilter/xhtml.php $RPM_BUILD_ROOT%{_pearDir}TheSeer/fDOMDocument/fDOMFilter/xhtml.php

phpab -o $RPM_BUILD_ROOT%{_pearDir}TheSeer/fDOMDocument/autoload.php TheSeer/fDOMDocument

%post

%files
%defattr(-,root,root)
%dir %{_pearDir}TheSeer/fDOMDocument
%dir %{_pearDir}TheSeer/fDOMDocument/fDOMFilter

%{_pearDir}TheSeer/fDOMDocument/*
%{_pearDir}TheSeer/fDOMDocument/fDOMFilter/*
%{_pearDir}TheSeer/fDOMDocument/autoload.php
%{_pearDir}TheSeer/fDOMDocument/fDOMDocument.php
%{_pearDir}TheSeer/fDOMDocument/fDOMDocumentFragment.php
%{_pearDir}TheSeer/fDOMDocument/fDOMElement.php
%{_pearDir}TheSeer/fDOMDocument/fDOMException.php
%{_pearDir}TheSeer/fDOMDocument/fDOMFilter.php
%{_pearDir}TheSeer/fDOMDocument/fDOMNode.php
%{_pearDir}TheSeer/fDOMDocument/fDOMXPath.php
%{_pearDir}TheSeer/fDOMDocument/fDOMFilter/xhtml.php

%changelog
* Tue Jul 04 2011 Maik 'M4ikT' Thieme <maik.thieme@gmail.com> 1.1.0
- Initial package release
