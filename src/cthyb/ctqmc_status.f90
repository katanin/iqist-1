!!!-----------------------------------------------------------------------
!!! project : iqist @ manjushaka
!!! program : ctqmc_save_status
!!!           ctqmc_retrieve_status
!!! source  : ctqmc_status.f90
!!! type    : subroutines
!!! author  : li huang (email:huangli@caep.cn)
!!! history : 09/23/2009 by li huang (created)
!!!           06/20/2024 by li huang (last modified)
!!! purpose : save or retrieve the data structures of the perturbation
!!!           expansion series to or from the well-formatted status file
!!!           for hybridization expansion version continuous time quantum
!!!           Monte Carlo (CTQMC) quantum impurity solver, respectively.
!!!           it can be used to save the computational time to reach the
!!!           equilibrium state.
!!! status  : unstable
!!! comment :
!!!-----------------------------------------------------------------------

!!
!! @sub ctqmc_save_status
!!
!! save the current perturbation expansion series information for the
!! continuous time quantum Monte Carlo quantum impurity solver
!!
  subroutine ctqmc_save_status()
     use constants, only : mytmp

     use stack, only : istack_getrest

     use version, only : V_MAIL

     use control, only : cname
     use control, only : norbs

     use context, only : index_s, index_e
     use context, only : time_s, time_e
     use context, only : empty_v
     use context, only : index_v
     use context, only : type_v
     use context, only : flvr_v
     use context, only : time_v
     use context, only : rank

     implicit none

!! local variables
     ! loop index over orbitals
     integer :: i

     ! loop index over operators
     integer :: j

     ! total number of operators
     integer :: nsize

     ! string for current date and time
     character (len = 20) :: date_time_string

!! [body

     ! obtain current date and time
     call s_time_builder(date_time_string)

     ! evaluate nsize at first
     nsize = istack_getrest( empty_v )

     ! open status file: solver.status.dat
     open(mytmp, file='solver.status.dat', form='formatted', status='unknown')

     ! write the header message
     write(mytmp,'(a)') '>> WARNING: DO NOT MODIFY THIS FILE MANUALLY'
     write(mytmp,'(a)') '>> it is used to store current status of ctqmc quantum impurity solver'
     write(mytmp,'(a)') '>> generated by '//cname//' code at '//date_time_string
     write(mytmp,'(a)') '>> any problem, please contact me: '//V_MAIL

     ! dump the diagrammatic configurations
     FLVR_CYCLE: do i=1,norbs
         write(mytmp,'(a9,i4)') '# flavor:', i

         ! write out the creation operators
         write(mytmp,'(a9,i4)') '# time_s:', rank(i)
         do j=1,rank(i)
             write(mytmp,'(2i4,f12.6)') i, j, time_s( index_s(j, i), i )
         enddo ! over j={1,rank(i)} loop

         ! write out the annihilation operators
         write(mytmp,'(a9,i4)') '# time_e:', rank(i)
         do j=1,rank(i)
             write(mytmp,'(2i4,f12.6)') i, j, time_e( index_e(j, i), i )
         enddo ! over j={1,rank(i)} loop

         write(mytmp,*) ! write empty lines
         write(mytmp,*)
     enddo FLVR_CYCLE ! over i={1,norbs} loop

     ! dump the flavor part, not be used at all, just for reference
     write(mytmp,'(a9,i4)') '# time_v:', nsize
     do j=1,nsize
         write(mytmp,'(3X,a,i4)',advance='no') '>>>', j
         write(mytmp,'(3X,a,i4)',advance='no') 'flvr:', flvr_v( index_v(j) )
         write(mytmp,'(3X,a,i4)',advance='no') 'type:', type_v( index_v(j) )
         write(mytmp,'(3X,a,f12.6)')           'time:', time_v( index_v(j) )
     enddo ! over j={1,nsize} loop

     ! close the file handler
     close(mytmp)

!! body]

     return
  end subroutine ctqmc_save_status

!!
!! @sub ctqmc_retrieve_status
!!
!! retrieve the perturbation expansion series information to initialize
!! the continuous time quantum Monte Carlo quantum impurity solver
!!
  subroutine ctqmc_retrieve_status()
     use constants, only : dp
     use constants, only : zero, epss
     use constants, only : mytmp

     use mmpi, only : mp_bcast
     use mmpi, only : mp_barrier

     use control, only : iscut
     use control, only : norbs
     use control, only : mkink
     use control, only : beta
     use control, only : myid, master

     use context, only : ckink, csign, cnegs
     use context, only : n_mtr
     use context, only : rank

     implicit none

