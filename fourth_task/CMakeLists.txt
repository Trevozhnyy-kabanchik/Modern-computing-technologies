cmake_minimum_required(VERSION 3.10)
project(inmost_project)

set(CMAKE_CXX_STANDARD 17)
set(CMAKE_CXX_STANDARD_REQUIRED ON)

set(INMOST_DIR "${CMAKE_CURRENT_SOURCE_DIR}/../second_task/INMOST-install")

find_package(INMOST REQUIRED)

include_directories(${INMOST_INCLUDE_DIRS})
link_directories(${INMOST_LIBRARY_DIRS})
add_definitions(${INMOST_DEFINITIONS})

add_executable(mesh mesh.cpp)

target_link_libraries(mesh ${INMOST_LIBRARIES})