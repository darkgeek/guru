# Copyright 1999-2021 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

SSL_DAYS=36500
SSL_CERT_MANDATORY=1
VERIFY_SIG_METHOD="signify"
inherit ssl-cert systemd toolchain-funcs verify-sig

DESCRIPTION="Simple and secure Gemini server"
HOMEPAGE="https://gmid.omarpolo.com"

if [[ ${PV} == 9999 ]]; then
	EGIT_REPO_URI="https://git.omarpolo.com/${PN} https://github.com/omar-polo/${PN}.git"
	inherit git-r3
else
	SRC_URI="https://github.com/omar-polo/${PN}/releases/download/${PV}/${P}.tar.gz
		verify-sig? ( https://github.com/omar-polo/${PN}/releases/download/${PV}/SHA256.sig -> ${P}.sha.sig )"
	KEYWORDS="~amd64 ~x86"
fi

LICENSE="BSD ISC MIT"
SLOT="0"
IUSE="seccomp test"
RESTRICT="!test? ( test )"

DEPEND="
	!elibc_Darwin? ( dev-libs/libbsd )
	acct-user/gemini
	dev-libs/imsg-compat
	dev-libs/libevent:=
	dev-libs/libretls
	dev-libs/openssl:=
"
RDEPEND="${DEPEND}"
BDEPEND="
	virtual/pkgconfig
	virtual/yacc
"
if [[ ${PV} != 9999 ]]; then
	BDEPEND+="verify-sig? ( sec-keys/signify-keys-gmid:$(ver_cut 1-2) )"
fi

VERIFY_SIG_OPENPGP_KEY_PATH="${BROOT}/usr/share/signify-keys/${PN}-$(ver_cut 1-2).pub"

DOCS=( README.md ChangeLog contrib/README )

src_unpack() {
	if [[ ${PV} == 9999 ]]; then
		git-r3_src_unpack
	else
		if use verify-sig; then
			# Too many levels of symbolic links
			cp "${DISTDIR}"/${P}.{sha.sig,tar.gz} "${WORKDIR}" || die
			cd "${WORKDIR}" || die
			verify-sig_verify_signed_checksums \
				${P}.sha.sig sha256 ${P}.tar.gz
		fi
		default
	fi
}

src_prepare() {
	default

	sed \
		-e "s:/usr/local/bin/gmid:/usr/bin/gmid:" \
		-e "s:/etc/gmid.conf:/etc/gmid/gmid.conf:" \
		-i contrib/gmid.service || die
}

src_configure() {
	local conf_args
	tc-export CC

	# note: not an autoconf configure script
	conf_args=(
		PREFIX="${EPREFIX}"/usr/share
		BINDIR="${EPREFIX}"/usr/bin
		$(use_enable seccomp sandbox)
	)

	./configure "${conf_args[@]}" || die

	if use seccomp && has usersandbox ${FEATURES} ; then
		export SKIP_RUNTIME_TESTS=1
	fi
}

src_compile() {
	emake gmid
	if use test ; then
		emake -C regress gg data puny-test fcgi-test
	fi
}

src_test() {
	emake regress
}

src_install() {
	default

	insinto /etc/gmid
	doins "${FILESDIR}"/gmid.conf

	insinto /usr/share/vim/vimfiles
	doins -r contrib/vim/*

	systemd_dounit contrib/gmid.service
	newinitd "${FILESDIR}"/gmid.initd gmid
	newconfd "${FILESDIR}"/gmid.confd gmid

	keepdir /var/gemini/localhost
}

pkg_postinst() {
	if [[ ! -f "${EROOT}"/etc/ssl/${PN}/${PN}.key ]]; then
		install_cert /etc/ssl/${PN}/${PN}
		chown gemini:gemini "${EROOT}"/etc/ssl/${PN}/${PN}.{crt,csr,key,pem}
	fi

	einfo "This gemini server can be run as a user with zero configuration.\n"
	einfo "In order to use it with the init service you will need to generate a"
	einfo "self-signed TLS certificate and a key and set up the configuration"
	einfo "file (see man 1 gmid for details)."
}
