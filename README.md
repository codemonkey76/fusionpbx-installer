FusionPBX Install
--------------------------------------
A quick install guide & scripts for installing FusionPBX. It is recommended to start with a minimal install of Ubuntu 24.04 LTS.

## Installation
```sh
wget -O - https://raw.githubusercontent.com/codemonkey76/fusionpbx-installer/main/pre-install.sh | sh;
cd /usr/src/fusionpbx-installer && ./install.sh
```

## Security Considerations
Fail2ban is installed and pre-configured for all operating systems this repository works on besides Windows, but the default settings may not be ideal depending on your needs. Please take a look at the jail file (/etc/fail2ban/jail.local on Debian/Devuan) to configure it to suit your application and security model!

## ISSUES
If you find a bug sign up for an account on www.fusionpbx.com to report the issue.

