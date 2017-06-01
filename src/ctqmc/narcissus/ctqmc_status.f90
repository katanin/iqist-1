!!!-----------------------------------------------------------------------
!!! project : narcissus
!!! program : ctqmc_save_status
!!!           ctqmc_retrieve_status
!!! source  : ctqmc_status.f90
!!! type    : subroutines
!!! author  : li huang (email:lihuang.dmft@gmail.com)
!!! history : 09/23/2009 by li huang (created)
!!!           06/01/2017 by li huang (last modified)
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

     use version, only : MAIL_VER

     use control, only : cname
     use control, only : norbs

     use context, only : index_s, index_e
     use context, only : time_s, time_e
     use context, only : rank, stts

     implicit none

! local variables
! loop index over orbitals
     integer :: i

! loop index over operators
     integer :: j

! string for current date and time
     character (len = 20) :: date_time_string

! obtain current date and time
     call s_time_builder(date_time_string)

! open status file: solver.status.dat
     open(mytmp, file='solver.status.dat', form='formatted', status='unknown')

! write the header message
     write(mytmp,'(a)') '>> WARNING: DO NOT MODIFY THIS FILE MANUALLY'
     write(mytmp,'(a)') '>> it is used to store current status of ctqmc quantum impurity solver'
     write(mytmp,'(a)') '>> generated by '//cname//' code at '//date_time_string
     write(mytmp,'(a)') '>> any problem, please contact me: '//MAIL_VER

! dump the diagrammatic configurations
     FLVR_CYCLE: do i=1,norbs
         write(mytmp,'(a9,i4)') '# flavor:', i
         write(mytmp,'(a9,i4)') '# status:', stts(i)

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

! close the file handler
     close(mytmp)

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
     use constants, only : zero
     use constants, only : mytmp

     use mmpi, only : mp_bcast
     use mmpi, only : mp_barrier

     use control, only : norbs
     use control, only : mkink
     use control, only : beta
     use control, only : myid, master

     use context, only : ckink, cstat
     use context, only : rank, stts

     implicit none

! local variables
! loop index
     integer  :: i
     integer  :: j

! dummy integer variables
     integer  :: m
     integer  :: n

! used to check whether the input file (solver.status.dat) exists
     logical  :: exists

! dummy character variables
     character (len = 9) :: chr

! determinant ratio for insert operators
     real(dp) :: deter_ratio

! dummy variables, used to store imaginary time points
     real(dp) :: tau_s(mkink,norbs)
     real(dp) :: tau_e(mkink,norbs)

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
             read(mytmp,'(a9,i4)') chr, cstat

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

             stts(i) = cstat
             rank(i) = ckink
         enddo FLVR_CYCLE ! over i={1,norbs} loop

! close the status file
         close(mytmp)

     endif ! back if ( myid == master ) block

! broadcast rank, stts, tau_s, and tau_e from master node to all children nodes
# if defined (MPI)

! broadcast data
     call mp_bcast( rank,  master )
     call mp_bcast( stts,  master )

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

! restore all the operators
     do i=1,norbs
         if ( stts(i) == 1 ) then ! segment scheme
             do j=1,rank(i)
                 ckink = j - 1 ! update ckink simultaneously
                 call cat_insert_detrat(i, tau_s(j, i), tau_e(j, i), deter_ratio)
                 call cat_insert_matrix(i, j, j, tau_s(j, i), tau_e(j, i), deter_ratio)
             enddo ! over j={1,rank(i)} loop
         endif ! back if ( stts(i) == 1 ) block

         if ( stts(i) == 2 ) then ! anti-segment scheme
             do j=1,rank(i)-1
                 ckink = j - 1 ! update ckink simultaneously
                 call cat_insert_detrat(i, tau_s(j, i), tau_e(j+1, i), deter_ratio)
                 call cat_insert_matrix(i, j, j, tau_s(j, i), tau_e(j+1, i), deter_ratio)
             enddo ! over j={1,rank(i)-1} loop
             ckink = rank(i) - 1
             call cat_insert_detrat(i, tau_s(ckink+1, i), tau_e(1, i), deter_ratio)
             call cat_insert_matrix(i, ckink+1, 1, tau_s(ckink+1, i), tau_e(1, i), deter_ratio)
         endif ! back if ( stts(i) == 2 ) block
     enddo ! over i={1,norbs} loop

     return
  end subroutine ctqmc_retrieve_status
