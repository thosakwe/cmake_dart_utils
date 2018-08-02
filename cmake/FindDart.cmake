# Attempts to find the paths to Dart SDK include files and libraries, based on the path of the `dart` executable.
#
# Use as follows:
#
#   find_package(Dart)
#
#
# The following variables will be set:
#
# Dart_FOUND - TRUE if Dart was found
# Dart_ROOT_DIR - The Dart SDK root
# Dart_EXECUTABLE - The `dart` executable
# Dart_INCLUDE_DIR - The `include` directory within the SDK
# Dart_LIBRARY - The name of the `libdart` library
#
# The following macro is added as well:
#
# add_dart_native_extension(NAME srcs...)
# This is a very convenient macro that automatically performs all
# necessary configuration to build a Dart native extension.

find_program(_Dart_EXECUTABLE dart)

if ("${_Dart_EXECUTABLE}" STREQUAL "_Dart_EXECUTABLE-NOTFOUND")
  set(Dart_FOUND FALSE)
else()
  get_filename_component(Dart_EXECUTABLE ${_Dart_EXECUTABLE} REALPATH)
  set(Dart_FOUND TRUE)
endif()

if (Dart_FOUND)
  get_filename_component(_Dart_BIN ${Dart_EXECUTABLE} DIRECTORY)
  get_filename_component(Dart_ROOT_DIR ${_Dart_BIN} DIRECTORY)

  if (WIN32)
    set(Dart_INCLUDE_DIR "${Dart_ROOT_DIR}\include")
    set(Dart_LIBRARY "${_Dart_BIN}\dart.lib")
  else()
    set(Dart_INCLUDE_DIR "${Dart_ROOT_DIR}/include")
  endif()
endif()

macro(add_dart_native_extension NAME)
  add_library(${NAME} SHARED ${ARGN})
  target_include_directories(${NAME} PUBLIC ${Dart_INCLUDE_DIR})
  target_compile_definitions(${NAME} PUBLIC DART_SHARED_LIB=1)

  if (APPLE)
    target_link_libraries(${NAME} "-undefined dynamic_lookup")
  endif()



  if (WIN32)
    target_link_libraries(${NAME} ${Dart_LIBRARY})
  else()
    set_target_properties(${NAME} PROPERTIES POSITION_INDEPENDENT_CODE TRUE)
  endif()
endmacro()
