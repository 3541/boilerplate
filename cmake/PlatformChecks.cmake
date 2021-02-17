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
  include(CheckSymbolExists)

  set(CMAKE_C_STANDARD 11)
  set(CMAKE_CXX_STANDARD 17)

  if (WIN32)
    target_compile_definitions(${target} PRIVATE WIN32_LEAN_AND_MEAN)
  endif()

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

  check_c_source_compiles("
    #define GEN_MACRO(X) _Generic((X), int: \"int\", float: \"float\")
    int main(void) {
      int x;
      const char* res = GEN_MACRO(x);
      return 0;
    }"
    HAVE__Generic
  )
  target_have_item(${target} _Generic)

  # For ZERO_STRUCT macro.
  check_function_exists(memset_s HAVE_memset_s)
  target_have_item(${target} memset_s)
  if (HAVE_memset_s)
    target_compile_definitions(${target} PUBLIC __STDC_WANT_LIB_EXT1__=1)
  endif()

  check_function_exists(explicit_bzero HAVE_explicit_bzero)
  target_have_item(${target} explicit_bzero)

  check_symbol_exists(SecureZeroMemory "Windows.h" HAVE_SecureZeroMemory)
  target_have_item(${target} SecureZeroMemory)
endfunction()

function(target_link_math target)
  include(CheckLibraryExists)

  check_library_exists(m floor "" NEED_LIBM)
  if (NEED_LIBM)
    target_link_libraries(${target} PRIVATE m)
  endif()
endfunction()
