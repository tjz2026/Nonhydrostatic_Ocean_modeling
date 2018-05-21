problem='lock_exchange_flow';
%***Numerical parmeters *******************************************
dte=0.0003;  %external time step(s)
isplit=5;
tend=100;%Time of end of calculations (s)
swtch=1000.0;      % Time to switch from prtd1 to prtd2
%******************************************************************

%*** Calculation Grid **********************************************
im=20; jm=5; kb=8;
imm1=im-1; jmm1=jm-1; kbm1=kb-1;
imm2=im-2; jmm2=jm-2; kbm2=kb-2;
alonmn=0.; alonmx=0.8;
alatmn=0.; alatmx=0.15;
depth_bath=0.1;
%*******************************************************************
z0b=0.0008; % roughness parameter (in m)
cbcmin=0.00025;% min. drag coef. bottom log layer
cbcmax=1.000;%max. drag coef
pi=3.1416;
small=1.e-10;
time0=0.0;
days=1.0;       % run duration in days
beta=1.98e-11;
prtd1=2;
ispadv=5;
smoth=0.10;
tprni=1.;
grav=9.8;
umol=1.e-6;
mode=3;
isk=2;
jsk=2;
hvis=0.04;
alpha=0.225;
corfac=0.25;
vmaxl=1000;
horcon=0.01;

tbias=0.0;         % Temperature bias (deg. C)
sbias=0.0;         % Salinity bias

%     Advection scheme:
%      nadv     Advection scheme
%        1       Centred scheme, as originally provide in POM
%        2       Smolarkiewicz iterative upstream scheme, based on
%                subroutines provided by Gianmaria Sannino and Vincenzo
%                Artale
nadv=2;
%     Constants for Smolarkiewicz iterative upstream scheme.
%
%     Number of iterations. This should be in the range 1 - 4. 1 is
%     standard upstream differencing; 3 adds 50% CPU time to POM:
nitera=2;
%     Smoothing parameter. This should preferably be 1, but 0 < sw < 1
%     gives smoother solutions with less overshoot when nitera > 1:
sw=0.50;
%     Surface temperature boundary condition, used in subroutine proft:
%       nbct   prescribed    prescribed   short wave
%              temperature      flux      penetration
%        1        no           yes           no
%        2        no           yes           yes
%        3        yes          no            no
%        4        yes          no            yes
%
nbct=1;

%     Surface salinity boundary condition, used in subroutine proft:
%       nbcs   prescribed    prescribed
%               salinity      flux
%        1        no           yes
%        3        yes          no
%     NOTE that only 1 and 3 are allowed for salinity.
nbcs=1;
%     Water type, used in subroutine proft.
%       ntp    Jerlov water type
%        1            i
%        2            ia
%        3            ib
%        4            ii
%        5            iii
ntp=2;

%     Reference density (recommended values: 1025 for seawater,
%     1000 for freswater; S.I. units):
rhoref=1025.0;
aam_init=2.e-6;
kappa=0.40;        % von Karman's constant
%     Logical for inertial ramp (true if inertial ramp to be applied
%     to wind stress and baroclinic forcing, otherwise false)
lramp=false;
% ramp is not assigned in fortran pom2k before used in barop
ramp=0.0;
turbmode=0;