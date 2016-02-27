
include ../make.inc

LINKS = \
-I$(OBJ_DIRECTORY) \
-I$(LIB_DIRECTORY)

EXECUTABLE = ./build.exe

type_CpuTimer.o: \
type_CpuTimer.f90
	$(FC) $(FFLAGS) -c type_CpuTimer.f90 $(LINKS) \
	 -o $(OBJ_DIRECTORY)/$@ -J$(LIB_DIRECTORY)

module_array_passing.o: \
module_array_passing.f90
	$(FC) $(FFLAGS) -c module_array_passing.f90 $(LINKS) \
	 -o $(OBJ_DIRECTORY)/$@ -J$(LIB_DIRECTORY)

main.o: \
type_CpuTimer.o \
module_array_passing.o \
main.f90
	$(FC) $(FFLAGS) -c main.f90 $(LINKS) \
	-o $(OBJ_DIRECTORY)/$@

exec: $(OBJ)
	$(FC) $(FFLAGS) -o $(EXECUTABLE) $(OBJS) $(LINKS)

run:
	make clean
	make exec; $(EXECUTABLE)

clean:
	rm -f $(OBJS) $(EXECUTABLE) $(LIB_DIRECTORY)/*.mod
