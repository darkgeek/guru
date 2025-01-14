# Copyright 1999-2021 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

PYTHON_COMPAT=( python3_{8..10} )
inherit distutils-r1

DESCRIPTION="Python implementation of SAML Version 2 to be used in a WSGI environment"
HOMEPAGE="https://github.com/rohe/pysaml2"
SRC_URI="https://github.com/IdentityPython/${PN}/archive/refs/tags/v${PV}.tar.gz -> ${P}.tar.gz"

LICENSE="Apache-2.0"
SLOT="0"
KEYWORDS="~amd64"

RDEPEND="
	dev-python/cryptography[${PYTHON_USEDEP}]
	dev-python/defusedxml[${PYTHON_USEDEP}]
	dev-python/pyopenssl[${PYTHON_USEDEP}]
	dev-python/python-dateutil[${PYTHON_USEDEP}]
	dev-python/python-xmlsec[${PYTHON_USEDEP}]
	dev-python/pytz[${PYTHON_USEDEP}]
	dev-python/requests[${PYTHON_USEDEP}]
	dev-python/six[${PYTHON_USEDEP}]
	dev-python/xmlschema[${PYTHON_USEDEP}]
	$(python_gen_cond_dep \
		'dev-python/importlib_resources[${PYTHON_USEDEP}]' python3.8)
"
BDEPEND="test? (
	dev-python/mock[${PYTHON_USEDEP}]
	dev-python/pyasn1[${PYTHON_USEDEP}]
	dev-python/pymongo[${PYTHON_USEDEP}]
	dev-python/responses[${PYTHON_USEDEP}]
	dev-python/toml[${PYTHON_USEDEP}]
)"

distutils_enable_tests --install pytest

python_prepare_all() {
	# No module named 'pymongo.mongo_replica_set_client'
	rm tests/test_{75_mongodb,76_metadata_in_mdb}.py || die
	distutils-r1_python_prepare_all
}
