IOS_PLATFORMDIR=/Applications/Xcode.app/Contents/Developer/Platforms/iPhoneOS.platform
IOS_SYSROOT=($IOS_PLATFORMDIR/Developer/SDKs/iPhoneOS*.sdk)
export CFLAGS="-Wall -mfloat-abi=softfp -arch armv7s -miphoneos-version-min=6.0"

MYDIR=`pwd`
OUT_FOLDER="/ARMv7s"
OUT_PATH=$MYDIR$OUT_FOLDER
IN_FOLDER="/libjpeg-turbo"
IN_PATH=$MYDIR$IN_FOLDER

cd $OUT_PATH

cat <<EOF >toolchain.cmake
set(CMAKE_SYSTEM_NAME Darwin)
set(CMAKE_SYSTEM_PROCESSOR arm)
set(CMAKE_C_COMPILER /Applications/Xcode.app/Contents/Developer/Toolchains/XcodeDefault.xctoolchain/usr/bin/clang)
EOF

cmake -G"Unix Makefiles" -DCMAKE_TOOLCHAIN_FILE=toolchain.cmake \
  -DCMAKE_OSX_SYSROOT=${IOS_SYSROOT[0]} \
  $IN_PATH
make
