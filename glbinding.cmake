
# Stripped down version of glbinding's cmake files

# Fake scope with a function, to hide all variables defined
function(glbinding_scope)



# 
# External dependencies
# 

find_package(OpenGL REQUIRED)

include (GenerateExportHeader)
include(WriteCompilerDetectionHeader)
# 
# Library name and options
# 

# Target name
set(target glbinding)

# Set API export file and macro
string(MAKE_C_IDENTIFIER ${target} target_id)
string(TOUPPER ${target_id} target_id)
set(feature_file         "include/${target}/${target}_features.h")
set(export_file          "include/${target}/${target}_export.h")
set(template_export_file "include/${target}/${target}_api.h")
set(export_macro         "${target_id}_API")

string(TOUPPER ${CMAKE_SYSTEM_NAME} SYSTEM_NAME_UPPER)

# 
# Sources
# 
set(source_dir ${CMAKE_CURRENT_SOURCE_DIR}/glbinding/source/glbinding)

set(include_path "${source_dir}/include/${target}")
set(source_path  "${source_dir}/source")

set(headers
    ${include_path}/callbacks.h

    ${include_path}/nogl.h

    ${include_path}/gl/bitfield.h
    ${include_path}/gl/boolean.h
    ${include_path}/gl/boolean.inl
    ${include_path}/gl/enum.h
    ${include_path}/gl/extension.h
    ${include_path}/gl/functions.h
    ${include_path}/gl/types.h
    ${include_path}/gl/values.h

    ${include_path}/AbstractFunction.h
    ${include_path}/AbstractValue.h
    ${include_path}/CallbackMask.h
    ${include_path}/CallbackMask.inl
    ${include_path}/Function.h
    ${include_path}/Function.inl
    ${include_path}/FunctionCall.h
    ${include_path}/Binding.h
    ${include_path}/Meta.h
    ${include_path}/ProcAddress.h
    ${include_path}/ContextHandle.h
    ${include_path}/ContextInfo.h
    ${include_path}/Value.h
    ${include_path}/Value.inl
    ${include_path}/Version.h
    ${include_path}/Version.inl
    ${include_path}/SharedBitfield.h
    ${include_path}/SharedBitfield.inl

    ${include_path}/logging.h
)

# add featured headers

file(GLOB featured_includes ${include_path}/gl*/*.h)
list(APPEND headers ${featured_includes})

set(sources
    ${source_path}/callbacks_private.h
    ${source_path}/callbacks.cpp
    
    ${source_path}/AbstractFunction.cpp
    ${source_path}/AbstractValue.cpp
    ${source_path}/Binding.cpp
    ${source_path}/Binding_list.cpp
    ${source_path}/FunctionCall.cpp

    ${source_path}/ProcAddress.cpp
    ${source_path}/ContextHandle.cpp
    ${source_path}/ContextInfo.cpp
    ${source_path}/Value.cpp
    ${source_path}/Version.cpp
    ${source_path}/Version_ValidVersions.cpp

    ${source_path}/Meta.cpp
    ${source_path}/Meta_Maps.h
    ${source_path}/Meta_getStringByBitfield.cpp
    ${source_path}/Meta_BitfieldsByString.cpp
    ${source_path}/Meta_BooleansByString.cpp
    ${source_path}/Meta_EnumsByString.cpp
    ${source_path}/Meta_ExtensionsByFunctionString.cpp
    ${source_path}/Meta_ExtensionsByString.cpp
    ${source_path}/Meta_FunctionStringsByExtension.cpp
    ${source_path}/Meta_FunctionStringsByVersion.cpp
    ${source_path}/Meta_ReqVersionsByExtension.cpp
    ${source_path}/Meta_StringsByBitfield.cpp
    ${source_path}/Meta_StringsByBoolean.cpp
    ${source_path}/Meta_StringsByEnum.cpp
    ${source_path}/Meta_StringsByExtension.cpp

    ${source_path}/RingBuffer.h
    ${source_path}/RingBuffer.inl
    ${source_path}/logging.cpp

    ${source_path}/gl/types.cpp
    ${source_path}/gl/functions-patches.cpp

    ${source_path}/Binding_pch.h
)


# use splitted function and binding sources on windows compilers (e.g., mingw, msvc) and clang
# also use them for GCC for reduced project setup complexity

file(GLOB splitted_binding_sources ${source_path}/Binding_objects_*.cpp)
file(GLOB splitted_functions_sources ${source_path}/gl/functions_*.cpp)

list(APPEND sources 
    ${splitted_binding_sources}
    ${splitted_functions_sources}
)

if(MSVC_IDE)
    # on msvc use private (non-api) per file precompiled headers on those grouped sources

    list(APPEND sources
        ${source_path}/Binding_pch.cpp)
endif()


# 
# Create library
# 

# Build library
add_library(${target} STATIC
    ${sources}
    ${headers}
)

# Create namespaced alias
add_library(glbinding::${target} ALIAS ${target})


# Create API export header
generate_export_header(${target}
    EXPORT_FILE_NAME  ${export_file}
    EXPORT_MACRO_NAME ${export_macro}
)


if (MSVC)
    configure_file(glbinding/source/codegeneration/template_msvc_api.h.in ${CMAKE_CURRENT_BINARY_DIR}/${template_export_file})
else (MSVC)
    configure_file(glbinding/source/codegeneration/template_api.h.in ${CMAKE_CURRENT_BINARY_DIR}/${template_export_file})
endif (MSVC)

write_compiler_detection_header(
    FILE ${feature_file}
    PREFIX ${target_id}
    COMPILERS AppleClang Clang GNU MSVC
    FEATURES
        cxx_thread_local
        cxx_constexpr
        cxx_attribute_deprecated
        cxx_noexcept
    VERSION 3.2
)


# 
# Include directories
# 

target_include_directories(${target}
    PUBLIC
    ${CMAKE_CURRENT_BINARY_DIR}/include
    ${source_dir}/include
)


# 
# Libraries
# 
target_link_libraries(${target}
    PUBLIC ${OPENGL_LIBRARIES}
)


# 
# Compile definitions
# 

target_compile_definitions(${target}
    PUBLIC ${target_id}_STATIC_DEFINE
    PRIVATE SYSTEM_${SYSTEM_NAME_UPPER}
)



#
# Precompiled Header Configuration
#

if (MSVC_IDE)
    # on msvc use private (non-api) per file precompiled headers on those grouped sources

    set_source_files_properties(${source_path}/Binding_pch.cpp PROPERTIES COMPILE_FLAGS /Yc"Binding_pch.h")
    # set_source_files_properties(${source_path}/gl/functions_pch.cpp PROPERTIES COMPILE_FLAGS /Yc"functions_pch.h")

    file(GLOB binding_pch_sources ${source_path}/Binding_objects_*.cpp)
    list(APPEND binding_pch_sources ${source_path}/Binding_list.cpp)

    file(GLOB functions_pch_sources ${source_path}/gl/functions_*.cpp)

    set_source_files_properties(${binding_pch_sources} PROPERTIES COMPILE_FLAGS /Yu"Binding_pch.h")
    set_source_files_properties(${functions_pch_sources} PROPERTIES COMPILE_FLAGS /Yu"../Binding_pch.h")
endif()

endfunction(glbinding_scope)

glbinding_scope()