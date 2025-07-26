#include "utils.hpp" // this is the source file that goes with that header

/* STL includes */
#include <string>

using namespace std;


/* <======== STRING UTILITIES ========> */

    /*
    ltrim stands for "left trim" because it removes
      all whitespace chars: space ( ), newline (\n),
      and carriage return (\r) from the left side of
      a string.

    Very efficient function, estimated linear O(n) time
      complexity and O(1) space complexity (because the
      string is modified in place).

    @param str Reference to a string that will be ltrimmed
    */
void ltrim(string& str) {
	size_t first = str.find_first_not_of(" \n\r");
	if (first == 0) { // no whitespaces were found before text
		return;
	}
	str = str.substr(first, str.length() - 1); // modify in place because str is a reference
	return;
}


    /*
    rtrim stand for "right trim" and is the equivalent
      function to the above ltrim, but for the right side.

    @param str Reference to a string that will be rtrimmed
    */
void rtrim(string& str) {
	size_t last = str.find_last_not_of(" \n\r");
	if (last == str.length() - 1) { //no whitespaces were found after text
		return;
	}
	str = str.substr(0, last); // modify in place because str is a reference
	return;
}

/* <==== ====> */
