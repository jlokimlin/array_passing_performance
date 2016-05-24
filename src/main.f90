program main

    use, intrinsic :: iso_fortran_env, only: &
        wp => REAL64, &
        ip => INT32, &
        stdout => OUTPUT_UNIT

    use type_CpuTimer, only: &
        CpuTimer

    use type_array_passer, only: &
        ArrayPasser

    ! Explicit typing only
    implicit none

    ! Declare derived data type
    type :: TimeKeeper
        !--------------------------------------------------
        ! Class variables
        !--------------------------------------------------
        real (wp) :: contiguous_static = 0.0_wp
        real (wp) :: contiguous_alloc = 0.0_wp
        real (wp) :: contiguous_pointer = 0.0_wp
        real (wp) :: assumed_static = 0.0_wp
        real (wp) :: assumed_alloc = 0.0_wp
        real (wp) :: assumed_pointer = 0.0_wp
        real (wp) :: explicit_static = 0.0_wp
        real (wp) :: explicit_alloc = 0.0_wp
        real (wp) :: explicit_pointer = 0.0_wp
        real (wp) :: local_auto = 0.0_wp
        real (wp) :: local_alloc = 0.0_wp
        real (wp) :: local_pointer = 0.0_wp
        !--------------------------------------------------
    end type

    !------------------------------------------------------
    ! Dictionary
    !------------------------------------------------------
    integer (ip), parameter :: STATIC_SIZE = 10**6
    integer (ip)            :: array_size
    integer (ip)            :: i, j !! Counters
    real (wp)               :: mean, total_mean
    real (wp), target       :: static_data(STATIC_SIZE)
    real (wp), allocatable  :: allocatable_data(:)
    real (wp), pointer      :: pointer_data(:) => null()
    type (ArrayPasser)      :: pass
    type (CpuTimer)         :: cpu_timer
    type (TimeKeeper)       :: time_keeper
    !------------------------------------------------------

    ! Initialize
    array_size = 1
    pass = ArrayPasser(f=get_mean)

    do j = 1, 4

        ! Increment array size
        array_size = array_size * 10

        !
        !==> Allocate memory
        !
        allocate( allocatable_data(array_size) )

        !
        !==> Assign pointer
        !
        pointer_data => static_data(1:array_size)

        !
        !==>  Pass explicit-shape static data
        !
        associate( time => time_keeper%explicit_static )

            ! Start timer
            call cpu_timer%start()

            do i = 1,STATIC_SIZE
                associate( subarray => static_data(1:array_size) )

                    ! Pass array
                    call pass%explicit_shape_array(array_size, subarray, mean)

                    ! Update total mean
                    total_mean = total_mean + mean
                end associate
            end do

            ! Stop timer
            call cpu_timer%stop()

            ! Get elapsed CPU time
            time = cpu_timer%get_elapsed_time()
        end associate

        !
        !==>  Pass explicit-shape allocatable data
        !
        associate( time => time_keeper%explicit_alloc )

            ! Start timer
            call cpu_timer%start()

            do i = 1,STATIC_SIZE

                ! Pass array
                call pass%explicit_shape_array(array_size, allocatable_data, mean)

                ! Update total mean
                total_mean = total_mean + mean
            end do

            ! Stop timer
            call cpu_timer%stop()

            ! Get elapsed CPU time
            time = cpu_timer%get_elapsed_time()
        end associate

        !
        !==>  Pass explicit-shape pointer data
        !
        associate( time => time_keeper%explicit_pointer )

            ! Start timer
            call cpu_timer%start()

            do i = 1,STATIC_SIZE

                ! Pass array
                call pass%explicit_shape_array(array_size, pointer_data, mean)

                ! Update total mean
                total_mean = total_mean + mean
            end do

            ! Stop timer
            call cpu_timer%stop()

            ! Get elapsed CPU time
            time = cpu_timer%get_elapsed_time()
        end associate

        !
        !==>  Pass assumed-shape static data
        !
        associate( time => time_keeper%assumed_static )

            ! Start timer
            call cpu_timer%start()

            associate( subarray => static_data(1:array_size) )
                do i = 1,STATIC_SIZE

                    ! Pass array
                    call pass%assumed_shape_array(subarray, mean)

                    ! Update total mean
                    total_mean = total_mean + mean
                end do
            end associate

            ! Stop timer
            call cpu_timer%stop()

            ! Get elapsed CPU time
            time = cpu_timer%get_elapsed_time()
        end associate

        !
        !==>  Pass assumed-shape allocatable data
        !
        associate( time => time_keeper%assumed_alloc )

            ! Start timer
            call cpu_timer%start()

            do i = 1,STATIC_SIZE

                ! Pass array
                call pass%assumed_shape_array(allocatable_data, mean)

                ! Update total mean
                total_mean = total_mean + mean
            end do

            ! Stop timer
            call cpu_timer%stop()

            ! Get elapsed CPU time
            time = cpu_timer%get_elapsed_time()
        end associate

        !
        !==>  Pass assumed-shape pointer data
        !
        associate( time => time_keeper%assumed_pointer )

            ! Start timer
            call cpu_timer%start()

            do i = 1,STATIC_SIZE

                ! Pass array
                call pass%assumed_shape_array(pointer_data, mean)

                ! Update total mean
                total_mean = total_mean + mean
            end do

            ! Stop timer
            call cpu_timer%stop()

            ! Get elapsed CPU time
            time = cpu_timer%get_elapsed_time()
        end associate

        !
        !==>  Pass contiguous assumed-shape static data
        !
        associate( time => time_keeper%contiguous_static )

            ! Start timer
            call cpu_timer%start()

            associate( subarray => static_data(1:array_size) )
                do i = 1,STATIC_SIZE

                    ! Pass array
                    call pass%assumed_shape_array_contiguous( subarray, mean)

                    ! Update total mean
                    total_mean = total_mean + mean
                end do
            end associate

            ! Stop timer
            call cpu_timer%stop()

            ! Get elapsed CPU time
            time = cpu_timer%get_elapsed_time()
        end associate

        !
        !==>  Pass contiguous assumed-shape allocatable data
        !
        associate( time => time_keeper%contiguous_alloc )

            ! Start timer
            call cpu_timer%start()

            do i = 1,STATIC_SIZE

                ! Pass array
                call pass%assumed_shape_array_contiguous(allocatable_data, mean)

                ! Update total mean
                total_mean = total_mean + mean
            end do

            ! Stop timer
            call cpu_timer%stop()

            ! Get elapsed CPU time
            time = cpu_timer%get_elapsed_time()
        end associate

        !
        !==>  Pass contiguous assumed-shape pointer data
        !
        associate( time => time_keeper%contiguous_pointer )

            ! Start timer
            call cpu_timer%start()

            do i = 1,STATIC_SIZE
                ! Pass array
                call pass%assumed_shape_array_contiguous( pointer_data, mean)

                ! Update total mean
                total_mean = total_mean + mean
            end do

            ! Stop timer
            call cpu_timer%stop()

            ! Get elapsed CPU time
            time = cpu_timer%get_elapsed_time()
        end associate

        !
        !==>  Local automatic array
        !
        associate( time => time_keeper%local_auto )

            ! Start timer
            call cpu_timer%start()

            do i = 1,STATIC_SIZE

                ! Pass array
                call pass%local_automatic_array(array_size, mean)

                ! Update total mean
                total_mean = total_mean + mean
            end do

            ! Stop timer
            call cpu_timer%stop()

            ! Get elapsed CPU time
            time = cpu_timer%get_elapsed_time()
        end associate

        !
        !==>  Local allocatable array
        !
        associate( time => time_keeper%local_alloc )

            ! Start timer
            call cpu_timer%start()

            do i = 1,STATIC_SIZE

                ! Pass array
                call pass%local_allocatable_array(array_size, mean)

                ! Update total mean
                total_mean = total_mean + mean
            end do

            ! Stop timer
            call cpu_timer%stop()

            ! Get elapsed CPU time
            time = cpu_timer%get_elapsed_time()
        end associate

        !
        !==>  Local pointer array
        !
        associate( time => time_keeper%local_pointer )

            ! Start timer
            call cpu_timer%start()

            do i = 1,STATIC_SIZE

                ! Pass array
                call pass%local_pointer_array(array_size, mean)

                ! Update total mean
                total_mean = total_mean + mean
            end do

            ! Stop timer
            call cpu_timer%stop()

            ! Get elapsed CPU time
            time = cpu_timer%get_elapsed_time()
        end associate

        ! Release memory
        deallocate( allocatable_data )

        ! Nullify pointer
        nullify( pointer_data )

        !
        !==> Print performance
        !
        write( stdout, '(A)' ) ''
        write( stdout, '(A,I11)' )      'Array size: ', array_size
        write( stdout, '(A,E23.15E3)' ) 'Explicit-shape static:                ', time_keeper%explicit_static
        write( stdout, '(A,E23.15E3)' ) 'Explicit-shape allocatable:           ', time_keeper%explicit_alloc
        write( stdout, '(A,E23.15E3)' ) 'Explicit-shape pointer:               ', time_keeper%explicit_pointer
        write( stdout, '(A,E23.15E3)' ) 'Assumed-shape static:                 ', time_keeper%assumed_static
        write( stdout, '(A,E23.15E3)' ) 'Assumed-shape allocatable:            ', time_keeper%assumed_alloc
        write( stdout, '(A,E23.15E3)' ) 'Assumed-shape pointer:                ', time_keeper%assumed_pointer
        write( stdout, '(A,E23.15E3)' ) 'Assumed-shape contiguous static:      ', time_keeper%contiguous_static
        write( stdout, '(A,E23.15E3)' ) 'Assumed-shape contiguous allocatable: ', time_keeper%contiguous_alloc
        write( stdout, '(A,E23.15E3)' ) 'Assumed-shape contiguous pointer:     ', time_keeper%contiguous_pointer
        write( stdout, '(A,E23.15E3)' ) 'Local automatic:                      ', time_keeper%local_auto
        write( stdout, '(A,E23.15E3)' ) 'Local allocatable:                    ', time_keeper%local_alloc
        write( stdout, '(A,E23.15E3)' ) 'Local pointer:                        ', time_keeper%local_pointer
        write( stdout, '(A)' ) ''
    end do

    !
    !==> Print total mean
    !
    write( stdout, '(A,E23.15E3)' ) 'Total mean:', total_mean

    !
    !==> Print compiler info
    !
    call cpu_timer%print_compiler_info()


contains


    pure function get_mean(data) result (mean)
        !------------------------------------------------------------------
        ! Dictionary: calling arguments
        !------------------------------------------------------------------
        real (wp), intent (in) :: data(:)
        real (wp)              :: mean
        !------------------------------------------------------------------

        mean = sum(data)/max(1, size(data))

    end function get_mean

end program main
