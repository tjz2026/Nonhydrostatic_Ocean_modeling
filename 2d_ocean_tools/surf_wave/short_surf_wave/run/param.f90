module param

integer(4), parameter :: nx = 201 ! horizontal dimension	
integer(4), parameter :: nz = 51 ! vertical dimension
real, parameter :: g = 9.81 ! acceleration due to gravity
real, parameter :: rho = 1028.0 ! reference density
real, parameter :: pi = 3.1416 ! pi

real :: dt, dx, dz
real :: ad
integer :: i,k

real :: dp(0:nz+1,0:nx+1) ! dynamic pressure
real :: u(0:nz+1,0:nx+1), un(0:nz+1,0:nx+1) ! horizontal velocity 
real :: w(0:nz+1,0:nx+1), wn(0:nz+1,0:nx+1) ! vertical velocity 
real :: q(0:nx+1) ! depth-integrated flow

real :: period, amplitude ! forcing parameters

! matrices and parameters for s.o.r iteration
real :: omega 
real :: pstar(nz,nx)
real :: ct(nz,nx), cb(nz,nx) 
real :: ce(nz,nx), cw(nz,nx)
real :: ctot(nz,nx) 
real :: peps ! pressure accuracy

end module param
