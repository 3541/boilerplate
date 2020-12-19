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

function(target_add_extra_warnings target)
  if (MSVC)
    set(extra_warnings_common "")
    set(extra_warnings_c "")
    set(extra_warnings_cxx "")
  else()
    set(extra_warnings_common "disabled-optimization" "duplicated-branches" "duplicated-cond" "float-equal" "format-nonliteral" "format-security" "inline" "logical-op" "missing-declarations" "missing-include-dirs" "null-dereference" "packed" "shadow" "stack-protector" "undef" "cast-align" "cast-qual" "conversion")
    set(extra_warnings_c "bad-function-cast" "implicit" "missing-prototpyes" "nested-externs" "strict-prototypes")
    set(extra_warnings_cxx "ctor-dtor-privacy" "delete-non-virtual-dtor" "effc++")
  endif()

  target_add_warnings(${target} "${extra_warnings_common}" FALSE)

  get_property(languages GLOBAL PROPERTY ENABLED_LANGUAGES)
  if ("C" IN_LIST languages)
    target_add_warnings_c(${target} "${extra_warnings_c}" FALSE)
  endif()

  if ("CXX" IN_LIST languages)
    target_add_warnings_cxx(${target} "${extra_warnings_cxx}" FALSE)
  endif()
endfunction()
