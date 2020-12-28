function(target_disable_rtti target)
  include(AddFlags)

  if (CMAKE_CXX_COMPILER_ID STREQUAL "MSVC")
    target_add_flag_cxx(${target} GR- FALSE FALSE)
  elseif (CMAKE_CXX_COMPILER_ID STREQUAL "GNU" OR CMAKE_CXX_COMPILER_ID STREQUAL "Clang" OR CMAKE_CXX_COMPILER_ID STREQUAL "Intel")
    target_add_flag_cxx(${target} fno-rtti FALSE FALSE)
  else()
    message(WARNING "Unkown compiler: Cannot disable RTTI.")
  endif()
endfunction()
