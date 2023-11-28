
esri-tomcat cookbook CHANGELOG
================================

This file is used to list changes made in each version of the esri-tomcat cookbook.

0.2.2
-----

- Added support for Rocky Linux and AlmaLinux platforms.

0.2.1
-----

- Added new attributes to control tomcat user and group creation.

0.2.0
-----

- Updated HTTPS connector in server.xml.

0.1.9
-----
- Added support for Apache Tomcat 9.
- Added support for new linux platforms.

0.1.8
-----
- Added iptables, firewalld, and openjdk recipes.

0.1.7
-----
- Disabled AJP port connector.

0.1.6
-----
- Added tarball_path attribute.

0.1.5
-----
- Updated and locked versions of dependent cookbooks.

0.1.4
-----
- Install Tomcat 8.0.53 as default.
- Use openjdk for test kitchen.

0.1.3
-----
- Add ec2 test kitchen.

0.1.2
-----
- Update tomcat dependency version > 2.5.2
- Fix chef 14 deprecation warnings
- Update kitchen to use chef 13

0.1.1
-----
- Add additional guard for tomcat_install resource
- Fix some rubocop offenses

0.1.0
-----
- Installs and configures Apache Tomcat for using with ArcGIS Web Adaptor
