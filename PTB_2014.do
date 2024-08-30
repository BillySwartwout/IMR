//PTB by Race, Hispanic Ethnicity and Nativity

//2014 file

clear

capture log close

keep dob_yy mager41 mager9 fagerec11 dmar meduc feduc sex mracehisp mbstate mbstate_rec ostate mrstatepstl mbcntry mrcntry precare5 bwtr14 lbo_rec gestrec10 flgnd ager5 ager22

// To Discuss: 
// formatting of poss, im, naive
// Maternal race/foreign-born status
// infant mortality variable

* Maternal Charactersitics
*********************************
* Maternal age
tab mager41, mi
label variable mager41 "Maternal age"

tab mager9, mi
label define mager9 1 "<15 years" 2 "15-19 years" 3 "20-24 years" 4 "25-29 years" 5 "30-34 years" 6 "35-39 years" 7 "40-44 years" 8 "45-49 years" 9 "50-54 years"
label values mager9 mager9
label variable mager9 "Maternal age"
tab mager9, mi
* dummy for mother's age

// Please adjust and create dummy variables starting with the missing category
// Corrected
foreach i in less_15 btwn15_19 btwn20_24 btwn25_29 btwn30_34 btwn35_39 btwn40_44 btwn45_49 btwn50_54 {
gen `i' = .
}
replace less_15 = 1 if mager9 == 1
replace btwn15_19 = 1 if mager9 == 2
replace btwn20_24 = 1 if mager9 == 3
replace btwn25_29 = 1 if mager9 == 4
replace btwn30_34 = 1 if mager9 == 5
replace btwn35_39 = 1 if mager9 == 6
replace btwn40_44 = 1 if mager9 == 7
replace btwn45_49 = 1 if mager9 == 8
replace btwn50_54 = 1 if mager9 == 9

foreach i in less_15 btwn15_19 btwn20_24 btwn25_29 btwn30_34 btwn35_39 btwn40_44 btwn45_49 btwn50_54 {
replace `i' = 0 if `i' != 1 & mager9 != .
}

label variable less_15 "less than 15 years old"
label variable btwn15_19 "15-19 years old"
label variable btwn20_24 "20-24 years old"
label variable btwn25_29 "25-29 years old"
label variable btwn30_34 "30-34  years old"
label variable btwn35_39 "35-39 years old"
label variable btwn40_44 "40-44 years old"
label variable btwn45_49 "45-49 years old"
label variable btwn50_54 "50-54 years old"

foreach i in less_15 btwn15_19 btwn20_24 btwn25_29 btwn30_34 btwn35_39 btwn40_44 btwn45_49 btwn50_54 {
tab `i' mager9, mi
}

* Paternal Charactersitics
*********************************
* Father's age
tab fagerec11, mi
label variable fagerec11 "Paternal age"
replace fagerec11 = . if fagerec11 == 11
label define fagerec11 1 "<15 years" 2 "15-19 years" 3 "20-24 years" 4 "25-29 years" 5 "30-34 years" 6 "35-39 years" 7 "40-44 years" 8 "45-49 years" 9 "50-54 years" 10 "55-98 years"
label values fagerec11 fagerec11
label variable fagerec11 "Paternal age"
tab fagerec11, mi

/// Please adjust and create dummy variables starting with the missing category
// corrected
* dummy for father's age
foreach i in f_less_15 f_btwn15_19 f_btwn20_24 f_btwn25_29 f_btwn30_34 f_btwn35_39 f_btwn40_44 f_btwn45_49 f_btwn50_54 f_btwn55_98 {
gen `i' = .
}
replace f_less_15 = 1 if fagerec11 == 1
replace f_btwn15_19 = 1 if fagerec11 == 2
replace f_btwn20_24 = 1 if fagerec11 == 3
replace f_btwn25_29 = 1 if fagerec11 == 4
replace f_btwn30_34 = 1 if fagerec11 == 5
replace f_btwn35_39 = 1 if fagerec11 == 6
replace f_btwn40_44 = 1 if fagerec11 == 7
replace f_btwn45_49 = 1 if fagerec11 == 8
replace f_btwn50_54 = 1 if fagerec11 == 9
replace f_btwn55_98 = 1 if fagerec11 == 10

foreach i in f_less_15 f_btwn15_19 f_btwn20_24 f_btwn25_29 f_btwn30_34 f_btwn35_39 f_btwn40_44 f_btwn45_49 f_btwn50_54 f_btwn55_98 {
replace `i' = 0 if `i' != 1 & fagerec11 != .
}

label variable f_less_15 "<15 years old"
label variable f_btwn15_19 "15-19 years old"
label variable f_btwn20_24 "20-24 years old"
label variable f_btwn25_29 "25-29 years old"
label variable f_btwn30_34 "30-34  years old"
label variable f_btwn35_39 "35-39 years old"
label variable f_btwn40_44 "40-44 years old"
label variable f_btwn45_49 "45-49 years old"
label variable f_btwn50_54 "50-54 years old"
label variable f_btwn55_98 "55-98 years old"

foreach i in f_less_15 f_btwn15_19 f_btwn20_24 f_btwn25_29 f_btwn30_34 f_btwn35_39 f_btwn40_44 f_btwn45_49 f_btwn50_54 f_btwn55_98 {
tab `i' fagerec11, mi
}

* Married
label define dmar 1 "Married" 2 "Unmarried"
label value dmar dmar
tab dmar, mi
*
foreach i in married unmarried {
gen `i' = .
}

replace married = 1 if dmar == 1
replace unmarried = 1 if dmar == 2

foreach i in married unmarried {
replace `i' = 0 if `i' != 1 & dmar != .
}

foreach i in married unmarried {
tab `i' dmar, mi
}

* Maternal education
*********************
tab meduc, mi
gen meduc_sim = .
replace meduc_sim = 1 if meduc <3
replace meduc_sim = 2 if meduc == 3 & meduc != .
replace meduc_sim = 3 if meduc == 4 & meduc != .
replace meduc_sim = 4 if meduc == 5 & meduc != .
replace meduc_sim = 5 if meduc == 6 & meduc != .
replace meduc_sim = 6 if meduc == 7 & meduc != .
replace meduc_sim = 7 if meduc == 8 & meduc != .
replace meduc_sim = . if meduc == 9
lab var meduc_sim "Maternal Education"
label define meduc_sim 1 "<12 years" 2 "High school graduate or GED completed" 3 "Some College" 4 "Associate degree" 5 "Bachelor's degree" 6 "Master's degree" 7 "Doctorate or Professional Degree" 
label values meduc_sim meduc_sim
tab meduc_sim, mi
tab meduc meduc_sim, mi


// Please adjust and create dummy variables starting with the missing category
//corrected 
foreach i in m_nonhsgrad m_hsgrad m_somecollege m_assocdeg m_bachdeg m_mastdeg m_docdeg {
gen `i' = .
}

replace m_nonhsgrad = 1 if meduc_sim == 1
replace m_hsgrad = 1 if meduc_sim == 2
replace m_somecollege = 1 if meduc_sim == 3
replace m_assocdeg = 1 if meduc_sim == 4
replace m_bachdeg = 1 if meduc_sim == 5
replace m_mastdeg = 1 if meduc_sim == 6
replace m_docdeg = 1 if meduc_sim == 7

foreach i in m_nonhsgrad m_hsgrad m_somecollege m_assocdeg m_bachdeg m_mastdeg m_docdeg {
replace `i' = 0 if `i' != 1 & meduc_sim != .
}

label variable m_nonhsgrad "Non high school graduate"
label variable m_hsgrad "High school graduate"
label variable m_somecollege "Some College"
label variable m_assocdeg "Associate degree"
label variable m_bachdeg "Bachelor's degree"
label variable m_mastdeg "Master's degree"
label variable m_docdeg "Doctorate"

