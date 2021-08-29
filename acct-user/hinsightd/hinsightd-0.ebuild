# Copyright 2021 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit acct-user

DESCRIPTION="A user account for www-servers/hinsightd"
ACCT_USER_ID=-1
ACCT_USER_GROUPS=( hinsightd )

acct-user_add_deps
