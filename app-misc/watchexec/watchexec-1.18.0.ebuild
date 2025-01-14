# Copyright 2022 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

# Auto-Generated by cargo-ebuild 0.5.0

EAPI=8

CRATES="
	addr2line-0.17.0
	adler-1.0.2
	aho-corasick-0.7.18
	ansi_term-0.12.1
	anyhow-1.0.52
	arrayref-0.3.6
	arrayvec-0.5.2
	assert_cmd-2.0.4
	async-io-1.6.0
	async-recursion-1.0.0
	async-stream-0.3.2
	async-stream-impl-0.3.2
	async-trait-0.1.52
	atomic-take-1.0.0
	atty-0.2.14
	autocfg-1.0.1
	backtrace-0.3.63
	base64-0.13.0
	bitflags-1.2.1
	blake2b_simd-0.5.11
	block-0.1.6
	bstr-0.2.17
	byteorder-1.4.3
	bytes-1.1.0
	cache-padded-1.2.0
	cc-1.0.72
	cfg-if-0.1.10
	cfg-if-1.0.0
	chrono-0.4.19
	clap-2.34.0
	clearscreen-1.0.9
	command-group-1.0.8
	concurrent-queue-1.2.2
	console-0.15.0
	console-api-0.1.0
	console-subscriber-0.1.0
	constant_time_eq-0.1.5
	crc32fast-1.3.0
	crossbeam-channel-0.5.2
	crossbeam-utils-0.8.6
	derivative-2.2.0
	difflib-0.4.0
	dirs-1.0.5
	dirs-2.0.2
	dirs-sys-0.3.6
	doc-comment-0.3.3
	dunce-1.0.2
	either-1.6.1
	embed-resource-1.6.5
	encode_unicode-0.3.6
	enumflags2-0.6.4
	enumflags2_derive-0.6.4
	fastrand-1.6.0
	filetime-0.2.15
	fixedbitset-0.4.1
	flate2-1.0.22
	fnv-1.0.7
	form_urlencoded-1.0.1
	fsevent-sys-4.1.0
	futures-0.3.19
	futures-channel-0.3.19
	futures-core-0.3.19
	futures-executor-0.3.19
	futures-io-0.3.19
	futures-lite-1.12.0
	futures-macro-0.3.19
	futures-sink-0.3.19
	futures-task-0.3.19
	futures-util-0.3.19
	getrandom-0.1.16
	getrandom-0.2.4
	gimli-0.26.1
	git2-0.13.25
	globset-0.4.8
	h2-0.3.10
	hashbrown-0.11.2
	hdrhistogram-7.4.0
	heck-0.3.3
	hermit-abi-0.1.19
	http-0.2.6
	http-body-0.4.4
	httparse-1.5.1
	httpdate-1.0.2
	humantime-2.1.0
	hyper-0.14.16
	hyper-timeout-0.4.1
	idna-0.2.3
	ignore-0.4.18
	indexmap-1.8.0
	inotify-0.9.6
	inotify-sys-0.1.5
	insta-1.10.0
	instant-0.1.12
	is_ci-1.1.1
	itertools-0.10.3
	itoa-0.4.8
	itoa-1.0.1
	jobserver-0.1.24
	kqueue-1.0.4
	kqueue-sys-1.0.3
	lazy_static-1.4.0
	libc-0.2.112
	libgit2-sys-0.12.26+1.3.0
	libmimalloc-sys-0.1.23
	libz-sys-1.1.3
	linked-hash-map-0.5.4
	lock_api-0.4.5
	log-0.4.14
	mac-notification-sys-0.3.0
	malloc_buf-0.0.6
	matchers-0.1.0
	matches-0.1.9
	memchr-2.4.1
	memoffset-0.6.5
	miette-3.3.0
	miette-derive-3.3.0
	mimalloc-0.1.27
	minimal-lexical-0.2.1
	miniz_oxide-0.4.4
	mio-0.7.14
	miow-0.3.7
	multimap-0.8.3
	nb-connect-1.2.0
	nix-0.20.2
	nix-0.22.2
	nom-5.1.2
	nom-7.1.0
	notify-5.0.0-pre.13
	notify-rust-4.5.5
	ntapi-0.3.6
	num-integer-0.1.44
	num-traits-0.2.14
	num_cpus-1.13.1
	objc-0.2.7
	objc-foundation-0.1.1
	objc_id-0.1.1
	object-0.27.1
	once_cell-1.9.0
	owo-colors-3.2.0
	parking-2.0.0
	parking_lot-0.11.2
	parking_lot_core-0.8.5
	percent-encoding-2.1.0
	petgraph-0.6.0
	phf-0.8.0
	phf_codegen-0.8.0
	phf_generator-0.8.0
	phf_shared-0.8.0
	pin-project-1.0.10
	pin-project-internal-1.0.10
	pin-project-lite-0.2.8
	pin-utils-0.1.0
	pkg-config-0.3.24
	polling-2.2.0
	ppv-lite86-0.2.16
	predicates-2.1.1
	predicates-core-1.0.3
	predicates-tree-1.0.5
	proc-macro-crate-0.1.5
	proc-macro-crate-1.1.0
	proc-macro2-1.0.36
	prost-0.9.0
	prost-build-0.9.0
	prost-derive-0.9.0
	prost-types-0.9.0
	quote-1.0.14
	rand-0.7.3
	rand-0.8.4
	rand_chacha-0.2.2
	rand_chacha-0.3.1
	rand_core-0.5.1
	rand_core-0.6.3
	rand_hc-0.2.0
	rand_hc-0.3.1
	rand_pcg-0.2.1
	redox_syscall-0.1.57
	redox_syscall-0.2.10
	redox_users-0.3.5
	redox_users-0.4.0
	regex-1.5.4
	regex-automata-0.1.10
	regex-syntax-0.6.25
	remove_dir_all-0.5.3
	rust-argon2-0.8.3
	rustc-demangle-0.1.21
	ryu-1.0.9
	same-file-1.0.6
	scoped-tls-1.0.0
	scopeguard-1.1.0
	serde-1.0.133
	serde_derive-1.0.133
	serde_json-1.0.75
	serde_repr-0.1.7
	serde_yaml-0.8.23
	sharded-slab-0.1.4
	signal-hook-registry-1.4.0
	similar-2.1.0
	siphasher-0.3.9
	slab-0.4.5
	smallvec-1.8.0
	smawk-0.3.1
	socket2-0.4.2
	static_assertions-1.1.0
	strum-0.22.0
	strum_macros-0.22.0
	supports-color-1.3.0
	supports-hyperlinks-1.2.0
	supports-unicode-1.0.2
	syn-1.0.85
	tempfile-3.3.0
	term_size-0.3.2
	terminal_size-0.1.17
	terminfo-0.7.3
	termtree-0.2.4
	textwrap-0.11.0
	textwrap-0.14.2
	thiserror-1.0.30
	thiserror-impl-1.0.30
	thread_local-1.1.3
	time-0.1.43
	tinyvec-1.5.1
	tinyvec_macros-0.1.0
	tokio-1.15.0
	tokio-io-timeout-1.2.0
	tokio-macros-1.7.0
	tokio-stream-0.1.8
	tokio-util-0.6.9
	toml-0.5.8
	tonic-0.6.2
	tonic-build-0.6.2
	tower-0.4.11
	tower-layer-0.3.1
	tower-service-0.3.1
	tracing-0.1.29
	tracing-attributes-0.1.18
	tracing-core-0.1.21
	tracing-futures-0.2.5
	tracing-log-0.1.2
	tracing-subscriber-0.3.6
	try-lock-0.2.3
	unicase-2.6.0
	unicode-bidi-0.3.7
	unicode-linebreak-0.1.2
	unicode-normalization-0.1.19
	unicode-segmentation-1.8.0
	unicode-width-0.1.9
	unicode-xid-0.2.2
	url-2.2.2
	uuid-0.8.2
	vcpkg-0.2.15
	version_check-0.9.4
	vswhom-0.1.0
	vswhom-sys-0.1.0
	wait-timeout-0.2.0
	waker-fn-1.1.0
	walkdir-2.3.2
	want-0.3.0
	wasi-0.9.0+wasi-snapshot-preview1
	wasi-0.10.2+wasi-snapshot-preview1
	watchexec-2.0.0-pre.6
	wepoll-ffi-0.1.2
	which-4.2.2
	winapi-0.3.9
	winapi-i686-pc-windows-gnu-0.4.0
	winapi-util-0.1.5
	winapi-x86_64-pc-windows-gnu-0.4.0
	windows-0.24.0
	windows_i686_gnu-0.24.0
	windows_i686_msvc-0.24.0
	windows_x86_64_gnu-0.24.0
	windows_x86_64_msvc-0.24.0
	winreg-0.10.1
	winrt-notification-0.5.1
	xml-rs-0.8.4
	yaml-rust-0.4.5
	zbus-1.9.2
	zbus_macros-1.9.2
	zvariant-2.10.0
	zvariant_derive-2.10.0
