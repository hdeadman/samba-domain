FROM ubuntu:focal
LABEL originalauthor="Fmstrat <fmstrat@NOSPAM.NO>"
LABEL maintainer="Hal Deadman"

ENV DEBIAN_FRONTEND noninteractive

# Install all apps
# The third line is for multi-site config (ping is for testing later) 
# openssl is to make sure recent version of openssl that supports subject alt names command line option is available (openssl 1.1.1)
# nano and vim are for "samba-tool user edit", vi is default but --editor=nano works
RUN apt-get update && \
    apt-get upgrade -y && \
    apt-get install -y pkg-config && \
    apt-get install -y attr acl samba smbclient ldb-tools ldap-utils winbind libnss-winbind libpam-winbind krb5-user krb5-kdc supervisor dnsutils && \
    apt-get install -y openvpn inetutils-ping openssl && \
    apt-get install -y nano vim

# Set up script and run
ADD init.sh /init.sh
RUN chmod 755 /init.sh
ENTRYPOINT [ "/init.sh" ]
CMD [ "setup" ]
