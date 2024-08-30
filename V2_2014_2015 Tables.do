
capture log close

log using 2014_2015_table1_recreation_billy.txt, text replace

local infant_mortality "newinfantmort newneonatalmort newpostneonatalmort"
local maternal_edu "m_nonhsgrad m_hsgrad m_assocdeg m_bachdeg m_mastdeg m_docdeg"
local mat_RF_status "mnh_white mnh_black m_hispanic mnh_asian m_fborn mb_possessions"
local prenatal_behav "tri_1 nullip one_priorbirth two_priorbirths threeplus_priorbirths"
local mat_chars "less_15 btwn15_19 btwn20_24 btwn25_29 btwn30_34 btwn35_39 btwn40_44 btwn45_49 btwn50_54 married"
local birth_reg "oreg_northeast oreg_midwest oreg_south oreg_west"

foreach z in 2014 2015 {

foreach y in immigrant for_nhwhite for_nhblack for_his for_nhasian {

estpost tabstat `infant_mortality' `maternal_edu' m_gender `mat_RF_status' `prenatal_behav' `mat_chars' `birth_reg' if `y'== 1 & dob_yy == `z', statistics(mean sd) columns(statistics)  
est store `y'_`z'
}

foreach y in native nat_nhwhite nat_nhblack nat_his nat_nhasian {

estpost tabstat `infant_mortality' `maternal_edu' m_gender `mat_RF_status' `prenatal_behav' `mat_chars' `birth_reg' if  `y'== 1 & dob_yy == `z', statistics(mean sd) columns(statistics)  
est store `y'_`z'
}

foreach y in mb_possessions poss_nhwhite poss_nhblack poss_his poss_nhasian {

estpost tabstat `infant_mortality' `maternal_edu' m_gender `mat_RF_status' `prenatal_behav' `mat_chars' `birth_reg' if  `y'== 1 & dob_yy == `z', statistics(mean sd) columns(statistics)  
est store `y'_`z'
}


esttab native_`z' immigrant_`z' mb_possessions_`z' nat_nhwhite_`z' for_nhwhite_`z' poss_nhwhite_`z' nat_nhblack_`z' for_nhblack_`z' poss_nhblack_`z' nat_his_`z' for_his_`z' poss_his_`z' nat_nhasian_`z' for_nhasian_`z' poss_nhasian_`z' using Descriptive_Natives_`z'_v2.tex, replace ///
label cells(mean(fmt(4))) collabel(none) mtitle( "Native" "Immigrant" "Territory" "Native" "Immigrant" "Territory" "Native" "Immigrant" "Territory" "Native" "Immigrant" "Territory" "Native" "Immigrant" "Territory") ///
	 mgroups("All" "NH White" "NH Black" "Hispanic" "NH Asian", pattern(1 0 0 1 0 0 1 0 0 1 0 0 1 0 0) ///
	   	prefix(\multicolumn{@span}{c}{) suffix(}) span erepeat(\cmidrule(lr){@span})) ///
   title(Summary statistics stratified by race/ethnicity and nativity, `z') refcat(oreg_northeast "\bf{\emph{Region of birth}}"  less_15  "\bf{\emph{Other maternal characteristics}}"	tri_1 "\bf{\emph{Prenatal behaviors/pregnancy characteristics}}"	mnh_white "\bf{\emph{Maternal race/foreign-born status}}"  m_gender "\bf{\emph{Child characteristics}}"	m_nonhsgrad "\bf{\emph{Maternal education}}" newinfantmort "\bf{\emph{Infant Mortality}}", nolabel) ///
   addnotes("Source: `z' Birth Cohort Linked Birth-Infant Death Data (LBID)," " published by the National Center for Health Statistics;" " all variables expressed as percentages or means (standard deviations).") ///

}
   
****Combined 2014_2015 Table
   
foreach y in immigrant for_nhwhite for_nhblack for_his for_nhasian {

estpost tabstat `infant_mortality' `maternal_edu' m_gender `mat_RF_status' `prenatal_behav' `mat_chars' `birth_reg' if `y'== 1, statistics(mean sd) columns(statistics)  
est store `y'
}


foreach y in native nat_nhwhite nat_nhblack nat_his nat_nhasian {

estpost tabstat `infant_mortality' `maternal_edu' m_gender `mat_RF_status' `prenatal_behav' `mat_chars' `birth_reg' if  `y'== 1, statistics(mean sd) columns(statistics)  
est store `y'
}



esttab native immigrant nat_nhwhite for_nhwhite nat_nhblack for_nhblack nat_his for_his nat_nhasian for_nhasian using Descriptive_combined2014_2015_v2.tex, replace ///
label cells(mean(fmt(4))) collabel(none) mtitle( "Native" "Immigrant"  "Native" "Immigrant"  "Native" "Immigrant"  "Native" "Immigrant"  "Native" "Immigrant" ) ///
	 mgroups("All" "NH White" "NH Black" "Hispanic" "NH Asian", pattern(1 0 1 0 1 0 1 0 1 0) ///
	   	prefix(\multicolumn{@span}{c}{) suffix(}) span erepeat(\cmidrule(lr){@span})) ///
   title(Summary statistics stratified by race/ethnicity and nativity, 2014 and 2015) refcat(oreg_northeast "\bf{\emph{Region of birth}}"  less_15  "\bf{\emph{Other maternal characteristics}}"	tri_1 "\bf{\emph{Prenatal behaviors/pregnancy characteristics}}"	mnh_white "\bf{\emph{Maternal race/foreign-born status}}"  m_gender "\bf{\emph{Child characteristics}}"	m_nonhsgrad "\bf{\emph{Maternal education}}" newinfantmort "\bf{\emph{Infant Mortality}}", nolabel) ///
   addnotes("Source: 2014 & 2015 Birth Cohort Linked Birth-Infant Death Data (LBID)," " published by the National Center for Health Statistics;" " all variables expressed as percentages or means (standard deviations).") ///

