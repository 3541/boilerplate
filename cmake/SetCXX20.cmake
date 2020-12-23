# This is a hack which is only necessary because CMake doesn't appear to
# recognize that ICC supports C++20.
function(target_set_cxx_std_20 target)
  if (CMAKE_CXX_COMPILER_ID STREQUAL Intel)
    target_compile_options(${target} PRIVATE $<$<COMPILE_LANGUAGE:CXX>:-std=c++2a>)
  else()
    target_compile_features(${target} PRIVATE cxx_std_20)
  endif()
endfunction()
