capture log close
cd "/Users/todh/Dropbox/NHIS_Immigration/Final_Draft"
log using Graph_TemplateDK20200904v3.txt, text replace
use "/Users/todh/Dropbox/NHIS_Immigration/nhis_00013_madevars.dta", clear
*use nhis_00013_madevars.dta, clear
tab adultsample, mi
keep if (hispnative==1| hispimmigrant==1| whitenative==1| whiteimmigrant==1| blacknative==1| blackimmigrant==1| asiannative==1| asianimmigrant==1) & (age>=25 & age<=64) 
keep if year>=2000

* Generating Log BMI
gen log_bmi=ln(bmicleanedround)

* Duration Variable for Models without Arrival Cohort  
gen arrivalgrp2 = 0 if usborn == 20 | usborn == 11
replace arrivalgrp2 = 1 if arrival0_4==1
replace arrivalgrp2 = 2 if  arrival5_9 == 1
replace arrivalgrp2 = 3 if  arrival10_14 == 1
replace arrivalgrp2 = 5 if  arrival15plus == 1

* Recent immigrant groups
gen immigyear_grp2 = 0 if usborn == 20 | usborn == 11
replace immigyear_grp2 = 1 if immig2003orbefore == 1
replace immigyear_grp2 = 2 if immig20042008 == 1 
replace immigyear_grp2 = 3 if immig20092013 == 1 
replace immigyear_grp2 = 4 if immig20142018 == 1

* Duration Variable for Models with Arrival Cohort
*gen arrivalgrp6 = 1 if ((usborn == 20 | usborn == 11))
gen arrivalgrp6 = 1 if ((usborn == 20 | usborn == 11)|arrival0_4==1)
replace arrivalgrp6 = 2 if  arrival5_9 == 1
replace arrivalgrp6 = 3 if  arrival10_14 == 1
replace arrivalgrp6 = 5 if  arrival15plus == 1




* ******************************
* Regression Models for Table 10
* ******************************
tab raceth
tab raceth, nolab
foreach O in  hyperten diabetic obesity {
* foreach O in fairpoorhealth2 limany hyperten overweight obesity log_bmi {
* foreach O in diabetic {
local ses_controls_2  "age agesq i.female i.married  educyrs i.workpast2weeks i.belowpoverty  i.reg_midwest i.reg_south i.reg_west  " 

local duration_controls "i.arrival0_4 i.arrival5_9 i.arrival10_14 i.arrival15plus" 
local interaction "hispanic_arrival0_4 hispanic_arrival5_9 hispanic_arrival10_14 hispanic_arrival15plus  black_arrival0_4 black_arrival5_9 black_arrival10_14 black_arrival15plus  asian_arrival0_4 asian_arrival5_9 asian_arrival10_14  asian_arrival15plus"

if ("`O'" != "log_bmi") {
* probit  `O' `duration_controls' i. raceth `ses_controls_2' `interaction' i.year  [pw=perweight],robust
probit    `O'  i.arrivalgrp2##i.raceth  `ses_controls_2'  i.year  [pw=perweight], robust
}
else {
regress    `O'  i.arrivalgrp2##i.raceth  `ses_controls_2'  i.year   [pw=perweight], robust 
}


margins arrivalgrp2 if immigrant~=0, atmeans over(raceth) 
  
if ("`O'" == "diabetic") {
local YRANGE "0.0 0.08"
local YLABEL ".0(.02).08"
local XRANGE "0.8 5.2"
local TITLE  "Diabetes"
local YTITLE "Pr(Diabetes)"
}

if ("`O'" == "obesity") {
local YRANGE "0.0 0.37"
local YLABEL ".0(.1).3"
local XRANGE "0.8 5.2"
local TITLE  "Obesity"
local YTITLE "Pr(Obesity)"
}
if ("`O'" == "fairpoorhealth2") {
local YRANGE "0.0 0.12"
local YLABEL ".0(.04).12"
local XRANGE "0.8 5.2"
local TITLE  "Fair/Poor Health"
local YTITLE "Pr(Fair/Poor Health)"
}
if ("`O'" == "hyperten") {
local YRANGE "0.0 0.37"
local YLABEL ".0(.1).3"
local XRANGE "0.8 5.2"
local TITLE  "Hypertension"
local YTITLE "Pr(Hypertension)"
}
/***
if ("`O'" == "log_bmi") {
local YRANGE "3.1 3.4"
local YLABEL "3.1(.1)3.4"
local XRANGE "0.8 5.2"
}
if ("`O'" == "limany") {
local YRANGE "0.0 0.1"
local YLABEL ".0(.02).1"
local XRANGE "0.8 5.2"
}
if ("`O'" == "overweight") {
local YRANGE "0.0 0.8"
local YLABEL ".0(.2).8"
local XRANGE "0.8 5.2"
local TITLE  "Overweight"
local YTITLE "Pr(Overweight)"
}
***/

/***
yline(`MARG_`O'_nhwhite',  lcolor(gray)) 
yline(`MARG_`O'_nhblack',  lcolor(gray) lpattern(longdash))
yline(`MARG_`O'_hispanic', lcolor(gray) lpattern(shortdash)) 
yline(`MARG_`O'_nhasian',  lcolor(gray) lpattern(shortdash_dot))  
***/

#delimit ;
marginsplot,
plotopts(lcolor(black) mcolor(black) lwidth(thick))
plot2opts(lpattern(longdash))  plot3opts(lpattern(shortdash)) plot4opts(lpattern(shortdash_dot))
ciopts(lcolor(black))
yscale(range(`YRANGE')) ylabel(`YLABEL', angle(0) nogrid)
xscale(range(`XSCALE')) xlabel(1 "0-4" 2 "5-9" 3 "10-14" 5 "15+")
xtitle("Years in US", size(small))
ytitle("`YTITLE'")
legend(rows(2) order(5 "Non-Hispanic White Immigrants" 6 "Non-Hispanic Black Immigrants" 7 "Hispanic Immigrants" 8 "Asian Immigrants") size(small) region(lcolor(white)))
graphregion(fcolor(white) color(white))
title("`TITLE'", size(small))
name(`O', replace)
;
#delimit cr

}



#delimit ;
grc1leg2 hyperten diabetic obesity, 
cols(3) xcommon graphregion(fcolor(white) color(white)) 
title("Figure 1: Predicted Probabilites of Health Status", size(small)) 
note("Figure 1: Predicted probabilites of health status. Source: 2000-2018 NHIS. All statistics use NHIS annual weight."
"Predicted probabilities of health" "status are based on probit regression models that control for age, sex, marital status, region of current residence, education, employment status," "poverty status, and survey year. NHIS = National Health Interview Survey.", size(vsmall))
;
#delimit cr
	
graph export Table10_4outcomes_nocohort_v3.pdf, replace

log close









