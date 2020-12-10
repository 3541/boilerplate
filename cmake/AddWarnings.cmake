function(target_add_warning target warning public)
  include(CheckCCompilerFlag)
  include(CheckCXXCompilerFlag)

  if (MSVC)
    set(flag "/W${warning}")
  else()
    set(flag "-W${warning}")
  endif()

  get_property(languages GLOBAL PROPERTY ENABLED_LANGUAGES)

  if ("C" IN_LIST languages)
    check_c_compiler_flag("${flag}" "C_HAS_WARNING_${warning}")
    if (C_HAS_WARNING_${warning})
      if (${public})
        target_compile_options(${target} PUBLIC $<$<COMPILE_LANGUAGE:C>:${flag}>)
      else()
        target_compile_options(${target} PRIVATE $<$<COMPILE_LANGUAGE:C>:${flag}>)
      endif()
    endif()
  endif()

  if ("CXX" IN_LIST languages)
    check_cxx_compiler_flag("${flag}" "CXX_HAS_WARNING_${warning}")
    if (CXX_HAS_WARNING_${warning})
      if (${public})
        target_compile_options(${target} PUBLIC $<$<COMPILE_LANGUAGE:CXX>:${flag}>)
      else()
        target_compile_options(${target} PRIVATE $<$<COMPILE_LANGUAGE:CXX>:${flag}>)
      endif()
    endif()
  endif()
endfunction()

function(target_add_warnings target warnings public)
  foreach(warning ${warnings})
    target_add_warning(${target} "${warning}" ${public})
  endforeach()
endfunction()

function(target_add_extra_warnings target)
  set(extra_warnings "bad-function-cast" "disabled-optimization" "duplicated-branches" "duplicated-cond" "float-equal" "format-nonliteral" "format-security" "implicit" "inline" "logical-op" "missing-declarations" "missing-include-dirs" "missing-prototypes" "nested-externs" "null-dereference" "packed" "shadow" "stack-protector" "strict-prototypes" "undef" "cast-align" "cast-qual" "conversion ctor-dtor-privacy" "delete-non-virtual-dtor" "effc++")
  target_add_warnings(${target} "${extra_warnings}" FALSE)
endfunction()