foreach i in m_nonhsgrad m_hsgrad m_somecollege m_assocdeg m_bachdeg m_mastdeg m_docdeg {
tab `i' meduc_sim, mi
}

* Paternal Education 
************************
tab feduc, mi
gen feduc_sim = .
replace feduc_sim = 1 if feduc <3 & feduc != .
replace feduc_sim = 2 if feduc == 3 & feduc != .
replace feduc_sim = 3 if feduc == 4 & feduc != .
replace feduc_sim = 4 if feduc == 5 & feduc != .
replace feduc_sim = 5 if feduc == 6 & feduc != .
replace feduc_sim = 6 if feduc == 7 & feduc != .
replace feduc_sim = 7 if feduc == 8 & feduc != .
replace feduc_sim = . if feduc == 9
lab var feduc_sim "Paternal Education"
label define feduc_sim 1 "<12 years" 2 "High school graduate or GED completed" 3 "Some College" 4 "Associate degree" 5 "Bachelor's degree" 6 "Master's degree" 7 "Doctorate or Professional Degree" 
label values feduc_sim feduc_sim
tab feduc_sim, mi
tab feduc feduc_sim, mi

// Please adjust and create dummy variables starting with the missing category
// corrected
foreach i in f_nonhsgrad f_hsgrad f_somecollege f_assocdeg f_bachdeg f_mastdeg f_docdeg {
gen `i' = .
}

replace f_nonhsgrad = 1 if feduc_sim == 1
replace f_hsgrad = 1 if feduc_sim == 2
replace f_somecollege = 1 if feduc_sim == 3
replace f_assocdeg = 1 if feduc_sim == 4
replace f_bachdeg = 1 if feduc_sim == 5
replace f_mastdeg = 1 if feduc_sim == 6
replace f_docdeg = 1 if feduc_sim == 7

foreach i in f_nonhsgrad f_hsgrad f_somecollege f_assocdeg f_bachdeg f_mastdeg f_docdeg {
replace `i' = 0 if `i' != 1 & feduc_sim != .
}

label variable f_nonhsgrad "Non high school graduate"
label variable f_hsgrad "High school graduate"
label variable f_somecollege "Some College"
label variable f_assocdeg "Associate degree"
label variable f_bachdeg "Bachelor's degree"
label variable f_mastdeg "Master's degree"
label variable f_docdeg "Doctorate"

foreach i in f_nonhsgrad f_hsgrad f_somecollege f_assocdeg f_bachdeg f_mastdeg f_docdeg {
tab `i' feduc_sim, mi
}

* Child gender
************************
tab sex, mi
gen childgender = .
replace childgender = 1 if sex == "F"
replace childgender = 2 if sex == "M"
label define childgender 1 "Female" 2 "Male"
label values childgender childgender
tab childgender, mi


// Please adjust and create dummy variables starting with the missing category
// corrected
foreach i in m_gender f_gender {
gen `i' = .
}
replace f_gender = 1 if childgender == 1
replace m_gender = 1 if childgender == 2

foreach i in m_gender f_gender {
replace `i' = 0 if `i' != 1 & childgender != .
}

label variable f_gender "Female"
label variable m_gender "Male"

foreach i in m_gender f_gender {
tab `i' childgender, mi
}

//Ethnicity & immigrant status
tab mracehisp, mi
replace mracehisp = . if mracehisp == 8
label define mracehisp 1 "NH White" 2 "NH Black" 3 "NH American Indian or Alaskan Native" 4 "NH Asian" 5 "NH Native Hawaiian or Pacific Islander" 6 "NH More than one" 7 "Hispanic"
label value mracehisp mracehisp
tab mracehisp, mi

// var to include US possessions/territories
tab mbstate_rec, mi
replace mbstate_rec = . if mbstate_rec == 3
tab mbstate, mi
gen mb_possessions = .
replace mb_possessions = 0 if (mbstate != "GU" & mbstate != "PR" & mbstate != "VI" & mbstate != "AS" & mbstate != "MP")
replace mb_possessions = 1 if (mbstate == "GU" | mbstate == "PR" | mbstate == "VI" | mbstate == "AS" | mbstate == "MP")
replace mb_possessions = . if (mbstate== "ZZ" | mbstate== "XX")
label variable mb_possessions "Mother born in US Possessions not incl. States"
label define mb_possessions 0 "Not US Possessions" 1 "US Possessions"
label values mb_possessions mb_possessions
tab mb_possessions, mi
tab mb_possessions mbstate_rec, mi

// Mother's residence in US possessions variable
tab mrstatepstl, mi
tab mrstatepstl mbstate_rec, mi
gen mr_possessions = .
replace mr_possessions = 0 if (mrstatepstl != "GU" | mrstatepstl != "PR" | mrstatepstl != "VI" | mrstatepstl != "AS" | mrstatepstl != "MP")
replace mr_possessions = 1 if (mrstatepstl == "GU" | mrstatepstl == "PR" | mrstatepstl == "VI" | mrstatepstl == "AS" | mrstatepstl == "MP")
replace mr_possessions = . if (mrstatepstl == "ZZ" | mrstatepstl == "XX")
label variable mr_possessions "Mother Resides in US possessions not incl. 50 states"
label define mr_possessions 0 "Not US Possessions" 1 "US possessions"
label values mr_possessions mr_possessions
tab mr_possessions, mi

// I'm not sure this code is correct. The zero category includes individuals originally coded as missing
// corrected
* vars for immigration
foreach i in immigrant native /* possessions/territories */ {
gen `i' = .
}
replace native = 1 if mbstate_rec == 1 & mb_possessions == 0
replace immigrant = 1 if mbstate_rec == 2 & mb_possessions == 0

foreach i in immigrant native /* possessions/territories */ {
replace `i' = 0 if `i' != 1 & mbstate_rec != . & mb_possessions != .
}
tab immigrant mb_possessions, mi
tab native mb_possessions, mi

gen non_im_race = .
replace non_im_race = 1 if mracehisp == 1 & immigrant == 0 & native == 1
replace non_im_race = 2 if mracehisp == 2 & immigrant == 0 & native == 1
replace non_im_race = 3 if mracehisp == 3 & immigrant == 0 & native == 1
replace non_im_race = 4 if mracehisp == 4 & immigrant == 0 & native == 1
replace non_im_race = 5 if mracehisp == 5 & immigrant == 0 & native == 1
replace non_im_race = 6 if mracehisp == 6 & immigrant == 0 & native == 1
replace non_im_race = 7 if mracehisp == 7 & immigrant == 0 & native == 1
label define non_im_race 1 "NH White US-Born" 2 "NH Black US-Born" 3 "NH AIAN US-Born" 4 "NH Asian US-Born" 5 "NH NHOPI US-Born" 6 "NH more than one race US-Born" 7 "Hispanic US-Born"
label values non_im_race non_im_race
tab non_im_race, mi

gen im_race = .
replace im_race = 1 if mracehisp == 1 & immigrant == 1 & native == 0
replace im_race = 2 if mracehisp == 2 & immigrant == 1 & native == 0
replace im_race = 3 if mracehisp == 3 & immigrant == 1 & native == 0
replace im_race = 4 if mracehisp == 4 & immigrant == 1 & native == 0
replace im_race = 5 if mracehisp == 5 & immigrant == 1 & native == 0
replace im_race = 6 if mracehisp == 6 & immigrant == 1 & native == 0
replace im_race = 7 if mracehisp == 7 & immigrant == 1 & native == 0
label define im_race 1 "NH White Foreign Born" 2 "NH Black Foreign Born" 3 "NH AIAN Foreign Born" 4 "NH Asian Foreign Born" 5 "NH NHOPI Foreign Born" 6 "NH more than one race Foreign Born" 7 "Hispanic Foreign Born"
label values im_race im_race
tab im_race, mi

