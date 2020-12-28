# Copyright 1999-2020 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

PYTHON_COMPAT=( python3_{6,7,8} )

inherit distutils-r1

DESCRIPTION="An easy-to-use Python library for accessing the Twitter API."
HOMEPAGE="https://www.tweepy.org/"
SRC_URI="https://github.com/${PN}/${PN}/archive/v${PV}.tar.gz -> ${P}.tar.gz"

KEYWORDS="~amd64"
LICENSE="MIT"
SLOT="0"

RDEPEND="
	dev-python/requests[${PYTHON_USEDEP},socks5]
	dev-python/requests-oauthlib[${PYTHON_USEDEP}]
"

DEPEND="
	${RDEPEND}
	test? (
		dev-python/mock[${PYTHON_USEDEP}]
		dev-python/vcrpy[${PYTHON_USEDEP}]
	)
"

distutils_enable_tests nose