"

inherit cargo

DESCRIPTION="Executes commands in response to file modifications"
HOMEPAGE="https://github.com/watchexec/watchexec"
SRC_URI="https://github.com/watchexec/${PN}/archive/refs/tags/cli-v${PV}.tar.gz -> ${P}.tar.gz"
SRC_URI+=" $(cargo_crate_uris)"
LICENSE="Apache-2.0 BSD BSD-2 CC0-1.0 ISC MIT WTFPL-2"
SLOT="0"
KEYWORDS="~amd64 ~x86"
# Prevent portage from trying to fetch bunch of *.crate from mirror despite they are not mirrored.
RESTRICT="mirror"

S="${WORKDIR}/${PN}-cli-v${PV}"
DOCS=( README.md )
HTML_DOCS=( doc/watchexec.1.html )

QA_FLAGS_IGNORED="usr/bin/watchexec"

src_compile() {
	cargo_src_compile --manifest-path=cli/Cargo.toml
}

src_install() {
	cargo_src_install --path cli

	einstalldocs
	doman doc/watchexec.1

	insinto /usr/share/zsh/site-functions
	newins completions/zsh _watchexec
}

src_test() {
	cargo_src_test --manifest-path lib/Cargo.toml --lib
	cargo_src_test --manifest-path cli/Cargo.toml
}
