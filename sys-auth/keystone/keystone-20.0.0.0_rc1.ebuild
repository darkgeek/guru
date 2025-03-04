# Copyright 1999-2021 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

MYP="${P/_/}"
PYTHON_COMPAT=( python3_8 )

inherit distutils-r1

DESCRIPTION="The Openstack authentication, authorization, and service catalog"
HOMEPAGE="
	https://opendev.org/openstack/keystone
	https://launchpad.net/keystone
	https://pypi.org/project/keystone
"
SRC_URI="
	https://dev.gentoo.org/~prometheanfire/dist/openstack/keystone/victoria/keystone.conf.sample -> keystone.conf.sample-${PV}
	https://tarballs.openstack.org/${PN}/${MYP}.tar.gz
"
S="${WORKDIR}/${MYP}"

KEYWORDS="~amd64"
LICENSE="Apache-2.0"
SLOT="0"
IUSE="+sqlite ldap memcached mongo mysql postgres"

RDEPEND="
	>=dev-python/webob-1.7.1[${PYTHON_USEDEP}]
	>=dev-python/flask-1.0.2[${PYTHON_USEDEP}]
	>=dev-python/flask-restful-0.3.5[${PYTHON_USEDEP}]
	>=dev-python/cryptography-2.7[${PYTHON_USEDEP}]
	sqlite? (
		>=dev-python/sqlalchemy-1.3.0[sqlite,${PYTHON_USEDEP}]
	)
	mysql? (
		>=dev-python/pymysql-0.7.6[${PYTHON_USEDEP}]
		>=dev-python/sqlalchemy-1.3.0[${PYTHON_USEDEP}]
	)
	postgres? (
		>=dev-python/psycopg-2.5.0[${PYTHON_USEDEP}]
		>=dev-python/sqlalchemy-1.3.0[${PYTHON_USEDEP}]
	)
	>=dev-python/sqlalchemy-migrate-0.13.0[${PYTHON_USEDEP}]
	>=dev-python/stevedore-1.20.0[${PYTHON_USEDEP}]
	>=dev-python/passlib-1.7.0[${PYTHON_USEDEP}]
	>=dev-python/python-keystoneclient-3.8.0[${PYTHON_USEDEP}]
	>=dev-python/keystonemiddleware-7.0.0[${PYTHON_USEDEP}]
	>=dev-python/bcrypt-3.1.3[${PYTHON_USEDEP}]
	>=dev-python/scrypt-0.8.0[${PYTHON_USEDEP}]
	>=dev-python/oslo-cache-1.26.0[${PYTHON_USEDEP}]
	>=dev-python/oslo-config-6.8.0[${PYTHON_USEDEP}]
	>=dev-python/oslo-context-2.22.0[${PYTHON_USEDEP}]
	>=dev-python/oslo-messaging-5.29.0[${PYTHON_USEDEP}]
	>=dev-python/oslo-db-6.0.0[${PYTHON_USEDEP}]
	>=dev-python/oslo-i18n-3.15.3[${PYTHON_USEDEP}]
	>=dev-python/oslo-log-3.44.0[${PYTHON_USEDEP}]
	>=dev-python/oslo-middleware-3.31.0[${PYTHON_USEDEP}]
	>=dev-python/oslo-policy-3.7.0[${PYTHON_USEDEP}]
	>=dev-python/oslo-serialization-2.18.0[${PYTHON_USEDEP}]
	>=dev-python/oslo-upgradecheck-1.3.0[${PYTHON_USEDEP}]
	>=dev-python/oslo-utils-3.33.0[${PYTHON_USEDEP}]
	>=dev-python/oauthlib-0.6.2[${PYTHON_USEDEP}]
	>=dev-python/pysaml2-5.0.0[${PYTHON_USEDEP}]
	>=dev-python/pyjwt-1.6.1[${PYTHON_USEDEP}]
	>=dev-python/dogpile-cache-1.0.2[${PYTHON_USEDEP}]
	>=dev-python/jsonschema-3.2.0[${PYTHON_USEDEP}]
	>=dev-python/pycadf-1.1.0[${PYTHON_USEDEP}]
	>=dev-python/msgpack-0.5.0[${PYTHON_USEDEP}]
	>=dev-python/osprofiler-1.4.0[${PYTHON_USEDEP}]
	>=dev-python/pytz-2013.6[${PYTHON_USEDEP}]
	memcached? (
		>=dev-python/python-memcached-1.56[${PYTHON_USEDEP}]
	)
	mongo? (
		>=dev-python/pymongo-3.0.2[${PYTHON_USEDEP}]
	)
	ldap? (
		>=dev-python/python-ldap-3.1.0[${PYTHON_USEDEP}]
		>=dev-python/ldappool-2.3.1[${PYTHON_USEDEP}]
	)
	|| (
		www-servers/uwsgi[python,${PYTHON_USEDEP}]
		www-apache/mod_wsgi[${PYTHON_USEDEP}]
		www-servers/gunicorn[${PYTHON_USEDEP}]
	)
	acct-user/keystone
	acct-group/keystone
