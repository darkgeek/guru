# Copyright 2019-2020 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7
PYTHON_COMPAT=( python3_8 )

inherit distutils-r1

DESCRIPTION="A HTTP service for managing, selecting, and claiming cloud resources."
HOMEPAGE="https://github.com/openstack/placement"
if [[ ${PV} == *9999 ]];then
	inherit git-r3
	SRC_URI="https://dev.gentoo.org/~prometheanfire/dist/openstack/placement/victoria/placement.conf.sample -> placement.conf.sample-${PV}"
	EGIT_REPO_URI="https://github.com/openstack/placement.git"
	EGIT_BRANCH="stable/victoria"
else
	SRC_URI="https://dev.gentoo.org/~prometheanfire/dist/openstack/placement/victoria/placement.conf.sample -> placement.conf.sample-${PV}
	https://tarballs.openstack.org/${PN}/openstack-${P}.tar.gz"
	KEYWORDS="~amd64"
	S="${WORKDIR}/openstack-${P}"
fi

LICENSE="Apache-2.0"
SLOT="0"
IUSE="mysql postgres sqlite"
REQUIRED_USE="|| ( mysql postgres sqlite )"

DEPEND=">=dev-python/pbr-5.0.0[${PYTHON_USEDEP}]"
RDEPEND="
	>=dev-python/pbr-5.0.0[${PYTHON_USEDEP}]
	sqlite? (
		>=dev-python/sqlalchemy-1.2.19[${PYTHON_USEDEP}]
	)
	mysql? (
		>=dev-python/pymysql-0.7.6[${PYTHON_USEDEP}]
		!~dev-python/pymysql-0.7.7[${PYTHON_USEDEP}]
		>=dev-python/sqlalchemy-1.2.19[${PYTHON_USEDEP}]
	)
	postgres? (
		>=dev-python/psycopg-2.5.0[${PYTHON_USEDEP}]
		>=dev-python/sqlalchemy-1.2.19[${PYTHON_USEDEP}]
	)
	>=dev-python/keystonemiddleware-4.18.0[${PYTHON_USEDEP}]
	>=dev-python/routes-2.3.1[${PYTHON_USEDEP}]
	>=dev-python/webob-1.8.2[${PYTHON_USEDEP}]
	>=dev-python/jsonschema-3.2.0[${PYTHON_USEDEP}]
	>=dev-python/requests-2.14.2[${PYTHON_USEDEP}]
	>=dev-python/six-1.10.0[${PYTHON_USEDEP}]
	>=dev-python/oslo-concurrency-3.26.0[${PYTHON_USEDEP}]
	>=dev-python/oslo-config-6.7.0[${PYTHON_USEDEP}]
	>=dev-python/oslo-context-2.19.2[${PYTHON_USEDEP}]
	>=dev-python/oslo-log-3.36.0[${PYTHON_USEDEP}]
	>=dev-python/oslo-serialization-1.18.0[${PYTHON_USEDEP}]
	!~dev-python/oslo-serialization-1.19.1[${PYTHON_USEDEP}]
	>=dev-python/oslo-utils-3.37.0[${PYTHON_USEDEP}]
	>=dev-python/oslo-db-4.40.0[${PYTHON_USEDEP}]
	>=dev-python/oslo-policy-1.35.0[${PYTHON_USEDEP}]
	>=dev-python/oslo-middleware-3.31.0[${PYTHON_USEDEP}]
	>=dev-python/oslo-upgradecheck-0.2.0[${PYTHON_USEDEP}]
	>=dev-python/os-resource-classes-0.5.0[${PYTHON_USEDEP}]
	>=dev-python/os-traits-2.4.0[${PYTHON_USEDEP}]
	>=dev-python/microversion-parse-0.2.1[${PYTHON_USEDEP}]
	acct-user/placement
	acct-group/placement"
BDEPEND=""

python_install_all() {
	distutils-r1_python_install_all

	diropts -m 0750 -o placement -g placement
	insinto /etc/placement
	insopts -m 0640 -o placement -g placement
	newins "${DISTDIR}/placement.conf.sample-${PV}" placement.conf.sample

	dobin tools/mysql-migrate-db.sh
	dobin tools/postgresql-migrate-db.sh
}
