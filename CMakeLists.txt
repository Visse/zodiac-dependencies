
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
get_target_property(IMGUI_INTERFACE_SOURCES imgui INTERFACE_SOURCES)
source_group(imgui FILES ${IMGUI_INTERFACE_SOURCES})


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
    PUBLIC stb
)
set_target_properties( nuklear
   PROPERTIES
   FOLDER "Dependencies"
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

