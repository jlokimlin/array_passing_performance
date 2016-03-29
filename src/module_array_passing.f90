module module_array_passing

    use, intrinsic :: iso_fortran_env, only: &
        wp => REAL64, &
        ip => INT32

    ! Explicit typing only
    implicit none

    ! Everything is private unless stated otherwise
    private
    public :: pass_assumed_shape_array_contiguous
    public :: pass_assumed_shape_array
    public :: pass_explicit_shape_array
    public :: local_automatic_array
    public :: local_allocatable_array
    public :: local_pointer_array


contains


    subroutine pass_assumed_shape_array_contiguous(data, mean)
        !--------------------------------------------------------------------------------
        ! Dictionary: calling arguments
        !--------------------------------------------------------------------------------
        real (wp), contiguous, intent (in out) :: data(:)
        real (wp),             intent (out)    :: mean
        !--------------------------------------------------------------------------------
        ! Dictionary: local variables
        !--------------------------------------------------------------------------------
        integer (ip) :: i !! Counter
        !--------------------------------------------------------------------------------

        associate( n => size(data) )
            do i = 1, n
                data(i) = real(i, kind=wp)
            end do
        end associate

        mean = sum(data) / max(1, size(data))

    end subroutine pass_assumed_shape_array_contiguous



    subroutine pass_assumed_shape_array(data, mean)
        !--------------------------------------------------------------------------------
        ! Dictionary: calling arguments
        !--------------------------------------------------------------------------------
        real (wp), intent (in out) :: data(:)
        real (wp), intent (out)    :: mean
        !--------------------------------------------------------------------------------
        ! Dictionary: local variables
        !--------------------------------------------------------------------------------
        integer (ip) :: i !! Counter
        !--------------------------------------------------------------------------------

        associate( n => size(data) )

            do i = 1, n
                data(i) = real(i, kind=wp)
            end do
        end associate

        mean = sum(data) / max(1, size(data))

    end subroutine pass_assumed_shape_array




    subroutine pass_explicit_shape_array( n, data, mean )
        !--------------------------------------------------------------------------------
        ! Dictionary: calling arguments
        !--------------------------------------------------------------------------------
        integer (ip), intent (in)     :: n
        real (wp),    intent (in out) :: data(n)
        real (wp),    intent (out)    :: mean
        !--------------------------------------------------------------------------------
        ! Dictionary: local variables
        !--------------------------------------------------------------------------------
        integer (ip) :: i !! Counter
        !--------------------------------------------------------------------------------

        do i = 1, n
            data(i) = real(i, kind=wp)
        end do

        mean = sum(data) / max(1, size(data))

    end subroutine pass_explicit_shape_array




    subroutine local_automatic_array(n, mean)
        !--------------------------------------------------------------------------------
        ! Dictionary: calling arguments
        !--------------------------------------------------------------------------------
        integer (ip), intent (in)  :: n
        real (wp),    intent (out) :: mean
        !--------------------------------------------------------------------------------
        ! Dictionary: local variables
        !--------------------------------------------------------------------------------
        real (wp)     :: data(n) !! Automatic array
        integer (ip)  :: i !! Counter
        !--------------------------------------------------------------------------------

        do i = 1, n
            data(i) = real(i, kind=wp)
        end do

        mean = sum(data) / max(1, size(data))

    end subroutine local_automatic_array




    subroutine local_allocatable_array(n, mean)
        !--------------------------------------------------------------------------------
        ! Dictionary: calling arguments
        !--------------------------------------------------------------------------------
        integer (ip), intent (in)  :: n
        real (wp),    intent (out) :: mean
        !--------------------------------------------------------------------------------
        ! Dictionary: local variables
        !--------------------------------------------------------------------------------
        real (wp), allocatable :: data(:) !! Allocatable array
        integer (ip)           :: i !! Counter
        !--------------------------------------------------------------------------------

        ! Allocate array
        allocate( data(n) )

        do i = 1, n
            data(i) = real(i, kind=wp)
        end do

        mean = sum(data) / max(1, size(data))

        ! Release memory
        deallocate( data )

    end subroutine local_allocatable_array



    subroutine local_pointer_array(n, mean)
        !--------------------------------------------------------------------------------
        ! Dictionary: calling arguments
        !--------------------------------------------------------------------------------
        integer (ip), intent (in)  :: n
        real (wp),    intent (out) :: mean
        !--------------------------------------------------------------------------------
        ! Dictionary: local variables
        !--------------------------------------------------------------------------------
        real (wp), pointer :: data(:) => null() !! Pointer array
        integer (ip)       :: i !! Counter
        !--------------------------------------------------------------------------------

        ! Associate pointer
        allocate( data(n) )

        do i = 1, n
            data(i) = real(i, kind=wp)
        end do

        mean = sum(data) / max(1, size(data))

        ! Nullify pointer
        deallocate( data )

    end subroutine local_pointer_array



end module module_array_passing
