"""
=================
An animated image
=================

This example demonstrates how to animate an image.
"""
import sys
import numpy as np
import matplotlib.pyplot as plt
import matplotlib.animation as animation

fig = plt.figure()


def f(i):
    nz = 101
    nx = 201
    str = 'den' + np.str(i) + '.dat'
    den = np.loadtxt(str)
    den = np.reshape(den,(nz,nx))
    return den

i = 120
#im = plt.imshow(f(i), cmap="bwr",animated=True)
im = plt.imshow(f(i), cmap="jet",interpolation='bilinear',animated=True)
#im = plt.imshow(f(i), cmap="jet",animated=True)
#im = plt.imshow(f(i), animated=True)


def updatefig(*args):
    global i
    i += 120
    if i >42000:
        sys.exit(0)
    im.set_array(f(i))
    plt.title('time:'+ np.str(round(i*1.0/60.0,2)) + ' min' )
    return im,

ani = animation.FuncAnimation(fig, updatefig, interval=100, blit=True)
plt.show()
