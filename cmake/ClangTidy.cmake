option(USE_CLANG_TIDY "Use clang-tidy to lint." ON)

function(target_add_clang_tidy target)
  find_program(CLANG_TIDY clang-tidy)

  if (NOT USE_CLANG_TIDY OR NOT CLANG_TIDY)
    return()
  endif()

  set_target_properties(${target} PROPERTIES
    # The "secure" C11 API which this lint requires is neither particularly more
    # secure than the alternative, nor supported on any major C library other
    # than Microsoft's (and even theirs is out of date).
    C_CLANG_TIDY "${CLANG_TIDY};-checks=-clang-analyzer-security.insecureAPI.DeprecatedOrUnsafeBufferHandling"
    CXX_CLANG_TIDY "${CLANG_TIDY};-checks=-clang-analyzer-security.insecureAPI.DeprecatedOrUnsafeBufferHandling"
  )
endfunction()
