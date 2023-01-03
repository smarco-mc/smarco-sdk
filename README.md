# Smart Core Silicon Software Development Kit

This repository contains OpenEmbedded/Yocto SDK for Smart Core silicon
chips.

## Pre-requisites

First, you need to install `repo` from Google, please refer to [the
following instructionss](https://source.android.com/setup/develop#installing-repo).

Second, you need to install packages for OE build tool - BitBake to work
properly. The BitBake tool depends on Python 3. Please refer to [the
following instructions](http://docs.yoctoproject.org/ref-manual/system-requirements.html#required-packages-for-the-build-host).
> For Ubuntu 18.04 (or newer) install python3-distutils package.

You need to perform the following commads every time you want a clean
setup based on the latest layers.

```bash
mkdir riscv-smarco && cd riscv-smarco
repo init -u https://github.com/smarco-mc/smarco-sdk -m tools/manifests/smarco.xml
repo sync
```

### Creating a Working Branch

If you want to make modifications to existing layers then creating working
branches in all repositories is advisable.

```bash
repo start work --all
```

### Getting Build Tools (optional)

OpenEmbedded-Core requires GCC 6 or newer to be available on the host
system. Your host system might have an older version of GCC if you use LTS
(Long Term Support) Linux distribution (e.g. Ubuntu 16.04.6 has GCC
5.4.0).

#### Installing OpenEmbedded-Core Build Tools (Pre-Built)

```bash
./openembedded-core/scripts/install-buildtools -r yocto-3.2_M2 -V '3.1+snapshot' -t 20200729
```

The native SDK will be installed under `$BUILDDIR/../openembedded-core/buildtools` prefix.

Finally you should be able to use build tools:

```bash
. ./openembedded-core/buildtools/environment-setup-x86_64-pokysdk-linux
```

#### Building Your Own Build Tools

To build your own build tools execute the command below (e.x., BUILDDIR
points to build which is under current directory (riscv-smarco):

```bash
mkdir -p $BUILDDIR
. ./openembedded-core/oe-init-build-env $BUILDDIR
bitbake buildtools-extended-tarball
```

You can find the native SDK under `$BUILDDIR/tmp-glibc/deploy/sdk/` directory.

Now you can install build tools:

```bash
$BUILDDIR/tmp-glibc/deploy/sdk/x86_64-buildtools-extended-nativesdk-standalone-nodistro.0.sh -d $BUILDDIR/../openembedded-core/buildtools -y
```

Finally you should be able to use your build tools:

```bash
. $BUILDDIR/../openembedded-core/buildtools/environment-setup-x86_64-oesdk-linux
```

### Setting up Build Environment

This step has to be done after you modify your environment with toolchain
you want to use otherwise wrong host tools might be available in the
package build environment. For example, `gcc` from host system will be
used for building `*-native` packages.

```bash
. ./smarco-sdk/setup.sh
```

> You can verify and fix your host tools by checking symlinks in
  `$BUILDDIR/tmp-glibc/hosttools` directory.

### Configuring BitBake Parallel Number of Tasks/Jobs

There are 3 variables that control the number of parallel tasks/jobs
BitBake will use: `BB_NUMBER_PARSE_THREADS`, `BB_NUMBER_THREADS` and
`PARALLEL_MAKE`. The last two are the most important, and both are set to
number of cores available on the system. You can set them in your
`$BUILDDIR/conf/local.conf` or in your shell environment similar to how
`MACHINE` is used (see next section). Example:

```bash
PARALLEL_MAKE="-j 4" BB_NUMBER_THREADS=4 MACHINE=duowen bitbake demo-coreip-cli
```

Leaving defaults could cause high load averages, high memory usage, high
IO wait and could make your system unresponsive due to resources overuse.
The defaults should be changed based on your system configuration.
