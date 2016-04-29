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
	Explicit-shape static:                 0.200000000000000E-001
	Explicit-shape allocatable:            0.240000000000000E-001
	Explicit-shape pointer:                0.320000000000000E-001
	Assumed-shape static:                  0.200000000000000E-001
	Assumed-shape allocatable:             0.200000000000000E-001
	Assumed-shape pointer:                 0.240000000000000E-001
	Assumed-shape contiguous static:       0.200000000000000E-001
	Assumed-shape contiguous allocatable:  0.200000000000000E-001
	Assumed-shape contiguous pointer:      0.320000000000000E-001
	Local automatic:                       0.440000000000000E-001
	Local allocatable:                     0.480000000000000E-001
	Local pointer:                         0.440000000000000E-001
	
	
	Array size:         100
	Explicit-shape static:                 0.148000000000000E+000
	Explicit-shape allocatable:            0.144000000000000E+000
	Explicit-shape pointer:                0.152000000000000E+000
	Assumed-shape static:                  0.180000000000000E+000
	Assumed-shape allocatable:             0.180000000000000E+000
	Assumed-shape pointer:                 0.180000000000000E+000
	Assumed-shape contiguous static:       0.140000000000000E+000
	Assumed-shape contiguous allocatable:  0.140000000000000E+000
	Assumed-shape contiguous pointer:      0.160000000000000E+000
	Local automatic:                       0.184000000000000E+000
	Local allocatable:                     0.180000000000000E+000
	Local pointer:                         0.172000000000000E+000
	
	
	Array size:        1000
	Explicit-shape static:                 0.140800000000000E+001
	Explicit-shape allocatable:            0.140400000000000E+001
	Explicit-shape pointer:                0.140800000000000E+001
	Assumed-shape static:                  0.166400000000000E+001
	Assumed-shape allocatable:             0.166000000000000E+001
	Assumed-shape pointer:                 0.174800000000000E+001
	Assumed-shape contiguous static:       0.147600000000000E+001
	Assumed-shape contiguous allocatable:  0.146400000000000E+001
	Assumed-shape contiguous pointer:      0.141600000000000E+001
	Local automatic:                       0.148800000000000E+001
	Local allocatable:                     0.146800000000000E+001
	Local pointer:                         0.150400000000000E+001
	
	
	Array size:       10000
	Explicit-shape static:                 0.142960000000000E+002
	Explicit-shape allocatable:            0.143520000000000E+002
	Explicit-shape pointer:                0.142800000000000E+002
	Assumed-shape static:                  0.166920000000000E+002
	Assumed-shape allocatable:             0.167040000000000E+002
	Assumed-shape pointer:                 0.167720000000000E+002
	Assumed-shape contiguous static:       0.140360000000000E+002
	Assumed-shape contiguous allocatable:  0.140640000000000E+002
	Assumed-shape contiguous pointer:      0.140400000000000E+002
	Local automatic:                       0.140840000000000E+002
	Local allocatable:                     0.141480000000000E+002
	Local pointer:                         0.141200000000000E+002
	
	Total mean: 0.666840000000000E+011
	 
	This result was compiled by GCC version 5.3.1
```