# Building the Saxon C PHP extension on Alpine Linux Aarch64

This is a simple example repo for https://saxonica.plan.io/issues/6933.

Saxon C is compiled against `glibc`, and GraalVM native-image does not currently allow building using `musl` in place of `glibc` on ARM.

Building with `libgcompat` does work, but because of the problem of PHP loading its extensions using `dlopen()`, extra steps are needed to get the `saxon.so` shared library successfully loaded at runtime.

The Dockerfile builds an image that runs the PHP unit tests with PHPUnit. The tests are not correctly set up (there's a missing data directory), so a number of them fail or error, but the fact that they run at all, and that some succeed, suggests that things are working as we would hope and expect on an Arm-based Linux.

Because of a bug in the current release that only affects Alpine Linux / Aarch64 (or, more probably, only affects systems `aarch64` systems using `musl`), the provided patch is necessary to get things to compile. This will be fixed in the next maintenance release (current release is 12.9).