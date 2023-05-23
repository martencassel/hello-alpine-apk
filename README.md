# Unofficial Alpine Linux Packaging Guide

This guide borrows from  the RPM Packaging Guide
and tries to explain the basics of packaging alpine packages.

## Introduction

This Alpine APK Packaging Guide documents:

**How to package source code into an APK**

This is for software developers who need to package software into Alpine Linux APKs.

# Prerequisites

To follow this tutorial you need the tools mentioned below:

* Docker 

* Git 

# Why Package Software with APK ? 

The APK Package Manager (Alpine Package keeper) is a package management system that runs on Alpine Linux.
APK makes it easier for you to consume, distribute, manage, and update software that you create for Alpine Linux. The Alpine Linux distribution has a offical source of packages at https://pkgs.alpinelinux.org/.

With APK, you can:

**Install, reinstall, remove, upgrade and verify packages**

**Use metadata to describe packages, their installation details, and so on.**

**Digitally sign your packages**

# Your First APK Package
Here is a complete, working APKBUILD file with many things skipped and simplified:.

```bash
pkgname=hello-world
pkgver="1"
pkgrel=0
pkgdesc="Most simple APK package"
url="http://www.example.com"
arch="all"
license="FIXME"
depends=""
makedepends=""
checkdepends=""
install=""
subpackages=""
source="hello-world-1.tar.gz"
builddir="$srcdir/"

build() {
        :
}

check() {
        # Replace with proper check command(s)
        :
}

package() {
        mkdir -p "$pkgdir/usr/bin/"
        install -m 755 hello-world.sh $pkgdir/usr/bin/hello-world.sh
}

sha512sums="
771e132d32e1c5c223b8b4b6a530668b79a41a7f108f94e6649c6f74be8f2bd5a07ec489da4d59493ec2713676758cfb6b1e28dfc88f5ecda005cdc77f8eef08  hello-world-1.tar.gz
"
```
# What is a APKBUILD File ? 

APKBUILD is a file that contains the scripts that are used in order 
to build Alpine Packages using the abuild tool.
It contains "recipes" on how something should be built and compiled. 
This is used when building Alpine Packages from source.
The abuild script reads the APKBUILD file and executes the steps needed to create a package.


# APK Packaging Workspace

To setup a directory layout that is the APK packaging workspace,

First launch the docker container shell,
```bash
$ make builder-shell
```

Then create the directory tree,

```bash
/host $

/host $ mkdir -p ~/apkbuild/main/

/host $ tree ~/apkbuild/

/root/apkbuild/
└── main

1 directories, 0 files
```
The sample APKBUILD file shown above, exists in this repository in the example-code directory.

```bash
/host $ cp /host/example-code/APKBUILD.hello-world ~/apkbuild/main/APKBUILD
/host $ tree ~/apkbuild/
/root/apkbuild/
└── main
    ├── APKBUILD

1 directories, 2 files
/host #
```


# Generate a keypair

Building a package, requires a keypair that is used to sign the APK package and APKINDEX file.
Run the following command to create a keypair in ~/.abuild/ directory,

```bash
/host $ abuild-keygen -an
$ ls -lt ~/.abuild/
total 8
-rw-------    1 root     root          3272 May 20 05:30 -64685ae9.rsa
-rw-r--r--    1 root     root           800 May 20 05:30 -64685ae9.rsa.pub
```

# Prepare source code

We need to have the source code archive available in the build directory tree,
Copy it from the example folder

```bash
/host $ cp /host/example-code/hello-world-1.tar.gz ~/apkbuild/main/
/host $ tree ~/apkbuild/main/
/root/apkbuild/main/
├── APKBUILD
└── hello-world-1.tar.gz

0 directories, 2 files
/host $
```
# Add a checksum to the APKBUILD file

Before building, we need to add a checksum using the abuild command,

```bash
/host/repo/main/hello-world # abuild -F checksum
>>> hello-world: Updating the sha512sums in /host/repo/main/hello-world/APKBUILD...
```

```bash
/host/repo/main/hello-world # abuild -Fr

>>> hello-world: Building main/hello-world 1-r0 (using abuild 3.11.0-r1) started Sat, 20 May 2023 05:36:34 +0000
>>> hello-world: Checking sanity of /host/repo/main/hello-world/APKBUILD...
>>> WARNING: hello-world: No maintainer
>>> hello-world: Analyzing dependencies...
>>> hello-world: Installing for build: build-base
WARNING: opening /root/packages//main: No such file or directory
fetch https://dl-cdn.alpinelinux.org/alpine/edge/main/x86_64/APKINDEX.tar.gz
fetch https://dl-cdn.alpinelinux.org/alpine/edge/community/x86_64/APKINDEX.tar.gz
(1/1) Installing .makedepends-hello-world (20230520.053636)
OK: 266 MiB in 65 packages
>>> hello-world: Cleaning up srcdir
>>> hello-world: Cleaning up pkgdir
>>> hello-world: Checking sha512sums...
hello-world-1.tar.gz: OK
>>> hello-world: Unpacking /host/repo/main/hello-world/hello-world-1.tar.gz...
>>> hello-world: Running postcheck for hello-world
>>> hello-world: Preparing package hello-world...
>>> hello-world: Stripping binaries
>>> WARNING: hello-world: No arch specific binaries found so arch should probably be set to "noarch"
>>> hello-world: Scanning shared objects
>>> hello-world: Tracing dependencies...
>>> hello-world: Package size: 16.0 KB
>>> hello-world: Compressing data...
>>> hello-world: Create checksum...
>>> hello-world: Create hello-world-1-r0.apk
>>> hello-world: Build complete at Sat, 20 May 2023 05:36:36 +0000 elapsed time 0h 0m 2s
>>> hello-world: Cleaning up srcdir
>>> hello-world: Cleaning up pkgdir
>>> hello-world: Uninstalling dependencies...
(1/1) Purging .makedepends-hello-world (20230520.053636)
OK: 266 MiB in 64 packages
>>> hello-world: Updating the main/x86_64 repository index...
>>> hello-world: Signing the index...
```

