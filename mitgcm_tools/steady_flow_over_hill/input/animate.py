from MITgcmutils import rdmds
from MyMITgcmUtils import get_grid
from matplotlib.animation import FuncAnimation
import numpy.ma as ma

run_dir = '/home/hugke729/mitgcm/dirstu17/proj1/runs/RunFr3900/'
g = get_grid(run_dir)
T = rdmds(run_dir + 'T*', itrs=np.nan).squeeze()
U = rdmds(run_dir + 'U*', itrs=np.nan).squeeze()
hfacW = rdmds(run_dir + 'hFacW').squeeze()
hfacC = rdmds(run_dir + 'hFacC').squeeze()

U = ma.masked_where(hfacW*np.ones((U.shape[0], 1, 1)) == 0, U)
T = ma.masked_where(hfacC*np.ones((T.shape[0], 1, 1)) == 0, T)

fig, ax = plt.subplots()
ax.set(facecolor='Grey')

# cax = ax.pcolormesh(g.xf, g.zf, T[0, :, :],
#                     vmin=0, vmax=26, cmap='RdBu')
cax = ax.pcolormesh(g.xf, g.zf, U[1, :, :],
                    vmin=0, vmax=1, cmap='YlOrRd')

ax.set(xlim=(1.8E5, 2.3E5), ylim=(2000, 0))
# ax.set(ylim=(2000, 0))

fig.colorbar(cax)


def animate(i):
    # cax.set_array((T[i, ...] - T[0, ...]).flatten())
    # cax.set_array((T[i, ...]).flatten())
    cax.set_array(U[i, ...].flatten())


anim = FuncAnimation(fig, animate, frames=T.shape[0])