"
DEPEND="
	${RDEPEND}
	>=dev-python/pbr-2.0.0[${PYTHON_USEDEP}]
	test? (
		>=dev-python/bashate-0.5.1[${PYTHON_USEDEP}]
		>=dev-python/freezegun-0.3.6[${PYTHON_USEDEP}]
		>=dev-python/pytz-2013.6[${PYTHON_USEDEP}]
		>=dev-python/oslo-db-6.0.0[${PYTHON_USEDEP}]
		>=dev-python/fixtures-3.0.0[${PYTHON_USEDEP}]
		>=dev-python/lxml-4.5.0[${PYTHON_USEDEP}]
		>=dev-python/oslotest-3.2.0[${PYTHON_USEDEP}]
		>=dev-python/webtest-2.0.27[${PYTHON_USEDEP}]
		>=dev-python/testtools-2.2.0[${PYTHON_USEDEP}]
		>=dev-python/tempest-17.1.0[${PYTHON_USEDEP}]
		>=dev-python/requests-2.14.2[${PYTHON_USEDEP}]
	)
"

REQUIRED_USE="
	|| ( mysql postgres sqlite )
	test? ( ldap )
"

distutils_enable_tests pytest

python_prepare_all() {
	# it's in git, but not in the tarball.....
	sed -i '/^hacking/d' test-requirements.txt || die
	mkdir -p ${PN}/tests/tmp/ || die
	sed -i 's|/usr/local|/usr|g' httpd/keystone-uwsgi-* || die
	sed -i 's|python|python27|g' httpd/keystone-uwsgi-* || die
	# allow useage of renamed msgpack
	sed -i '/^msgpack/d' requirements.txt || die
	distutils-r1_python_prepare_all
}

python_install_all() {
	distutils-r1_python_install_all

	diropts -m 0750
	keepdir /etc/keystone /var/log/keystone
	insinto /etc/keystone
	insopts -m0640 -okeystone -gkeystone
	newins "${DISTDIR}/keystone.conf.sample-${PV}" keystone.conf.sample
	doins etc/logging.conf.sample
	doins etc/default_catalog.templates
#	doins etc/policy.v3cloudsample.json
	insinto /etc/keystone/httpd
	doins httpd/*

	fowners keystone:keystone /etc/keystone /etc/keystone/httpd /var/log/keystone
	# stupid python doing stupid things
	rm -r "${ED}/usr/etc" || die
}

pkg_postinst() {
	elog "You might want to run:"
	elog "emerge --config =${CATEGORY}/${PF}"
	elog "if this is a new install."
	elog "If you have not already configured your openssl installation"
	elog "please do it by modifying /etc/ssl/openssl.cnf"
	elog "BEFORE issuing the configuration command."
	elog "Otherwise default values will be used."
}

pkg_config() {
	if [ ! -d "${ROOT}"/etc/keystone/ssl ] ; then
		einfo "Press ENTER to configure the keystone PKI, or Control-C to abort now..."
		read
		"${ROOT}"/usr/bin/keystone-manage pki_setup --keystone-user keystone --keystone-group keystone
	else
		einfo "keystone PKI certificates directory already present, skipping configuration"
	fi
}
