
/// APPENDIX - G7 logistic fit - Supplement Table A1
/// Run each country separately 




**** UNITED STATES 
use "/Users/app/Dropbox/Optimal control/Data/Nature-data/owid-oecd.dta", clear
keep if country=="United States"
sort date
gen days=_n
gen days2=days^2
nl (testpc =  ({b1=0.5}/(1 +{b2=10}*exp(-1*{b3=0.1}*days)))) if days<366 & country=="United States"
predict testpc_fit
estat ic
reg testpc days if days<366 & country=="United States"
estat ic
reg testpc days days2 if days<366 & country=="United States"
estat ic

/* Results United States 
b1=.0050477
b2=13.5318 
b3=.0162647
AIC logistic= -4378.012
AIC linear=-4300.265
AIC quadratic=-4366.873 
*/

**** Canada
use "/Users/app/Dropbox/Optimal control/Data/Nature-data/owid-oecd.dta", clear

keep if country=="Canada"
sort date
gen days=_n
gen days2=days^2

nl (testpc =  ({b1=0.5}/(1 +{b2=10}*exp(-1*{b3=0.1}*days)))) if days<366 
predict testpc_fit
estat ic
reg testpc days if days<366 
estat ic
reg testpc days days2 if days<366 
estat ic

/* Results Canada
b1=.0031535
b2= 13.94823 
b3=.0161688
AIC logistic= -5051.196
AIC linear=-4926.708
AIC quadratic=-4983.211 
*/


**** France
use "/Users/app/Dropbox/Optimal control/Data/Nature-data/owid-oecd.dta", clear

keep if country=="France"
sort date
gen days=_n
gen days2=days^2

nl (testpc =  ({b1=0.5}/(1 +{b2=10}*exp(-1*{b3=0.01}*days)))) if days<366 
predict testpc_fit
estat ic
reg testpc days if days<366 
estat ic
reg testpc days days2 if days<366 
estat ic

/* Results France
b1= .0045399
b2= 85.48579
b3= .0230961
AIC logistic= -3354.468 
AIC linear=  -3321.272
AIC quadratic=-3337.196
*/


**** Germany
use "/Users/app/Dropbox/Optimal control/Data/Nature-data/owid-oecd.dta", clear

keep if country=="Germany"
sort date
gen days=_n
gen days2=days^2

nl (testpc =  ({b1=0.5}/(1 +{b2=10}*exp(-1*{b3=0.1}*days)))) if days<366 
predict testpc_fit
estat ic
reg testpc days if days<366 
estat ic
reg testpc days days2 if days<366 
estat ic

/* Results Germany
b1=.0022912
b2= 17.69271
b3=.0214839
AIC logistic= -4562.615
AIC linear= -4379.48
AIC quadratic=-4479.526
*/




**** "Italy"
use "/Users/app/Dropbox/Optimal control/Data/Nature-data/owid-oecd.dta", clear

keep if country=="Italy"
sort date
gen days=_n
gen days2=days^2

nl (testpc =  ({b1=0.5}/(1 +{b2=10}*exp(-1*{b3=0.01}*days)))) if days<366 
predict testpc_fit
estat ic
reg testpc days if days<366 
estat ic
reg testpc days days2 if days<366 
estat ic

/* Results Italy
b1= .0116978
b2=   29.58199
b3=  .0079752 
AIC logistic= -4487.122
AIC linear=  -4384.092
AIC quadratic=-4486.858
*/


**** "Japan"
use "/Users/app/Dropbox/Optimal control/Data/Nature-data/owid-oecd.dta", clear

keep if country=="Japan"
sort date
gen days=_n
gen days2=days^2

nl (testpc =  ({b1=0.5}/(1 +{b2=10}*exp(-1*{b3=0.01}*days)))) if days<366 
predict testpc_fit
estat ic
reg testpc days if days<366 
estat ic
reg testpc days days2 if days<366 
estat ic

/* Results Japan
b1= .0006846
b2=  60.85516 
b3= .0136551 
AIC logistic= -6130.944
AIC linear=  -5962.66 
AIC quadratic= -6115.856
*/



**** "United Kingdom"
use "/Users/app/Dropbox/Optimal control/Data/Nature-data/owid-oecd.dta", clear

keep if country=="United Kingdom"
sort date
gen days=_n
gen days2=days^2

nl (testpc =  ({b1=0.5}/(1 +{b2=10}*exp(-1*{b3=0.01}*days)))) if days<366 
predict testpc_fit
estat ic
reg testpc days if days<366 
estat ic
reg testpc days days2 if days<366 
estat ic

/* Results United Kingdom
b1= .0281759
b2=  56.69848 
b3= .0092772
AIC logistic= -3987.9
AIC linear=  -3703.755
AIC quadratic=-3965.993
*/


/* COPY THE FOLLOWING INTO LATEX

\begin{table*}[b!]
\begin{center}
\begin{tabular}{|l|lll|lll|}
\hline
                & $b_1$             & $b_2$               & $b_3$             & AIC    & Linear AIC & Quadratic AIC \\
\hline

Canada          & 0.003          & 13.94         & .016        & -5051 & -4926         & -4983 \\

France          & 0.004          & 85.48          & 0.023        & -3354 & -3321         & -3337 \\
Germany         & 0.002          & 17.69          & 0.021         & -4562 & -4379          & -4479  \\

Italy           & 0.011          & 29.58         & 0.007        & -4487 & -4384         & -4486 \\
Japan           & 0.0006          &  60.85          & 0.013        & -6130 & -5962          & -6115  \\

United Kingdom  & 0.028          & 56.69          & 0.009         & -3987 & -3703          & -3965 \\
United States   & 0.005          & 13.53          & 0.016          & -4378          & -4300 &  -4366 \\
\hline
\hline
\end{tabular}
\end{center}





*/








