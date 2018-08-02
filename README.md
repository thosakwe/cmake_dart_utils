# cmake_dart_utils
Handy utilities for building Dart native extensions with CMake.
Includes macros for finding and linking against Dart with ease.

For a Dart-based solution, see
[`package:build_native`](https://github.com/thosakwe/build_native)
instead.

# Usage
To use this script, copy `cmake/FindDart.cmake` into your local project, likely to
`<project root>/cmake/FindDart.cmake`.

This script works with the `find_package` CMake macro, so make sure to include it in your
search path:

```cmake
list(APPEND CMAKE_MODULE_PATH "${CMAKE_CURRENT_LIST_DIR}/cmake")
find_package(Dart REQUIRED)

add_dart_native_extension(sample_extension lib/src/sample_extension.cc)
```

# Functionality

Attempts to find the paths to Dart SDK include files and libraries, based on the path of the `dart` executable.

Use as follows:

```cmake
find_package(Dart)
```

The following variables will be set:

* `Dart_FOUND` - `TRUE` if Dart was found
* `Dart_ROOT_DIR` - The Dart SDK root
* `Dart_EXECUTABLE` - The `dart` executable
* `Dart_INCLUDE_DIR` - The `include` directory within the SDK
* `Dart_LIBRARY` - The name of the `libdart` library

The following macro is added as well:

```cmake
add_dart_native_extension(NAME srcs...)
```

This is a very convenient macro that automatically performs all
necessary configuration to build a Dart native extension.
