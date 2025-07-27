#ifndef UTILS_HPP
#define UTILS_HPP

/* STL includes */
#include <string>

using std::string;

/* <== STRING UTILITIES ==> */

  /*
  docstrings for funcs located in source file (m4/src/utils.cpp)
  */
	
void ltrim(string& str);

void rtrim(string& str);

inline void ftrim(string& str) { // ftrim stands for "full trim" because it combines left and right trims
	ltrim(str);
	rtrim(str);
	return;
}

	/*
	The multiplication operator for strings is useful
	  in many cases, specifically when trying to repeat
	  a string many times without a for loop.

	This function is very simple and has O(n) time
	  complexity and <UNKOWN> space complexity.

	It does return by value, which is inefficient (but
	  somewhat ok for primitive data types like strings)
	  however I felt it was more cumbersome to have to
	  worry about heap management for such a simple func.

	@param a std::string that will be multiplied by b
	@param b unsigned int that will multiply a

	@return a std::string that will be a repeated b times
	*/
static string operator * (string a, unsigned int b) {
	string output = "";
	while (b--) { // count down
		output += a;
	}
	return output;
}
static string operator * (unsigned int b, string a) { // same operator but for reversed param order
	return a * b; // use the previously defined operator but use correct param order
}

/* <= => */

#endif /* UTILS_HPP */
