option(USE_CLANG_TIDY "Use clang-tidy to lint." OFF)

function(target_add_clang_tidy target)
  find_program(CLANG_TIDY clang-tidy)

  if (NOT USE_CLANG_TIDY OR NOT CLANG_TIDY)
    return()
  endif()

  set_target_properties(${target} PROPERTIES
    C_CLANG_TIDY "${CLANG_TIDY}"
    CXX_CLANG_TIDY "${CLANG_TIDY}"
  )
endfunction()
