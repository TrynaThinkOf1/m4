#ifndef DEFINITIONS_HPP
#define DEFINITIONS_HPP


/* <== DEFINITIONS ==> */

	/* numbers */
#define PI 3.1415926535897932384626433832795
#define HALF_PI 1.5707963267948966192313216916398
#define TWO_PI 6.283185307179586476925286766559
#define EULER 2.718281828459045235360287471352

#define DEG_TO_RAD 0.017453292519943295769236907684886
#define RAD_TO_DEG 57.295779513082320876798154814105

	/* functions */
#define CONSTRAIN(num, high, low) ( (num) > (high) ? (high) : (num) < (low) ? (low) : (num) )
	
#define RELU(num) ( (num) > 0 ? (num) : 0 )
	
#define RADIANS(degrees) ( (degrees) * DEG_TO_RAD )
#define DEGREES(radians) ( (degrees) * RAD_TO_DEG )

#define MIN(a, b) ( (a) < (b) ? (a) : (b) )
#define MAX(a, b) ( (a) > (b) ? (a) : (b) )
#define SQ(x) ( (x) * (x) )

/* <= => */


#endif /* DEFINITIONS_HPP */
