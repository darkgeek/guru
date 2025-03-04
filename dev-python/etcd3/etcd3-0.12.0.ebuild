# Copyright 1999-2021 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

PYTHON_COMPAT=( python3_8 )

inherit distutils-r1

DESCRIPTION="Python client for the etcd API v3"
HOMEPAGE="
	https://pypi.org/project/etcd3
	https://github.com/kragniz/python-etcd3
"
SRC_URI="mirror://pypi/${PN:0:1}/${PN}/${P}.tar.gz"

LICENSE="Apache-2.0"
SLOT="0"
KEYWORDS="~amd64"

RDEPEND="
	>=dev-python/grpcio-1.2.0[${PYTHON_USEDEP}]
	>=dev-python/tenacity-5.0.2[${PYTHON_USEDEP}]
	>=dev-python/protobuf-python-3.6.1[${PYTHON_USEDEP}]
"
DEPEND="${RDEPEND}"
BDEPEND="
	test? (
		>=dev-python/pyyaml-5.1[${PYTHON_USEDEP}]
		>=dev-python/mock-2.0.0[${PYTHON_USEDEP}]
		dev-python/grpcio-tools[${PYTHON_USEDEP}]
		dev-python/hypothesis[${PYTHON_USEDEP}]
		dev-python/pifpaf[${PYTHON_USEDEP}]
	)
"

distutils_enable_tests pytest
