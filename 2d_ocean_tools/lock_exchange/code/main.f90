!==================================
! Exercise 4: Density-driven flows
!==================================
! Author: J. Kaempf, August 2009 

PROGRAM slice

USE param
USE sub

! local parameters
INTEGER :: n, ntot, nout
REAL :: wl, ps
integer :: nt
character*20 :: str,str1

!**********
CALL INIT  ! initialisation
!**********

! runtime parameters
ntot = INT(3000./dt)
time = 0.0

! output frequency
nout = INT(30./dt)

! open files for output
OPEN(10,file ='q.dat',form='formatted')
OPEN(20,file ='u.dat',form='formatted')
OPEN(30,file ='w.dat',form='formatted')
OPEN(40,file ='eta.dat',form='formatted')
OPEN(50,file ='rho.dat',form='formatted')


! prescribe plume layer with increased density
!DO i = 0,nz+1
!DO k = 0,20
! rho(i,k) = RHOREF+0.5
!END DO
!END DO
DO i = 0,nz+1
DO k = nx/2,nx+1
 rho(i,k) = RHOREF+0.5
 !rho(i,k) = RHOREF+1.5
END DO
END DO

!---------------------------
! simulation loop
!---------------------------
DO n = 1,ntot

time = time + dt
write(6,*)"time (hours)", time/(3600.)

! prognostic equations
CALL dyn

! data output
IF(MOD(n,nout)==0)THEN
!  DO i = 1,nz
!    WRITE(10,'(101F12.6)')(q(i,k)/(RHOREF*G),k=1,nx)
!    WRITE(20,'(101F12.6)')(u(i,k),k=1,nx)
!    WRITE(30,'(101F12.6)')(w(i,k),k=1,nx)
    !WRITE(50,'(101F12.6)')(rho(i,k)-RHOREF,k=1,nx)
!  END DO
!  WRITE(40,'(101F12.6)')(q(0,k)/(RHOREF*G),k=1,nx)
  WRITE(6,*)"Data output at time = ",time/(24.*3600.)

ENDIF

if(mod(n,nout) ==0) then
if (n <100) write(str1,'(I2.2)') n
if (n>=100 .and. n <1000) write(str1,'(I3.3)') n
if (n >= 1000 .and. n<10000)  write(str1,'(I4.4)') n
if (n >= 10000)  write(str1,'(I5.5)') n

str = 'den'//trim(str1)//'.dat'
open(unit=33,file=str,status='replace')
 do i = 1,nz
  do k = 1,nx
     write(33,'(1F12.6)') rho(i,k)- RHOREF
  enddo
 enddo
close(33)
endif



END DO ! end of iteration loop

END PROGRAM slice
