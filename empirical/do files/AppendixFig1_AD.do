////// Appendix figures

/// FIGURE 1.A: Peak testing vs peak fatality (OECD)


clear
import delimited "/Users/app/Dropbox/Optimal control/Data/EI_replicate/EMPIRICAL/newreplication/owid-covid-data.csv"

rename location country

**** Keep oecd countries 
merge m:1 country using "/Users/app/Dropbox/Optimal control/Data/EI_replicate/EMPIRICAL/newreplication/oecd_list.dta"

keep if _m==3
keep if oecd==1

*** CHL is an extreme outlier in terms of # of death.
*** It fits the thesis of the paper but makes the graph unreadable 
drop if iso_code=="CHL"

sort country date 

* Convert string date to Stata date format
gen date_var = date(date, "YMD")

* Format the date variable for readability
format date_var %td

keep if date_var > date("2020-03-01", "YMD")

keep if date_var<date("2022-06-30", "YMD")

**using smoothed variables provided by owid
gen testpc=new_tests_smoothed/population
*gen newdeath per million
gen ndsm_pc=new_deaths_smoothed_per_million

bys country: egen testpc_max=max(testpc)  
bys country: egen ndsm_pc_max=max(ndsm_pc)  
collapse (mean) ndsm_pc_max testpc_max, by(iso_code)
scatter  testpc_max ndsm_pc_max, mlabel(iso_code) ytitle("Peak daily per capita tests") xtitle("Peak daily deaths (per million)")





/// FIGURE 1.B: Testing capacity (based on news/annoucements)

*** Testing capacity do 

clear 
import excel "/Users/app/Dropbox/Optimal control/Data/EI_replicate/EMPIRICAL/newreplication/testing capacity.xlsx", sheet("Sheet1") firstrow


*** Removing spaces in "region" to get identical names

replace region = subinstr(region, " ", "", .)

gen pct=capacity/population

scatter pct date, mlabel(region)


/// FIGURE 1.C: Testing capacity (OECD)


clear
import delimited "/Users/app/Dropbox/Optimal control/Data/EI_replicate/EMPIRICAL/newreplication/owid-covid-data.csv"

rename location country

**** Keep oecd countries 
merge m:1 country using "/Users/app/Dropbox/Optimal control/Data/EI_replicate/EMPIRICAL/newreplication/oecd_list.dta"

keep if _m==3
keep if oecd==1

*** CHL is an extreme outlier in terms of # of death.
*** It fits the thesis of the paper but makes the graph unreadable 
drop if iso_code=="CHL"

sort country date 

* Convert string date to Stata date format
gen date_var = date(date, "YMD")

* Format the date variable for readability
format date_var %td

keep if date_var > date("2020-03-01", "YMD")

keep if date_var<date("2022-06-30", "YMD")

**using smoothed variables provided by owid
gen testpc=new_tests_smoothed/population
*gen newdeath per million
gen ndsm_pc=new_deaths_smoothed_per_million

collapse (mean) testpc ndsm_pc, by(date_var) 
gen days=_n


*Estimating a non-linear reg with starting value for b1,b2,b3
** first 365 days ***
** the regression requries to be initialized - which we do with the values below
nl (testpc =  ({b1=0.5}/(1 +{b2=10}*exp(-1*{b3=0.01}*days)))) if days <366 
predict testpc_fit
twoway (line testpc date_var, yaxis(1)) (line testpc_fit date_var, yaxis(1))(line ndsm_pc date_var, yaxis(2)) 


*
/// FIGURE 1.D: Same as fig 1 in the main text (US)
clear


import delimited "/Users/app/Downloads/owid-covid-data.csv"


keep if location=="United States"

sort date

**using smoothed variables provided by owid
gen testpc=new_tests_smoothed/population
*gen newdeath per million
gen ndsm_pc=new_deaths_smoothed_per_million

* Convert string date to Stata date format
gen date_var = date(date, "YMD")

* Format the date variable for readability
format date_var %td

keep if date_var > date("2020-03-01", "YMD")
drop if date_var>date("2022-07-01", "YMD")
gen days=_n

/*In orded for the (non linear) Logistic estimation to converge
it needs reasonable parametrization. We purposely start from a reasonably distant parametrization, but not extreme). See interpretation of the logistic parameters
in the text to judge what is reasonable.  */

nl (testpc =  ({b1=0.1}/(1 +{b2=10}*exp(-1*{b3=0.01}*days)))) if days<365
predict testpc_fit
*** adding the calibrated fit 
gen calib=((0.01)/(1 +13.5*exp(-1*0.016*days)))

	   
twoway (line ndsm_pc date_var, yaxis(1) lcolor(green) lwidth(med) lpattern(dot)) ///
       (line testpc date_var, yaxis(2) lcolor(black) lwidth(med)) ///
       (line testpc_fit date_var, yaxis(2) lcolor(red) lwidth(med) lpattern(longdash)) ///
	   (line calib date_var, yaxis(2) lcolor(blue) lwidth(thin) lpattern(longdash)) ///
       , ytitle(" ", axis(1)) ///
	   ytitle(" ", axis(2))    xtitle(" ") xlabel(#5, angle(45)) ///
	   legend(order(1 "Deaths p.m." 2 "per capita tests " 3 "logistic fit" 4 "calibrated")) /// 
	   title(" ")
        

