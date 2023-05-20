
```bash
$ cat Dockerfile.builder

FROM alpine:edge
RUN apk update && apk add bash vim alpine-sdk

$ docker build -t alpine:builder -f ./Dockerfile.builder .

$ docker run -it -v $(pwd):/host alpine:builder

```

# hello-world

```bash
$ abuild-keygen -an
$ ls -lt ~/.abuild/
total 8
-rw-------    1 root     root          3272 May 20 05:30 -64685ae9.rsa
-rw-r--r--    1 root     root           800 May 20 05:30 -64685ae9.rsa.pub

cd /host/repo/main/hello-world/
tar czvf hello-world-1.tar.gz -C hello-world-1/ .

/host/repo/main/hello-world # abuild -F checksum
>>> hello-world: Updating the sha512sums in /host/repo/main/hello-world/APKBUILD...
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

$ tree ~/packages/
/root/packages/
└── main
    └── x86_64
        ├── APKINDEX.tar.gz
        └── hello-world-1-r0.apk

2 directories, 2 files

$ tar tvf ~/packages/main/x86_64/hello-world-1-r0.apk
-rw-r--r-- 0/0             512 2023-05-20 05:36 .SIGN.RSA.-64685c04.rsa.pub
-rw-r--r-- root/root       415 2023-05-20 05:36 .PKGINFO
drwxr-xr-x root/root         0 2023-05-20 05:36 usr/
drwxr-xr-x root/root         0 2023-05-20 05:36 usr/bin/
-rwxr-xr-x root/root        29 2023-05-20 05:36 usr/bin/hello-world.sh

$ apk add --allow-untrusted ~/packages/main/x86_64/hello-world-1-r0.apk
(1/1) Installing hello-world (1-r0)
Executing busybox-1.36.0-r5.trigger
OK: 267 MiB in 65 packages

$ /usr/bin/hello-world.sh
Hello world
```

# cello

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
