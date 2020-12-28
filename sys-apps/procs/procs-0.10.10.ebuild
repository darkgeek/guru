# Copyright 2017-2020 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

CRATES="
	addr2line-0.14.0
	adler-0.2.3
	ansi_term-0.11.0
	anyhow-1.0.34
	arrayref-0.3.6
	arrayvec-0.5.2
	atty-0.2.14
	autocfg-1.0.1
	backtrace-0.3.55
	backtrace-sys-0.1.23
	base64-0.13.0
	base64-0.9.3
	bitflags-1.2.1
	blake2b_simd-0.5.11
	byte-unit-4.0.9
	byteorder-1.3.4
	bytes-0.5.6
	cc-1.0.65
	cfg-if-0.1.10
	cfg-if-1.0.0
	chrono-0.4.19
	clap-2.33.3
	console-0.13.0
	const_fn-0.4.3
	constant_time_eq-0.1.5
	crc32fast-1.2.1
	crossbeam-utils-0.8.0
	directories-3.0.1
	dirs-1.0.5
	dirs-sys-0.3.5
	dockworker-0.0.19
	encode_unicode-0.3.6
	errno-0.2.7
	errno-dragonfly-0.1.1
	failure-0.1.8
	failure_derive-0.1.8
	filetime-0.2.13
	flate2-1.0.19
	fnv-1.0.7
	form_urlencoded-1.0.0
	fuchsia-zircon-0.3.3
	fuchsia-zircon-sys-0.3.3
	futures-0.3.8
	futures-channel-0.3.8
	futures-core-0.3.8
	futures-executor-0.3.8
	futures-io-0.3.8
	futures-macro-0.3.8
	futures-sink-0.3.8
	futures-task-0.3.8
	futures-util-0.3.8
	gcc-0.3.55
	getch-0.2.1
	getrandom-0.1.15
	gimli-0.23.0
	h2-0.2.7
	hashbrown-0.9.1
	heck-0.3.1
	hermit-abi-0.1.17
	hex-0.4.2
	http-0.2.1
	http-body-0.3.1
	httparse-1.3.4
	httpdate-0.3.2
	hyper-0.13.9
	hyperlocal-0.7.0
	hyperx-1.2.0
	idna-0.2.0
	indexmap-1.6.0
	iovec-0.1.4
	itoa-0.4.6
	kernel32-sys-0.2.2
	language-tags-0.2.2
	lazy_static-1.4.0
	libc-0.2.80
	libproc-0.9.1
	log-0.4.11
	matches-0.1.8
	memchr-2.3.4
	mime-0.3.16
	miniz_oxide-0.4.3
	mio-0.6.22
	mio-named-pipes-0.1.7
	mio-uds-0.6.8
	miow-0.2.1
	miow-0.3.6
	named_pipe-0.2.4
	net2-0.2.35
	nix-0.15.0
	num-integer-0.1.44
	num-traits-0.2.14
	num_cpus-1.13.0
	object-0.22.0
	once_cell-1.5.2
	pager-0.16.0
	percent-encoding-2.1.0
	pin-project-0.4.27
	pin-project-1.0.2
	pin-project-internal-0.4.27
	pin-project-internal-1.0.2
	pin-project-lite-0.1.11
	pin-project-lite-0.2.0
	pin-utils-0.1.0
	proc-macro-error-1.0.4
	proc-macro-error-attr-1.0.4
	proc-macro-hack-0.5.19
	proc-macro-nested-0.1.6
	proc-macro2-1.0.24
	procfs-0.9.0
	quote-1.0.7
	redox_syscall-0.1.57
	redox_users-0.3.5
	regex-1.4.2
	regex-syntax-0.6.21
	rust-argon2-0.8.3
	rustc-demangle-0.1.18
	ryu-1.0.5
	safemem-0.3.3
	serde-1.0.117
	serde_derive-1.0.117
	serde_json-1.0.59
	signal-hook-registry-1.2.2
	slab-0.4.2
	socket2-0.3.17
	strsim-0.8.0
	structopt-0.3.20
	structopt-derive-0.4.13
	syn-1.0.51
	synstructure-0.12.4
	tar-0.4.30
	terminal_size-0.1.15
	termios-0.2.2
	textwrap-0.11.0
	thiserror-1.0.22
	thiserror-impl-1.0.22
	time-0.1.44
	tinyvec-1.1.0
	tinyvec_macros-0.1.0
	tokio-0.2.23
	tokio-macros-0.2.6
	tokio-util-0.3.1
	toml-0.5.7
	tower-service-0.3.0
	tracing-0.1.22
	tracing-core-0.1.17
	tracing-futures-0.2.4
	try-lock-0.2.3
	unicase-2.6.0
	unicode-bidi-0.3.4
	unicode-normalization-0.1.16
	unicode-segmentation-1.7.0
	unicode-width-0.1.8
	unicode-xid-0.2.1
	unix_socket-0.5.0
	url-2.2.0
	users-0.11.0
	utf8-width-0.1.4
	vec_map-0.8.2
	version_check-0.9.2
	void-1.0.2
	want-0.3.0
	wasi-0.10.0+wasi-snapshot-preview1
	wasi-0.9.0+wasi-snapshot-preview1
	which-4.0.2
	winapi-0.2.8
	winapi-0.3.9
	winapi-build-0.1.1
	winapi-i686-pc-windows-gnu-0.4.0
	winapi-util-0.1.5
	winapi-x86_64-pc-windows-gnu-0.4.0
	ws2_32-sys-0.2.1
	xattr-0.2.2
"

inherit cargo

DESCRIPTION="A modern replacement for ps"
HOMEPAGE="https://github.com/dalance/procs"
SRC_URI="
	https://github.com/dalance/procs/archive/v${PV}.tar.gz
	$(cargo_crate_uris ${CRATES})
"

LICENSE="Apache-2.0 BSD BSD-2 CC0-1.0 MIT ZLIB"
SLOT="0"
KEYWORDS="~amd64"
RESTRICT="mirror"