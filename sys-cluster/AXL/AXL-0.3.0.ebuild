# Copyright 1999-2021 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI="7"

inherit cmake

DESCRIPTION="AXL provides a common C interface to transfer files in an HPC storage hierarchy."
HOMEPAGE="https://github.com/ECP-VeloC/AXL"
SRC_URI="https://github.com/ECP-VeloC/${PN}/archive/v${PV}.tar.gz -> ${P}.tar.gz"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64"
IUSE="test"

RDEPEND="
	sys-libs/zlib
	sys-cluster/KVTree
"
DEPEND="${RDEPEND}"
BDEPEND="
	>=dev-util/cmake-2.8
"

RESTRICT="test" # https://github.com/ECP-VeloC/AXL/issues/110
#RESTRICT="!test? ( test )"
PATCHES=(
	"${FILESDIR}/no-install-readme.patch"
)

src_configure() {
	local mycmakeargs=(
		#other options available: CRAY_DW INTEL_CPPR IBM_BBAPI
		-DAXL_ASYNC_API=NONE
	)
	cmake_src_configure
}

src_install() {
	cmake_src_install
	dodoc -r doc/.
}
