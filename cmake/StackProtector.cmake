include(AddFlags)

option(USE_STACK_PROTECTOR "Enable stack protector." TRUE)

function(target_add_stack_protector target)
  if (USE_STACK_PROTECTOR)
    if (MSVC)
      target_add_flag(${target} "GS" FALSE FALSE)
    else()
      target_add_flag(${target} "fstack-protector" FALSE FALSE)
    endif()
  endif()
endfunction()
