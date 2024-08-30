
capture log close

*billyswartwout/Dropbox (Princeton)

log using 2014_2015_table_migration_tables.txt, text replace

local infant_mortality "newinfantmort newneonatalmort newpostneonatalmort"
local maternal_edu "m_nonhsgrad m_hsgrad m_assocdeg m_bachdeg m_mastdeg m_docdeg"
local mat_RF_status "mnh_white mnh_black m_hispanic mnh_asian m_fborn"
local prenatal_behav "tri_1 nullip one_priorbirth two_priorbirths threeplus_priorbirths"
local mat_chars "less_15 btwn15_19 btwn20_24 btwn25_29 btwn30_34 btwn35_39 btwn40_44 btwn45_49 btwn50_54 married"
local birth_reg "oreg_northeast oreg_midwest oreg_south oreg_west"

foreach z in mnh_white mnh_black m_hispanic mnh_asian {

foreach y in native mob_oregion mob_wregion mob_acr_state mob_fborn {

estpost tabstat `infant_mortality' `maternal_edu' m_gender `mat_RF_status' `prenatal_behav' `mat_chars' `birth_reg' if `y'== 1 & `z' == 1, statistics(mean sd) columns(statistics)  
est store `y'_`z'
}



esttab native_`z' mob_oregion_`z' mob_wregion_`z' mob_acr_state_`z' mob_fborn_`z' using Internal_Migration_`z'.tex, replace ///
label cells(mean(fmt(2))) collabel(none) mtitle("N" "DBR" "SBR" "SBS" "FB") ///
   title(Summary statistics stratified by race/ethnicity and nativity, `z') refcat(oreg_northeast "\bf{\emph{Region of birth}}"  less_15  "\bf{\emph{Other maternal characteristics}}"	tri_1 "\bf{\emph{Prenatal behaviors/pregnancy characteristics}}"	mnh_white "\bf{\emph{Maternal race/foreign-born status}}"  m_gender "\bf{\emph{Child characteristics}}"	m_nonhsgrad "\bf{\emph{Maternal education}}" newinfantmort "\bf{\emph{Infant Mortality}}", nolabel) ///
//    addnotes("Source: 2014 & 2015 Birth Cohort Linked Birth-Infant Death Data (LBID)," " published by the National Center for Health Statistics;" " all variables expressed as percentages or means (standard deviations).") ///

}

*** Nonrace specific
local infant_mortality "newinfantmort newneonatalmort newpostneonatalmort"
local maternal_edu "m_nonhsgrad m_hsgrad m_assocdeg m_bachdeg m_mastdeg m_docdeg"
local mat_RF_status "mnh_white mnh_black m_hispanic mnh_asian m_fborn"
local prenatal_behav "tri_1 nullip one_priorbirth two_priorbirths threeplus_priorbirths"
local mat_chars "less_15 btwn15_19 btwn20_24 btwn25_29 btwn30_34 btwn35_39 btwn40_44 btwn45_49 btwn50_54 married"
local birth_reg "oreg_northeast oreg_midwest oreg_south oreg_west"


foreach p in native mob_oregion mob_wregion mob_acr_state mob_fborn {

estpost tabstat `infant_mortality' `maternal_edu' m_gender `mat_RF_status' `prenatal_behav' `mat_chars' `birth_reg' if `p'== 1, statistics(mean sd) columns(statistics)  
est store `p'
}


esttab native mob_oregion mob_wregion mob_acr_state mob_fborn using Internal_Migration_nonrace.tex, replace ///
label cells(mean(fmt(2))) collabel(none) mtitle("N" "DBR" "SBR" "SBS" "FB") ///
   title(Summary statistics stratified by race/ethnicity and nativity, nonrace) refcat(oreg_northeast "\bf{\emph{Region of birth}}"  less_15  "\bf{\emph{Other maternal characteristics}}"	tri_1 "\bf{\emph{Prenatal behaviors/pregnancy characteristics}}"	mnh_white "\bf{\emph{Maternal race/foreign-born status}}"  m_gender "\bf{\emph{Child characteristics}}"	m_nonhsgrad "\bf{\emph{Maternal education}}" newinfantmort "\bf{\emph{Infant Mortality}}", nolabel) ///
//    addnotes("Source: 2014 & 2015 Birth Cohort Linked Birth-Infant Death Data (LBID)," " published by the National Center for Health Statistics;" " all variables expressed as percentages or means (standard deviations).") ///


