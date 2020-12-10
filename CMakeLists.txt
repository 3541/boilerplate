cmake_minimum_required(VERSION 3.9...3.17)

project(
  PROJECT_NAME
  VERSION 0.1.0
  LANGUAGES C CXX
)

set(CMAKE_MODULE_PATH "${PROJECT_SOURCE_DIR}/boilerplate/cmake" ${CMAKE_MODULE_PATH})

set(default_build_type "Release")
if (NOT CMAKE_BUILD_TYPE AND NOT CMAKE_CONFIGURATION_TYPES)
  message(STATUS "Unspecified build type. Using ${default_build_type}.")
  set_property(CACHE CMAKE_BUILD_TYPE PROPERTY STRINGS
    "Debug" "Release" "RelWithDebInfo")
endif()

set(CMAKE_EXPORT_COMPILE_COMMANDS ON)

include(CheckIPOSupported)
check_ipo_supported(RESULT lto_support)
if (lto_support)
  message(STATUS "LTO support found.")
else()
  message(WARNING "LTO is not supported.")
endif()

add_compile_options(-Wall -Wextra -pedantic)

set(CMAKE_C_VISIBILITY_PRESET hidden)
set(CMAKE_CXX_VISIBILITY_PRESET hidden)

add_executable(BINARY_NAME src/main.c)
target_include_directories(urs PRIVATE src)

include(AddWarnings)
target_add_extra_warnings(BINARY_NAME)
set_target_properties(BINARY_NAME PROPERTIES
  C_STANDARD 11
  C_EXTENSIONS OFF
)
if (lto_support)
  set_target_properties(BINARY_NAME PROPERTIES
    INTERPROCEDURAL_OPTIMIZATION_RELEASE TRUE
    INTERPROCEDURAL_OPTIMIZATION_RELWITHDEBINFO TRUE
  )
endif()

if (CMAKE_BUILD_TYPE STREQUAL "Debug")
  target_compile_definitions(BINARY_NAME PRIVATE DEBUG_BUILD)
endif()
