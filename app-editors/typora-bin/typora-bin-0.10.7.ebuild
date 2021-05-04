# Copyright 2019-2021 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit unpacker xdg

DESCRIPTION="a markdown editor,markdown reader."
HOMEPAGE="https://typora.io"
SRC_URI="https://typora.io/linux/typora_${PV}_amd64.deb"

LICENSE="Typora-EULA"
SLOT="0"
KEYWORDS="-* ~amd64"
IUSE=""

DEPEND=""
RDEPEND="
	app-accessibility/at-spi2-atk
	dev-libs/atk
	dev-libs/nss
	media-libs/alsa-lib
	net-print/cups
	x11-libs/cairo
	x11-libs/gdk-pixbuf
	x11-libs/gtk+:3
	x11-libs/pango
	x11-libs/libdrm
	x11-libs/libXcomposite
	x11-libs/libXcursor
	x11-libs/libXdamage
	x11-libs/libXfixes
	x11-libs/libXi
	x11-libs/libXrandr
	x11-libs/libXrender
	x11-libs/libXtst
	x11-libs/libXScrnSaver
	${DEPEND}"
BDEPEND=""

QA_PREBUILT="*"
S="${WORKDIR}"

src_install() {
	mv "${S}"/* "${ED}" || die
	mv "${ED}/usr/share/doc/${PN//-bin}" "${ED}/usr/share/doc/${PF}" || die
}