gen poss_race = .
replace poss_race = 1 if mracehisp == 1 & mb_possessions == 1
replace poss_race = 2 if mracehisp == 2 & mb_possessions == 1
replace poss_race = 3 if mracehisp == 3 & mb_possessions == 1
replace poss_race = 4 if mracehisp == 4 & mb_possessions == 1
replace poss_race = 5 if mracehisp == 5 & mb_possessions == 1
replace poss_race = 6 if mracehisp == 6 & mb_possessions == 1
replace poss_race = 7 if mracehisp == 7 & mb_possessions == 1
label define poss_race 1 "NH White US-Territory" 2 "NH Black US-Territory" 3 "NH AIAN US-Territory" 4 "NH Asian US-Territory" 5 "NH NHOPI US-Territory" 6 "NH more than one race US-Territory" 7 "Hispanic US-Territory"
label values poss_race poss_race
tab poss_race, mi

* generate header vars
gen dumRF = 1 if non_im_race == 1
replace dumRF = 2 if im_race == 1
replace dumRF = 3 if poss_race == 1
replace dumRF = 4 if non_im_race == 2
replace dumRF = 5 if im_race == 2
replace dumRF = 6 if poss_race == 2
replace dumRF = 7 if non_im_race == 3
replace dumRF = 8 if im_race == 3
replace dumRF = 9 if poss_race == 3
replace dumRF = 10 if non_im_race == 4
replace dumRF = 11 if im_race == 4
replace dumRF = 12 if poss_race == 4
replace dumRF = 13 if non_im_race == 5
replace dumRF = 14 if im_race == 5
replace dumRF = 15 if poss_race == 5
replace dumRF = 16 if non_im_race == 6
replace dumRF = 17 if im_race == 6
replace dumRF = 18 if poss_race == 6
replace dumRF = 19 if non_im_race == 7
replace dumRF = 20 if im_race == 7
replace dumRF = 21 if poss_race == 7

label define dumRF 1 "NH White US-Born" 2 "NH White Foreign Born" 3 "NH White US-Territory" 4 "NH Black US-Born" 5 "NH Black Foreign Born" 6 "NH Black US-Territory" 7 "AIAN US-Born" 8 "AIAN Foreign Born" 9 "NH AIAN US-Territory" 10 "NH Asian US-Born" 11 "NH Asian Foreign Born" 12 "NH Asian US-Territory" 13 "NH NHOPI US-Born" 14 "NH NHOPI Foreign Born" 15 "NH NHOPI US-Territory" 16 "NH more than one race US-Born" 17 "NH more than one race Foreign Born" 18 "NH more than one race US-Territory" 19 "Hispanic US-Born" 20 "Hispanic Foreign Born" 21 "Hispanic US-Territory"
label values dumRF dumRF
label variable dumRF "Race Nativity"
tab dumRF, mi


