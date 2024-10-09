FROM local/rl9-systemd
RUN dnf -y update
RUN dnf -y groupinstall "Workstation"
COPY opt/desktop/ /opt/desktop/
RUN /opt/desktop/bin/install.sh
CMD ["/opt/desktop/sbin/entrypoint.sh"]
