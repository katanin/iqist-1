!!!-----------------------------------------------------------------------
!!! project : CSSL (Common Service Subroutines Library)
!!! program : s_linspace_d
!!!           s_logspace_d
!!!           s_linspace_z
!!!           s_legendre
!!!           s_chebyshev
!!! source  : s_math.f90
!!! type    : subroutines
!!! author  : li huang (email:huangli712@gmail.com)
!!! history : 07/10/2014 by li huang
!!!           07/24/2014 by li huang
!!! purpose : these subroutines are used to manipulate grid and mesh, to
!!!           generate Legendre polynomial and Chebyshev polynomial, etc.
!!! status  : unstable
!!! comment :
!!!-----------------------------------------------------------------------

!!>>> s_linspace_d: create a linear mesh x in interval [xmin, xmax], real(dp) version
  subroutine s_linspace_d(xmin, xmax, n, x)
     use constants, only : dp

     implicit none

! external arguments
! left boundary
     real(dp), intent(in)  :: xmin

! right boundary
     real(dp), intent(in)  :: xmax

! size of array x
     integer,  intent(in)  :: n

! output array, containing the linear mesh
     real(dp), intent(out) :: x(n)

! local variables
! loop index
     integer :: i

     do i=1,n
         x(i) = ( xmax - xmin ) * real(i - 1, dp) / real(n - 1, dp) + xmin
     enddo ! over i={1,n} loop

     return
  end subroutine s_linspace_d

!!>>> s_logspace_d: create a log mesh x in interval [xmin, xmax], real(dp) version
  subroutine s_logspace_d(xmin, xmax, n, x)
     use constants, only : dp

     implicit none

! external arguments
! left boundary
     real(dp), intent(in)  :: xmin

! right boundary
     real(dp), intent(in)  :: xmax

! size of array x
     integer,  intent(in)  :: n

! output array, containing the linear mesh
     real(dp), intent(out) :: x(n)

! we can use the s_linspace_d() subroutine
     call s_linspace_d(log10(xmin), log10(xmax), n, x)
     x = 10.0_dp**x

     return
  end subroutine s_logspace_d

!!>>> s_linspace_z: create a linear mesh x in interval [xmin, xmax], complex(dp) version
  subroutine s_linspace_z(xmin, xmax, n, x)
     use constants, only : dp

     implicit none

! external arguments
! left boundary
     complex(dp), intent(in)  :: xmin

! right boundary
     complex(dp), intent(in)  :: xmax

! size of array x
     integer,  intent(in)     :: n

! output array, containing the linear mesh
     complex(dp), intent(out) :: x(n)

! local variables
! loop index
     integer :: i

     do i=1,n
         x(i) = ( xmax - xmin ) * real(i - 1, dp) / real(n - 1, dp) + xmin
     enddo ! over i={1,n} loop

     return
  end subroutine s_linspace_z

!!>>> s_legendre: build legendre polynomial in [-1,1]
  subroutine s_legendre(lemax, legrd, pmesh, ppleg)
     use constants, only : dp, one

     implicit none

! external arguments
! maximum order for legendre polynomial
     integer, intent(in)   :: lemax

! number of mesh points for legendre polynomial
     integer, intent(in)   :: legrd

! mesh for legendre polynomial in [-1,1]
     real(dp), intent(in)  :: pmesh(legrd)

! legendre polynomial defined on [-1,1]
     real(dp), intent(out) :: ppleg(legrd,lemax)

! local variables
! loop index
     integer :: i
     integer :: j
     integer :: k

! check lemax
     if ( lemax <= 2 ) then
         call s_print_error('s_legendre','lemax must be larger than 2')
     endif ! back if ( lemax <= 2 ) block

! the legendre polynomials obey the three term recurrence relation known
! as Bonnet’s recursion formula:
!     $P_0(x) = 1$
!     P_1(x) = x$
!     $(n+1) P_{n+1}(x) = (2n+1) x P_n(x) - n P_{n-1}(x)$
     do i=1,legrd
         ppleg(i,1) = one
         ppleg(i,2) = pmesh(i)
         do j=3,lemax
             k = j - 1
             ppleg(i,j) = ( real(2*k-1) * pmesh(i) * ppleg(i,j-1) - real(k-1) * ppleg(i,j-2) ) / real(k)
         enddo ! over j={3,lemax} loop
     enddo ! over i={1,legrd} loop

     return
  end subroutine s_legendre

!!>>> s_chebyshev: build chebyshev polynomial in [-1,1]
!!>>> note: it is second kind chebyshev polynomial
  subroutine s_chebyshev(chmax, chgrd, qmesh, qqche)
     use constants, only : dp, one, two

     implicit none

! external arguments
! maximum order for chebyshev polynomial
     integer, intent(in)   :: chmax

! number of mesh points for chebyshev polynomial
     integer, intent(in)   :: chgrd

! mesh for chebyshev polynomial in [-1,1]
     real(dp), intent(in)  :: qmesh(chgrd)

! chebyshev polynomial defined on [-1,1]
     real(dp), intent(out) :: qqche(chgrd, chmax)

! local variables
! loop index
     integer :: i
     integer :: j

! check chmax
     if ( chmax <= 2 ) then
         call s_print_error('s_chebyshev','chmax must be larger than 2')
     endif ! back if ( chmax <= 2 ) block

! the chebyshev polynomials of the second kind can be defined by the
! following recurrence relation
!     $U_0(x) = 1$
!     $U_1(x) = 2x$
!     $U_{n+1}(x) = 2xU_n(x) - U_{n-1}(x)$
     do i=1,chgrd
         qqche(i,1) = one
         qqche(i,2) = two * qmesh(i)
         do j=3,chmax
             qqche(i,j) = two * qmesh(i) * qqche(i,j-1) - qqche(i,j-2)
         enddo ! over j={3,chmax} loop
     enddo ! over i={1,chgrd} loop

     return
  end subroutine s_chebyshev
