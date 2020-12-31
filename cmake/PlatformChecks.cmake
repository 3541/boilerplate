function(check_type type)
  include(CheckTypeSize)

  if (HAVE_${type})
    return()
  endif()

  check_type_size(${type} ${type})
endfunction()

function(target_platform_checks target)
  include(CheckCSourceCompiles)

  check_type(ssize_t)
  if (HAVE_ssize_t)
    target_compile_definitions(${target} PUBLIC ${target}_HAVE_ssize_t)
  endif()

  check_c_source_compiles("
    _Thread_local int x = 123;
    int main(void) {
      return 0;
    }"
    HAVE__Thread_local
  )
  if (HAVE__Thread_local)
    target_compile_definitions(${target} PUBLIC ${target}_HAVE__Thread_local)
  endif()

  # For ZERO_STRUCT macro.
  check_function_exists(memset_s ${target}_HAVE_memset_s)
  check_function_exists(explicit_bzero ${target}_HAVE_explicit_bzero)
endfunction()

function(target_link_math target)
  include(CheckLibraryExists)

  check_library_exists(m floor "" NEED_LIBM)
  if (NEED_LIBM)
    target_link_libraries(${target} PRIVATE m)
  endif()
endfunction()
