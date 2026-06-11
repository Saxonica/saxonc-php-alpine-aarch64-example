# Building the Saxon C PHP extension on Alpine Linux Aarch64

This is a simple example repo for https://saxonica.plan.io/issues/6933.

Saxon C is compiled against `glibc`, and GraalVM native-image does not currently allow building using `musl` in place of `glibc` on ARM.

Building with `libgcompat` does work, but because of the problem of PHP loading its extensions using `dlopen()`, extra steps are needed to get the `saxon.so` shared library successfully loaded at runtime.

The Dockerfile builds an image that runs the PHP unit tests with PHPUnit. The tests are not correctly set up (there's a missing data directory), so a number of them fail or error, but the fact that they run at all, and that some succeed, suggests that things are working as we would hope and expect on an Arm-based Linux.

Because of an error in the release process, the config.m4 that ships with Saxon C 13.0 is incorrect and will not build. The provided patch fixes that, and the config.m4 release process has been fixed so this should not be needed in future 12 or 13 releases.
