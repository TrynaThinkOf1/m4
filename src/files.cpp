#include "files.hpp" // header file located at m4/include/headers/files.hpp

/* STL includes */
#include <string>
#include <sstream>
#include <fstream>

/* LOCAL includes */
#include "zlc/zlibcomplete.hpp"
namespace z = zlibcomplete;

using namespace std;

/* DEFINITIONS */
#define CHUNK 16384


/* <======== READING FUNCS ========> */

	/*
	read_compressed uses the GZip decompression
	  algorithm to read compressed data from storage
	  files that contain game configuration data.
	  The GZipDecompressor class comes from the
	  zlibcomplete library (credit to Rudi Cilibrasi
	  @rudi-cilibrasi on GitHub, MIT License for
	  located in m4/include/headers/zlc/LICENSE).

	Very efficient function as the GZip decompressor
	  always takes linear O(n) time and linear O(n)
	  space complexity because it appends to an
	  existing string.

	@param filepath std::string that is the path to the file to read, if file doesn't exist it is created
	@return a std::string that is the decompressed data from the file
	*/
string read_compressed(string filepath) {
	stringstream* buffer = new stringstream;
	fstream file(filepath); // fstream so that if the file doesn't exist it is created

	*buffer << file.rdbuf(); // << is the operator for streams; rdbuf = read buffer
	file.close();

	z::GZipDecompressor decompressor; // create new class instance every time because the compiler will optimize it
	string output = decompressor.decompress(buffer->str()); // convert std::stringstream to std::string in place
	delete buffer; // clear heap

	return output;
}


	/*
	read_plaintext uses fstream to read from
	  a file.

	Highly efficient linear O(n) time and space.

	@param filepath std::string that is the path to the file to read, if file doesn't exist it is created
	@return a std::string that is the plaintext data from the file
	*/
string read_plaintext(string filepath) {
	stringstream buffer; // not on the heap so that buffer.str() can be returned directly without manually deleting
	fstream file(filepath);

	buffer << file.rdbuf(); // << is the operator for streams; rdbuf = read buffer
	file.close();

	return buffer.str();
}

/* <==== ====> */


/* <======== WRITING FUNCS ========> */

	/*
	write_compressed uses the GZip compression
	  algorithm to write compressed data to
	  storage files that contain game configuration
	  files. The GZipCompressor class comes from the
  	  zlibcomplete library (credit to Rudi Cilibrasi
  	  @rudi-cilibrasi on GitHub, MIT License for
  	  located in m4/include/headers/zlc/LICENSE).

  	Somehwat efficient function as the GZip
  	  compressor always takes close to O(n * log(n))
  	  time and space complexity.

  	@param filepath std::string that is the path to the file to write to, if file doesn't exist it is created
  	@param data Reference to a std::string that contains the data to compress and write
	*/
void write_compressed(string filepath, string& data) {
	// create new class instance every time because the compiler will optimize it
	z::GZipCompressor compressor(9, z::auto_flush); // 9 is the highest level of compression

	string fileput = compressor.compress(data); // fileput instead of output because were writing to a file

	fstream file(filepath); // fstream so that if the file doesn't exist it is created
	file << fileput; // << is the operator for adding to a stream (fstream is a filestream)
	file.close();
	compressor.finish(); // necessary function so that the compressor can flush and delete itself

	return;
}


	/*
	write_plaintext uses fstream to write to
	  a file.

	Highly efficient linear O(n) time and space.

	@param filepath std::string that is the path to the to write to, if file doesn't exist it is created
	@param data Reference to a std::string that contains the data to write
	*/
void write_plaintext(string filepath, string& data) {
	fstream file(filepath); // fstream so that if the file doesn't exist it is created
	file << data; // << is the operator for adding to a stream (fstream is a filestream)
	file.close();
	
	return;
}

/* <==== ====> */
