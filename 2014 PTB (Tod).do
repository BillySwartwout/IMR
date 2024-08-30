//PTB by Race, Hispanic Ethnicity and Nativity

//2014 infant mortality file

clear

capture log close //creates a log file, will close at the last line of code

cd "/Users/thamilton/Dropbox/Hamilton_Check_Swartwout"

log using ptb_latinx_birthplace_tod,text replace

use "/Users/thamilton/Dropbox/Swartwout_Hamilton/Analysis Files/Linked Cohort/LKBC2014USDenom.AllCnty.dta", clear
// find how to use only specific variables ***************

//Ethnicity & immigrant status
tab mracehisp, mi
label define mracehisp 1 "NH White" 2 "NH Black" 3 "NH American Indian or Alaskan Native" 4 "NH Asian" 5 "NH Native Hawaiian or Pacific Islander" 6 "NH More than one" 7 "Hispanic" 8 "Unknown or not stated"
label value mracehisp mracehisp
tab mracehisp, missing

// var to include US possessions/territories : (Tod: Please add the other territories)
tab mbstate_rec, mi
tab mbstate, mi
gen possessions = .
replace possessions = 0 if (mbstate != "GU" & mbstate != "PR" & mbstate != "VI")
replace  possessions = 1 if mbstate == "GU" | mbstate == "PR" | mbstate == "VI"
tab possessions, mi

* vars for immigration
foreach i in immigrant native {
gen `i' = 0
}
replace native = 1 if mbstate_rec == 1 | possessions == 1
replace immigrant = 1 if mbstate_rec == 2 & possessions == 0

gen NonIM_race = .
replace NonIM_race = 1 if mracehisp == 1 & immigrant == 0
replace NonIM_race = 2 if mracehisp == 2 & immigrant == 0
replace NonIM_race = 3 if mracehisp == 3 & immigrant == 0
replace NonIM_race = 4 if mracehisp == 4 & immigrant == 0
replace NonIM_race = 5 if mracehisp == 5 & immigrant == 0
replace NonIM_race = 6 if mracehisp == 6 & immigrant == 0
replace NonIM_race = 7 if mracehisp == 7 & immigrant == 0
label define NonIM_race 1 "NH White US-Born" 2 "NH Black US-Born" 3 "NH AIAN US-Born" 4 "NH Asian US-Born" 5 "NH NHOPI US-Born" 6 "NH more than one race US-Born" 7 "Hispanic US-Born"
label values NonIM_race NonIM_race
tab NonIM_race, mi

gen IM_race = .
replace IM_race = 1 if mracehisp == 1 & immigrant == 1
replace IM_race = 2 if mracehisp == 2 & immigrant == 1
replace IM_race = 3 if mracehisp == 3 & immigrant == 1
replace IM_race = 4 if mracehisp == 4 & immigrant == 1
replace IM_race = 5 if mracehisp == 5 & immigrant == 1
replace IM_race = 6 if mracehisp == 6 & immigrant == 1
replace IM_race = 7 if mracehisp == 7 & immigrant == 1
label define IM_race 1 "NH White Foreign Born" 2 "NH Black Foreign Born" 3 "NH AIAN Foreign Born" 4 "NH Asian Foreign Born" 5 "NH NHOPI Foreign Born" 6 "NH more than one race Foreign Born" 7 "Hispanic Foreign Born"
label values IM_race IM_race
tab IM_race, mi


* generate header vars
gen dumRF = 1 if NonIM_race == 1
replace dumRF = 2 if IM_race == 1
replace dumRF = 3 if NonIM_race == 2
replace dumRF = 4 if IM_race == 2
replace dumRF = 5 if NonIM_race == 3
replace dumRF = 6 if IM_race == 3
replace dumRF = 7 if NonIM_race == 4
replace dumRF = 8 if IM_race == 4
replace dumRF = 9 if NonIM_race == 5
replace dumRF = 10 if IM_race == 5
replace dumRF = 11 if NonIM_race == 6
replace dumRF = 12 if IM_race == 6
replace dumRF = 13 if NonIM_race == 7
replace dumRF = 14 if IM_race == 7

label define dumRF 1 "NH White US-Born" 2 "NH White Foreign Born" 3 "NH Black US-Born" 4 "NH Black Foreign Born" 5 "AIAN US-Born" 6 "AIAN Foreign Born" 7 "NH Asian US-Born" 8 "NH Asian Foreign Born" 9 "NH NHOPI US-Born" 10 "NH NHOPI Foreign Born" 11 "NH more than one race US-Born" 12 "NH more than one race Foreign Born" 13 "Hispanic US-Born" 14 "Hispanic Foreign Born"
label values dumRF dumRF
label variable dumRF "Variables"
tab dumRF, mi

* race dummy (Corrected Tod)
foreach i in nat_nhwhite for_nhwhite nat_nhblack for_nhblack nat_aian for_aian nat_nhasian for_nhasian nat_nhnhopi for_nhnhopi nat_mtor for_mtor nat_his for_his {
gen `i' = 0
}
replace nat_nhwhite = 1 if NonIM_race == 1
replace for_nhwhite = 1 if IM_race == 1
replace nat_nhblack = 1 if NonIM_race == 2
replace for_nhblack = 1 if IM_race == 2
replace nat_aian = 1 if NonIM_race == 3
replace for_aian = 1 if IM_race == 3
replace nat_nhasian = 1 if NonIM_race == 4
replace for_nhasian = 1 if IM_race == 4
replace nat_nhnhopi = 1 if NonIM_race == 5
replace for_nhnhopi = 1 if IM_race == 5
replace nat_mtor = 1 if NonIM_race == 6
replace for_mtor = 1 if IM_race == 6
replace nat_his = 1 if NonIM_race == 7
replace for_his = 1 if IM_race == 7