!! local variables
     ! loop index
     integer  :: i
     integer  :: j

     ! dummy integer variables
     integer  :: m
     integer  :: n

     ! index address for create and destroy operators in flavor part
     integer  :: fis
     integer  :: fie

     ! whether it is valid to update the configuration
     logical  :: ladd

     ! used to check whether the input file (solver.status.dat) exists
     logical  :: exists

     ! dummy character variables
     character (len = 9) :: chr

     ! determinant ratio for insert operators
     real(dp) :: deter_ratio

     ! dummy variables, used to store imaginary time points
     real(dp) :: tau_s(mkink,norbs)
     real(dp) :: tau_e(mkink,norbs)

!! [body

     ! initialize variables
     exists = .false.

     tau_s = zero
     tau_e = zero

     ! inquire file status: solver.status.dat, only master node can do it
     if ( myid == master ) then
         inquire (file = 'solver.status.dat', exist = exists)
     endif ! back if ( myid == master ) block

! broadcast exists from master node to all children nodes
# if defined (MPI)

     ! broadcast data
     call mp_bcast( exists, master )

     ! block until all processes have reached here
     call mp_barrier()

# endif  /* MPI */

     ! if solver.status.dat does not exist, return parent subroutine immediately
     if ( exists .eqv. .false. ) RETURN

     ! if high energy states are dynamically truncated, the trace of saved
     ! diagramm may be zero, so we don't retrieve it for iscut == 2
     if ( iscut == 2 ) RETURN

     ! read solver.status.dat, only master node can do it
     if ( myid == master ) then

         ! open the status file
         open(mytmp, file='solver.status.dat', form='formatted', status='unknown')

         ! skip comment lines
         read(mytmp,*)
         read(mytmp,*)
         read(mytmp,*)
         read(mytmp,*)

         ! read in key data
         FLVR_CYCLE: do i=1,norbs
             read(mytmp,'(a9,i4)') chr, m

             read(mytmp,'(a9,i4)') chr, ckink
             do j=1,ckink
                 read(mytmp,*) m, n, tau_s(j, i)
             enddo ! over j={1,ckink} loop

             read(mytmp,'(a9,i4)') chr, ckink
             do j=1,ckink
                 read(mytmp,*) m, n, tau_e(j, i)
             enddo ! over j={1,ckink} loop

             read(mytmp,*) ! skip two lines
             read(mytmp,*)

             rank(i) = ckink
         enddo FLVR_CYCLE ! over i={1,norbs} loop

         ! close the status file
         close(mytmp)

     endif ! back if ( myid == master ) block

! broadcast rank, tau_s, and tau_e from master node to all children nodes
# if defined (MPI)

     ! broadcast data
     call mp_bcast( rank,  master )

     ! block until all processes have reached here
     call mp_barrier()

     ! broadcast data
     call mp_bcast( tau_s, master )
     call mp_bcast( tau_e, master )

     ! block until all processes have reached here
     call mp_barrier()

# endif  /* MPI */

     ! check the validity of tau_s
     if ( maxval(tau_s) > beta ) then
         call s_print_error('ctqmc_retrieve_status','the retrieved tau_s data are not correct')
     endif ! back if ( maxval(tau_s) > beta ) block

     ! check the validity of tau_e
     if ( maxval(tau_e) > beta ) then
         call s_print_error('ctqmc_retrieve_status','the retrieved tau_e data are not correct')
     endif ! back if ( maxval(tau_e) > beta ) block

     ! restore all the operators for colour part
     do i=1,norbs
         do j=1,rank(i)
             ckink = j - 1 ! update ckink simultaneously
             call cat_insert_detrat(i, tau_s(j, i), tau_e(j, i), deter_ratio)
             call cat_insert_matrix(i, j, j, tau_s(j, i), tau_e(j, i), deter_ratio)
         enddo ! over j={1,rank(i)} loop
     enddo ! over i={1,norbs} loop

     ! restore all the operators for flavor part
     do i=1,norbs
         do j=1,rank(i)
             call try_insert_flavor(i, fis, fie, tau_s(j, i), tau_e(j, i), ladd)
             call cat_insert_flavor(i, fis, fie, tau_s(j, i), tau_e(j, i))
         enddo ! over j={1,rank(i)} loop
     enddo ! over i={1,norbs} loop

     ! update the matrix trace for product of F matrix and time evolution operators
     i = 2 * sum(rank) ! get total number of operators
     call ctqmc_retrieve_ztrace(i, n_mtr)

     ! update the operators trace
     call ctqmc_make_evolve()

     ! reset csign and cnegs
     csign = 1
     cnegs = 0

     ! finally, it is essential to check the validity of n_mtr
     if ( abs( n_mtr - zero ) < epss ) then
         call s_print_exception('ctqmc_retrieve_status','very dangerous! ztrace maybe too small')
     endif ! back if ( abs( n_mtr - zero ) < epss ) block

!! body]

     return
  end subroutine ctqmc_retrieve_status
