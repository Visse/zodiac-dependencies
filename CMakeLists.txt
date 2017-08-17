
add_library( stb STATIC
    stb.cpp
    stb/stb_image.h
    stb/stb_sprintf.h
)
target_include_directories( stb
    PUBLIC stb/
)
set_target_properties( stb
   PROPERTIES
   FOLDER "Dependencies"
)


add_library( imgui INTERFACE )
target_sources(imgui INTERFACE
    ${CMAKE_CURRENT_LIST_DIR}/imgui/imconfig.h
    ${CMAKE_CURRENT_LIST_DIR}/imgui/imgui.cpp
    ${CMAKE_CURRENT_LIST_DIR}/imgui/imgui.h
    ${CMAKE_CURRENT_LIST_DIR}/imgui/imgui_demo.cpp
    ${CMAKE_CURRENT_LIST_DIR}/imgui/imgui_draw.cpp
    ${CMAKE_CURRENT_LIST_DIR}/imgui/imgui_internal.h
    ${CMAKE_CURRENT_LIST_DIR}/imgui/stb_rect_pack.h
    ${CMAKE_CURRENT_LIST_DIR}/imgui/stb_textedit.h
    ${CMAKE_CURRENT_LIST_DIR}/imgui/stb_truetype.h
)
target_include_directories( imgui
    INTERFACE imgui/
)
set_target_properties( imgui
   PROPERTIES
   INTERFACE_HEADER "${CMAKE_CURRENT_LIST_DIR}/imgui/imgui.h;${CMAKE_CURRENT_LIST_DIR}/imgui/imconfig.h"
)


add_library( nuklear INTERFACE )
target_sources(nuklear INTERFACE
    ${CMAKE_CURRENT_LIST_DIR}/nuklear.cpp
    ${CMAKE_CURRENT_LIST_DIR}/nuklear/nuklear.h
)
target_include_directories( nuklear
    INTERFACE nuklear/
)
set_target_properties( nuklear
   PROPERTIES
   INTERFACE_HEADER "${CMAKE_CURRENT_LIST_DIR}/nuklear/nuklear.h"
)

target_compile_definitions( nuklear
    INTERFACE -DNK_INCLUDE_FIXED_TYPES
    INTERFACE -DNK_INCLUDE_DEFAULT_ALLOCATOR
    INTERFACE -DNK_INCLUDE_STANDARD_IO
    INTERFACE -DNK_INCLUDE_STANDARD_VARARGS
    INTERFACE -DNK_INCLUDE_VERTEX_BUFFER_OUTPUT
    INTERFACE -DNK_INCLUDE_VERTEX_BUFFER_OUTPUT
    INTERFACE -DNK_INCLUDE_FONT_BAKING
    INTERFACE -DNK_INCLUDE_DEFAULT_FONT
    INTERFACE -DNK_VSNPRINTF=stbsp_vsnprintf
)
target_link_libraries( nuklear
    INTERFACE stb
)


add_library(tinydir INTERFACE)
target_include_directories( tinydir
    INTERFACE tinydir
)


file(GLOB_RECURSE YAML_SOURCES yaml-cpp/src/*.h yaml-cpp/src/*.cpp)
add_library(yaml-cpp STATIC ${YAML_SOURCES})
target_include_directories( yaml-cpp
    PUBLIC yaml-cpp/include
)
set_target_properties( yaml-cpp
   PROPERTIES
   FOLDER "Dependencies"
)

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

add_library(catch INTERFACE)
target_include_directories( catch
    INTERFACE Catch/include
)

add_library(mgn STATIC
    mgn.cpp
    mgn/strpool.h
)
set_target_properties( mgn
   PROPERTIES
   FOLDER "Dependencies"
)
target_include_directories( mgn
    PUBLIC mgn
)

