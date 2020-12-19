function(check_type type)
  include(CheckTypeSize)

  if (HAVE_${type})
    return()
  endif()

  check_type_size(${type} ${type})
endfunction()

function(target_platform_checks target)
  check_type(ssize_t)
  if (HAVE_ssize_t)
    target_compile_definitions(${target} PUBLIC ${target}_HAVE_ssize_t)
  endif()
endfunction()
