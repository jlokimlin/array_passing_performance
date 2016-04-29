# **array\_passing\_performance**

This project times the impact of various types of arrays and concludes that passing assumed-shape dummy arguments with the **contiguous** attribute is crucial for performance. 

-----------------------------------------------------------------------------

## Requirements
* The GNU Make tool https://www.gnu.org/software/make/
* The GNU gfortran compiler https://gcc.gnu.org/wiki/GFortran

-----------------------------------------------------------------------------

## To build the project

Type the following command line arguments
```
git clone https://github.com/jlokimlin/array_passing_performance.git

cd array_passing_performance; make all
```
-----------------------------------------------------------------------------

## Result

```

	Array size:          10
	Pass explicit-shape static:                 0.229960000000000E-001
	Pass explicit-shape allocatable:            0.229970000000000E-001
	Pass explicit-shape pointer:                0.349940000000000E-001
	Pass assumed-shape static:                  0.249960000000000E-001
	Pass assumed-shape allocatable:             0.249970000000000E-001
	Pass assumed-shape pointer:                 0.239960000000000E-001
	Pass assumed-shape contiguous static:       0.229960000000000E-001
	Pass assumed-shape contiguous allocatable:  0.239970000000000E-001
	Pass assumed-shape contiguous pointer:      0.349940000000000E-001
	Local automatic:                            0.589920000000000E-001
	Local allocatable:                          0.539910000000000E-001
	Local pointer:                              0.549920000000000E-001
	
	Array size:         100
	Pass explicit-shape static:                 0.173973000000000E+000
	Pass explicit-shape allocatable:            0.175974000000000E+000
	Pass explicit-shape pointer:                0.189971000000000E+000
	Pass assumed-shape static:                  0.228965000000000E+000
	Pass assumed-shape allocatable:             0.225966000000000E+000
	Pass assumed-shape pointer:                 0.222966000000000E+000
	Pass assumed-shape contiguous static:       0.170974000000000E+000
	Pass assumed-shape contiguous allocatable:  0.174973000000000E+000
	Pass assumed-shape contiguous pointer:      0.186972000000000E+000
	Local automatic:                            0.218967000000000E+000
	Local allocatable:                          0.222966000000000E+000
	Local pointer:                              0.227965000000000E+000
	
	Array size:        1000
	Pass explicit-shape static:                 0.169774200000000E+001
	Pass explicit-shape allocatable:            0.169274300000000E+001
	Pass explicit-shape pointer:                0.170574000000000E+001
	Pass assumed-shape static:                  0.210068100000000E+001
	Pass assumed-shape allocatable:             0.209968100000000E+001
	Pass assumed-shape pointer:                 0.210068000000000E+001
	Pass assumed-shape contiguous static:       0.168874400000000E+001
	Pass assumed-shape contiguous allocatable:  0.168874300000000E+001
	Pass assumed-shape contiguous pointer:      0.170574100000000E+001
	Local automatic:                            0.173673600000000E+001
	Local allocatable:                          0.173773500000000E+001
	Local pointer:                              0.174373500000000E+001
	
	Array size:       10000
	Pass explicit-shape static:                 0.167694510000000E+002
	Pass explicit-shape allocatable:            0.167684510000000E+002
	Pass explicit-shape pointer:                0.167794490000000E+002
	Pass assumed-shape static:                  0.208948230000000E+002
	Pass assumed-shape allocatable:             0.208978230000000E+002
	Pass assumed-shape pointer:                 0.208948240000000E+002
	Pass assumed-shape contiguous static:       0.167654510000000E+002
	Pass assumed-shape contiguous allocatable:  0.167604520000000E+002
	Pass assumed-shape contiguous pointer:      0.167754500000000E+002
	Local automatic:                            0.168354410000000E+002
	Local allocatable:                          0.168374400000000E+002
	Local pointer:                              0.168394400000000E+002
	
	Total mean: 0.500130000000000E+011
	 
	This result was compiled by GCC version 5.1.0
```