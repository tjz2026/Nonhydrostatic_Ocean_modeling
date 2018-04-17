module sub
use param

contains

!******************
subroutine init()
!local parameters
real :: ccc, cmc

! set all arrays to zero
dp = 0.0 
u = 0.0 ; un = 0.0
w = 0.0; wn = 0.0 
q = 0.0

! grid parameters
dx = 5.0; dz = 2.0; dt = 0.05
! coefficients for sor
omega = 1.4
peps = 1.e-2

ct = dx/dz
cb = dx/dz
ce = dz/dx
cw = dz/dx
cw(:,1) = 0.0
ce(:,nx) = 0.0
cb(nz,:) = 0.0
ctot = cb + ct + ce + cw

end subroutine init

!*******************
subroutine dyn()
! local parameters and arrays
real :: ustar(0:nz+1,0:nx+1), wstar(0:nz+1,0:nx+1)
real :: pressx, drdxh, pressz, drdzh
real :: dpstore(nx+1), perr, p1, p2, term1
integer :: nsor, nstop

drdxh = 0.5/(rho*dx)
drdzh = 0.5/(rho*dz)

! sea-level forcing
dp(0,2) = ad*rho*g

! step 1: store surface pressure field
do k = 0,nx+1
 dpstore(k) = dp(0,k)
end do

! step 2: calculate ustar and vstar 
do i = 1,nz
do k = 1,nx
  pressx = -drdxh*(dp(i,k+1)-dp(i,k))
  ustar(i,k) = u(i,k) + dt*pressx
  pressz = -drdzh*(dp(i-1,k)-dp(i,k))
  wstar(i,k) = w(i,k) + dt*pressz
end do
end do

! lateral boundary conditions
do i = 1,nz
 ustar(i,nx) = 0.0
 ustar(i,nx+1) = ustar(i,nx)
 ustar(i,0) = 0.0 
end do

! bottom boundary condition
do k = 1,nx
 wstar(nz+1,k) = 0.0
end do

! step 3: calculate right-hand side of poisson equation
do i = 1,nz
do k = 1,nx
 pstar(i,k) = -2.0*rho/dt*(  &
 &  (ustar(i,k)-u(i,k)-ustar(i,k-1)+u(i,k-1))*dz + &
 &  (wstar(i,k)-w(i,k)-wstar(i+1,k)+w(i+1,k))*dx )
end do
end do

! step 4: s.o.r. iteration

nstop = 5000

!*****************
do nsor = 1,500000
!*****************

perr = 0.0

! step 4.1: predict new pressure
do i = 1,nz
do k = 1,nx
 p1 = dp(i,k)
 term1 = pstar(i,k) + & 
  &      ct(i,k)*dp(i-1,k) + cb(i,k)*dp(i+1,k) + & 
  &      cw(i,k)*dp(i,k-1) + ce(i,k)*dp(i,k+1)  
 p2 = (1.0-omega)*p1 + omega*term1/ctot(i,k) 
 dp(i,k) = p2
 perr = max(abs(p2-p1),perr)
end do
end do

do i = 1,nz
  dp(i,0) = dp(i,1)
  dp(i,nx+1) = dp(i,nx)
end do

! step 4.2: predict new velocities 
do i = 1,nz
do k = 1,nx
  pressx = -drdxh*(dp(i,k+1)-dp(i,k))
  un(i,k) = ustar(i,k) + dt*pressx
  pressz = -drdzh*(dp(i-1,k)-dp(i,k))
  wn(i,k) = wstar(i,k) + dt*pressz
end do
end do

do i = 1,nz
 un(i,nx) = 0.0
 un(i,nx+1) = un(i,nx)
 un(i,0) = 0.0 
end do

! step 4.3: predict depth-integrated flow
do k = 1,nx
  q(k) = dz*sum(un(1:nz,k))
end do

! lateral boundary conditions
q(0) = 0.0
q(nx) = 0.0
q(nx+1) = q(nx)

! step 4.4: predict surface pressure field
do k = 1,nx
 dp(0,k) = dpstore(k)-dt*rho*g*(q(k)-q(k-1))/dx
end do

if(perr <= peps)then
 exit
end if

!********************
end do
!********************
write(*,*) "no. of interactions =>", nsor

! updating for next time step
do i = 1,nz
do k = 1,nx
  u(i,k) = un(i,k)
  w(i,k) = wn(i,k)
end do
end do

! lateral boundary conditions
do i = 1,nz
 u(i,0) = 0.0
 u(i,nx) = 0.0
 u(i,nx+1) = 0.0
end do

! vertical boundary conditions
do k = 1,nx
 w(nz+1,k) = 0.0
end do

return
end subroutine dyn

end module sub
