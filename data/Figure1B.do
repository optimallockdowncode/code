*** Testing capacity do 

clear 
use "/Users/app/Dropbox/Optimal control/Submissions/NHB/Github/Factiva_search_results_data_Fig1B.dta"


scatter pct date, mlabel(region)
graph save "Graph" "/Users/app/Dropbox/Optimal control/Data/Nature-data/Figures/testing_capacity.gph", replace  
