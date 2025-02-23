#!/bin/bash

# Function to find the project root by looking for the CMakeLists.txt file
find_project_root() {
  DIR=$(pwd)
  while [ ! -f "$DIR/CMakeLists.txt" ] && [ "$DIR" != "/" ]; do
    DIR=$(dirname "$DIR")
  done
  echo "$DIR"
}

# Find the project root directory
PROJECT_DIR=$(find_project_root)

# Ensure that CMakeLists.txt was found
if [ ! -f "$PROJECT_DIR/CMakeLists.txt" ]; then
  echo "Error: Could not find CMakeLists.txt in the project."
  exit 1
fi

# Ask the user for the build type
echo "Select build type:"
echo "d) Debug (default)"
echo "r) Release"
read -p "Enter choice [d-r]: " choice

# Set build type based on user input
case "$choice" in
  r|R) BUILD_TYPE="Release" ;;
  *) BUILD_TYPE="Debug" ;;  # Default to Debug
esac

echo "Using build type: $BUILD_TYPE"

# Create the build and output directories if they don't exist
mkdir -p "$PROJECT_DIR/build"
mkdir -p "$PROJECT_DIR/output"

# Navigate into the build directory
cd "$PROJECT_DIR/build"

# Run CMake with the chosen build type
cmake -DCMAKE_BUILD_TYPE=$BUILD_TYPE "$PROJECT_DIR"

# Run make to build the project
make

# Move the 'main' file to the output directory
if [ -f "$PROJECT_DIR/build/main" ]; then
  mv "$PROJECT_DIR/build/main" "$PROJECT_DIR/output/"
  # Run the main executable from the output directory
  echo "Running the program..."
  cd "$PROJECT_DIR/output"
  ./main  # Execute the main program
else
  echo "File 'main' not found!"
fi
