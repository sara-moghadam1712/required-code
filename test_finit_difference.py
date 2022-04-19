from queue import PriorityQueue
import numpy as np
from numpy.core.fromnumeric import shape
from numpy.core.function_base import linspace
import pandas as pd
import matplotlib.pyplot as plt
import imagesc as imagesc
from pandas.tseries.offsets import Minute
import matplotlib.cbook as cbook
from matplotlib_colorbar.colorbar import Colorbar


dt = 300 
nt = 9
t = 2700
dx = 0.03 
L = 0.12
nx = 4
kt = 15
alpha = 0.0000015
Tin = 85
Tinf = 20
h = 50

delta_t = t/nt
delta_x = L/nx 

Temperature = np.zeros((nx+1, nt+1))
print(Temperature)

for k in range(0,nt+1):
    for i in range (0,nx+1):
        Temperature[i,k] = Tin
print(Temperature)

F0_num = alpha*delta_t/delta_x**2
F0 = alpha*t/L**2

print(F0)


for k in range (0, nt):
    for i in range (0, nx+1):
        if i == 0:
            fb = h*(Tinf-Temperature[0,k])
            print(Temperature[0,k])
            Temperature[i, k+1] = Temperature[i, k]+2*F0_num*(Temperature[i+1, k]-Temperature[i, k]+((delta_x/kt)*fb))
            print(Temperature[i,k+1])
        elif i == nx:
            Temperature[i, k+1] = Temperature[i, k] + 2*F0_num*(Temperature[i-1, k] - Temperature[i, k])
        else:
            Temperature[i, k+1] = Temperature[i, k] + F0_num*(Temperature[i-1,k]-2*Temperature[i,k]+Temperature[i+1,k])
            print(Temperature[i,k+1])
    print(Temperature[:,k+1])
print('h')

