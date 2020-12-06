project(
  'NAME',
  ['c', 'cpp'],
  version: '0.1.0',
  default_options: [
    'c_std=c18',

    'cpp_std=c++2a',
    'cpp_rtti=false',
    'cpp_eh=none',

    'warning_level=3',
    'werror=true',
    'buildtype=debug',
    'b_ndebug=if-release'
  ]
)

c_compiler = meson.get_compiler('c')
cpp_compiler = meson.get_compiler('cpp')

extra_warnings_c = [
  'bad-function-cast',
  'disabled-optimization',
  'duplicated-branches',
  'duplicated-cond',
  'float-equal',
  'format-nonliteral',
  'format-security',
  'format=2',
  'implicit',
  'inline',
  'logical-op',
  'missing-declarations',
  'missing-include-dirs',
  'missing-prototypes',
  'nested-externs',
  'null-dereference',
  'packed',
  'shadow',
  'stack-protector',
  'strict-prototypes',
  'undef'
]

extra_warnings_cpp = [
  'cast-align',
  'cast-qual',
  'conversion',
  'ctor-dtor-privacy',
  'delete-non-virtual-dtor'
  'effc++',
]

foreach warning : extra_c_warnings
  warning = '-W' + warning
  if c_compiler.has_argument(warning)
    add_project_arguments(warning, language: ['c', 'cpp'])
  endif
endforeach

foreach warning : extra_cpp_warnings
  warning = '-W' + warning
  if cpp_compiler.has_argument(warning)
    add_project_arguments(warning, language: 'cpp')
  endif
endforeach

if get_option('debug')
  add_project_arguments('-DDEBUG_BUILD', language: ['c', 'cpp'])
endif

if get_option('profile')
  add_project_arguments('-DPROFILE', language: ['c', 'cpp'])
  add_project_arguments('-DNDEBUG', language: ['c', 'cpp'])
endif

src = files([])
headers = include_directories('src')

executable(
  'NAME',
  src,
  include_directories: headers,
  build_by_default: true
)
