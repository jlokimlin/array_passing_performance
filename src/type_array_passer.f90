module type_array_passer

    use, intrinsic :: iso_fortran_env, only: &
        wp => REAL64, &
        ip => INT32

    ! Explicit typing only
    implicit none

    ! Everything is private unless stated otherwise
    private
    public :: ArrayPasser


    ! Declare derived array type
    type, public :: ArrayPasser
        !----------------------------------------------------------------------
        ! Dictionary: calling arguments
        !----------------------------------------------------------------------
        logical, private                            :: usable = .false.
        procedure (func_interface), nopass, pointer :: f => null()
        !----------------------------------------------------------------------
    contains
        !----------------------------------------------------------------------
        ! Dictionary: calling arguments
        !----------------------------------------------------------------------
        procedure, public :: assumed_shape_array_contiguous
        procedure, public :: assumed_shape_array
        procedure, public :: explicit_shape_array
        procedure, public :: local_automatic_array
        procedure, public :: local_allocatable_array
        procedure, public :: local_pointer_array
        final             :: destructor
        !----------------------------------------------------------------------
    end type


    ! Declare interface for procedure pointer
    interface
        function func_interface(array) result (return_value)
            import :: wp
            !------------------------------------------------------------------
            ! Dictionary: calling arguments
            !------------------------------------------------------------------
            real (wp), intent (in) :: array(:)
            real (wp)              :: return_value
            !------------------------------------------------------------------
        end function func_interface
    end interface


    ! Declare user-defined constructor
    interface ArrayPasser
        module procedure constructor
    end interface


