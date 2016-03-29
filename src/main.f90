program main

    use, intrinsic :: iso_fortran_env, only: &
        wp => REAL64, &
        ip => INT32, &
        stdout => OUTPUT_UNIT, &
        compiler_version, &
        compiler_options

    use type_CpuTimer, only: &
        CpuTimer

    use module_array_passing, only: &
        pass_assumed_shape_array_contiguous, &
        pass_assumed_shape_array, &
        pass_explicit_shape_array, &
        local_automatic_array, &
        local_allocatable_array, &
        local_pointer_array

    ! Explicit typing only
    implicit none

    !--------------------------------------------------------------------------------
    ! Dictionary
    !--------------------------------------------------------------------------------
    type (CpuTimer)         :: timer
    integer (ip), parameter :: STATIC_SIZE = 10**6
    integer (ip)            :: array_size
    integer (ip)            :: i, j !! Counters
    real (wp)               :: time_contiguous_static
    real (wp)               :: time_contiguous_alloc
    real (wp)               :: time_contiguous_pointer
    real (wp)               :: time_assumed_static
    real (wp)               :: time_assumed_alloc
    real (wp)               :: time_assumed_pointer
    real (wp)               :: time_explicit_static
    real (wp)               :: time_explicit_alloc
    real (wp)               :: time_explicit_pointer
    real (wp)               :: time_local_auto
    real (wp)               :: time_local_alloc
    real (wp)               :: time_local_pointer
    real (wp)               :: mean, total_mean
    real (wp), target       :: static_data(STATIC_SIZE)
    real (wp), allocatable  :: allocatable_data(:)
    real (wp), pointer      :: pointer_data(:) => null()
    !--------------------------------------------------------------------------------

    !
    !==> Initialize
    !
    array_size = 1

    do j = 1, 4

        ! Increment array size
        array_size = array_size * 10

        ! Allocate array
        allocate( allocatable_data(array_size) )

        ! Associate pointer
        pointer_data => static_data(1:array_size)

        !
        !==> explicit-shape array passing
        !

        ! Pass explicit-shape static data
        call timer%start()
        do i = 1,STATIC_SIZE
            associate( subarray => static_data(1:array_size) )
                call pass_explicit_shape_array( array_size, subarray, mean )
                total_mean = total_mean + mean
            end associate
        end do
        call timer%stop()
        time_explicit_static = timer%get_total_cpu_time()

        ! Pass explicit-shape allocatable data
        call timer%start()
        do i = 1,STATIC_SIZE
            call pass_explicit_shape_array( array_size, allocatable_data, mean )
            total_mean = total_mean + mean
        end do
        call timer%stop()
        time_explicit_alloc = timer%get_total_cpu_time()

        ! Pass explicit-shape pointer data
        call timer%start()
        do i = 1,STATIC_SIZE
            call pass_explicit_shape_array( array_size, pointer_data, mean )
            total_mean = total_mean + mean
        end do
        call timer%stop()
        time_explicit_pointer = timer%get_total_cpu_time()

        !
        !==> assumed-shape array passing
        !

        ! Pass assumed-shape static data
        call timer%start()
        associate( subarray => static_data(1:array_size) )
            do i = 1,STATIC_SIZE
                call pass_assumed_shape_array( subarray, mean )
                total_mean = total_mean + mean
            end do
        end associate
        call timer%stop()
        time_assumed_static = timer%get_total_cpu_time()

        ! Pass assumed-shape allocatable data
        call timer%start()
        do i = 1,STATIC_SIZE
            call pass_assumed_shape_array( allocatable_data, mean )
            total_mean = total_mean + mean
        end do
        call timer%stop()
        time_assumed_alloc = timer%get_total_cpu_time()

        ! Pass assumed-shape pointer data
        call timer%start()

        do i = 1,STATIC_SIZE
            call pass_assumed_shape_array( pointer_data, mean )
            total_mean = total_mean + mean
        end do
        call timer%stop()
        time_assumed_pointer = timer%get_total_cpu_time()

        !
        !==> Contiguous assumed-shape array passing

        ! Pass contiguous assumed-shape static data
        call timer%start()
        associate( subarray => static_data(1:array_size) )
            do i = 1,STATIC_SIZE
                call pass_assumed_shape_array_contiguous( subarray, mean )
                total_mean = total_mean + mean
            end do
        end associate
        call timer%stop()
        time_contiguous_static = timer%get_total_cpu_time()

        ! Pass contiguous assumed-shape allocatable data
        call timer%start()
        do i = 1,STATIC_SIZE
            call pass_assumed_shape_array_contiguous( allocatable_data, mean )
            total_mean = total_mean + mean
        end do
        call timer%stop()
        time_contiguous_alloc = timer%get_total_cpu_time()

        ! Pass contiguous assumed-shape pointer data
        call timer%start()
        do i = 1,STATIC_SIZE
            call pass_assumed_shape_array_contiguous( pointer_data, mean )
            total_mean = total_mean + mean
        end do
        call timer%stop()
        time_contiguous_pointer = timer%get_total_cpu_time()

        !
        !==> Local arrays
        !

        ! Local automatic array
        call timer%start()
        do i = 1,STATIC_SIZE
            call local_automatic_array( array_size, mean )
        end do
        call timer%stop()
        time_local_auto = timer%get_total_cpu_time()

        ! Local allocatable array
        call timer%start()
        do i = 1,STATIC_SIZE
            call local_allocatable_array( array_size, mean )
        end do
        call timer%stop()
        time_local_alloc = timer%get_total_cpu_time()

        ! Local pointer array
        call timer%start()
        do i = 1,STATIC_SIZE
            call local_pointer_array( array_size, mean )
        end do
        call timer%stop()
        time_local_pointer = timer%get_total_cpu_time()

        ! Deallocate array
        deallocate( allocatable_data )

        ! Nullify pointer
        nullify( pointer_data )

        !
        !==> Print performance
        !
        write( stdout, '(A)' ) ''
        write( stdout, '(A,I11)' )      'Array size: ', array_size
        write( stdout, '(A,E23.15E3)' ) 'Pass explicit-shape static:                ', time_explicit_static
        write( stdout, '(A,E23.15E3)' ) 'Pass explicit-shape allocatable:           ', time_explicit_alloc
        write( stdout, '(A,E23.15E3)' ) 'Pass explicit-shape pointer:               ', time_explicit_pointer
        write( stdout, '(A,E23.15E3)' ) 'Pass assumed-shape static:                 ', time_assumed_static
        write( stdout, '(A,E23.15E3)' ) 'Pass assumed-shape allocatable:            ', time_assumed_alloc
        write( stdout, '(A,E23.15E3)' ) 'Pass assumed-shape pointer:                ', time_assumed_pointer
        write( stdout, '(A,E23.15E3)' ) 'Pass assumed-shape contiguous static:      ', time_contiguous_static
        write( stdout, '(A,E23.15E3)' ) 'Pass assumed-shape contiguous allocatable: ', time_contiguous_alloc
        write( stdout, '(A,E23.15E3)' ) 'Pass assumed-shape contiguous pointer:     ', time_contiguous_pointer
        write( stdout, '(A,E23.15E3)' ) 'Local automatic:                           ', time_local_auto
        write( stdout, '(A,E23.15E3)' ) 'Local allocatable:                         ', time_local_alloc
        write( stdout, '(A,E23.15E3)' ) 'Local pointer:                             ', time_local_pointer
    end do

    ! Print total mean
    write( stdout, '(A)' ) ''
    write( stdout, '(A,E23.15E3)' ) 'Total mean:', total_mean

    !
    !==> Print compiler info
    !
    write( stdout, '(A)' ) ' '
    write( stdout, '(4A)' ) 'This result was compiled by ', &
        compiler_version(), ' using the options ', &
        compiler_options()
    write( stdout, '(A)' ) ' '

end program main
