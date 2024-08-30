

//natality file tables for PTB by race, hispanic ethnicity and nativity fun after APNCU do

clear 

capture log close //creates a log file, will close at the last line of code
*cd "Z:\Preterm_Birth\"


cd "/Volumes/Hamilton/Preterm_Birth/Vital Statisticss (2018 and 2019)/Tod's Analysis"

log using ptb_latinx_birthplace_tables,text replace

use ptb_makevars_4_9_2022.dta

//how do I connect this to the file from the variable creation do file, ? save temp 
//use  "Z:\Preterm_Birth\Vital Statisticss (2018 and 2019)\NATL2018US.AllCnty.dta", clear

tab ansamp, missing
keep if ansamp==1
tab ansamp, missing

//dating can be 2 weeks off and go postdates to 42+, but very hard to believe could go past 45 wks, need ega to calculate ptb outcome
//35,519 < 18 yrs
//2,828 dropped >46 years
//15,696 with congenital anomalies dropped
 //109372 without singleton pregnancies reported e.g., twins 
*************************************Descriptive Table for  Combined Sample *********************************************************************************
local outcomes "ptb extreme_ptb lbw vlbw" 
local med_var "ppterm nullip any_htn any_diab cig sti"
local pnc "nopnc inadequate intermediate adequate intensive unkpnc"

*local demographic " magerc3 meduc_4 pay_rec regions "
local demographic "young ama very_ama less_hs hs college grad_school medicaid private_ins other_ins oreg_northeast oreg_midwest oreg_south oreg_west"
	
	
foreach y in  immigrant bl_nh_immigrant wh_nh_immigrant bl_hispimmigrant wh_hispimmigrant aian_hisp_imm  {
estpost tabstat `outcomes'  `med_var'  mager `demographic'   if (ptb~=.) &  `y'==1 ,  statistics(mean sd) columns(statistics)  
est store `y'

}

foreach y in native bl_nh_native  wh_nh_native bl_hisp_native wh_hisp_native aian_hisp_native    {
estpost tabstat `outcomes' `med_var'  mager `demographic'   if (ptb~=.) &  `y'==1 ,  statistics(mean sd) columns(statistics)  
est store `y'

}

esttab native immigrant bl_nh_native bl_nh_immigrant wh_nh_native wh_nh_immigrant bl_hisp_native bl_hispimmigrant wh_hisp_native wh_hispimmigrant aian_hisp_native aian_hisp_imm   using Descriptive_PTB_ren.tex, replace ///
	 	 label cells(mean(fmt(2))) collabel(none) mtitle( "Native" "Immigrant"  "Native" "Immigrant"  "Native" "Immigrant"  "Native" "Immigrant"  "Native" "Immigrant" "Native" "Immigrant") ///
	 mgroups("All Origin" "Black non-Hispanic" "White non-Hispanic" "Black Hispanic" "White Hispanic" "American Indian", pattern(1 0 1 0 1 0 1 0 1 0 1 0 ) ///
	   	prefix(\multicolumn{@span}{c}{) suffix(}) span erepeat(\cmidrule(lr){@span})) ///
   title(Descriptive Statistics for U.S.-Born and Foreign-Born Birthing People,  Ages 18-46) refcat(ppterm "\bf{\emph{Medical Factors.}}" nopnc "\bf{\emph{Prenatal Care, Adequacy of Prenatal Care Utilization Index (APNCU)}}" ptb  "\bf{\emph{Birth Outcomes}}" oreg_northeast"\bf{\emph{US Region of Birth Occurrence}}" magerc3 "\bf{\emph{Demographic, Social, and Economic Characteristics}}", nolabel) ///
   addnotes("Source: National Center for Health Statistics 2018 Natality Files.") ///
   
//how to run the latex file and which regression analyses do we want to use for tables? 
/*sample analyses
logistic ptb i.mbrace5 immigrant
logistic ptb ppterm multip any_htn any_diab cig sti b2.APNCU i.magerc3 b2.meduc_4 b2.pay_rec i.mbrace5 immigrant i.oregion //
logistic ptb ppterm multip any_htn any_diab cig sti poorpnc i.magerc3 b2.meduc_4 b2.pay_rec i.mbrace5 immigrant i.oregion 

probit ptb i.fullren ppterm multip any_htn any_diab cig sti b2.APNCU i.magerc3 b2.meduc_4 b2.pay_rec i.oregion
margins i.fullren#meduc 
marginsplot

probit ptb ppterm multip any_htn any_diab cig sti b2.APNCU i.magerc3 b2.meduc_4 b2.pay_rec if native==1 | bl_hispimmigrant ==1 
probit ptb ppterm multip any_htn any_diab cig sti b2.APNCU i.magerc3 b2.meduc_4 b2.pay_rec if wh_nh_native ==1
probit ptb ppterm multip any_htn any_diab cig sti b2.APNCU i.magerc3 b2.meduc_4 b2.pay_rec if bl_nh_immigrant ==1
probit ptb ppterm multip any_htn any_diab cig sti b2.APNCU i.magerc3 b2.meduc_4 b2.pay_rec if wh_nh_immigrant ==1

probit ptb ppterm multip any_htn any_diab cig sti b2.APNCU i.magerc3 b2.meduc_4 b2.pay_rec if bl_hisp_native ==1
probit ptb ppterm multip any_htn any_diab cig sti b2.APNCU i.magerc3 b2.meduc_4 b2.pay_rec if wh_hisp_native ==1
probit ptb ppterm multip any_htn any_diab cig sti b2.APNCU i.magerc3 b2.meduc_4 b2.pay_rec if bl_hispimmigrant ==1
probit ptb ppterm multip any_htn any_diab cig sti b2.APNCU i.magerc3 b2.meduc_4 b2.pay_rec if wh_hispimmigrant ==1

probit ptb ppterm multip any_htn any_diab cig sti b2.APNCU i.magerc3 b2.meduc_4 b2.pay_rec if aian_hisp_native ==1
probit ptb ppterm multip any_htn any_diab cig sti b2.APNCU i.magerc3 b2.meduc_4 b2.pay_rec if aian_hisp_imm ==1

*/

