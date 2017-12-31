
############## stb ##############
add_library(stb STATIC
    stb.cpp
    stb/stb_image.h
    stb/stb_sprintf.h
)
target_include_directories(stb
    PUBLIC stb/
)
set_target_properties(stb
   PROPERTIES
   FOLDER "Dependencies"
)


############## imgui ##############
add_library(imgui STATIC
    imgui/imconfig.h
    imgui/imgui.cpp
    imgui/imgui.h
    imgui/imgui_demo.cpp
    imgui/imgui_draw.cpp
    imgui/imgui_internal.h
    imgui/stb_rect_pack.h
    imgui/stb_textedit.h
    imgui/stb_truetype.h
)
target_include_directories( imgui
    PUBLIC imgui/
)

set_target_properties( imgui
   PROPERTIES
   FOLDER "Dependencies"
)

####### nuklear ####### 
add_library( nuklear STATIC
    nuklear.cpp
    nuklear/nuklear.h
)
target_include_directories( nuklear
    PUBLIC nuklear/
)
target_compile_definitions( nuklear
    PUBLIC -DNK_INCLUDE_FIXED_TYPES
    PUBLIC -DNK_INCLUDE_DEFAULT_ALLOCATOR
    PUBLIC -DNK_INCLUDE_STANDARD_IO
    PUBLIC -DNK_INCLUDE_STANDARD_VARARGS
    PUBLIC -DNK_INCLUDE_VERTEX_BUFFER_OUTPUT
    PUBLIC -DNK_INCLUDE_VERTEX_BUFFER_OUTPUT
    PUBLIC -DNK_INCLUDE_FONT_BAKING
    PUBLIC -DNK_INCLUDE_DEFAULT_FONT
    PUBLIC -DNK_VSNPRINTF=stbsp_vsnprintf
)
target_link_libraries( nuklear
    PRIVATE stb
)
set_target_properties( nuklear
   PROPERTIES
   FOLDER "Dependencies"
)


############## tinydir ##############
add_library(tinydir INTERFACE)
target_include_directories( tinydir
    INTERFACE tinydir
)

############## libyaml ##############
file(GLOB YAML_HEADERS libyaml/include/*.h)
file(GLOB YAML_SOURCES libyaml/src/*.c libyaml/src/*.h)
add_library(libyaml STATIC
    ${YAML_HEADERS}
    ${YAML_SOURCES}
)
target_include_directories(libyaml
    PUBLIC libyaml/include
)
target_compile_definitions(libyaml
    PUBLIC YAML_DECLARE_STATIC
    PUBLIC YAML_VERSION_MAJOR=0
    PUBLIC YAML_VERSION_MINOR=1
    PUBLIC YAML_VERSION_PATCH=7
    PUBLIC YAML_VERSION_STRING="0.1.7"
)
set_target_properties(libyaml
   PROPERTIES
   FOLDER "Dependencies"
)

############## libyaml-cpp ##############
add_library(libyaml-cpp STATIC
    libyaml-cpp/include/libyaml-cpp.h
    libyaml-cpp/src/libyaml-cpp.cpp
)
target_link_libraries( libyaml-cpp
    PRIVATE libyaml
)
target_include_directories(libyaml-cpp
    PUBLIC ${CMAKE_CURRENT_LIST_DIR}/libyaml-cpp/include/
)
target_compile_definitions(libyaml-cpp
    PUBLIC LIBYAML_CPP_STATIC
)
set_target_properties(libyaml-cpp
   PROPERTIES
   FOLDER "Dependencies"
)

############## lz4 ##############
add_library(lz4 STATIC
    lz4/lib/lz4.h
    lz4/lib/lz4.c
    lz4/lib/lz4hc.h
    lz4/lib/lz4hc.c
    
    lz4/lib/lz4frame.h
    lz4/lib/lz4frame.c
    
    lz4/lib/lz4frame_static.h
    lz4/lib/lz4opt.h

    
    lz4/lib/xxhash.h
    lz4/lib/xxhash.c
)
target_include_directories( lz4
    PUBLIC lz4/lib
)
set_target_properties( lz4
   PROPERTIES
   FOLDER "Dependencies"
)

############## catch ##############
add_library(catch INTERFACE)
target_include_directories( catch
    INTERFACE Catch/include
)

############## mgn ##############
add_library(mgn STATIC
    mgn.cpp
    mgn/mgn/strpool.h
    mgn/mgn/hashtable.h
)
set_target_properties( mgn
   PROPERTIES
   FOLDER "Dependencies"
)
target_include_directories( mgn
    PUBLIC mgn
)

############## tinyobjloader ##############
add_library(tinyobjloader STATIC
    tinyobjloader/tiny_obj_loader.h
    tinyobjloader/tiny_obj_loader.cc
)
set_target_properties( tinyobjloader
   PROPERTIES
   FOLDER "Dependencies"
)
target_include_directories( tinyobjloader
    PUBLIC tinyobjloader
)

############## SDL2 ##############

# create a target named 'uninstall' to force sdl2 to skip creating that target
# INTERFACE is a pseudo target, and
add_library(uninstall INTERFACE)
add_subdirectory(SDL2)
set_target_properties(SDL2 SDL2main SDL2-static
   PROPERTIES
   FOLDER "Dependencies"
)

target_include_directories(SDL2
    INTERFACE SDL2/include
)


############## glbinding ##############

include (glbinding.cmake)
set_target_properties (glbinding
   PROPERTIES
   FOLDER "Dependencies"
)

############## glm ##############
add_library (glm INTERFACE)
target_include_directories (glm
    INTERFACE glm/
)



