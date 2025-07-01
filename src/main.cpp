#include <iostream>
#include <glad/glad.h>
#include <GLFW/glfw3.h>
using namespace std;

#define term glfwTerminate()

void framebuffer_size_callback(GLFWwindow* window, int width, int height);
void process_input(GLFWwindow* window);

int main() {
	glfwInit(); // start GLFW window manager (I think?)
	glfwWindowHint(GLFW_CONTEXT_VERSION_MAJOR, 3); // OpenGL version 3.3
	glfwWindowHint(GLFW_CONTEXT_VERSION_MINOR, 3); //    ^             ^
	
	glfwWindowHint(GLFW_OPENGL_PROFILE, GLFW_OPENGL_CORE_PROFILE); // idk

	#ifdef __APPLE__ // MILM (Man I Love MacOS)
		glfwWindowHint(GLFW_OPENGL_FORWARD_COMPAT, GL_TRUE);
	#endif

	GLFWwindow* window = glfwCreateWindow(800, 600, "OpenGL!!!", NULL, NULL); // the NULL, NULL are for monitors, which we laptop people don't have to deal with
	if (window == NULL) { // window not created -> CREATES NULL NOT nullptr OBJECT!!!
		cerr << "Could not create window!" << endl;
		term;
		return -1;
	}
	glfwMakeContextCurrent(window);

	if (!gladLoadGLLoader((GLADloadproc)glfwGetProcAddress)) { // the glad manager couldn't pickup the window
		cerr << "Could not initialize glad!" << endl;
		term;
		return -1;
	}

	glViewport(0, 0, 800, 600); // posX, posY, width, height

	glfwSetFramebufferSizeCallback(window, framebuffer_size_callback);

	while (!glfwWindowShouldClose(window)) {
		// check for interrupts
		process_input(window);

		// render
		glClearColor(0.2f, 0.3f, 0.3f, 1.0f); // clear entire window and set color to this (RGBA format)
		glClear(GL_COLOR_BUFFER_BIT); //          ^
	
		// GPU saves 2 states: current frame & next frame (just like React), it's necessary to manually swap them when working at such low levels
		glfwSwapBuffers(window); // ^ that is what this does
		glfwPollEvents(); // this looks for interrupts and such
	}

	term;
	
	return 0;
}

/*
	This method is beneficial because we need to be able to smoothly handle resizing the window
*/
void framebuffer_size_callback(GLFWwindow* window, int width, int height) {
	glViewport(0, 0, width, height);
}

/*
	In order to process interrupts like keys or mouse movement, we must define an input processor method
*/
void process_input(GLFWwindow* window) {
	if (glfwGetKey(window, GLFW_KEY_ESCAPE) == GLFW_PRESS) { // has the ESC key been pressed?
		glfwSetWindowShouldClose(window, true);
	}
}
