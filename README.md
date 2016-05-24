# **array\_passing\_performance**

This project times the impact of various types of arrays. Major improvements in GCC 6.1.1 now show negligible performance gains by omitting the **contiguous** attribute. 

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
	Explicit-shape static:                 0.559991460000000E-001
	Explicit-shape allocatable:            0.551294810000000E-001
	Explicit-shape pointer:                0.827090390000000E-001
	Assumed-shape static:                  0.669992460000000E-001
	Assumed-shape allocatable:             0.670481520000000E-001
	Assumed-shape pointer:                 0.671272990000000E-001
	Assumed-shape contiguous static:       0.569287150000000E-001
	Assumed-shape contiguous allocatable:  0.569440670000000E-001
	Assumed-shape contiguous pointer:      0.870297350000000E-001
	Local automatic:                       0.120876771000000E+000
	Local allocatable:                     0.125104144000000E+000
	Local pointer:                         0.121064947000000E+000
	
	
	Array size:         100
	Explicit-shape static:                 0.255928868000000E+000
	Explicit-shape allocatable:            0.255614121000000E+000
	Explicit-shape pointer:                0.294262873000000E+000
	Assumed-shape static:                  0.281204920000000E+000
	Assumed-shape allocatable:             0.281041024000000E+000
	Assumed-shape pointer:                 0.280135554000000E+000
	Assumed-shape contiguous static:       0.272155257000000E+000
	Assumed-shape contiguous allocatable:  0.272878350000000E+000
	Assumed-shape contiguous pointer:      0.296904086000000E+000
	Local automatic:                       0.360552687000000E+000
	Local allocatable:                     0.362944364000000E+000
	Local pointer:                         0.362944647000000E+000
	
	
	Array size:        1000
	Explicit-shape static:                 0.220929762200000E+001
	Explicit-shape allocatable:            0.220713577200000E+001
	Explicit-shape pointer:                0.222715641700000E+001
	Assumed-shape static:                  0.245621769200000E+001
	Assumed-shape allocatable:             0.247705259000000E+001
	Assumed-shape pointer:                 0.247833731800000E+001
	Assumed-shape contiguous static:       0.220680980500000E+001
	Assumed-shape contiguous allocatable:  0.220569575800000E+001
	Assumed-shape contiguous pointer:      0.223140802800000E+001
	Local automatic:                       0.230275847800000E+001
	Local allocatable:                     0.231266195200000E+001
	Local pointer:                         0.229842231800000E+001
	
	
	Array size:       10000
	Explicit-shape static:                 0.217241810860000E+002
	Explicit-shape allocatable:            0.216997048280000E+002
	Explicit-shape pointer:                0.217798387650000E+002
	Assumed-shape static:                  0.258936981860000E+002
	Assumed-shape allocatable:             0.258560792400000E+002
	Assumed-shape pointer:                 0.259130844300000E+002
	Assumed-shape contiguous static:       0.217495623440000E+002
	Assumed-shape contiguous allocatable:  0.217350725600000E+002
	Assumed-shape contiguous pointer:      0.217606021540000E+002
	Local automatic:                       0.220954619360000E+002
	Local allocatable:                     0.221360859870000E+002
	Local pointer:                         0.220309651460000E+002
	
	Total mean: 0.666840000000000E+011
	
	This file was compiled by GCC version 6.1.1 20160511 using the options -I ../objs -I ../lib -mtune=generic -march=x86-64 -auxbase-strip ../objs/type_CpuTimer.o -O3 -fimplicit-none -J ../lib


```