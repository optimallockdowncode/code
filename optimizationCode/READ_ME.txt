This is the code for the manuscript Optimal Lockdowns Under Constraints.

To use: download the code and place all files in the same directory. 
Then simply run driver.m or driver_2var.m. You can specify the parameter 
values that you want inside those files 

Contents:

driver.m - a driver file, that allows you to specify parameter
	   values and interfaces with APMonitor which solves the 
	   optimal control problem for each of the parameter values 
           specified. In particular, you can choose one independent 
	   variable and specify a range of values and it will solve 
	   the optimal control problem for each value. 

           After solving, it will output two data files: 
		(1) current_indiv_run.mat
			This file contains the data from the 
			latest simulation. In particular,
   			it can be loaded by drawDynamics.m to 
			plot the actual populations and control
			values throughout the course of the epidemic
		(2) current.mat 
			This file contains aggregated data regarding
			total quarantine from all of the simulations.
			It can be loaded by QPlots.m to produce the 
			plots of total quarantine as a function of the 
			specified parameter. 

driver_2var.m - a driver file, that allows you to specify parameter
	   values and interfaces with APMonitor which solves the 
	   optimal control problem for each of the parameter values 
           specified. In particular, you can choose two independent 
	   variables, specify a range of values for each, and it will 
	   solve the optimal control problem for each pair of values. 

           After solving, it will output a data file: 
		(1) current.mat 
			This file contains aggregated data regarding
			total quarantine from all of the simulations.
			It can be loaded by QPlots_2var.m to produce the 
			surfae or heat map plots of total quarantine 
			as a function of the two specified parameters. 

WriteAPMFile.m / WriteCsvFile.m - these are helper scripts which 
	  take all the info from driver.m (or driver_2var.m), and print 
	  it into APMonitor readable files, so that the optimization
	  problem can be passed into APMonitor. These should not be 
	  edited

drawDynamics.m / QPlots.m / QPlots_2var.m - these are plotting 
	  scripts which will take the data files produced by 
	  driver.m or driver_2var.m (as described above) and 
          produce the plots seen in the manuscript. 
