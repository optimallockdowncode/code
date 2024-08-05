////// FIGURES 


/// FIGURE 1A: Peak testing vs peak fatality
use "/Users/app/Dropbox/Optimal control/Data/Nature-data/owid-oecd.dta", clear
sort ctry
*Generates peak death per 1mil by country 
bys ctry: egen ndsm_pc_max=max(ndsm_pc) 
*Generate peak per capita tests by country 
bys ctry: egen testpc_max=max(testpc)   
collapse (mean) ndsm_pc_max testpc_max, by(iso_code)
scatter  testpc_max ndsm_pc_max, mlabel(iso_code)


/// FIGURE 1C: OECD  (Remove the comment /*  */ function to run)
use "/Users/app/Dropbox/Optimal control/Data/Nature-data/owid-oecd.dta", clear
collapse (mean) new_cases_pc ndsm_pc testpc  , by(date)
sort date
gen days=_n
*Estimating a non-linear reg with starting value for b1,b2,b3
** first 365 days ***
** the regression requries to be initialized - which we do with the values below
nl (testpc =  ({b1=0.5}/(1 +{b2=10}*exp(-1*{b3=0.01}*days)))) if days <366 
predict testpc_fit
*gen us_fit=(0.008/(1 +13.5*exp(-1*0.016*days)))
twoway (line testpc date, yaxis(1)) (line testpc_fit date, yaxis(1))(line ndsm_pc date, yaxis(2)) 




/// FIGURE 1D: USA  (Remove the comment /*  */ function to run)

use "/Users/app/Dropbox/Optimal control/Data/Nature-data/owid-oecd.dta", clear

keep if country=="United States"
sort date
gen days=_n
nl (testpc =  ({b1=0.5}/(1 +{b2=10}*exp(-1*{b3=0.01}*days)))) if days<365
predict testpc_fit
twoway (line testpc date, yaxis(1)) (line testpc_fit date, yaxis(1))(line ndsm_pc date, yaxis(2)) 
*** adding the calibrated fit 
gen calib=((0.008)/(1 +13.5*exp(-1*0.016*days)))

twoway (line testpc date, yaxis(1)) (line testpc_fit date, yaxis(1))(line calib date, yaxis(1))(line ndsm_pc date, yaxis(2)) 