//ptb ppterm multip any_htn any_diab cig sti b0.poorpnc magerc3 b2.meduc4 b2.pay_rec i.oregion   


* Regression Models 
foreach r in 1 2 3 4 5 6{
foreach O in  ptb extreme_ptb lbw vlbw{

	
local ses_controls  "young ama very_ama  hs college grad_school medicaid private_ins other_ins oreg_northeast oreg_midwest  oreg_west" 
local med_var "ppterm nullip any_htn any_diab cig sti"
local pnc "nopnc inadequate intermediate adequate intensive unkpnc"
xi: dprobit  `O'  immigrant `ses_controls' `med_var' `pnc' if (raceth==`r') ,robust



 est store `O'_`r'w
}
}



esttab ptb_1w ptb_2w ptb_3w ptb_4w ptb_5w ptb_6w extreme_ptb_1w extreme_ptb_2w extreme_ptb_3w extreme_ptb_4w extreme_ptb_5w extreme_ptb_6w  using sumPTB_ren.tex, replace  ///
		label booktabs compress   margin   nodiscrete b(2) se  eqlabels(none) alignment(S S)  mtitle("White NH" "Black NH" "Hisp White" "Hisp Black" "Hisp AIAN" "AIAN NH" "White NH" "Black NH" "Hisp White" "Hisp Black" "Hisp AIAN" "AIAN NH"  ) ///	
	mgroups("PTB" "Very PTB" , pattern(1 0 0 0 0 0 1 0 0 0 0 0 ) ///
	prefix(\multicolumn{@span}{c}{) suffix(}) span erepeat(\cmidrule(lr){@span})) ///
	keep(immigrant `ses_controls' `med_var' `pnc') ///
	addnotes("Notes: All models include controls for age, education, region of birth, education, insurance status at time of birth, prior preterm birth, multiparity, hypertension, diabetes, cigarette smoking in pregnancy, and gonorrhea, chlamydia or syphilis during the pregnancy. Robust standard errors are in parentheses." "\*+ p \textless 0.10, \** p \textless 0.05, \*** p \textless 0.01, \**** p \textless 0.001 (two-tailed tests)." "Source: National Center for Health Statistics 2018 Natality Files.") ///
	star(+ 0.10 * 0.05 ** 0.01 *** 0.001) collabels("\multicolumn{1}{c}{MFx}" ) ///
	nonotes ///
		title(Marginal Effects from Probit Regression Models of Preterm Birth and Low Birth Weight for U.S.-born and Foreign-Born Individuals, Age 18-46)  refcat(youngteen "\bf{\emph{SES Char.}}" ///
    oreg_northeast "\bf{\emph{Birth Region}}" ppterm "\bf{\emph{Health Char.}}" APNCU "\bf{\emph{Prenatal Care Attendance}}"  \, nolabel) ///
	stats(N , fmt(0 3) layout("\multicolumn{1}{c}{@}" "\multicolumn{1}{S}{@}") labels(`"Observations"' ))
	
	
	esttab lbw_1w lbw_2w lbw_3w lbw_4w lbw_5w lbw_6w vlbw_1w vlbw_2w vlbw_3w vlbw_4w vlbw_5w vlbw_6w using sumPTB_ren.tex, replace  ///
		label booktabs compress   margin   nodiscrete b(2) se  eqlabels(none) alignment(S S)  mtitle("White NH" "Black NH" "Hisp White" "Hisp Black" "Hisp AIAN" "AIAN NH" "White NH" "Black NH" "Hisp White" "Hisp Black" "Hisp AIAN" "AIAN NH"  ) ///	
	mgroups( "LBW" "VLBW" , pattern(1 0 0 0 0 0 1 0 0 0 0 0 ) ///
	prefix(\multicolumn{@span}{c}{) suffix(}) span erepeat(\cmidrule(lr){@span})) ///
	keep(immigrant `ses_controls' `med_var' `pnc') ///
	addnotes("Notes: All models include controls for age, education, region of birth, education, insurance status at time of birth, prior preterm birth, multiparity, hypertension, diabetes, cigarette smoking in pregnancy, and gonorrhea, chlamydia or syphilis during the pregnancy. Robust standard errors are in parentheses." "\*+ p \textless 0.10, \** p \textless 0.05, \*** p \textless 0.01, \**** p \textless 0.001 (two-tailed tests)." "Source: National Center for Health Statistics 2018 Natality Files.") ///
	star(+ 0.10 * 0.05 ** 0.01 *** 0.001) collabels("\multicolumn{1}{c}{MFx}" ) ///
	nonotes ///
		title(Marginal Effects from Probit Regression Models of Preterm Birth and Low Birth Weight for U.S.-born and Foreign-Born Individuals, Age 18-46)  refcat(youngteen "\bf{\emph{SES Char.}}" ///
    oreg_northeast "\bf{\emph{Birth Region}}" ppterm "\bf{\emph{Health Char.}}" APNCU "\bf{\emph{Prenatal Care Attendance}}"  \, nolabel) ///
	stats(N , fmt(0 3) layout("\multicolumn{1}{c}{@}" "\multicolumn{1}{S}{@}") labels(`"Observations"' ))
	
	//can repeat with parity instead of multip in med_var, parity is 0, 1, 2 3+ prior births; also could use restatus to look at mobility. *nb this ansamp does not include foreign residents. 
