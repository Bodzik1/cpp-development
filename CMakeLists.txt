# Set the minimum CMake version required
cmake_minimum_required(VERSION 3.10)

# Define the project
project(main VERSION 1.0)

# Set the C++ standard
set(CMAKE_CXX_STANDARD 20)
set(CMAKE_CXX_STANDARD_REQUIRED True)

# Ensure a default build type
if(NOT CMAKE_BUILD_TYPE)
    set(CMAKE_BUILD_TYPE Debug CACHE STRING "Choose the type of build (Debug or Release)" FORCE)
endif()

# Add an executable target
add_executable(main src/main.cpp)

# Set compile options based on the build type
if(CMAKE_BUILD_TYPE STREQUAL "Debug")
    target_compile_options(main PRIVATE
        -Wall
        -Weffc++
        -Wextra
        -Wconversion
        -Wsign-conversion
        -pedantic-errors
        -Werror
        -ggdb   # Debugging symbols for GDB
        -O0     # No optimizations for easier debugging
    )
elseif(CMAKE_BUILD_TYPE STREQUAL "Release")
    target_compile_options(main PRIVATE
        -Wall
        -Weffc++
        -Wextra
        -Wconversion
        -Wsign-conversion
        -pedantic-errors
        -Werror
        -O2      # Optimization for release builds
        -DNDEBUG # Disable debugging-related code
    )
endif()
