

/// IMPORT OWID DATA (csv downloaded from: https://ourworldindata.org/coronavirus-testing)
import delimited "/Users/app/Dropbox/Optimal control/Data/Nature-data/owid-covid-data.csv",clear 


/// RENAME (date, country)
rename location country 
rename date dt, replace  


/// GENERATE variables (Date, per capita measures)

*format date
gen date= date(dt, "YMD")
format %td date

*numeric country code 
egen ctry = group(iso_code) 

*per-capita tests per day 
gen testpc=new_tests_smoothed/population 
*per-capita new cases 
gen new_cases_pc=new_cases_smoothed/population 
*per-1mil new deaths 
gen ndsm_pc=new_deaths_smoothed*1000000/population 
gen ratio=testpc/ndsm_pc


/// START DATA MARCH 2020 - end date June 2022
drop if date < date("20200301","YMD")
drop if date > date("20220601","YMD")


/// KEEP OECD COUNTRIES 
keep if inlist(country,"Austria","Australia", "Belgium", "Canada", "Chile", "Colombia", "Costa Rica", "Czechia", "Denmark")|inlist(country, "Estonia","Finland", "France", "Germany", "Greece", "Hungary", "Iceland", "Ireland", "Israel")|inlist(country,"Italy","Japan","Latvia", "Lithuania","Luxembourg", "Mexico", "Netherlands", "New Zealand")|inlist(country,"Norway", "Poland","Portugal","Slovakia", "Slovenia", "Spain","South Korea","Sweden", "Switzerland") |inlist(country,"Turkey", "United Kingdom","United States") 


xtset ctry date
by ctry (date): gen testpc_max = testpc if _n == 1
by ctry (date): replace testpc_max = max(L1.testpc_max, testpc) if _n > 1

save "/Users/app/Dropbox/Optimal control/Data/Nature-data/owid-oecd.dta", replace

