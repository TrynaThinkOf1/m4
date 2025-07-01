set -e # exit upon error


RED='\e[31m'
GREEN='\e[32m'
YELLOW='\e[33m'
BOLD='\e[1m'
NC='\e[0m'


msg='       ___  __  ________   ___  _____  _______
      / _ )/ / / /  _/ /  / _ \/  _/ |/ / ___/
     / _  / /_/ // // /__/ // // //    / (_ /
    /____/\____/___/____/____/___/_/|_/\___/  
'
printf "${BOLD}${msg}${NC}"


rm -f ./main
printf "${RED}\n[ Deleted existing compiled binary ]\n${NC}"


INCLUDE_DIR="./linking/include"
printf "${YELLOW}\n[ Verifying library header files ]\n${NC}"
if [ ! -d "${INCLUDE_DIR}/GLFW" ]; then
	printf "${BOLD}${RED}\n!!! [ GLFW3 LIBRARY HEADER FILES NOT FOUND ] !!!\n${NC}"
	exit
else
	printf "${GREEN}[ GLFW3 library header files found ]\n${NC}"
fi

if [ ! -d "${INCLUDE_DIR}/glad" ]; then
	printf "${BOLD}${RED}\n!!! [ GLAD LIBRARY HEADER FILES NOT FOUND ] !!!\n${NC}"
	exit
else
	printf "${GREEN}[ GLAD library header files found ]\n${NC}"
fi

if [ ! -d "${INCLUDE_DIR}/KHR" ]; then
	printf "${BOLD}${RED}\n!!! [ KHR LIBRARY HEADER FILES NOT FOUND ] !!!\n${NC}"
	exit
else
	printf "${GREEN}[ KHR library header files found ]\n${NC}"
fi

#if [ ! -d "./linking/GLEW" ]; then
#	printf "${BOLD}${RED}\n!!! [ GLEW LIBRARY HEADER FILES NOT FOUND ] !!!\n${NC}"
#	exit
#else
#	printf "${GREEN}[ GLEW library header files found ]\n${NC}"
#fi
printf "${BOLD}${GREEN}[ All library header files found ]\n${NC}"

LIB_DIR="./linking/lib"
printf "${YELLOW}[ Verifying dynamic libraries ]\n${NC}"
if [ ! -f "${LIB_DIR}/libglfw.3.dylib" ]; then
	printf "${BOLD}${RED}\n!!! [ libglfw.3.dylib LIBRARY NOT FOUND ] !!!\n${NC}"
	exit
else
	printf "${GREEN}[ libglfw.3.dylib found ]\n${NC}"
fi

if [ ! -f "./src/glad.c" ]; then
	printf "${BOLD}${RED}\n!!! [ glad.c LIBRARY FILE NOT FOUND ] !!!\n${NC}"
	exit
else
	printf "${GREEN}[ glad.c found ]\n${NC}"
fi
printf "${BOLD}${GREEN}[ ALL dynamic libraries found ]\n${NC}"


BUILD_DIR="${PWD}/build"
pushd "${BUILD_DIR}" > /dev/null # switch into build directory
rm -rf *
printf "${RED}\n[ Deleted old build files ]\n${NC}"


printf "${YELLOW}\n[ Starting CMake build ]\n${NC}"
cmake ..
printf "${GREEN}\n[ Successfully created build files ]\n${NC}"
printf "${YELLOW}[ Starting program compilation and linking ]\n${NC}"
cmake --build .
printf "${GREEN}[ Successfully created arm64 executable ]\n${NC}"
mv ./m4 ..


popd > /dev/null
printf "${GREEN}\n[ Switched back to top-level dir ]\n${NC}"


printf "${BOLD}${GREEN}\n[ BUILD SUCCESSFUL ]\n${NC}"
