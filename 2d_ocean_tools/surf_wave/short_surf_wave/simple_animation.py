"""
A simple example of an animated plot
"""
import numpy as np
import matplotlib.pyplot as plt
import matplotlib.animation as animation
import scipy as sy

#fig, ax = plt.subplots(2,1)
#fig, ax = plt.subplots()
fig, ax = plt.subplots(3, sharex=True)
#axarr[0].plot(x, y)
ax[0].set_title('Surface elevation,period = 4s')
ax[1].set_title('Surface elevation,period = 8s')
ax[2].set_title('Surface elevation,period = 16s')
#axarr[1].scatter(x, y)

#plt.ylim(-1.0,1.0)
ax[0].set_ylim(-1.0,1.0)
ax[1].set_ylim(-1.0,1.0)
ax[2].set_ylim(-1.0,1.0)
plt.xlabel('x')
plt.ylabel('Surface elevation:eta')
plt.axis([0,101,-1.0,1.0])

def f1(i):
    str = '../period4/eta' + np.str(i) + '.dat'
    eta = np.loadtxt(str)
    return eta

def f2(i):
    str = '../period8/eta' + np.str(i) + '.dat'
    eta = np.loadtxt(str)
    return eta

def f3(i):
    str = '../period16/eta' + np.str(i) + '.dat'
    eta = np.loadtxt(str)
    return eta

def animate(i):
    line1.set_ydata(f1(i))  # update the data
    line2.set_ydata(f2(i))  # update the data
    line3.set_ydata(f3(i))  # update the data
    return line1,line2,line3

x = np.arange(201)
line1, = ax[0].plot(x, f1(20)*0.0)
line2, = ax[1].plot(x, f2(20)*0.0)
line3, = ax[2].plot(x, f3(20)*0.0)


# Init only required for blitting to give a clean slate.
def init():
    line1.set_ydata(np.ma.array(x, mask=True))
    line2.set_ydata(np.ma.array(x, mask=True))
    line3.set_ydata(np.ma.array(x, mask=True))
    return line1,line2,line3

#ani = animation.FuncAnimation(fig, animate, np.arange(21, 1800,20), init_func=init,
#                              interval=100, blit=True)
ani = animation.FuncAnimation(fig, animate, np.arange(20, 1800,20),
                              interval=100, blit=True)
plt.show()
