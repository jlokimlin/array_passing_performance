# **array\_passing\_performance**

This project times the impact of various types of arrays and concludes that passing assumed shape dummy arguments with the **CONTIGUOUS** attribute is absolutely crucial for performance. 

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

-----------------------------------------------------------------------------

## Result

Array size:          10
Pass explicit shape static:                 0.240000000000000E-001
Pass explicit shape allocatable:            0.200000000000000E-001
Pass explicit shape pointer:                0.280000000000000E-001
Pass assumed shape static:                  0.200000000000000E-001
Pass assumed shape allocatable:             0.320000000000000E-001
Pass assumed shape pointer:                 0.320000000000000E-001
Pass assumed shape contiguous static:       0.240000000000000E-001
Pass assumed shape contiguous allocatable:  0.200000000000000E-001
Pass assumed shape contiguous pointer:      0.240000000000000E-001
Local automatic:                            0.400000000000000E-001
Local allocatable:                          0.400000000000000E-001
Local pointer:                              0.400000000000000E-001

Array size:         100
Pass explicit shape static:                 0.152000000000000E+000
Pass explicit shape allocatable:            0.148000000000000E+000
Pass explicit shape pointer:                0.160000000000000E+000
Pass assumed shape static:                  0.192000000000000E+000
Pass assumed shape allocatable:             0.192000000000000E+000
Pass assumed shape pointer:                 0.200000000000000E+000
Pass assumed shape contiguous static:       0.164000000000000E+000
Pass assumed shape contiguous allocatable:  0.156000000000000E+000
Pass assumed shape contiguous pointer:      0.156000000000000E+000
Local automatic:                            0.180000000000000E+000
Local allocatable:                          0.188000000000000E+000
Local pointer:                              0.180000000000000E+000

Array size:        1000
Pass explicit shape static:                 0.151600000000000E+001
Pass explicit shape allocatable:            0.152400000000000E+001
Pass explicit shape pointer:                0.152800000000000E+001
Pass assumed shape static:                  0.195600000000000E+001
Pass assumed shape allocatable:             0.178800000000000E+001
Pass assumed shape pointer:                 0.184400000000000E+001
Pass assumed shape contiguous static:       0.154800000000000E+001
Pass assumed shape contiguous allocatable:  0.152000000000000E+001
Pass assumed shape contiguous pointer:      0.158400000000000E+001
Local automatic:                            0.153200000000000E+001
Local allocatable:                          0.153200000000000E+001
Local pointer:                              0.154000000000000E+001

Array size:       10000
Pass explicit shape static:                 0.149880000000000E+002
Pass explicit shape allocatable:            0.149760000000000E+002
Pass explicit shape pointer:                0.150160000000000E+002
Pass assumed shape static:                  0.190320000000000E+002
Pass assumed shape allocatable:             0.180920000000000E+002
Pass assumed shape pointer:                 0.179640000000000E+002
Pass assumed shape contiguous static:       0.150400000000000E+002
Pass assumed shape contiguous allocatable:  0.150640000000000E+002
Pass assumed shape contiguous pointer:      0.152000000000000E+002
Local automatic:                            0.151280000000000E+002
Local allocatable:                          0.150320000000000E+002
Local pointer:                              0.150560000000000E+002

Total mean: 0.500130000000000E+011
 
This result was compiled by GCC version 5.3.1
