#ifndef FILES_HPP
#define FILES_HPP

/* STL includes */
#include <string>
#include <sstream>
#include <fstream>

/* LOCAL includes */
#include "zlc/zlibcomplete.hpp"
namespace z = zlibcomplete;

using namespace std;

/* <== FILE FUNCTIONS ==> */

  /*
  docstrings for funcs are located in source file (m4/src/files.cpp)
  */

string read_compressed(string filepath);

string read_plaintext(string filepath);


void write_compressed(string filepath, string& data);

void write_plaintext(string filepath, string& data);

/* <= => */

#endif /* FILES_HPP */
