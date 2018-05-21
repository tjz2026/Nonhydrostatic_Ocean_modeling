!=========================================
! exercise 3: short surface gravity waves
!=========================================
! author: j. kaempf, august 2009 

program slice

use param
use sub

! local parameters
integer :: n, ntot, nout
real :: wl, ps
character*20 :: str,str1

period = 8.0 ! forcing period in seconds
amplitude = 0.5 ! forcing amplitude

wl = g*period*period/(2.*pi)
write(6,*)"deep-water wavelength (m) is ",wl
ps = wl/period
write(6,*)"deep-water phase speed (m/s) is ",ps


!**********
call init  ! initialisation
!**********

! runtime parameters
ntot = int(100./dt)
time = 0.0

! output parameter
nout = int(1./dt)

! open files for data output
!open(10,file ='dp.dat',form='formatted',status = 'replace')
!open(20,file ='u.dat',form='formatted',status='replace')
!open(30,file ='w.dat',form='formatted',status='replace')
!open(40,file ='eta.dat',form='formatted',status='replace')

!---------------------------
! simulation loop
!---------------------------
do n = 1,ntot

time = time + dt
write(6,*)"time (seconds)", time

! variation of forcing
ad = amplitude*sin(2.*pi*time/period)

! prognostic equations
call dyn()

! data output
!if(mod(n,nout)==0)then
!  do k = 1,nz
!    do i = 1,nz
!    write(10,'(101f12.6)') dp(i,k)/(rho*g)
!    write(20,'(101f12.6)') u(i,k)
!    write(30,'(101f12.6)') w(i,k)
!  end do
!  enddo
!  close(10)
!  close(20)
!  close(30)
!  do k = 1,nx
!  write(40,'(101f12.6)') dp(0,k)/(rho*g)
!  enddo
!  close(40)
!  write(6,*)"data output at time(s) = ",time
!endif

if(mod(n,nout) ==0) then
if (n <100) write(str1,'(I2.2)') n
if (n>=100 .and. n <1000) write(str1,'(I3.3)') n
if (n >= 1000 .and. n<10000)  write(str1,'(I4.4)') n
if (n >= 10000)  write(str1,'(I5.5)') n

str = 'eta'//trim(str1)//'.dat'
open(unit=33,file=str,status='replace')
  do k = 1,nx
     write(33,'(1F12.6)') dp(0,k)/(rho*g)
  enddo
close(33)
  write(6,*)"data output at time(s) = ",time
endif




end do ! end of iteration loop

end program slice
