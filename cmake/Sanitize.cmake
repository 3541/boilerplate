option(SANITIZE "Enable sanitizers.")
option(SANITIZE_FORCE_OFF "Disable sanitizers." FALSE)
function(target_add_sanitizers target default_on)
  include(AddFlags)

  if(WIN32 AND CMAKE_CXX_COMPILER_ID STREQUAL Clang)
    set(default_on FALSE)
  endif()

  if (SANITIZE OR ${default_on} AND NOT SANITIZE_FORCE_OFF)
    target_add_flags(${target} "fsanitize=address" TRUE FALSE)

    list(FIND ARGN "MODULES" modules)
    if (NOT CMAKE_CXX_COMPILER_ID STREQUAL GNU AND modules GREATER -1)
      # https://gcc.gnu.org/bugzilla/show_bug.cgi?id=98735
      target_add_flags(${target} "fsanitize=undefined" TRUE FALSE)
    endif()
  endif()
endfunction()
