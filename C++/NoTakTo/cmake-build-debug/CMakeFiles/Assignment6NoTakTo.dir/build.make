# CMAKE generated file: DO NOT EDIT!
# Generated by "Unix Makefiles" Generator, CMake Version 3.14

# Delete rule output on recipe failure.
.DELETE_ON_ERROR:


#=============================================================================
# Special targets provided by cmake.

# Disable implicit rules so canonical targets will work.
.SUFFIXES:


# Remove some rules from gmake that .SUFFIXES does not remove.
SUFFIXES =

.SUFFIXES: .hpux_make_needs_suffix_list


# Suppress display of executed commands.
$(VERBOSE).SILENT:


# A target that is always out of date.
cmake_force:

.PHONY : cmake_force

#=============================================================================
# Set environment variables for the build.

# The shell in which to execute make rules.
SHELL = /bin/sh

# The CMake executable.
CMAKE_COMMAND = /Applications/CLion.app/Contents/bin/cmake/mac/bin/cmake

# The command to remove a file.
RM = /Applications/CLion.app/Contents/bin/cmake/mac/bin/cmake -E remove -f

# Escaping for special characters.
EQUALS = =

# The top-level source directory on which CMake was run.
CMAKE_SOURCE_DIR = /Users/victoriareddington/CLionProjects/Assignment6NoTakTo

# The top-level build directory on which CMake was run.
CMAKE_BINARY_DIR = /Users/victoriareddington/CLionProjects/Assignment6NoTakTo/cmake-build-debug

# Include any dependencies generated for this target.
include CMakeFiles/Assignment6NoTakTo.dir/depend.make

# Include the progress variables for this target.
include CMakeFiles/Assignment6NoTakTo.dir/progress.make

# Include the compile flags for this target's objects.
include CMakeFiles/Assignment6NoTakTo.dir/flags.make

CMakeFiles/Assignment6NoTakTo.dir/main.cpp.o: CMakeFiles/Assignment6NoTakTo.dir/flags.make
CMakeFiles/Assignment6NoTakTo.dir/main.cpp.o: ../main.cpp
	@$(CMAKE_COMMAND) -E cmake_echo_color --switch=$(COLOR) --green --progress-dir=/Users/victoriareddington/CLionProjects/Assignment6NoTakTo/cmake-build-debug/CMakeFiles --progress-num=$(CMAKE_PROGRESS_1) "Building CXX object CMakeFiles/Assignment6NoTakTo.dir/main.cpp.o"
	/Library/Developer/CommandLineTools/usr/bin/c++  $(CXX_DEFINES) $(CXX_INCLUDES) $(CXX_FLAGS) -o CMakeFiles/Assignment6NoTakTo.dir/main.cpp.o -c /Users/victoriareddington/CLionProjects/Assignment6NoTakTo/main.cpp

CMakeFiles/Assignment6NoTakTo.dir/main.cpp.i: cmake_force
	@$(CMAKE_COMMAND) -E cmake_echo_color --switch=$(COLOR) --green "Preprocessing CXX source to CMakeFiles/Assignment6NoTakTo.dir/main.cpp.i"
	/Library/Developer/CommandLineTools/usr/bin/c++ $(CXX_DEFINES) $(CXX_INCLUDES) $(CXX_FLAGS) -E /Users/victoriareddington/CLionProjects/Assignment6NoTakTo/main.cpp > CMakeFiles/Assignment6NoTakTo.dir/main.cpp.i

CMakeFiles/Assignment6NoTakTo.dir/main.cpp.s: cmake_force
	@$(CMAKE_COMMAND) -E cmake_echo_color --switch=$(COLOR) --green "Compiling CXX source to assembly CMakeFiles/Assignment6NoTakTo.dir/main.cpp.s"
	/Library/Developer/CommandLineTools/usr/bin/c++ $(CXX_DEFINES) $(CXX_INCLUDES) $(CXX_FLAGS) -S /Users/victoriareddington/CLionProjects/Assignment6NoTakTo/main.cpp -o CMakeFiles/Assignment6NoTakTo.dir/main.cpp.s

