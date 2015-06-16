# arm-tf-build
A few helper scripts to be able to test ARM Trusted Firmware standalone quick and easy

# Pre-requisites
 * __Toolchain__: see [this](https://github.com/ARM-software/arm-trusted-firmware/blob/master/docs/user-guide.md#3--tools) URL and untar to a folder named `toolchain`.
 * Foundation Models: Download from [this](http://www.arm.com/products/tools/models/fast-models/foundation-model.php) URL and untar to a folder named `Foundation_Platformpkg`.
 * Clone necessary gits (arm-trusted-firmware, edk2 and linux), see [this](https://github.com/ARM-software/arm-trusted-firmware/blob/master/docs/user-guide.md) user-guide.
 * Put a rootfs with name `filesystem.cpio.gz` in the folder `Foundation_Platformpkg`.
 
# Build
```
./build-edk2.sh
./build-edk2.sh -c
./build-linux.sh -c
./build-linux.sh -f
./build-linux.sh
./build-arm-tf.sh
./run.sh -i
```

# Run
```
./run.sh
```