foreach i in nat_nhwhite for_nhwhite nat_nhblack for_nhblack nat_aian for_aian nat_nhasian for_nhasian nat_nhnhopi for_nhnhopi nat_mtor for_mtor nat_his for_his {
tab `i' , mi
}



***Tod: Please add variables for father's race 

* Infant Mortality
********************
tab flgnd, mi
gen file_rec = 0 if flgnd == .
replace file_rec = 1 if flgnd == 1
label variable file_rec "Infant mortality place-holder"
tab file_rec, mi
// gen deathrec = . if file_rec == 1
// replace deathrec = 1 if ager5 == .
// // Neonatal mortality
// replace deathrec = 2 if ager5 == 1 | ager5 == 2 | ager5 == 3 | ager5 == 4
// // Postnatal mortality
// replace deathrec = 3 if ager5 == 5 & ager22 != .
// label define deathrec 1 "Infant mortality (birth to 1 year)" 2 "Neonatal mortality (0–28 days)" 3 "Postneonatal mortality (29 days to 1 year)"
// label values deathrec deathrec
// tab deathrec, mi
// * Dummy for infant moratlity catagories
// foreach i in infantmort neonatalmort postneonatalmort {
// gen `i' = 0
// }
// replace infantmort = 1 if deathrec == 1
// replace neonatalmort = 1 if deathrec == 2
// replace postneonatalmort = 1 if deathrec == 3
// label variable infantmort "Infant mortality (birth to 1 year), per 1,000 births"
// label variable neonatalmort "Neonatal mortality (0–28 days), per 1,000 births"
// label variable postneonatalmort "Postneonatal mortality (29 days to 1 year), per 1,000 births"
//
// foreach i in infantmort neonatalmort postneonatalmort {
// tab deathrec `i', mi
// }


* Maternal education (Tod: Please add the some college category)
*********************
tab meduc, mi
gen meduc_sim = 1 if meduc <3 
replace meduc_sim = 2 if meduc == 3 | meduc == 4 
replace meduc_sim = 3 if meduc == 5
replace meduc_sim = 4 if meduc == 6 
replace meduc_sim = 5 if meduc == 7 
replace meduc_sim = 6 if meduc == 8
replace meduc_sim = 7 if meduc == 9
lab var meduc_sim "Maternal Education"
label define meduc_sim 1 "<12 years" 2 "High school graduate or GED completed" 3 "Associate degree" 4 "Bachelor's degree" 5 "Master's degree" 6 "Doctorate or Professional Degree" 7 "Unknown"
label values meduc_sim meduc_sim
tab meduc meduc_sim, row mi

foreach i in nonhsgrad hsgrad assocdeg bachdeg mastdeg docdeg {
gen `i' = 0
}
replace nonhsgrad = 1 if meduc_sim == 1
replace hsgrad = 1 if meduc_sim == 2
replace assocdeg = 1 if meduc_sim == 3
replace bachdeg = 1 if meduc_sim == 4
replace mastdeg = 1 if meduc_sim == 5
replace docdeg = 1 if meduc_sim == 6

label variable nonhsgrad "Non high school graduate"
label variable hsgrad "High school graduate"
label variable assocdeg "Associate degree"
label variable bachdeg "Bachelor's degree"
label variable mastdeg "Master's degree"
label variable docdeg "Doctorate"

foreach i in nonhsgrad hsgrad assocdeg bachdeg mastdeg docdeg {
tab `i' meduc_sim, mi
}


* Please add variables for father's education


* Child gender
************************
tab sex, mi
gen childgender = .
replace childgender = 1 if sex == "F"
replace childgender = 2 if sex == "M"
label define childgender 1 "Female" 2 "Male"
label values childgender childgender
tab childgender, mi

foreach i in m_gender f_gender {
gen `i' = 0
}
replace f_gender = 1 if childgender == 1
replace m_gender = 1 if childgender == 2

label variable f_gender "Female"
label variable m_gender "Male"

foreach i in m_gender f_gender {
tab `i' childgender, mi
}

*Maternal race/foreign-born status
*************************************
foreach i in mnh_white mnh_black m_hispanic mnh_asian m_fborn {
gen `i' = 0
}
replace mnh_white = 1 if mracehisp == 1
replace mnh_black = 1 if mracehisp == 2
replace m_hispanic = 1 if mracehisp == 7
replace mnh_asian = 1 if mracehisp == 4
//line below correct?
replace m_fborn = 1 if immigrant == 1

label variable mnh_white "Mother NH white"
label variable mnh_black "Mother NH black"
label variable m_hispanic "Mother Hispanic"
label variable mnh_asian "Mother NH Asian"
label variable m_fborn "Mother foreign-born"

foreach i in mnh_white mnh_black m_hispanic mnh_asian m_fborn {
tab `i' , mi
}

* Prenatal behaviors/pregnancy characteristics
************************************************
tab precare5, mi
label define precare5 1 "1st trimester" 2 "2nd trimester" 3 "3rd trimester" 4 "No prenatal care" 5 "Unknown/Not stated"
label values precare5 precare5
tab precare5, mi
tab lbo_rec, mi

foreach i in tri_1 tri_2 tri_3 nocare nullip one_priorbirth two_priorbirths threeplus_priorbirths {
gen `i' = 0	
}
replace tri_1 = 1 if precare5 == 1
replace tri_2 = 1 if precare5 == 2
replace tri_3 = 1 if precare5 == 3
replace nocare = 1 if precare5 ==4
replace nullip = 1 if lbo_rec == 1
replace one_priorbirth = 1 if lbo_rec == 2
replace two_priorbirths = 1 if lbo_rec == 3
replace threeplus_priorbirths = 1 if lbo_rec ==4

label variable tri_1 "1st trimester prenatal care"
label variable tri_2 "2nd trimester prenatal care"
label variable tri_3 "3rd trimester prenatal care"
label variable nocare "No prenatal care"
label variable nullip "First birth"
label variable one_priorbirth "1 prior birth"
label variable two_priorbirths "2 prior births"
label variable threeplus_priorbirths "3 or more prior births"

foreach i in tri_1 tri_2 tri_3 nocare nullip one_priorbirth two_priorbirths threeplus_priorbirths {
tab `i', mi
}

* Other Maternal Charactersitics
*********************************
* Maternal age
tab mager41, mi
label variable mager41 "Maternal age"
sum mager41, detail

tab mager9, mi
label define mager9 1 "<15 years" 2 "15-19 years" 3 "20-24 years" 4 "25-29" 5 "30-34 years" 6 "35-39 years" 7 "40-44 years" 8 "45-49 years" 9 "50-54 years"
label values mager9 mager9
label variable mager9 "Maternal age"
tab mager9, mi
* dummy for mother's age
foreach i in less_15 btwn15_19 btwn20_24 btwn25_29 btwn30_34 btwn35_39 btwn40_44 btwn45_49 btwn50_54 {
gen `i' = 0
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

label variable less_15 "<15 years old"
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


***Please add variables for father's age


* Married
label define dmar 1 "Married" 2 "Unmarried" 9 "Unknown"
label value dmar dmar
tab dmar, missing
*
foreach i in married unmarried unknownmarriage {
gen `i' = 0
}
replace married = 1 if dmar == 1
replace unmarried = 1 if dmar == 2
replace unknownmarriage = 1 if dmar == 9


foreach i in married unmarried unknownmarriage {
tab `i' dmar, mi
}

***Please add variables for father's marital status


* Region of infant birth
***************************
gen oregion = 1 if ostate == "ME" | ostate == "VT" | ostate == "MA" | ostate == "NH" | ostate =="CT" | ostate == "RI" | ostate == "NY" | ostate =="NJ" | ostate == "PA"
replace oregion = 2 if ostate == "OH" | ostate =="MI" | ostate =="IN" | ostate =="IL" | ostate =="WI" | ostate =="MN" | ostate == "IA" | ostate =="MO"  | ostate == "KS" | ostate =="NE" | ostate =="SD" | ostate =="ND"
replace oregion = 3 if ostate =="DE" | ostate =="MD" | ostate =="DC" | ostate == "VA" | ostate =="WV" | ostate == "NC" | ostate =="SC" | ostate =="GA" | ostate =="FL" | ostate == "KY" | ostate =="TN" | ostate =="MS" | ostate =="AL" | ostate == "AR" | ostate == "LA" | ostate =="TX" | ostate =="OK" 
replace oregion = 4 if ostate =="MT" |ostate =="WY" |ostate == "CO" | ostate =="NM" | ostate =="AZ" | ostate == "UT" | ostate =="ID" | ostate =="NV" | ostate =="WA" | ostate =="OR"|ostate =="CA" |ostate =="AK" | ostate =="HI" 

tab oregion, mi 

label variable oregion "Birth Occurrence Region"
label define oregion   1 "Northeast" 2 "Midwest" 3 "South" 4 "West" 
label values oregion oregion
tab ostate oregion, mi

* oregion dummy
gen oreg_northeast =1 if oregion ==1
replace oreg_northeast = 0 if oregion !=1 & oregion !=.
label variable oreg_northeast "Northeast"
tab oreg_northeast oregion, mis

gen oreg_midwest = 1 if oregion ==2
replace oreg_midwest = 0 if oregion !=2 & oregion !=.
label variable oreg_midwest "Midwest"
tab oreg_midwest oregion, mis

gen oreg_south = 1 if oregion ==3
replace oreg_south = 0 if oregion !=3 & oregion !=.
label variable oreg_south "South"
tab oreg_south oregion, mis

gen oreg_west =1 if oregion ==4 
replace oreg_west = 0 if oregion !=4 & oregion !=.
label variable oreg_west "West"
tab oreg_west oregion, mis

// helper var for mother's birth region (used later)
gen mbregion = 1 if mbstate == "ME" | mbstate == "VT" | mbstate == "MA" | mbstate == "NH" | mbstate =="CT" | mbstate == "RI" | mbstate == "NY" | mbstate =="NJ" | mbstate == "PA"
replace mbregion = 2 if mbstate == "OH" | mbstate =="MI" | mbstate =="IN" | mbstate =="IL" | mbstate =="WI" | mbstate =="MN" | mbstate == "IA" | mbstate =="MO"  | mbstate == "KS" | mbstate =="NE" | mbstate =="SD" | mbstate =="ND"
replace mbregion = 3 if mbstate =="DE" | mbstate =="MD" | mbstate =="DC" | mbstate == "VA" | mbstate =="WV" | mbstate == "NC" | mbstate =="SC" | mbstate =="GA" | mbstate =="FL" | mbstate == "KY" | mbstate =="TN" | mbstate =="MS" | mbstate =="AL" | mbstate == "AR" | mbstate == "LA" | mbstate =="TX" | mbstate =="OK" 
replace mbregion = 4 if mbstate =="MT" | mbstate =="WY" | mbstate == "CO" | mbstate =="NM" | mbstate =="AZ" | mbstate == "UT" | mbstate =="ID" | mbstate =="NV" | mbstate =="WA" | mbstate =="OR"| mbstate =="CA" | mbstate =="AK" | mbstate =="HI" 

tab mbregion, mi 

label variable mbregion "Mother's Birth Region"
label define mbregion   1 "Northeast" 2 "Midwest" 3 "South" 4 "West" 
label values mbregion mbregion
tab mbregion, mi

//helper var for mother's residential region
gen resregion = 1 if mrstatepstl == "ME" | mrstatepstl == "VT" | mrstatepstl == "MA" | mrstatepstl == "NH" | mrstatepstl =="CT" | mrstatepstl == "RI" | mrstatepstl == "NY" | mrstatepstl =="NJ" | mrstatepstl == "PA"
replace resregion = 2 if mrstatepstl == "OH" | mrstatepstl =="MI" | mrstatepstl =="IN" | mrstatepstl =="IL" | mrstatepstl =="WI" | mrstatepstl =="MN" | mrstatepstl == "IA" | mrstatepstl =="MO"  | mrstatepstl == "KS" | mrstatepstl =="NE" | mrstatepstl =="SD" | mrstatepstl =="ND"
replace resregion = 3 if mrstatepstl =="DE" | mrstatepstl =="MD" | mrstatepstl =="DC" | mrstatepstl == "VA" | mrstatepstl =="WV" | mrstatepstl == "NC" | mrstatepstl =="SC" | mrstatepstl =="GA" | mrstatepstl =="FL" | mrstatepstl == "KY" | mrstatepstl =="TN" | mrstatepstl =="MS" | mrstatepstl =="AL" | mrstatepstl == "AR" | mrstatepstl == "LA" | mrstatepstl =="TX" | mrstatepstl =="OK" 
replace resregion = 4 if mrstatepstl =="MT" | mrstatepstl =="WY" | mrstatepstl == "CO" | mrstatepstl =="NM" | mrstatepstl =="AZ" | mrstatepstl == "UT" | mrstatepstl =="ID" | mrstatepstl =="NV" | mrstatepstl =="WA" | mrstatepstl =="OR"| mrstatepstl =="CA" | mrstatepstl =="AK" | mrstatepstl =="HI" 

tab resregion, mi 

label variable resregion "Mother's Residential Region"
label define resregion   1 "Northeast" 2 "Midwest" 3 "South" 4 "West" 
label values resregion resregion
tab resregion, mi

* Mobility 
******************
// var for foreign-born (place of birth outside the US and delivery in the US)
// tab mbcntry, mi
// tab mrcntry, mi
// gen mob_fborn = .
// replace mob_fborn = 1 if mbcntry != "US" & mrcntry == "US"
// label define mob_fborn 1 "foreign-born"
// label values mob_fborn mob_fborn
// tab mob_fborn, mi

* var for outside-region (place of birth in one US region and delivery in another US region)
tab ostate, mi
tab oregion, mi
gen mob_oregion = .
replace mob_oregion = 0 if mbregion == resregion & immigrant == 0
replace mob_oregion = 1 if mbregion != resregion & immigrant == 0
tab resregion if mob_oregion == 1

* var for within-region (place of birth in one US region and delivery in a different state in the same US region)
gen mob_wregion = .
replace mob_wregion = 0 if (mbregion != resregion) | (mbstate == mrstatepstl) & immigrant == 0
replace mob_wregion = 1 if (mbregion == resregion) & (mbstate != mrstatepstl) & immigrant == 0
tab oregion if mob_wregion == 1

* var for across-state (place of birth and delivery in the same US state)
tab mbstate, mi
tab mrstate, mi
gen mob_acr_state = .
replace mob_acr_state = 0 if mbstate == mrstatepstl & immigrant == 0
replace mob_acr_state = 1 if mbstate != mrstatepstl & immigrant == 0
tab mbstate 

* Birth weight var
**************************
tab bwtr14, mi
gen weight = 1 if bwtr14 == 1
replace weight = 2 if bwtr14 == 2
replace weight = 3 if bwtr14 == 3
replace weight = 4 if bwtr14 == 4
replace weight = 5 if bwtr14 == 5
replace weight = 6 if bwtr14 == 6
replace weight = 7 if bwtr14 == 7
replace weight = 8 if bwtr14 == 8
replace weight = 9 if bwtr14 == 9
replace weight = 10 if bwtr14 == 10
replace weight = 11 if bwtr14 == 11
replace weight = 12 if bwtr14 == 12
replace weight = 13 if bwtr14 == 13
replace weight = 14 if bwtr14 == 14
label define weight 1 "227 - 499 grams" 2 "500 – 749 grams" 3 "03	750 – 999 grams" 4	"1000 - 1249 grams" 5 "1250 – 1499 grams" 6 "1500 – 1999 grams" 7 "2000 – 2499 grams" 8 "2500 – 2999 grams" 9 "3000 – 3499 grams" 10 "3500 – 3999 grams" 11 "4000 – 4499 grams" 12 "4500 – 4999 grams" 13 "5000 – 8165 grams" 14 "Not Stated"
label values weight weight
tab weight
* dummy for weight 
gen wtcatagories = 1 if weight <= 5
replace wtcatagories = 2 if weight <= 7 & weight > 5
replace wtcatagories = 3 if weight >= 8
replace wtcatagories = 4 if weight == 14
label define wtcatagories 1 "Very Low Birth Weight (<1500 grams)" 2 "Low Birth Weight (<2500 grams)" 3 "Good Birth Weight (>=2500)" 4 "Not Stated"
label values wtcatagories wtcatagories
tab wtcatagories
foreach i in VLBweight LBweight GBweight NSweight {
gen `i' = 0
}
replace VLBweight = 1 if wtcatagories == 1
replace LBweight = 1 if wtcatagories == 2
replace GBweight = 1 if wtcatagories == 3
replace NSweight = 1 if wtcatagories == 4


foreach i in VLBweight LBweight GBweight NSweight {
tab `i' wtcatagories, mi
}

// var for gestational age characteristics
tab gestrec10, mi
gen gestweeks = 1 if gestrec10 == 1
replace gestweeks = 2 if gestrec10 == 2
replace gestweeks = 3 if gestrec10 == 3
replace gestweeks = 4 if gestrec10 == 4
replace gestweeks = 5 if gestrec10 == 5
replace gestweeks = 6 if gestrec10 == 6
replace gestweeks = 7 if gestrec10 == 7
replace gestweeks = 8 if gestrec10 == 8
replace gestweeks = 9 if gestrec10 == 9
replace gestweeks = 10 if gestrec10 == 10
replace gestweeks = 11 if gestrec10 == 99
label define gestweeks 1 "< 20 weeks" 2 "20-27 weeks" 3 "8-31 weeks" 4 "32-33 weeks" 5 "34-36 weeks" 6 "37-38 weeks" 7 "39 weeks" 8 "40 weeks" 9 "41 weeks" 10 "> 42 weeks" 11 "Unknown"
label values gestweeks gestweeks
tab gestweeks
//dummy gestational weeks var
gen GWdum = 1 if gestweeks < 4
replace GWdum = 2 if gestweeks < 6 & gestweeks >= 4
replace GWdum = 3 if gestweeks > 4
label define GWdum 1 "Very Preterm Birth" 2 "Preterm Birth" 3 "Normal Birth"
label values GWdum GWdum
tab GWdum
foreach i in vpreterm preterm normbirth {
gen `i' = 0
}
replace vpreterm = 1 if GWdum == 1
replace preterm = 1 if GWdum == 2
replace normbirth = 1 if GWdum == 3

foreach i in vpreterm preterm normbirth {
tab `i' GWdum, mi
}

***Please create dummy variables for each country


***Please correct the code below
//var for maternal place of birth for foreign born
gen usstates = (mrcntry== "Delaware" |mrcntry== "District of Columbia" |mrcntry== "Florida" |mrcntry== "Georgia" |mrcntry== "Hawaii" |mrcntry== "daho" |mrcntry== "Idaho Territory" |mrcntry== "Illinois" |mrcntry== "Indiana" |mrcntry== "Iowa" |mrcntry== "Kansas" |mrcntry== "Kentucky" |mrcntry== "Louisiana" |mrcntry== "Maine" |mrcntry== "Maryland" |mrcntry== "Massachusetts" |mrcntry== "Michigan" |mrcntry== "Minnesota" |mrcntry== "Mississippi" |mrcntry== "Missouri" | mrcntry=="Montana" |mrcntry== "Nebraska" |mrcntry== "Nevada" |mrcntry== "New Hampshire" | mrcntry== "New Jersey" |mrcntry== "New Mexico" |mrcntry== "New Mexico Territory" |mrcntry== "New York" |mrcntry== "North Carolina" |mrcntry== "North Dakota" |mrcntry== "Ohio" |mrcntry== "Oklahoma" |mrcntry== "Indian Territory" |mrcntry== "Oregon" |mrcntry== "Pennsylvania" | mrcntry== "Rhode Island" | mrcntry== "South Carolina" | mrcntry== "South" |mrcntry== "Dakota" |mrcntry== "DakotaTerritory" |mrcntry== "Tennessee" |mrcntry== "Texas" |mrcntry== "Utah" |mrcntry== "Utah Territory" |mrcntry== "Vermont" |mrcntry== "Virginia" |mrcntry== "Washington" |mrcntry== "West Virginia" |mrcntry== "Wisconsin" |mrcntry== "Wyoming" |mrcntry== "Wyoming Territory" |mrcntry== "Samoa" |mrcntry== "Samoa" |mrcntry== "Guam" |mrcntry== "Puerto Rico" |mrcntry== "U.S. Virgin Islands" |mrcntry== "St. Croix" | mrcntry=="St. John" |mrcntry== "St. Thomas" |mrcntry== "Johnston Atoll" |mrcntry== "Midway Islands" | mrcntry=="Wake Island" |mrcntry== "Navassa Island" |mrcntry== "Other US Pacific Is." |mrcntry== "Baker Island" |mrcntry== "Howland Island" |mrcntry== "Jarvis Island" |mrcntry== "Kingman Reef" |mrcntry== "Palmyra Atoll" |mrcntry== "Cantonand Enderbury Island")




gen namerica =  "Canton and Enderbury" | "Island" | "Canada" | "English Canada" | "British Columbia" | "Alberta" | "Saskatchewan" | "Northwest" | "Rupert's Land" | "Manitoba" | "Red River" | "Ontario/Upper Canada" | "Upper Canada" | "Canada West" | "New Brunswick" | "Nova Scotia" | "Cape Breton" | "Halifax" | "Prince Edward Island" | "Newfoundland" | "French Canada" | "Quebec" | "Lower Canada" | "Canada East" | "St. Pierreand Miquelon" | "Atlantic Islands" | "Bermuda" | "Cape Verde" | "Falkland Islands" | "Greenland" | "St. Helenaand Ascension" | "Canary Islands" 

gen centamerica = "Mexico" | "Central America" | "Belize/British Honduras" | "Costa Rica" | "El Salvador" | "Guatemala" | "Honduras" | "Nicaragua" | "Panama" | "Canal Zone" 


gen carribean = | "Cuba" | "West Indies" | "Dominican Republic" | "Haiti" | "Jamaica" | "British West Indies" | "Anguilla" | "Antigua-Barbuda" | "Bahamas" | "Barbados" | "British Virgin Islands" | "Anegada" | "Cooper" | "Jost" | "Van" | "Dyke" | "Peter" | "Tortola" | "Virgin" | "Gorda" | "Cayman Isles" | "Dominica" | "Grenada" | "Montserrat" | "St.Kitts-Nevis" | "St. Lucia" | "St. Vincent" | "Trinidadand Tobago" | "TurksandCaicos" | "Other West Indies" | "Aruba" | "Netherlands Antilles" | "Bonaire" | "Curacao" | "Dutch St. Maarten" | "Saba" | "St. Eustatius" | "Dutch Caribbean" | "St. Maarten" | "Guadeloupe" | "Martinique" | "St. Barthelemy" | "French Caribbean" | "Antilles" | "Latin America" | "Leeward Islands" | "West Indies" | "Windward Islands"

gen eng_speak_carib =  "West Indies"  "Jamaica" | "British West Indies" | "Anguilla" | "Antigua-Barbuda" | "Bahamas" | "Barbados" | "Dominica" | "Grenada" |  "St.Kitts-Nevis" | "St. Lucia" | "St. Vincent" | "Trinidadand Tobago" | | "Other West Indies" | 

gen span_speak_carib= cuba |dominician republic




gen samerica =  "Argentina" | "Bolivia" | "Brazil" | "Chile" | "Colombia" | "Ecuador" | "French" | "Guiana" | "Guyana/British Guiana" | "Paraguay" | "Peru" | "Suriname" | "Uruguay" | "Venezuela"

gen neurope =  "Denmark" | "Faroe Islands" | "Finland" | "Iceland" | "Lapland" | "Norway" | "Svalbardand Jan" | "Meyen" | "Svalbard" | "JanMeyen" | "Sweden" | "England" | "Channel Islands" | "Guernsey" | "Jersey" | "Isle of Man" | "Scotland" | "Wales" | "United Kingdom" | "Ireland" | "Northern Ireland"

gen weurope =  "Belgium" | "Alsace-Lorraine" | "Alsace" | "Lorraine" | "Liechtenstein" | "Luxembourg" | "Monaco" | "Netherlands" | "Switzerland"

gen seurope =  "Albania" | "Andorra" | "Gibraltar" | "Greece" | "Dodecanese Islands" | "Turkey Greece" | "Macedonia" | "Italy" | "Malta" | "Portugal" | "Azores" | "Madeira Islands" | "Cape Verde Islands" | "St. Miguel" | "SanMarino" | "Spain" | "Vatican City"

gen centeurope =  "Austria" | "Austria-Hungary" | "Austria-Graz" | "Austria-Linz" | "Austria-Salzburg" | "Austria-Tyrol" | "Austria-Vienna" | "Austria-Kaernten" | "Austria-Neustadt" | "Bulgaria" | "Czechoslovakia" | "Bohemia" | "Bohemia-Moravia" | "Slovakia" | "Czech Republic" | "Germany" | "Berlin" | "West Berlin" | "East Berlin" | "West Germany" | "Baden" | "Bavaria" | "Braunschweig" | "Bremen" | "Hamburg" | "Hanover" | "Hessen" | "Hesse-Nassau" | "Lippe" | "Lubeck" | "Oldenburg" | "Rheinland" | "Schaumburg-Lippe" | "Schleswi" | "Sigmaringen" | "Schwarzburg" | "Westphalia" | "Wurttemberg" | "Waldeck" | "Wittenberg" | "Frankfurt" | "Saarland" | "Nordrhein-Westfalen" | "East Germany" | "Anhalt" | "Brandenburg" | "Kingdom of Saxony" | "Mecklenburg" | "Saxony" | "Thuringian States" | "Sachsen-Meiningen" | "Sachsen-Weimar-Eisenach" | "Probable" | "Saxony" | "Schwerin" | "Strelitz" | "Probably" | "Thuringian" | "States" | "Prussia" | "Hohenzollern" | "Niedersachsen" | "Hungary" | "Poland" | "Austrian" | "Poland" | "Galicia" | "German Poland" | "East Prussia" | "Pomerania" | "Posen" | "Prussian Poland" | "Silesia" | "West Prussia" | "Russian Poland" | "Romania" | "Transylvania" | "Yugoslavia" | "Croatia" | "Montenegro" | "Serbia" | "Bosnia" | "Dalmatia" | "Slovonia" | "Carniola" | "Slovenia" | "Kosovo"

gen russemp =  "Estonia" | "Latvia" | "Lithuania" | "Byelorussia" | "Moldavia" | "Bessarabia" | "Ukraine" | "Armenia" | "Azerbaijan" | "Republic of Georgia" | "Kazakhstan" | "Kirghizia" | "Tadzhik" | "Turkmenistan" | "Uzbekistan" | "Siberia"

gen asiadum =  "China" | "Hong" | "Kong" | "Macau" | "Mongolia" | "Taiwan" | "Japan" | "Korea" | "North Korea" | "South Korea" | "Brunei" | "Cambodia (Kampuchea)" | "Indonesia" | "East Indies" | "EastTimor" | "Laos" | "Malaysia" | "Philippines" | "Singapore" | "Thailand" | "Vietnam" | "Indochina" | "Afghanistan" | "India" | "Bangladesh" | "Bhutan" | "Burma(Myanmar)" | "Pakistan" | "SriLanka(Ceylon)" | "Iran" | "Maldives" | "Nepal" | "Bahrain" | "Cyprus" | "Iraq" | "Mesopotamia" | "Iraq/Saudi Arabia" | "Israel/Palestine" | "GazaStrip" | "Palestine" | "West Bank" | "Israel" | "Jordan" | "Kuwait" | "Lebanon" | "Oman" | "Qatar" | "Saudi Arabia" | "Syria" | "Turkey" | "European Turkey" | "Asian Turkey" | "United Arab Emirates" | "Yemen Arab Republic( North)" | "Yemen,PDR (South)" | "Persian Gulf States"

gen east_asia = "China" | "Hong" | "Kong" | "Macau" | "Mongolia" | "Taiwan" | "Japan" | "Korea" | "North Korea" | "South Korea" |

gen southeast_asia "Brunei" | "Cambodia (Kampuchea)" | "Indonesia" | "East Indies" | "EastTimor" | "Laos" | "Malaysia" | "Philippines" | "Singapore" | "Thailand" | "Vietnam" | "Indochina" 

gen india_sw_asia = | "Afghanistan" | "India" | "Bangladesh" | "Bhutan" | "Burma(Myanmar)" | "Pakistan" | "SriLanka(Ceylon)" | "Iran" | "Maldives" | "Nepal" 


gen middle_east_asia = "Bahrain" | "Cyprus" | "Iraq" | "Mesopotamia" | "Iraq/Saudi Arabia" | "Israel/Palestine" | "GazaStrip" | "Palestine" | "West Bank" | "Israel" | "Jordan" | "Kuwait" | "Lebanon" | "Oman" | "Qatar" | "Saudi Arabia" | "Syria" | "Turkey" | "European Turkey" | "Asian Turkey" | "United Arab Emirates" | "Yemen Arab Republic( North)" | "Yemen,PDR (South)" | "Persian Gulf States"

gen africadum =  "Algeria" | "Egypt/United Arab Rep." | "Libya" | "Morocco" | "Sudan" | "Tunisia" | "Western Sahara" | "Benin" | "Burkina" | "Faso" | "Gambia" | "Ghana" | "Guinea" | "Guinea-Bissau" | "Ivory Coast" | "Liberia" | "Mali" | "Mauritania" | "Niger" | "Nigeria" | "Senegal" | "Sierra" | "Leone" | "Togo" | "British Indian Ocean Territory" | "Burundi" | "Comoros" | "Djibouti" | "Ethiopia" | "Kenya" | "Madagascar" | "Malawi" | "Mauritius" | "Mozambique" | "Reunion" | "Rwanda" | "Seychelles" | "Somalia" | "Tanzania" | "Uganda" | "Zambia" | "Zimbabwe" | "Bassasda India" | "Europa" | "Gloriosos" | "JuandeNova" | "Mayotte" | "Tromelin" | "Eritrea" | "SouthSudan" | "Angola" | "Cameroon" | "Central African Republic" | "Chad" | "Congo" | "Equatorial Guinea" | "Gabon" | "Sao Tomeand Principe" | "Zaire" | "Equatorial Africa" | "Botswana" | "Lesotho" | "Namibia" | "South Africa (Unionof)" | "Swaziland" /* Add Cape Verde */


gen northern_africa = "Algeria" | "Egypt/United Arab Rep." | "Libya" | "Morocco" | "Sudan" | "Tunisia" | "Western Sahara" 

gen west_africa = "Benin" | "Burkina" | "Faso" | "Gambia" | "Ghana" | "Guinea" | "Guinea-Bissau" | "Ivory Coast" | "Liberia" | "Mali" | "Mauritania" | "Niger" | "Nigeria" | "Senegal" | "Sierra" | "Leone" | "Togo"

gen east_africa = "British Indian Ocean Territory" | "Burundi" | "Comoros" | "Djibouti" | "Ethiopia" | "Kenya" | "Madagascar" | "Malawi" | "Mauritius" | "Mozambique" | "Reunion" | "Rwanda" | "Seychelles" | "Somalia" | "Tanzania" | "Uganda" | "Zambia" | "Zimbabwe" | "Bassasda India" | "Europa" | "Gloriosos" | "JuandeNova" | "Mayotte" | "Tromelin" | "Eritrea" | "SouthSudan" | 

gen central_africa = "Angola" | "Cameroon" | "Central African Republic" | "Chad" | "Congo" | "Equatorial Guinea" | "Gabon" | "Sao Tomeand Principe" | "Zaire" | "Equatorial Africa" | 

gen souther_Africa = | "Botswana" | "Lesotho" | "Namibia" | "South Africa (Unionof)" | "Swaziland"



gen oceaniadum =  "Australia" | "Ashmoreand Cartier Islands" | "Coral Sea Islands Territory" | "Christmas Island" | "Cocos Islands" | "New Zealand" | "Pacific Islands" | "New" | "Caledonia" | "Papua New Guinea" | "Solomon Islands" | "Vanuatu(New Hebrides)" | "Fiji" | "Norfolk Islands" | "Niue" | "Cook Islands" | "French Polynesia" | "Tonga" | "Wallisand Futuna Islands" | "Western Samoa" | "Pitcairn Island" | "Tokelau" | "Tuvalu" | "Kiribati" | "Canton and Enderbury" | "Nauru" | "Marshall Islands" | "Micronesia" | "Kosrae" | "Pohnpei" | "Truk" | "Yap" | "Northern Mariana Islands" | "Palau" | "Clipperton Island"

gen antarticadum =  "Bouvet Islands" | "British Antarctic Terr." | "Dronning MaudLand" | "French Southern and Antartic Lands" | "Heard and McDonald Islands"

gen abroaddum =  "Abroad(US citizen)" | "At sea(US citizen)" | "At sea or abroad(U.S. citizen)"
foreach i in usstates namerica centamerica samerica neurope weurope seurope centeurope russemp asiadum africadum oceaniadum antarticadum abroaddum {
tab `i', mi
}

save LKBC2014USDenom_AllCnty_tod, replace







