function(check_type type)
  include(CheckFunctionExists)
  include(CheckTypeSize)

  if (HAVE_${type})
    return()
  endif()

  check_type_size(${type} ${type})
endfunction()

function(target_have_item target item)
  if (HAVE_${item})
    target_compile_definitions(${target} PUBLIC ${target}_HAVE_${item})
  endif()
endfunction()

function(target_platform_checks target)
  include(CheckCSourceCompiles)

  check_type(ssize_t)
  target_have_item(${target} ssize_t)

  check_c_source_compiles("
    _Thread_local int x = 123;
    int main(void) {
      return 0;
    }"
    HAVE__Thread_local
  )
  target_have_item(${target} _Thread_local)

  # For ZERO_STRUCT macro.
  check_function_exists(memset_s HAVE_memset_s)
  target_have_item(${target} memset_s)
  if (HAVE_memset_s)
    target_compile_definitions(${target} PUBLIC __STDC_WANT_LIB_EXT1__=1)
  endif()

  check_function_exists(explicit_bzero HAVE_explicit_bzero)
  target_have_item(${target} explicit_bzero)
endfunction()

function(target_link_math target)
  include(CheckLibraryExists)

  check_library_exists(m floor "" NEED_LIBM)
  if (NEED_LIBM)
    target_link_libraries(${target} PRIVATE m)
  endif()
endfunction()
