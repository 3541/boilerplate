function(target_add_iwyu target)
  find_program(IWYU include-what-you-use)

  if (NOT IWYU)
    return()
  endif()

  set(IWYU_CMD "${IWYU};-Xiwyu;--no_fwd_decls")

  set_target_properties(${target} PROPERTIES
    C_INCLUDE_WHAT_YOU_USE "${IWYU_CMD}"
    CXX_INCLUDE_WHAT_YOU_USE "${IWYU_CMD}"
  )
endfunction()
