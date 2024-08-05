# code
All code and data which creates the figures for the manuscript Optimal Lockdowns Under Constraints

Data and .do files which create figure 1 are found in the directory "empirical."

The directory "OptimizationCode" contains all codes which create figures 2-7 in the manuscript. 
To create a figure, download all files to a common directory, navigate to the folder corresponding 
to the figure you want to see and run the driver. This will run all necessary code and produce the 
figure once completed. For example, to see Figure 5(I) or (II) simply navigate to the folder
Figure 5 and run the script driver_fig5_I.m or driver_fig5_II.m. The only difference is Figure 3(AB).
Because this figure has multiple simulations plotted on top of each other, the data files for each 
simulation are included, and one can create the figure simply by running plotFigure3AB. Alternatively,
one can run driver_fig3AB.m and it will re-run the simulations and then create the figure.

A NOTE ON CPU TIME: Currently, all code in the "Figure" folders is set to run at high resolution
(i.e., for a time horizon of T = 365 and a time step of dt = 1). At this resolution, individual 
simulations of the model require on the order of 5-10 minutes. To create plots like that in 
Figure 4 (which display optimal amount of lockdown as a function of an individual parameter), 
one must run an individual simulation for each parameter value. Thus the code for Figure 4 (which
runs simulations for 10 different theta values) requires roughly 1.5 hours. To create plots like 
those in the bottom panel of Figure 3 or in Figure 7 (which display optimal amount of lockdown 
as a function of two parameters), the code runs individual simulations for each specified pair of 
parameter values. Thus the code for figure 3(C) (which runs individual simulations for 9 values of 
b1 times 11 values of VSL = 99 pairs of values) requires on the order of 8-10 hours. To run the  
simulations at lower resolution, one can increase dt. In doing so, the code will be much faster 
(e.g. with dt = 7, individual simulations require on the order of 20-60 seconds), but produce 
"bumpier" results. 

CONTENTS: 
  Each folder beginning with "Figure..." contains all files necessary to create the corresponding
  figure (including optimization code and plotting scripts). The contents of these folders should 
  not be modified if one wants to see the exact figures presented in the manuscript. 

  In the OptimizationCode directory, there are two helper files WriteAPMFile.m and WriteCsvFile.m.
  They are scripts which take the settings from any of the driver files and write them to files which 
  are readable by APMonitor, which is the interface between MATLAB and IpOpt.
  These should not be modified. 

  In the OptimizationCode directory, there are three plotting files: draw_new.m, QPlots.m, and 
  QPlots_2var.m. Each of the driver files runs some simulation(s) and prints results to a MATLAB
  data file. These plotting scripts import data from these data files and plot results. They 
  are called at the bottom of the driver files, and contain some "automation" which attempts to 
  title plots/label axes/etc correctly, but may need to be edited if one wishes to create new figures. 
  Specifically, draw_new.m plots the dynamics from an individual simulation, like those in Figures
  2, 4 and 5 of the manuscript. QPlots.m plots optimal number of quarantine days as a function of 
  one parameter like the plots in Figures 3(AB) and Figure 6 of the manuscript. QPlots_2var.m plots
  optimal number of quarantine days as a function of two parameters like the plots in Figures 3(CD)
  and Figure 7 of the manuscript. 

  The OptimizationCode directory also includes two driver files: driver.m and driver_2var.m. 
  The file driver.m can be used to either run (1) an individual simulation or (2) a series of 
  simulations which evaluate optimal number of quarantine days as a function of one paramater. 
  The file driver_2var.m can be used to run a series of simulations which evaluate the optimal
  number of quarantine days as a function of two parameters. At the top of each file you can chose 
  which parameter is being treated as an independent variable and specify which values it should take. 
  The drivers will solve the corresponding optimization problems and call a plotting script to display
  results. For driver.m, if vals (the selection of values for the independent variable to assume) is a
  single value, it will draw_new.m to plot dynamics from the individual run, whereas if vals is a vector 
  of values it will call QPlots.m to plot total quarantine as a function of the independent variable. 
  NOTE: to specify a new independent variable in driver.m, one must change 3 things: 
      (i) the name of the independent variable on line 16
      (ii) the values that variable is to take on line 17
      (iii) the assignment of those values to the correct variable on lines 46-61
  Similarly, to specify a pair of independent variables in driver_2var.m, one must change 6 things: 
      (i) the 2 names of the independent variables on lines 11,12
      (ii) the values that each of the variables is going to take on lines 13,14
      (iii) the assignment of the values to the correct variable on lines 43-59
  
