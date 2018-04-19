import numpy as np
import matplotlib.pyplot as plt
from shutil import copy
from os import mkdir
import os
import shutil
from MyMITgcmUtils import write_for_mitgcm


def lininc(n, Dx, dx0):
    """Linear increasing vector"""
    a = (Dx - n*dx0)*2./n/(n + 1)
    dx = dx0 + np.arange(1., n+1., 1.)*a
    return dx


# -------------------------------------------------------------------------
# Flow parameters
Fr = 0.13/6
# Fr = 0.39
H = 2000.
h0 = 500.
om = 2.*np.pi/12.42/3600.
N0 = 5.2e-3
u0 = Fr*N0*h0

# -------------------------------------------------------------------------
# Grid parameters

# Number of cells
# These must match ../code/SIZE.h
ny = 1
nx = 2*200
nz = 100

# Resolution
dx0 = 100.  # Minimum dx
dy = 1000  # Arbitrary, since only 2D simulation
dz = H*np.ones(nz)/nz

# Domain size
xt = 410e3
xt_left, xt_right = 200e3, 200e3

# Number of elements in which dx (i) is constant (ii) increases to the left
# and (iii) increases to the right
nmid = 100
nleft = (nx-nmid)/2
nright = (nx-nmid)/2

# Calculate dx vector
dx_left = lininc(nleft, xt_left, dx0)[::-1]
dx_right = lininc(nleft, xt_right, dx0)
dx = np.r_[dx_left, dx0*np.ones(nmid), dx_right]

# Finally, calculate x and z
x = np.cumsum(dx)
x = x - x[nx//2]
z = np.cumsum(dz)

# ------------------------------------------------------------------------
# Other model inputs

# Seafloor
sigma = 4000.  # m

# Gaussian bump
topo = 1500*np.exp(-x*x/(sigma**2))-1500+h0
topo[topo < 0.] = 0.
topo = -H+topo
topo[topo < -H] = -H

# Temperature and density
g = 9.8
alpha = 2e-4
Tref = 28 + np.cumsum(N0**2/g/alpha*(-dz))

# save T0 over whole domain
T0 = Tref*np.ones((nx, ny, nz))
# -------------------------------------------------------------------------
# Create necessary directories
outdir = '../runs/RunFr%03d' % (10000*Fr)

try:
    mkdir(outdir)
except:
    print(outdir + ' Exists')
try:
    mkdir(outdir + '/figs')
except:
    print(outdir + '/figs Exists')

copy('./gendata.py',outdir)

# -------------------------------------------------------------------------
# Plot inputs
fig, ax = plt.subplots()
ax.plot(x/1000., dx)
ax.set(xlabel='x (km)', ylabel='dx (m)')
fig.savefig(outdir + '/figs/dx.pdf')

fig2, ax2 = plt.subplots()
ax2.plot(x/1.e3, topo)
ax2.set(xlabel='x (km)', ylabel='Depth (m)')
fig2.savefig(outdir + '/figs/topo.pdf')

fig3, ax3 = plt.subplots()
ax3.plot(Tref, z)
ax3.set(xlim=(0, 28), ylim=(2000, 0), xlabel='Temp (°C)', ylabel='Depth (m)')
fig3.savefig(outdir + '/figs/Tref.pdf')

# -------------------------------------------------------------------------
# Forcing for boundaries
ue = u0*np.ones(nz)
uw = u0*np.ones(nz)

# -------------------------------------------------------------------------
# Initial velocity
U0 = ue*np.ones((nx, ny, nz))

# -------------------------------------------------------------------------
# Write output files
write_files = dict(
    T0=T0, delXvar=dx, delZvar=dz, TRef=Tref, Te=Tref, Tw=Tref,
    Ue=ue, Uw=uw, U0=U0, topo=topo)

for k, v in write_files.items():
    write_for_mitgcm(outdir + '/' + k + '.bin', v)

# Copy some other files
copy('data', outdir + '/data')
copy('eedata', outdir)
copy('data.kl10', outdir)
copy('data.mnc', outdir)
copy('data.obcs', outdir)
copy('data.diagnostics', outdir)
copy('data.pkg', outdir + '/data.pkg')
# Also store these.  They are small and helpful to document what we did
for nm in {'input','code','build_options','analysis'}:
    to_path = outdir+'/'+nm
    if os.path.exists(to_path):
        shutil.rmtree(to_path)
