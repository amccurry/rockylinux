#!/bin/bash
set -ex

dnf -y install epel-release
systemctl mask auditd firewalld iscsi