CMakeFiles/Assignment6NoTakTo.dir/game.cpp.o: CMakeFiles/Assignment6NoTakTo.dir/flags.make
CMakeFiles/Assignment6NoTakTo.dir/game.cpp.o: ../game.cpp
	@$(CMAKE_COMMAND) -E cmake_echo_color --switch=$(COLOR) --green --progress-dir=/Users/victoriareddington/CLionProjects/Assignment6NoTakTo/cmake-build-debug/CMakeFiles --progress-num=$(CMAKE_PROGRESS_2) "Building CXX object CMakeFiles/Assignment6NoTakTo.dir/game.cpp.o"
	/Library/Developer/CommandLineTools/usr/bin/c++  $(CXX_DEFINES) $(CXX_INCLUDES) $(CXX_FLAGS) -o CMakeFiles/Assignment6NoTakTo.dir/game.cpp.o -c /Users/victoriareddington/CLionProjects/Assignment6NoTakTo/game.cpp

CMakeFiles/Assignment6NoTakTo.dir/game.cpp.i: cmake_force
	@$(CMAKE_COMMAND) -E cmake_echo_color --switch=$(COLOR) --green "Preprocessing CXX source to CMakeFiles/Assignment6NoTakTo.dir/game.cpp.i"
	/Library/Developer/CommandLineTools/usr/bin/c++ $(CXX_DEFINES) $(CXX_INCLUDES) $(CXX_FLAGS) -E /Users/victoriareddington/CLionProjects/Assignment6NoTakTo/game.cpp > CMakeFiles/Assignment6NoTakTo.dir/game.cpp.i

CMakeFiles/Assignment6NoTakTo.dir/game.cpp.s: cmake_force
	@$(CMAKE_COMMAND) -E cmake_echo_color --switch=$(COLOR) --green "Compiling CXX source to assembly CMakeFiles/Assignment6NoTakTo.dir/game.cpp.s"
	/Library/Developer/CommandLineTools/usr/bin/c++ $(CXX_DEFINES) $(CXX_INCLUDES) $(CXX_FLAGS) -S /Users/victoriareddington/CLionProjects/Assignment6NoTakTo/game.cpp -o CMakeFiles/Assignment6NoTakTo.dir/game.cpp.s

# Object files for target Assignment6NoTakTo
Assignment6NoTakTo_OBJECTS = \
"CMakeFiles/Assignment6NoTakTo.dir/main.cpp.o" \
"CMakeFiles/Assignment6NoTakTo.dir/game.cpp.o"

# External object files for target Assignment6NoTakTo
Assignment6NoTakTo_EXTERNAL_OBJECTS =

Assignment6NoTakTo: CMakeFiles/Assignment6NoTakTo.dir/main.cpp.o
Assignment6NoTakTo: CMakeFiles/Assignment6NoTakTo.dir/game.cpp.o
Assignment6NoTakTo: CMakeFiles/Assignment6NoTakTo.dir/build.make
Assignment6NoTakTo: CMakeFiles/Assignment6NoTakTo.dir/link.txt
	@$(CMAKE_COMMAND) -E cmake_echo_color --switch=$(COLOR) --green --bold --progress-dir=/Users/victoriareddington/CLionProjects/Assignment6NoTakTo/cmake-build-debug/CMakeFiles --progress-num=$(CMAKE_PROGRESS_3) "Linking CXX executable Assignment6NoTakTo"
	$(CMAKE_COMMAND) -E cmake_link_script CMakeFiles/Assignment6NoTakTo.dir/link.txt --verbose=$(VERBOSE)

# Rule to build all files generated by this target.
CMakeFiles/Assignment6NoTakTo.dir/build: Assignment6NoTakTo

.PHONY : CMakeFiles/Assignment6NoTakTo.dir/build

CMakeFiles/Assignment6NoTakTo.dir/clean:
	$(CMAKE_COMMAND) -P CMakeFiles/Assignment6NoTakTo.dir/cmake_clean.cmake
.PHONY : CMakeFiles/Assignment6NoTakTo.dir/clean

CMakeFiles/Assignment6NoTakTo.dir/depend:
	cd /Users/victoriareddington/CLionProjects/Assignment6NoTakTo/cmake-build-debug && $(CMAKE_COMMAND) -E cmake_depends "Unix Makefiles" /Users/victoriareddington/CLionProjects/Assignment6NoTakTo /Users/victoriareddington/CLionProjects/Assignment6NoTakTo /Users/victoriareddington/CLionProjects/Assignment6NoTakTo/cmake-build-debug /Users/victoriareddington/CLionProjects/Assignment6NoTakTo/cmake-build-debug /Users/victoriareddington/CLionProjects/Assignment6NoTakTo/cmake-build-debug/CMakeFiles/Assignment6NoTakTo.dir/DependInfo.cmake --color=$(COLOR)
.PHONY : CMakeFiles/Assignment6NoTakTo.dir/depend
