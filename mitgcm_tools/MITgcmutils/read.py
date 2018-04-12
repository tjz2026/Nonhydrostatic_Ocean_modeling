import sys
import numpy as np
import matplotlib.pyplot as plt
import matplotlib.animation as animation
from mpl_toolkits.mplot3d import Axes3D
from matplotlib import cm
from MITgcmutils import mds

fig = plt.figure()

T = mds.rdmds('./res/T',itrs=np.NaN)
nt,nx,ny,nz = np.shape(T)
print "nt,nx,ny,nz",nt,nx,ny,nz
TT = np.reshape(T,[nt,nx,nz])
TT[TT**2<1.0e-10]=np.NaN
i = 200
#im = plt.imshow(f(i), cmap="bwr",animated=True)
im = plt.imshow(TT[i,:,:], cmap="jet",interpolation='bilinear',animated=True)
#im = plt.imshow(TT[i,:,:],animated=True)
#im = plt.imshow(f(i), cmap="jet",animated=True)
#im = plt.imshow(f(i), animated=True)

#ax = Axes3D(fig)
#Z = np.arange(nz)
#X = np.arange(nx)
#Z, X = np.meshgrid(Z, X)
#print "shape of X",np.shape(X)
#print "shape of Z",np.shape(Z)
#surf = ax.plot_surface(X, Z, TT[200,:,:], rstride=1, cstride=1, cmap=cm.coolwarm)
#
#plt.show()









def updatefig(*args):
    global i
    i += 1
    if i >nt:
        sys.exit(0)
    #im.set_array(f(i))
    im.set_array(TT[i,:,:])
    plt.title('time:'+ np.str(round(i*1.0/60.0,2)) + ' min' )
    plt.clim(-0.03,0.01)
    return im,

ani = animation.FuncAnimation(fig, updatefig, interval=20, blit=True)
plt.colorbar()
plt.show()
