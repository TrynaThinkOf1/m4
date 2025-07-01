cmake_minimum_required( VERSION 4.0.3 )
set( CMAKE_CXX_STANDARD 20 )
set( CMAKE_CXX_FLAGS "-DCMAKE_OSX_ARCHITECTURES=arm64" )
set( CMAKE_VERBOSE_MAKEFILE ON )

project( learning_opengl )

# find OpenGL first
find_package( OpenGL REQUIRED )

# include headers (glfw, glad, etc.)
include_directories( "${PROJECT_SOURCE_DIR}/linking/include" )

add_executable( main
	src/main.cpp
	src/glad.c
)

target_link_libraries( main PRIVATE
	OpenGL::GL
	"${PROJECT_SOURCE_DIR}/linking/lib/libglfw.3.dylib"
)