```bash
$ tree ~/packages/
/root/packages/
└── main
    └── x86_64
        ├── APKINDEX.tar.gz
        └── hello-world-1-r0.apk

2 directories, 2 files
```

```bash
$ tar tvf ~/packages/main/x86_64/hello-world-1-r0.apk
-rw-r--r-- 0/0             512 2023-05-20 05:36 .SIGN.RSA.-64685c04.rsa.pub
-rw-r--r-- root/root       415 2023-05-20 05:36 .PKGINFO
drwxr-xr-x root/root         0 2023-05-20 05:36 usr/
drwxr-xr-x root/root         0 2023-05-20 05:36 usr/bin/
-rwxr-xr-x root/root        29 2023-05-20 05:36 usr/bin/hello-world.sh
```

```bash
$ apk add --allow-untrusted ~/packages/main/x86_64/hello-world-1-r0.apk
(1/1) Installing hello-world (1-r0)
Executing busybox-1.36.0-r5.trigger
OK: 267 MiB in 65 packages
```

```bash
$ /usr/bin/hello-world.sh
Hello world
```


# What is an APK ? 
An APK package is a file containing other files and information about them needed by the system. 
An Alpine APK package consists of a tar archive, which contains the files, and the package metadata file, 
which contains metadata about the package. The apk package manager uses this file to determine dependencies,
where to install files, and other information.

# Building cello

```bash
/host/repo/main/cello # abuild -F checksum
>>> cello: Updating the sha512sums in /host/repo/main/cello/APKBUILD...
/host/repo/main/cello # abuild -Fr
>>> cello: Building main/cello 1-r0 (using abuild 3.11.0-r1) started Sat, 20 May 2023 05:39:32 +0000
>>> cello: Checking sanity of /host/repo/main/cello/APKBUILD...
>>> WARNING: cello: No maintainer
>>> cello: Analyzing dependencies...
>>> cello: Installing for build: build-base
WARNING: opening /root/packages//main: UNTRUSTED signature
(1/1) Installing .makedepends-cello (20230520.053933)
OK: 267 MiB in 66 packages
>>> cello: Cleaning up srcdir
>>> cello: Cleaning up pkgdir
>>> cello: Checking sha512sums...
cello-1.0.tar.gz: OK
>>> cello: Unpacking /host/repo/main/cello/cello-1.0.tar.gz...
gcc -g -o cello cello.c
mkdir -p /host/repo/main/cello/pkg/cello/usr/bin
install -m 0755 cello /host/repo/main/cello/pkg/cello/usr/bin/cello
>>> cello: Running postcheck for cello
>>> cello: Preparing package cello...
>>> cello: Stripping binaries
>>> cello: Scanning shared objects
>>> cello: Tracing dependencies...
        so:libc.musl-x86_64.so.1
>>> cello: Package size: 28.0 KB
>>> cello: Compressing data...
>>> cello: Create checksum...
>>> cello: Create cello-1-r0.apk
>>> cello: Build complete at Sat, 20 May 2023 05:39:33 +0000 elapsed time 0h 0m 1s
>>> cello: Cleaning up srcdir
>>> cello: Cleaning up pkgdir
>>> cello: Uninstalling dependencies...
(1/1) Purging .makedepends-cello (20230520.053933)
OK: 267 MiB in 65 packages
>>> cello: Updating the main/x86_64 repository index...
ERROR: APKINDEX.tar.gz: UNTRUSTED signature
>>> ERROR: cello: Failed to create index
>>> cello: Uninstalling dependencies...
ERROR: No such package: .makedepends-cello
```

```bash
/host/repo/main/cello # tree ~/packages/
/root/packages/
└── main
    └── x86_64
        ├── APKINDEX.tar.gz
        ├── cello-1-r0.apk
        └── hello-world-1-r0.apk

2 directories, 3 files
```# hello-alpine-apk
# hello-alpine-apk
# hello-alpine-apk

# References

https://gitlab.alpinelinux.org/alpine/abuild/-/blob/master/sample.APKBUILD
https://rpm-packaging-guide.github.io/
