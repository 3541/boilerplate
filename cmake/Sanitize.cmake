option(SANITIZE "Enable sanitizers.")
function(target_add_sanitizers target default_on)
  include(AddFlags)

  if(WIN32 AND CMAKE_C_COMPILER_ID STREQUAL Clang)
    set(default_on FALSE)
  endif()

  if (SANITIZE OR ${default_on})
    target_add_flags(${target} "fsanitize=address;fsanitize=undefined" TRUE FALSE)
  endif()
endfunction()
