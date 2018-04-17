"""
A simple example of an animated plot
"""
import numpy as np
import matplotlib.pyplot as plt
import matplotlib.animation as animation
import scipy as sy

fig, ax = plt.subplots()
plt.ylim(-1.0,1.0)
plt.xlabel('x')
plt.ylabel('Surface elevation:eta')
plt.axis([0,101,-1.0,1.0])

def f(i):
    str = 'eta' + np.str(i) + '.dat'
    eta = np.loadtxt(str)
    return eta

def animate(i):
    line.set_ydata(f(i))  # update the data
    return line,

x = np.arange(101)
line, = ax.plot(x, f(20)*0.0)


# Init only required for blitting to give a clean slate.
def init():
    line.set_ydata(np.ma.array(x, mask=True))
    return line,

#ani = animation.FuncAnimation(fig, animate, np.arange(21, 1800,20), init_func=init,
#                              interval=100, blit=True)
ani = animation.FuncAnimation(fig, animate, np.arange(20, 1800,20),
                              interval=100, blit=True)
plt.show()
