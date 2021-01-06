include(AddFlags)

function(target_add_warning_c target warning public)
  target_add_flag_c(${target} "W${warning}" FALSE ${public})
endfunction()

function(target_add_warning_cxx target warning public)
  target_add_flag_cxx(${target} "W${warning}" FALSE ${public})
endfunction()

function(target_add_warning target warning public)
  target_add_flag(${target} "W${warning}" FALSE ${public})
endfunction()

function(target_add_warnings_c target warnings public)
  foreach(warning ${warnings})
    target_add_warning_c(${target} "${warning}" ${public})
  endforeach()
endfunction()

function(target_add_warnings_cxx target warnings public)
  foreach(warning ${warnings})
    target_add_warning_cxx(${target} "${warning}" ${public})
  endforeach()
endfunction()

function(target_add_warnings target warnings public)
  foreach(warning ${warnings})
    target_add_warning(${target} "${warning}" ${public})
  endforeach()
endfunction()

function(target_set_werror target)
  if (MSVC)
    # On MSVC, the linker can also take this argument.
    target_add_flag(${target} "WX" TRUE FALSE)
  else()
    target_add_flag(${target} "Werror" FALSE FALSE)
  endif()
endfunction()

option(USE_WERROR "Set Werror.")

function(target_add_extra_warnings target pedantic)
  if (MSVC)
    set(extra_warnings_common "4")
    set(extra_warnings_c "")
    set(extra_warnings_cxx "")

    target_compile_definitions(${target} PRIVATE _CRT_SECURE_NO_WARNINGS)
    # /W4 produces copious C5105 warnings in standard library headers.
    target_add_flag(${target} "wd5105" FALSE TRUE)
  else()
    set(extra_warnings_common "all" "extra" "disabled-optimization" "duplicated-branches" "duplicated-cond" "float-equal" "format-nonliteral" "format-security" "logical-op" "missing-declarations" "missing-include-dirs" "null-dereference" "packed" "shadow" "stack-protector" "undef" "cast-align" "cast-qual" "conversion")
    if (${pedantic})
      list(APPEND extra_warnings_common "pedantic")
    endif()

    if (CMAKE_C_COMPILER_ID STREQUAL GNU OR CMAKE_CXX_COMPILER_ID STREQUAL GNU)
      # -Wconversion is way too aggressive on GCC 9 and earlier.
      if (CMAKE_C_COMPILER_VERSION MATCHES "^9\." OR CMAKE_CXX_COMPILER_VERSION MATCHES "^9\.")
        list(APPEND extra_warnings_common "no-conversion")
      endif()
    endif()

    set(extra_warnings_c "bad-function-cast" "implicit" "missing-prototpyes" "nested-externs" "strict-prototypes")
    set(extra_warnings_cxx "ctor-dtor-privacy" "delete-non-virtual-dtor" "effc++")
    if (CMAKE_CXX_COMPILER_ID STREQUAL Intel)
      # ICC is too aggressive with -Weffc++.
      list(APPEND extra_warnings_cxx "no-effc++")
    endif()
  endif()

  target_add_warnings(${target} "${extra_warnings_common}" FALSE)

  if (USE_WERROR)
    target_set_werror(${target})
  endif()

  get_property(languages GLOBAL PROPERTY ENABLED_LANGUAGES)
  if ("C" IN_LIST languages)
    target_add_warnings_c(${target} "${extra_warnings_c}" FALSE)
  endif()

  if ("CXX" IN_LIST languages)
    target_add_warnings_cxx(${target} "${extra_warnings_cxx}" FALSE)
  endif()
endfunction()
