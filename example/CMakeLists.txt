cmake_minimum_required(VERSION 3.0)
project(sample_extension)

list(APPEND CMAKE_MODULE_PATH "${CMAKE_CURRENT_LIST_DIR}/../cmake")

find_package(Dart REQUIRED)

add_dart_native_extension(sample_extension lib/src/sample_extension.cc)
install(TARGETS sample_extension LIBRARY DESTINATION "${CMAKE_CURRENT_LIST_DIR}/lib/src")