// Please adjust and create dummy variables starting with the missing category
// corrected
* race dummy
foreach i in nat_nhwhite for_nhwhite poss_nhwhite nat_nhblack for_nhblack poss_nhblack nat_aian for_aian poss_aian nat_nhasian for_nhasian poss_nhasian nat_nhnhopi for_nhnhopi poss_nhnhopi nat_mtor for_mtor poss_mtor nat_his for_his poss_his {
gen `i' = .
}

replace nat_nhwhite = 1 if non_im_race == 1
replace for_nhwhite = 1 if im_race == 1
replace poss_nhwhite = 1 if poss_race == 1
replace nat_nhblack = 1 if non_im_race == 2
replace for_nhblack = 1 if im_race == 2
replace poss_nhblack = 1 if poss_race == 2
replace nat_aian = 1 if non_im_race == 3
replace for_aian = 1 if im_race == 3
replace poss_aian = 1 if poss_race == 3
replace nat_nhasian = 1 if non_im_race == 4
replace for_nhasian = 1 if im_race == 4
replace poss_nhasian = 1 if poss_race == 4
replace nat_nhnhopi = 1 if non_im_race == 5
replace for_nhnhopi = 1 if im_race == 5
replace poss_nhnhopi = 1 if poss_race == 5
replace nat_mtor = 1 if non_im_race == 6
replace for_mtor = 1 if im_race == 6
replace poss_mtor = 1 if poss_race == 6
replace nat_his = 1 if non_im_race == 7
replace for_his = 1 if im_race == 7
replace poss_his = 1 if poss_race == 7

// foreach i in nat_nhwhite for_nhwhite poss_nhwhite nat_nhblack for_nhblack poss_nhblack nat_aian for_aian poss_aian nat_nhasian for_nhasian poss_nhasian nat_nhnhopi for_nhnhopi poss_nhnhopi nat_mtor for_mtor poss_mtor nat_his for_his poss_his {
// replace `i' = 0 if `i' != 1 & non_im_race != . & im_race != . & poss_race != .
// }

foreach i in nat_nhwhite nat_nhblack nat_aian nat_nhasian nat_nhnhopi nat_mtor nat_his {
replace `i' = 0 if `i' != 1 & non_im_race != .
}
foreach i in for_nhwhite for_nhblack for_aian for_nhasian for_nhnhopi for_mtor for_his {
replace `i' = 0 if `i' != 1 & im_race != .
}
foreach i in poss_nhwhite poss_nhblack poss_aian poss_nhasian poss_nhnhopi poss_mtor poss_his {
replace `i' = 0 if `i' != 1 & poss_race != .
}

foreach i in nat_nhwhite for_nhwhite poss_nhwhite nat_nhblack for_nhblack poss_nhblack nat_aian for_aian poss_aian nat_nhasian for_nhasian poss_nhasian nat_nhnhopi for_nhnhopi poss_nhnhopi nat_mtor for_mtor poss_mtor nat_his for_his poss_his {
tab dumRF `i' , mi
}

// Please adjust and create dummy variables starting with the missing category
// corrected
*Maternal race/foreign-born status
*************************************
tab mracehisp, mi
tab immigrant, mi
tab mb_possessions, mi
foreach i in mnh_white mnh_black m_hispanic mnh_asian m_fborn m_poss{
gen `i' = .
}

replace mnh_white = 1 if mracehisp == 1
replace mnh_black = 1 if mracehisp == 2
replace m_hispanic = 1 if mracehisp == 7
replace mnh_asian = 1 if mracehisp == 4
replace m_fborn = 1 if immigrant == 1
replace m_poss = 1 if mb_possessions == 1

foreach i in mnh_white mnh_black m_hispanic mnh_asian m_fborn m_poss{
replace `i' = 0 if `i' != 1 & mracehisp != . & immigrant != . & mb_possessions != .
}

label variable mnh_white "Mother NH white"
label variable mnh_black "Mother NH black"
label variable m_hispanic "Mother Hispanic"
label variable mnh_asian "Mother NH Asian"
label variable m_fborn "Mother foreign-born"
label variable m_poss "Mother born in US-Territory"

foreach i in mnh_white mnh_black m_hispanic mnh_asian m_fborn m_poss{
tab immigrant `i', mi
}

gen raceth = .
replace raceth = 1 if mnh_white  == 1
replace raceth = 2 if mnh_black  == 1
replace raceth = 3 if m_hispanic == 1
replace raceth = 4 if mnh_asian  == 1
replace raceth = 5 if m_fborn == 1
replace raceth = 6 if m_poss == 1
label define raceth 1 "NH White" 2 "NH Black" 3 "Hispanic" 4 "NH Asian" 5 "Foreign Born" 6 "US-Territory"
label values raceth raceth

foreach i in mnh_white mnh_black m_hispanic mnh_asian m_fborn m_poss {
tab `i' mracehisp, mi
tab `i' immigrant, mi
tab `i' mb_possessions, mi
}

* Region of infant birth
***************************
tab ostate, mi
gen oregion = .
replace oregion = 1 if ostate == "ME" | ostate == "VT" | ostate == "MA" | ostate == "NH" | ostate =="CT" | ostate == "RI" | ostate == "NY" | ostate =="NJ" | ostate == "PA"
replace oregion = 2 if ostate == "OH" | ostate =="MI" | ostate =="IN" | ostate =="IL" | ostate =="WI" | ostate =="MN" | ostate == "IA" | ostate =="MO"  | ostate == "KS" | ostate =="NE" | ostate =="SD" | ostate =="ND"
replace oregion = 3 if ostate =="DE" | ostate =="MD" | ostate =="DC" | ostate == "VA" | ostate =="WV" | ostate == "NC" | ostate =="SC" | ostate =="GA" | ostate =="FL" | ostate == "KY" | ostate =="TN" | ostate =="MS" | ostate =="AL" | ostate == "AR" | ostate == "LA" | ostate =="TX" | ostate =="OK" 
replace oregion = 4 if ostate =="MT" |ostate =="WY" |ostate == "CO" | ostate =="NM" | ostate =="AZ" | ostate == "UT" | ostate =="ID" | ostate =="NV" | ostate =="WA" | ostate =="OR"|ostate =="CA" |ostate =="AK" | ostate =="HI" 
replace oregion = 5 if mr_possessions == 1

tab oregion, mi 
label variable oregion "Birth Occurrence Region"
label define oregion   1 "Northeast" 2 "Midwest" 3 "South" 4 "West" 5 "Possession/Territory"
label values oregion oregion
tab oregion, mi

/// Please start with the missing category

* oregion dummy
gen oreg_northeast = .
replace oreg_northeast = 1 if oregion == 1
replace oreg_northeast = 0 if oregion != 1 & oregion != .
label variable oreg_northeast "Northeast"
tab oreg_northeast oregion, mis

gen oreg_midwest = .
replace oreg_midwest = 1 if oregion == 2
replace oreg_midwest = 0 if oregion != 2 & oregion != .
label variable oreg_midwest "Midwest"
tab oreg_midwest oregion, mis

gen oreg_south = .
replace oreg_south = 1 if oregion == 3
replace oreg_south = 0 if oregion != 3 & oregion != .
label variable oreg_south "South"
tab oreg_south oregion, mis

gen oreg_west = .
replace oreg_west = 1 if oregion == 4 
replace oreg_west = 0 if oregion != 4 & oregion != .
label variable oreg_west "West"
tab oreg_west oregion, mis

* possesions & territories

// helper var for mother's birth region (used later)
gen mbregion = .
replace mbregion = 1 if mbstate == "ME" | mbstate == "VT" | mbstate == "MA" | mbstate == "NH" | mbstate =="CT" | mbstate == "RI" | mbstate == "NY" | mbstate =="NJ" | mbstate == "PA"
replace mbregion = 2 if mbstate == "OH" | mbstate =="MI" | mbstate =="IN" | mbstate =="IL" | mbstate =="WI" | mbstate =="MN" | mbstate == "IA" | mbstate =="MO"  | mbstate == "KS" | mbstate =="NE" | mbstate =="SD" | mbstate =="ND"
replace mbregion = 3 if mbstate =="DE" | mbstate =="MD" | mbstate =="DC" | mbstate == "VA" | mbstate =="WV" | mbstate == "NC" | mbstate =="SC" | mbstate =="GA" | mbstate =="FL" | mbstate == "KY" | mbstate =="TN" | mbstate =="MS" | mbstate =="AL" | mbstate == "AR" | mbstate == "LA" | mbstate =="TX" | mbstate =="OK" 
replace mbregion = 4 if mbstate =="MT" | mbstate =="WY" | mbstate == "CO" | mbstate =="NM" | mbstate =="AZ" | mbstate == "UT" | mbstate =="ID" | mbstate =="NV" | mbstate =="WA" | mbstate =="OR"| mbstate =="CA" | mbstate =="AK" | mbstate =="HI" 
replace mbregion = 5 if mbstate == "GU" | mbstate == "PR" | mbstate == "VI" | mbstate == "AS" | mbstate == "MP"

tab mbregion, mi 

label variable mbregion "Mother's Birth Region"
label define mbregion   1 "Northeast" 2 "Midwest" 3 "South" 4 "West" 5 "Possession/Territory"
label values mbregion mbregion
tab mbregion, mi

//helper var for mother's residential region
gen resregion = . 
replace resregion = . if mrstatepstl == "ZZ"
replace resregion = 1 if mrstatepstl == "ME" | mrstatepstl == "VT" | mrstatepstl == "MA" | mrstatepstl == "NH" | mrstatepstl =="CT" | mrstatepstl == "RI" | mrstatepstl == "NY" | mrstatepstl =="NJ" | mrstatepstl == "PA"
replace resregion = 2 if mrstatepstl == "OH" | mrstatepstl =="MI" | mrstatepstl =="IN" | mrstatepstl =="IL" | mrstatepstl =="WI" | mrstatepstl =="MN" | mrstatepstl == "IA" | mrstatepstl =="MO"  | mrstatepstl == "KS" | mrstatepstl =="NE" | mrstatepstl =="SD" | mrstatepstl =="ND"
replace resregion = 3 if mrstatepstl =="DE" | mrstatepstl =="MD" | mrstatepstl =="DC" | mrstatepstl == "VA" | mrstatepstl =="WV" | mrstatepstl == "NC" | mrstatepstl =="SC" | mrstatepstl =="GA" | mrstatepstl =="FL" | mrstatepstl == "KY" | mrstatepstl =="TN" | mrstatepstl =="MS" | mrstatepstl =="AL" | mrstatepstl == "AR" | mrstatepstl == "LA" | mrstatepstl =="TX" | mrstatepstl =="OK" 
replace resregion = 4 if mrstatepstl =="MT" | mrstatepstl =="WY" | mrstatepstl == "CO" | mrstatepstl =="NM" | mrstatepstl =="AZ" | mrstatepstl == "UT" | mrstatepstl =="ID" | mrstatepstl =="NV" | mrstatepstl =="WA" | mrstatepstl =="OR"| mrstatepstl =="CA" | mrstatepstl =="AK" | mrstatepstl =="HI" 
replace resregion = 5 if mrstatepstl == "GU" | mrstatepstl == "PR" | mrstatepstl == "VI" | mrstatepstl == "AS" | mrstatepstl == "MP"

tab resregion, mi 

label variable resregion "Mother's Residential Region"
label define resregion   1 "Northeast" 2 "Midwest" 3 "South" 4 "West" 5 "Possession/Territory"
label values resregion resregion
tab resregion, mi

* Mobility 
******************
//var for foreign-born (the mother is born outside the US and gives birth in the US)
tab mbcntry, mi
tab mrcntry, mi
gen mob_fborn = .
replace mob_fborn = 0 if (mbcntry == "US" | mb_possessions == 1)
replace mob_fborn = 1 if (mbcntry != "US" & mb_possessions != 1)
replace mob_fborn = . if mbcntry == "ZZ"
label define mob_fborn 1 "foreign-born"
label values mob_fborn mob_fborn
label variable mob_fborn "Foreign-Born"
tab mob_fborn, mi

* var for outside-region (mother's place of birth in one US region and delivers in another US region)
tab mbregion, mi
tab resregion, mi
gen mob_region = .
replace mob_region = 0 if mbregion == resregion & immigrant == 0
replace mob_region = 1 if mbregion != resregion & immigrant == 0
tab mob_region, mi
label variable mob_region "Different Region Birth"

* var for within-region (mother's place of birth in one US region and delivers in a different state in the same US region)
gen mob_wregion = .
replace mob_wregion = 0 if (mbregion != resregion) | (mbstate == mrstatepstl) & immigrant == 0
replace mob_wregion = 1 if (mbregion == resregion) & (mbstate != mrstatepstl) & immigrant == 0
tab mob_wregion, mi
label variable mob_wregion "Same Region Birth"

* var for across-state (mother's place of birth and delivery are in the same US state)
tab mbstate, mi
tab mrstate, mi
gen mob_acr_state = .
replace mob_acr_state = 0 if mbstate != mrstatepstl & immigrant == 0
replace mob_acr_state = 1 if mbstate == mrstatepstl & immigrant == 0
tab mob_acr_state, mi
label variable mob_acr_state "Same State Birth"


//section for maternal place of birth for foreign born
tab mbcntry if mbcntry != "ZZ" & mbcntry != "AY" & mbcntry != "BS" & mbcntry != "EQ" & mbcntry != "FS" & mbcntry != "FT" & mbcntry != "GI" & mbcntry != "IP" & mbcntry != "IW" & mbcntry != "JQ" & mbcntry != "KT" & mbcntry != "KV" & mbcntry != "LS" & mbcntry != "MJ" & mbcntry != "MQ" & mbcntry != "NE" & mbcntry != "NF" & mbcntry != "NH" & mbcntry != "NN" & mbcntry != "OD" & mbcntry != "RH" & mbcntry != "RI" & mbcntry != "RN" & mbcntry != "SK" & mbcntry != "SV" & mbcntry != "SX" & mbcntry != "UG" & mbcntry != "WB" & mbcntry != "UC", generate(c)

rename (c1 c2 c3 c4 c5 c6 c7 c8 c9 c10 c11 c12 c13 c14 c15 c16 c17 c18 c19 c20 c21 c22 c23 c24 c25 c26 c27 c28 c29 c30 c31 c32 c33 c34 c35 c36 c37 c38 c39 c40 c41 c42 c43 c44 c45 c46 c47 c48 c49 c50 c51 c52 c53 c54 c55 c56 c57 c58 c59 c60 c61 c62 c63 c64 c65 c66 c67 c68 c69 c70 c71 c72 c73 c74 c75 c76 c77 c78 c79 c80 c81 c82 c83 c84 c85 c86 c87 c88 c89 c90 c91 c92 c93 c94 c95 c96 c97 c98 c99 c100 c101 c102 c103 c104 c105 c106 c107 c108 c109 c110 c111 c112 c113 c114 c115 c116 c117 c118 c119 c120 c121 c122 c123 c124 c125 c126 c127 c128 c129 c130 c131 c132 c133 c134 c135 c136 c137 c138 c139 c140 c141 c142 c143 c144 c145 c146 c147 c148 c149 c150 c151 c152 c153 c154 c155 c156 c157 c158 c159 c160 c161 c162 c163 c164 c165 c166 c167 c168 c169 c170 c171 c172 c173 c174 c175 c176 c177 c178 c179 c180 c181 c182 c183 c184 c185 c186 c187 c188 c189 c190 c191 c192 c193 c194 c195 c196 c197 c198 c199 c200 c201 c202 c203 c204 c205 c206 c207 c208 c209 c210 c211 c212 c213 c214 c215 c216 c217 c218 c219 c220 c221 c222 c223 c224 c225 c226 c227 c228 c229 c230 c231 c232 c233 c234 c235 c236 c237 c238 c239 c240 c241) (Aruba Antigua_Barbuda UnitedArabEmirates Afghanistan Algeria Azerbaijan Albania Armenia Andorra Angola Argentina Australia Austria Anguilla Bahrain Barbados Botswana Bermuda Belgium TheBahamas Bangladesh Belize Bosnia_Herzegovina Bolivia Burma Benin Belarus Solomon_Islands Brazil Bhutan Bulgaria Brunei Burundi Canada Cambodia Chad SriLanka Congo_Brazzaville Congo_Kinshasa China Chile Cayman_Islands Cameroon Comoros Colombia CoralSea_Islands CostaRica CentralAfricanRepublic Cuba CapeVerde Cook_Islands Cyprus Czechoslovakia Denmark Djibouti Dominica DominicanRepublic EastBerlin Ecuador Egypt Ireland EquatorialGuinea Estonia Eritrea ElSalvador Ethiopia Europa_Island CzechRepublic FrenchGuiana Finland Fiji Falkland_Islands FederatedStates_Micronesia Faroe_Islands FrenchPolynesia France TheGambia Gabon EastGermany WestGermany Georgia Ghana Grenada Guernsey Greenland Germany GilbertEllice_Islands Guadeloupe Greece Guatemala Guinea Guyana GazaStrip Haiti HongKong Heard_Island_Mcdonald_Islands Honduras Croatia Hungary Iceland Indonesia IsleofMan India Brit_IndianOcean_VI USPacific_Islands Iran Israel Italy CoteDivoire Iraq Japan Jersey Jamaica Jordan Kenya Kyrgyzstan NorthKorea Kiribati SouthKorea Kuwait Kazakhstan Laos Lebanon Latvia Lithuania Liberia Slovakia Lesotho Luxembourg Libya Madagascar Martinique Macau Moldova Mayotte Mongolia Montserrat Malawi Macedonia Mali Monaco Morocco Mauritius Mauritania Malta Oman Maldives Mexico Malaysia Mozambique NA_NoName NewCaledonia Niger Nigeria NetherlandsEtc Norway Nepal Nauru Suriname NetherlandsAntilles Nicaragua NewZealand Paraguay Peru Pakistan Poland Panama Panama_old Portugal PapuaNewGuinea PanamaCanalZone Palau GuineaBissau Qatar Reunion Marshall_Islands Romania Philippines Russia Rwanda SaudiArabia Nevis Seychelles SouthAfrica Senegal SaintHelena Slovenia SierraLeone SanMarino Singapore Somalia Spain SpanishSahara SaintLucia Sudan Sweden  Syria Switzerland UnitedArabEmirates_old Trinidad_Tobago Thailand Tajikistan Turks_Caicos_Islands Tonga Togo SaoTome_Principe TT_ThePacific_Islands Tunisia EastTimor Turkey Tuvalu Taiwan Turkmenistan Tanzania UK Ukraine SovietUnion UnitedStates BurkinaFaso Uruguay Uzbekistan StVincent_Grenadines Venezuela BritishVirgin_Islands Vietnam NorthVietnam SouthVietnam VaticanCity Namibia WestBank Wake_Islands Samoa Swaziland YemenSanaa Yugoslavia Yemen YO_NoName YemenAden YY_NoCode Zambia Zimbabwe)


// Please start with the missing category
// corrected
//Table 1 beginning
foreach i in usstates namerica centamerica mexico haiti cuba domrep nevis wake_islands caribbean eng_speak_carib span_speak_carib samerica hispplaces {
gen `i' = .
}

replace usstates = 1 if UnitedStates == 1
replace namerica = 1 if (Canada == 1 | Bermuda == 1 | Falkland_Islands == 1 | Greenland == 1)
replace centamerica = 1 if (Belize == 1 | CostaRica == 1 | ElSalvador == 1 | Guatemala == 1 | Honduras == 1 | Nicaragua == 1 | Panama == 1 | PanamaCanalZone == 1 | Panama_old == 1)

replace mexico = 1 if Mexico == 1
replace haiti = 1 if Haiti == 1
replace cuba = 1 if Cuba == 1
replace domrep = 1 if DominicanRepublic == 1
replace nevis = 1 if Nevis == 1
replace wake_islands = 1 if Wake_Islands == 1

replace caribbean = 1 if (Jamaica == 1 | Anguilla == 1 | Antigua_Barbuda == 1 | TheBahamas == 1 | Barbados == 1 | BritishVirgin_Islands == 1 | Cayman_Islands == 1 | Dominica == 1 | Grenada == 1 | Montserrat == 1 | SaintLucia == 1 | StVincent_Grenadines == 1 | Trinidad_Tobago == 1 | Turks_Caicos_Islands == 1 | Aruba == 1 | NetherlandsAntilles == 1 | NetherlandsEtc == 1 | Guadeloupe == 1 | Martinique == 1 | Guyana == 1)

replace eng_speak_carib = 1 if (Jamaica == 1 | Anguilla == 1 | Antigua_Barbuda == 1 | TheBahamas == 1 | Barbados == 1 | Dominica == 1 | Grenada == 1 | SaintLucia == 1 | StVincent_Grenadines == 1 | Trinidad_Tobago == 1)

replace span_speak_carib = 1 if (Cuba == 1 | DominicanRepublic == 1)

replace samerica = 1 if (Argentina == 1 | Bolivia == 1 | Brazil == 1 | Chile == 1 | Colombia == 1 | Ecuador == 1 | FrenchGuiana == 1 | Paraguay == 1 | Peru == 1 | Suriname == 1 | Uruguay == 1 | Venezuela == 1)

replace hispplaces = 1 if (mexico == 1 | centamerica == 1 | samerica == 1)

foreach i in usstates namerica centamerica mexico haiti cuba domrep nevis wake_islands caribbean eng_speak_carib span_speak_carib samerica hispplaces {
replace `i' = 0 if `i' != 1 & (UnitedStates != . & Canada != . & Bermuda != . & Falkland_Islands != . & Greenland != . & Belize != . & CostaRica != . & ElSalvador != . & Guatemala != . & Honduras != . & Nicaragua != . & Panama != . & PanamaCanalZone != . & Panama_old != . & Mexico != . & Haiti != . & Cuba != . & DominicanRepublic != . & Nevis != . & Wake_Islands != . & Jamaica != . & Anguilla != . & Antigua_Barbuda != . & TheBahamas != . & Barbados != . & BritishVirgin_Islands != . & Cayman_Islands != . & Dominica != . & Grenada != . & Montserrat != . & SaintLucia != . & StVincent_Grenadines != . & Trinidad_Tobago != . & Turks_Caicos_Islands != . & Aruba != . & NetherlandsAntilles != . & NetherlandsEtc != . & Guadeloupe != . & Martinique != . & Guyana != . & Argentina != . & Bolivia != . & Brazil != . & Chile != . & Colombia != . & Ecuador != . & FrenchGuiana != . & Paraguay != . & Peru != . & Suriname != . & Uruguay != .)
}

foreach i in usstates namerica centamerica mexico haiti cuba domrep nevis wake_islands caribbean eng_speak_carib span_speak_carib samerica hispplaces {
tab `i', mi
}

label variable usstates "United States"
label variable namerica "Northern America"
label variable centamerica "Central America"
label variable haiti "Haiti"
label variable caribbean "Caribbean"
label variable eng_speak_carib "English Speaking Caribbean"
label variable span_speak_carib "Spanish Speaking Caribbean"
label variable samerica "South America"
label variable mexico "Mexico"
label variable cuba "Cuba"
label variable domrep "Dominican Republic"
label variable nevis "Nevis"
label variable wake_islands "Wake Islands"
label variable hispplaces "Mexico/Central America/South America"
//Table 1 conclusion

//Table 2 beginning
foreach i in neurope weurope seurope centeurope europe russemp {
gen `i' = .
}

replace neurope = 1 if (Denmark == 1 | Faroe_Islands == 1 | Iceland == 1 | Norway == 1 | Sweden == 1 | UK == 1 | Guernsey == 1 | Jersey == 1 | IsleofMan == 1 | Ireland == 1 | Finland == 1)

replace weurope = 1 if (Belgium == 1 | France == 1 | Luxembourg == 1 | Monaco == 1 | Switzerland == 1)

replace seurope = 1 if (Albania == 1 | Andorra == 1 | Greece == 1 | Macedonia == 1 | Italy == 1 | Malta == 1 | Portugal == 1 | CapeVerde == 1 | SanMarino == 1 | Spain == 1 | VaticanCity == 1)

replace centeurope = 1 if (Austria == 1 | Bulgaria == 1 | Czechoslovakia == 1 | Slovakia == 1 | CzechRepublic == 1 | Germany == 1 | EastBerlin == 1 | EastGermany == 1 | Hungary == 1 | Poland == 1 | Romania == 1 | Yugoslavia == 1 | Croatia == 1 | Slovenia | WestGermany == 1 | Bosnia_Herzegovina == 1 | Moldova == 1)

replace europe = 1 if (neurope == 1 | weurope == 1| seurope == 1 | centeurope == 1)

replace russemp = 1 if (Estonia == 1 | Latvia == 1 | Lithuania == 1 | Ukraine == 1 | Armenia == 1 | Azerbaijan == 1 | Kazakhstan == 1 | Turkmenistan == 1 | Uzbekistan == 1 | Belarus == 1 | Kyrgyzstan == 1 | Russia == 1 | SovietUnion == 1)

foreach i in neurope weurope seurope centeurope europe russemp {
replace `i' = 0 if `i' != 1 & Denmark != . & Faroe_Islands != . & Iceland != . & Norway != . & Sweden != . & UK != . & Guernsey != . & Jersey != . & IsleofMan != . & Ireland != . & Finland != . & Belgium != . & France != . & Luxembourg != . & Monaco != . & Switzerland != . & Albania != . & Andorra != . & Greece != . & Macedonia != . & Italy != . & Malta != . & Portugal != . & CapeVerde != . & SanMarino != . & Spain != . & VaticanCity != . & Australia != . & Bulgaria != . & Czechoslovakia != . & Slovakia != . & CzechRepublic != . & Germany != . & EastBerlin != . & EastGermany != . & Hungary != . & Poland != . & Romania != . & Yugoslavia != . & Croatia != . & Slovenia != . & WestGermany != . & Bosnia_Herzegovina != . & Moldova != . & Estonia != . & Latvia != . & Lithuania != . & Ukraine != . & Armenia != . & Azerbaijan != . & Kazakhstan != . & Turkmenistan != . & Uzbekistan != . & Belarus != . & Kyrgyzstan != . & Russia != . & SovietUnion != .
}

label variable neurope "Northern Europe"
label variable weurope "Western Europe"
label variable seurope "Southern Europe"
label variable centeurope "Central Europe"
label variable europe "Europe"
label variable russemp "Russian Empire"

foreach i in neurope weurope seurope centeurope europe russemp {
tab `i', mi
}
//Table 2 conclusion

//Table 3 beginning
foreach i in east_asia southeast_asia east_southeast_asia southwest_asia south_asia1 south_asia2 india india_sw_asia middle_east_asia {
gen `i' = .
}

replace east_asia = 1 if (China == 1 | HongKong == 1 | Macau == 1 | Mongolia == 1 | Taiwan == 1 | Japan == 1 | NorthKorea == 1 | SouthKorea == 1)
replace southeast_asia = (Brunei == 1 | Cambodia == 1 | Indonesia == 1 | EastTimor == 1 | Laos == 1 | Malaysia == 1 | Philippines == 1 | Singapore == 1 | Thailand == 1 | Vietnam == 1 | NorthVietnam == 1 | SouthVietnam == 1)

replace east_southeast_asia = 1 if (east_asia == 1 | southeast_asia == 1)
replace southwest_asia = 1 if (Bangladesh == 1 | Bhutan == 1 | Burma == 1 | Pakistan == 1 | SriLanka == 1 | Maldives == 1 | Nepal == 1)
replace south_asia1 = 1 if (Bangladesh == 1 | Bhutan == 1 | Burma == 1 | Pakistan == 1 | SriLanka == 1)
replace south_asia2 = 1 if (Afghanistan == 1 | Iran == 1 | Maldives == 1 | Nepal == 1)
replace india = 1 if India == 1
replace india_sw_asia = 1 if (india == 1 | southwest_asia == 1)

replace middle_east_asia = 1 if (Bahrain == 1 | Cyprus == 1 | Iraq == 1 | GazaStrip == 1 | WestBank == 1 | Jordan == 1 | Kuwait == 1 | Lebanon == 1 | Oman == 1 | Qatar == 1 | SaudiArabia == 1 | Syria == 1 | Turkey == 1 | UnitedArabEmirates == 1 | UnitedArabEmirates_old == 1 | YemenSanaa == 1 | Yemen == 1 | YemenAden == 1 | Iran == 1 | Afghanistan == 1 | Georgia == 1 | Israel == 1 | Tajikistan == 1)

foreach i in east_asia southeast_asia east_southeast_asia southwest_asia south_asia1 south_asia2 india india_sw_asia middle_east_asia {
replace `i' = 0 if `i' != 1 & China != . & HongKong != . & Macau != . & Mongolia != . & Taiwan != . & Japan != . & NorthKorea != . & SouthKorea != . & Brunei != . & Cambodia != . & Indonesia != . & EastTimor != . & Laos != . & Malaysia != . & Philippines != . & Singapore != . & Thailand != . & Vietnam != . & NorthVietnam != . & SouthVietnam != . & Bangladesh != . & Bhutan != . & Burma != . & Pakistan != . & SriLanka != . & Maldives != . & Nepal != . & Iran != . & Bahrain != . & Cyprus != . & Iraq != . & GazaStrip != . & WestBank != . & Jordan != . & Kuwait != . & Lebanon != . & Oman != . & Qatar != . & SaudiArabia != . & Syria != . & Turkey != . & UnitedArabEmirates != . & UnitedArabEmirates_old != . & YemenSanaa != . & Yemen != . & YemenAden != . & Georgia != . & Israel != . & Tajikistan != .
}

label variable east_asia "East Asia"
label variable southeast_asia "Southeast Asia"
label variable southwest_asia "Southwest Asia"
label variable east_southeast_asia "East/Southeast Asia"
label variable south_asia1 "South Asia"
label variable south_asia2 "South Asia Subdivision"
label variable india "India"
label variable india_sw_asia "India / Southwest Asia"
label variable middle_east_asia "Middle East Asia"

foreach i in east_asia southeast_asia east_southeast_asia southwest_asia south_asia1 south_asia2 india india_sw_asia middle_east_asia {
tab `i', mi
}
//Table 3 conclusion

//Table 4 beginning
foreach i in northern_africa nafrica_mideast west_africa east_africa central_africa southern_africa africa oceaniadum antarcticadum {
gen `i' = .
}

replace northern_africa = 1 if (Algeria == 1 | Egypt == 1 | Libya == 1 | Morocco == 1 | Sudan == 1 | Tunisia == 1 | SpanishSahara == 1)
replace nafrica_mideast = 1 if (northern_africa == 1 | middle_east_asia == 1)

replace west_africa = 1 if (Benin == 1 | BurkinaFaso == 1 | TheGambia == 1 | Ghana == 1 | Guinea == 1 | GuineaBissau == 1 | Liberia == 1 | Mali == 1 | Mauritania == 1 | Niger == 1 | Nigeria == 1 | Senegal == 1 | SierraLeone == 1 | Togo == 1 | CapeVerde == 1 | CoteDivoire == 1)

replace east_africa = 1 if (Brit_IndianOcean_VI == 1 | Burundi == 1 | Comoros == 1 | Djibouti == 1 | Ethiopia == 1 | Kenya == 1 | Madagascar == 1 | Malawi == 1 | Mauritius == 1 | Mozambique == 1 | Reunion == 1 | Rwanda == 1 | Seychelles == 1 | Somalia == 1 | Tanzania == 1 | Zambia == 1 | Zimbabwe == 1 | Europa_Island == 1 | Mayotte == 1 | Eritrea == 1)

replace central_africa = 1 if (Angola == 1 | Cameroon == 1 | CentralAfricanRepublic == 1 | Chad == 1 | Congo_Brazzaville == 1 |  Congo_Kinshasa == 1 | EquatorialGuinea == 1 | Gabon == 1 | SaoTome_Principe == 1)

replace southern_africa = 1 if (Botswana == 1 | Lesotho == 1 | Namibia == 1 | SouthAfrica == 1 | Swaziland == 1)
replace africa = (west_africa == 1 | east_africa == 1 | central_africa == 1 | southern_africa == 1)

replace oceaniadum = 1 if (Australia == 1 | CoralSea_Islands == 1 | NewZealand == 1 | USPacific_Islands == 1 | TT_ThePacific_Islands == 1 | NewCaledonia == 1 | PapuaNewGuinea == 1 | Solomon_Islands == 1 | Fiji == 1 | Cook_Islands == 1 | FrenchPolynesia == 1 | Tonga == 1 | Samoa == 1 | Tuvalu == 1 | Kiribati == 1 | Nauru == 1 | Marshall_Islands == 1 | FederatedStates_Micronesia == 1 | Palau == 1 | GilbertEllice_Islands == 1)

replace antarcticadum = 1 if Heard_Island_Mcdonald_Islands == 1

foreach i in northern_africa nafrica_mideast west_africa east_africa central_africa southern_africa africa oceaniadum antarcticadum {
replace `i' = 0 if `i' != 1 & Algeria != . & Egypt != . & Libya != . & Morocco != . & Sudan != . & Tunisia != . & SpanishSahara != . & Benin != . & BurkinaFaso != . & TheGambia != . & Ghana != . & Guinea != . & GuineaBissau != . & Liberia != . & Mali != . & Mauritania != . & Niger != . & Nigeria != . & Senegal != . & SierraLeone != . & Togo != . & CapeVerde != . & CoteDivoire != . & Brit_IndianOcean_VI != . & Burundi != . & Comoros != . & Djibouti != . & Ethiopia != . & Kenya != . & Madagascar != . & Malawi != . & Mauritius != . & Mozambique != . & Reunion != . & Rwanda != . & Seychelles != . & Somalia != . & Tanzania != . & Zambia != . & Zimbabwe != . & Europa_Island != . & Mayotte != . & Eritrea != . & Angola != . & Cameroon != . & CentralAfricanRepublic != . & Chad != . & Congo_Brazzaville != . & Congo_Kinshasa != . & EquatorialGuinea != . & Gabon != . & SaoTome_Principe != . & Botswana != . & Lesotho != . & Namibia != . & SouthAfrica != . & Swaziland != . & Australia != . & CoralSea_Islands != . & NewZealand != . & USPacific_Islands != . & TT_ThePacific_Islands != . & NewCaledonia != . & PapuaNewGuinea != . & Solomon_Islands != . & Fiji != . & Cook_Islands != . & FrenchPolynesia != . & Tonga != . & Samoa != . & Tuvalu != . & Kiribati != . & Nauru != . & Marshall_Islands != . & FederatedStates_Micronesia != . & Palau != . & GilbertEllice_Islands != . & Heard_Island_Mcdonald_Islands != .
}

label variable northern_africa "Northern Africa"
label variable nafrica_mideast "Northern Africa / Middle East"
label variable west_africa "West Africa"
label variable east_africa "East Africa"
label variable central_africa "Central Africa"
label variable southern_africa "Southern Africa"
label variable africa "Africa"
label variable oceaniadum "Oceania"
label variable antarcticadum "Antarctica"

foreach i in northern_africa nafrica_mideast west_africa east_africa central_africa southern_africa africa oceaniadum antarcticadum {
tab `i', mi 
}
//Table 4 conclusion

foreach i in usstates namerica centamerica samerica neurope weurope seurope centeurope russemp oceaniadum antarcticadum {
tab `i', mi
}

* Regression Model Catagorical Variables
gen places1_b = .
gen places2_b = .
gen places3_b = .
gen places4_b = .
			
replace places1_b = 1 if native == 1
replace places1_b = 2 if immigrant == 1
			
replace places2_b = 1 if native == 1
replace places2_b = 2 if caribbean == 1
replace places2_b = 3 if africa == 1
			
replace places3_b = 1 if native == 1
replace places3_b = 2 if haiti == 1
replace places3_b = 3 if eng_speak_carib == 1
replace places3_b = 4 if span_speak_carib == 1

replace places4_b = 1 if native == 1
replace places4_b = 2 if west_africa == 1
replace places4_b = 3 if east_africa == 1
replace places4_b = 4 if central_africa == 1
replace places4_b = 5 if southern_africa == 1

gen places1_w = .
gen places2_w = .
gen places3_w = .
gen places4_w = .
			
replace places1_w = 1 if native == 1
replace places1_w = 2 if immigrant == 1
			
replace places2_w = 1 if native == 1
replace places2_w = 2 if europe == 1
replace places2_w = 3 if nafrica_mideast == 1
replace places2_w = 4 if namerica == 1
replace places2_w = 5 if oceaniadum == 1
			
replace places3_w = 1 if native == 1
replace places3_w = 2 if neurope == 1
replace places3_w = 3 if weurope == 1
replace places3_w = 4 if seurope == 1
replace places3_w = 5 if centeurope == 1

replace places4_w = 1 if native == 1
replace places4_w = 2 if russemp == 1
replace places4_w = 3 if middle_east_asia == 1
replace places4_w = 4 if northern_africa == 1

gen places1_a = .
gen places2_a = .
gen places3_a = .
gen places4_a = .

replace places1_a = 1 if native == 1
replace places1_a = 2 if immigrant == 1

replace places2_a = 1 if native == 1
replace places2_a = 2 if east_southeast_asia == 1
replace places2_a = 3 if india_sw_asia == 1

replace places3_a = 1 if native == 1
replace places3_a = 2 if east_asia == 1
replace places3_a = 3 if southeast_asia == 1

replace places4_a = 1 if native == 1
replace places4_a = 2 if india == 1
replace places4_a = 3 if south_asia1 == 1
replace places4_a = 4 if south_asia2 == 1

gen places1_h = .
gen places2_h = .
gen places3_h = .
gen places4_h = .

replace places1_h = 1 if native == 1
replace places1_h = 2 if immigrant == 1

replace places2_h = 1 if native == 1
replace places2_h = 2 if hispplaces == 1
replace places2_h = 3 if span_speak_carib == 1

replace places3_h = 1 if native == 1
replace places3_h = 2 if mexico == 1
replace places3_h = 3 if centamerica == 1
replace places3_h = 4 if samerica == 1

replace places4_h = 1 if native == 1
replace places4_h = 2 if cuba == 1
replace places4_h = 3 if domrep == 1


* Prenatal behaviors/pregnancy characteristics
************************************************
tab precare5, mi
tab lbo_rec, mi
replace precare5 = . if precare5 == 5
replace lbo_rec = . if lbo_rec == 9
label define precare5 1 "1st trimester" 2 "2nd trimester" 3 "3rd trimester" 4 "No prenatal care"
label values precare5 precare5
tab precare5, mi
tab lbo_rec, mi

foreach i in tri_1 tri_2 tri_3 nocare nullip one_priorbirth two_priorbirths threeplus_priorbirths {
gen `i' = .
}

replace tri_1 = 1 if precare5 == 1
replace tri_2 = 1 if precare5 == 2
replace tri_3 = 1 if precare5 == 3
replace nocare = 1 if precare5 == 4
replace nullip = 1 if lbo_rec == 1
replace one_priorbirth = 1 if lbo_rec == 2
replace two_priorbirths = 1 if lbo_rec == 3
replace threeplus_priorbirths = 1 if (lbo_rec == 4 | lbo_rec == 5 | lbo_rec == 6 |lbo_rec== 7 | lbo_rec == 8)

// The zero category is incorrect
// corrected
foreach i in tri_1 tri_2 tri_3 nocare nullip one_priorbirth two_priorbirths threeplus_priorbirths {
replace `i' = 0 if `i' != 1 & precare5 != . & lbo_rec != .
}

label variable tri_1 "1st trimester prenatal care"
label variable tri_2 "2nd trimester prenatal care"
label variable tri_3 "3rd trimester prenatal care"
label variable nocare "No prenatal care"
label variable nullip "No prior births / first born"
label variable one_priorbirth "1 prior birth"
label variable two_priorbirths "2 prior births"
label variable threeplus_priorbirths "3 or more prior births"

foreach i in tri_1 tri_2 tri_3 nocare nullip one_priorbirth two_priorbirths threeplus_priorbirths {
tab `i', mi
}

* Birth weight
********************
tab bwtr14, mi
replace bwtr14 = . if bwtr14 == 14
label define bwtr14 1 "227 - 499 grams" 2 "500 – 749 grams" 3 "750 – 999 grams" 4 "1000 - 1249 grams" 5 "1250 – 1499 grams" 6 "1500 – 1999 grams" 7 "2000 – 2499 grams" 8 "2500 – 2999 grams" 9 "3000 – 3499 grams" 10 "3500 – 3999 grams" 11 "4000 – 4499 grams" 12 "4500 – 4999 grams" 13 "5000 – 8165 grams"
label values bwtr14 bwtr14
tab bwtr14, mi
* dummy for weight 
gen wtcategories = .
replace wtcategories = 1 if bwtr14 <= 5
replace wtcategories = 2 if bwtr14 <= 7 & bwtr14 > 5
replace wtcategories = 3 if bwtr14 >= 8 & bwtr14 != .
label define wtcategories 1 "Very Low Birth Weight (<1500 grams)" 2 "Low Birth Weight (<2500 grams)" 3 "Good Birth Weight (>=2500)"
label values wtcategories wtcategories
tab wtcategories, mi

foreach i in VLBweight LBweight GBweight {
gen `i' = .
}

replace VLBweight = 1 if wtcategories == 1
replace LBweight = 1 if wtcategories == 2
replace GBweight = 1 if wtcategories == 3

// The zeor category may be incorrect
// corrected
foreach i in VLBweight LBweight GBweight {
replace `i' = 0 if `i' != 1 & wtcategories != .
}

label variable VLBweight "Very Low Birth Weight"
label variable LBweight "Low Birth Weight"
label variable GBweight "Good Birth Weight"

foreach i in VLBweight LBweight GBweight {
tab `i' wtcategories, mi
}

// gestational age characteristics
tab gestrec10, mi
replace gestrec10 = . if gestrec10 == 99
label define gestweeks 1 "< 20 weeks" 2 "20-27 weeks" 3 "8-31 weeks" 4 "32-33 weeks" 5 "34-36 weeks" 6 "37-38 weeks" 7 "39 weeks" 8 "40 weeks" 9 "41 weeks" 10 "> 42 weeks"
label values gestrec10 gestrec10
tab gestrec10, mi

//dummy gestational weeks var
gen GWdum = .
replace GWdum = 1 if gestrec10 < 4
replace GWdum = 2 if gestrec10 < 6 & gestrec10 >= 4
replace GWdum = 3 if gestrec10 > 6 & gestrec10 != .
label define GWdum 1 "Very Preterm Birth" 2 "Preterm Birth" 3 "Normal Birth"
label values GWdum GWdum
tab GWdum, mi

foreach i in vpreterm preterm normbirth {
gen `i' = .
}

replace vpreterm = 1 if GWdum == 1
replace preterm = 1 if GWdum == 2
replace normbirth = 1 if GWdum == 3

foreach i in vpreterm preterm normbirth {
replace `i' = 0 if `i' != 1 & GWdum != .
}

label variable vpreterm "Very Preterm Birth"
label variable preterm "Preterm Birth"
label variable normbirth "Normal Birth"

foreach i in vpreterm preterm normbirth {
tab `i' GWdum, mi
}

* Infant Mortality
********************
// flgnd only has a one cat. and a missing cat.
tab flgnd, mi
gen file_rec = .
replace file_rec = 1 if flgnd == 1 & flgnd != .
label variable file_rec "Infant mortality"
tab file_rec, mi

// made adjustments to the zero cat.
gen neonatal = .
replace neonatal = 1 if (ager5 == 1 | ager5 == 2 | ager5 == 3 | ager5 == 4)
replace neonatal = 0 if ager5 == 5 & ager5 != .

// made adjustments to the zero cat.
gen postneonatal = .
replace postneonatal = 1 if ager5 == 5 
replace postneonatal = 0 if (ager5 == 1 | ager5 == 2 | ager5 == 3 | ager5 == 4) & ager5 != .

* Dummy for infant moratlity catagories
gen newinfantmort = (file_rec*1000)
gen newneonatalmort = (neonatal*1000)
gen newpostneonatalmort = (postneonatal*1000)
label variable newinfantmort "Infant mortality (birth to 1 year), per 1,000 births"
label variable newneonatalmort "Neonatal mortality (0–28 days), per 1,000 births"
label variable newpostneonatalmort "Postneonatal mortality (29 days to 1 year), per 1,000 births"

foreach i in newinfantmort newneonatalmort newpostneonatalmort {
tab `i', mi
}

save LKBC2014USDenom_plus.AllCnty_madevars.dta, replace

