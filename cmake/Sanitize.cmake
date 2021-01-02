option(SANITIZE "Enable sanitizers.")
option(SANITIZE_FORCE_OFF "Disable sanitizers." FALSE)
function(target_add_sanitizers target default_on)
  include(AddFlags)

  if(WIN32 AND CMAKE_C_COMPILER_ID STREQUAL Clang)
    set(default_on FALSE)
  endif()

  if (SANITIZE OR ${default_on} AND NOT SANITIZE_FORCE_OFF)
    target_add_flags(${target} "fsanitize=address;fsanitize=undefined" TRUE FALSE)
  endif()
endfunction()