contains


    function constructor(f) result (return_value)
        !--------------------------------------------------------------------------------
        ! Dictionary: calling arguments
        !--------------------------------------------------------------------------------
        procedure (func_interface) :: f
        type (ArrayPasser)         :: return_value
        !--------------------------------------------------------------------------------

        return_value%f => f

        return_value%usable = .true.

    end function constructor



    subroutine destructor(this)
        !--------------------------------------------------------------------------------
        ! Dictionary: calling arguments
        !--------------------------------------------------------------------------------
        type (ArrayPasser), intent (in out) :: this
        !--------------------------------------------------------------------------------

        if (associated(this%f)) then
            nullify (this%f)
        end if

        this%usable = .false.

    end subroutine destructor



    subroutine assumed_shape_array_contiguous(this, array, output)
        !----------------------------------------------------------------------
        ! Dictionary: calling arguments
        !----------------------------------------------------------------------
        class (ArrayPasser),   intent (in out) :: this
        real (wp), contiguous, intent (in out) :: array(:)
        real (wp),             intent (out)    :: output
        !----------------------------------------------------------------------
        ! Dictionary: local variables
        !----------------------------------------------------------------------
        integer (ip) :: i !! Counter
        !----------------------------------------------------------------------

        ! Check if object is usable
        if (this%usable .eqv. .false.) then
            error stop 'Uninitialized object of class (ArrayPasser)'
        end if


        ! Generate some data
        associate( n => size(array) )
            do i = 1, n
                array(i) = real(i, kind=wp)
            end do
        end associate

        ! Compute output
        output = this%f(array)

    end subroutine assumed_shape_array_contiguous



    subroutine assumed_shape_array(this, array, output)
        !----------------------------------------------------------------------
        ! Dictionary: calling arguments
        !----------------------------------------------------------------------
        class (ArrayPasser), intent (in out) :: this
        real (wp),           intent (in out) :: array(:)
        real (wp),           intent (out)    :: output
        !----------------------------------------------------------------------
        ! Dictionary: local variables
        !----------------------------------------------------------------------
        integer (ip) :: i !! Counter
        !----------------------------------------------------------------------

        ! Check if object is usable
        if (this%usable .eqv. .false.) then
            error stop 'Uninitialized object of class (ArrayPasser)'
        end if

        ! Generate some data
        associate( n => size(array) )
            do i = 1, n
                array(i) = real(i, kind=wp)
            end do
        end associate

        ! Compute output
        output = this%f(array)

    end subroutine assumed_shape_array



    subroutine explicit_shape_array(this, n, array, output)
        !----------------------------------------------------------------------
        ! Dictionary: calling arguments
        !----------------------------------------------------------------------
        class (ArrayPasser), intent (in out) :: this
        integer (ip),        intent (in)     :: n
        real (wp),           intent (in out) :: array(n)
        real (wp),           intent (out)    :: output
        !----------------------------------------------------------------------
        ! Dictionary: local variables
        !----------------------------------------------------------------------
        integer (ip) :: i !! Counter
        !----------------------------------------------------------------------

        ! Check if object is usable
        if (this%usable .eqv. .false.) then
            error stop 'Uninitialized object of class (ArrayPasser)'
        end if

        ! Generate some data
        do i = 1, n
            array(i) = real(i, kind=wp)
        end do

        ! Compute output
        output = this%f(array)

    end subroutine explicit_shape_array



    subroutine local_automatic_array(this, n, output)
        !----------------------------------------------------------------------
        ! Dictionary: calling arguments
        !----------------------------------------------------------------------
        class (ArrayPasser), intent (in out) :: this
        integer (ip),        intent (in)     :: n
        real (wp),           intent (out)    :: output
        !----------------------------------------------------------------------
        ! Dictionary: local variables
        !----------------------------------------------------------------------
        real (wp)     :: array(n) !! Automatic array
        integer (ip)  :: i !! Counter
        !----------------------------------------------------------------------

        ! Check if object is usable
        if (this%usable .eqv. .false.) then
            error stop 'Uninitialized object of class (ArrayPasser)'
        end if

        ! Generate some data
        do i = 1, n
            array(i) = real(i, kind=wp)
        end do

        ! Compute output
        output = this%f(array)

    end subroutine local_automatic_array



    subroutine local_allocatable_array(this, n, output)
        !----------------------------------------------------------------------
        ! Dictionary: calling arguments
        !----------------------------------------------------------------------
        class (ArrayPasser), intent (in out) :: this
        integer (ip),        intent (in)     :: n
        real (wp),           intent (out)    :: output
        !----------------------------------------------------------------------
        ! Dictionary: local variables
        !----------------------------------------------------------------------
        real (wp), allocatable :: array(:) !! Allocatable array
        integer (ip)           :: i !! Counter
        !----------------------------------------------------------------------

        ! Check if object is usable
        if (this%usable .eqv. .false.) then
            error stop 'Uninitialized object of class (ArrayPasser)'
        end if

        !
        !==> Allocate memory
        !
        allocate( array(n) )

        ! Generate some data
        do i = 1, n
            array(i) = real(i, kind=wp)
        end do

        ! Compute output
        output = this%f(array)

        !
        !==> Release memory
        !
        deallocate( array )

    end subroutine local_allocatable_array



    subroutine local_pointer_array(this, n, output)
        !----------------------------------------------------------------------
        ! Dictionary: calling arguments
        !----------------------------------------------------------------------
        class (ArrayPasser), intent (in out) :: this
        integer (ip),        intent (in)     :: n
        real (wp),           intent (out)    :: output
        !----------------------------------------------------------------------
        ! Dictionary: local variables
        !----------------------------------------------------------------------
        real (wp), pointer :: array(:) => null() !! Pointer array
        integer (ip)       :: i !! Counter
        !----------------------------------------------------------------------

        ! Check if object is usable
        if (this%usable .eqv. .false.) then
            error stop 'Uninitialized object of class (ArrayPasser)'
        end if

        !
        !==> Assign pointer
        !
        allocate( array(n) )

        ! Generate some data
        do i = 1, n
            array(i) = real(i, kind=wp)
        end do

        ! Compute output
        output = this%f(array)

        !
        !==> Nullify pointer
        !
        deallocate( array )

    end subroutine local_pointer_array



end module type_array_passer
