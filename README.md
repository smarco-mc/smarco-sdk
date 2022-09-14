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
