set more off
capture log close
log using reg2014_15.txt, text replace
#delimit;
use native immigrant carribean africa haiti eng_speak_carib span_speak_carib west_africa east_africa central_africa southern_africa europe nafrica_mideast namerica oceaniadum neurope weurope seurope centeurope russemp middle_east_asia northern_africa east_southeast_asia india_sw_asia east_asia southeast_asia india south_asia1 south_asia2 hispplaces span_speak_carib mexico centamerica samerica cuba domrep mager9 meduc_sim married m_gender lbo_rec precare5 oregion dob_yy neonatal postneonatal file_rec mnh_white mnh_black m_hispanic mnh_asian places1_b places2_b places3_b places4_b places1_w places2_w places3_w places4_w places1_a places2_a places3_a places4_a places1_h places2_h places3_h places4_h /*smokevar*/

using LKBC2015USDenom_plus.AllCnty_madevars.dta, clear;
// using LKBC2014_15appendedUSDenom_plus.AllCnty.dta, clear;

#delimit cr
tab dob_yy, mi


//plot1opts(lcolor(black) mcolor(black) msymbol(circle) lpattern(solid) ciopts(lcolor(black))) plot2opts(lcolor(gs5) mcolor(gs5) msymbol(diamond) lpattern(shortdash) ciopts(lcolor(gs5))) plot3opts(lcolor(gs10) mcolor(gs10) msymbol(square) lpattern(longdash) ciopts(lcolor(gs10))) plot4opts(lcolor(gs7) mcolor(gs10) msymbol(triangle) lpattern(longdash_dot) ciopts(lcolor(gs7)))

//legendfrom(`OUTCOME'_mnh_black_full_1) pos(11) ring(0) legendfrom(`OUTCOME'_mnh_black_full_2) pos(1) ring(0) legendfrom(`OUTCOME'_mnh_black_full_3) pos(3) ring(0) legendfrom(`OUTCOME'_mnh_black_full_4) pos(9) ring(0) 


**************** Specific Country *****************************************

/*
Panel 1: Blacks
NH Native Blacks
Black Immigrants

Panel 2: Blacks
NH Native Blacks
Black Caribbean
Black African

Panel 3:
NH Native Blacks
Haiti 
English-Speaking Caribbean
Spanish-Speaking Caribbean

Panel 4:
NH Native Blacks
West Africa
East Africa
Central Africa
Southern Africa
*/

foreach OUTCOME in   file_rec {
	if ("`OUTCOME'" == "neonatal" | "`OUTCOME'" == "file_rec") {
		local SAMPLE " 1 == 1 "
	}
	else { 
		local SAMPLE "neonatal == 0 "
	}
	if ("`OUTCOME'" == "neonatal" | "`OUTCOME'" == "postneonatal") {
		local YMAX .01
	}
	else {
		local YMAX .015
	}
	if ("`OUTCOME'" == "neonatal") {
		local YTITLE "pr(Neonatal Mortality)"
	}
		if ("`OUTCOME'" == "postneonatal") {
		local YTITLE "pr(Postneonatal Mortality)"
	}
	if ("`OUTCOME'" == "file_rec") {
		local YTITLE "pr(Infant Mortality)"
	}
	
	foreach r in mnh_black mnh_white mnh_asian m_hispanic{
		if ("`r'" == "mnh_black") {
			local SUBTITLE "Non-Hispanic Black"
			local XTITLE " "
			local YTITLE " "
			
			local baseCONTROLS1 "i.immigrant i.mager9##i.mager9 i.meduc_sim i.meduc_sim#i.immigrant"
			
			local baseCONTROLS2 "i.native i.carribean i.africa i.mager9##i.mager9 i.meduc_sim i.meduc_sim#i.native i.meduc_sim#i.carribean i.meduc_sim#i.africa"
			
			local baseCONTROLS3 "i.native i.haiti i.eng_speak_carib i.span_speak_carib i.mager9##i.mager9 i.meduc_sim i.meduc_sim#i.native i.meduc_sim#i.haiti i.meduc_sim#i.eng_speak_carib i.meduc_sim#i.span_speak_carib"
			
			local baseCONTROLS4 "i.native i.west_africa i.east_africa i.central_africa southern_africa i.mager9##i.mager9 i.meduc_sim i.meduc_sim#i.native i.meduc_sim#i.west_africa i.meduc_sim#i.east_africa i.meduc_sim#i.central_africa i.meduc_sim#i.southern_africa "

			local fullCONTROLS1 "i.immigrant i.mager9##i.mager9 i.meduc_sim i.meduc_sim#i.immigrant i.married i.m_gender i.lbo_rec i.oregion i.dob_yy"
			
			local fullCONTROLS2 "i.native i.carribean i.africa i.mager9##i.mager9 i.meduc_sim i.meduc_sim#i.native i.meduc_sim#i.carribean i.meduc_sim#i.africa i.married i.m_gender i.lbo_rec i.oregion i.dob_yy"

			local fullCONTROLS3 "i.native i.haiti i.eng_speak_carib i.span_speak_carib i.mager9##i.mager9 i.meduc_sim i.meduc_sim#i.native i.meduc_sim#i.haiti i.meduc_sim#i.eng_speak_carib i.meduc_sim#i.span_speak_carib i.married i.m_gender i.lbo_rec i.oregion i.dob_yy"
			
			local fullCONTROLS4 "i.native i.west_africa i.east_africa i.central_africa i.southern_africa i.mager9##i.mager9 i.meduc_sim i.meduc_sim#i.native i.meduc_sim#i.west_africa i.meduc_sim#i.east_africa i.meduc_sim#i.central_africa i.meduc_sim#i.southern_africa i.married i.m_gender i.lbo_rec i.oregion i.dob_yy"
			
			if ("`OUTCOME'" == "neonatal") {
				local YTITLE "pr(Neonatal Mortality)"
			}
			if ("`OUTCOME'" == "postneonatal") {
				local YTITLE "pr(Postneonatal Mortality)"
			}
			if ("`OUTCOME'" == "file_rec") {
				local YTITLE "pr(Infant Mortality)"
			}
		
		foreach m in base full {
			if ("`r'" == "mnh_black" & "`m'" == "base")  {
				local REPLACEorAPPEND replace
			}
			else {
				local REPLACEorAPPEND append
			}
* PANEL 1			
			logit `OUTCOME' ``m'CONTROLS1' if `r'== 1 & `SAMPLE', cluster(oregion)
			outreg2 using "`OUTCOME'", dec (3)  label word excel ci `REPLACEorAPPEND'
			margins, at(meduc_sim=(1(1)7)) over(places1_b)
			if ("`m'" == "full" ) {
				set scheme s2mono
				marginsplot, name(`OUTCOME'_`r'_`m'_1, replace) title("") subtitle("`SUBTITLE'") plot1opts(lcolor(black) mcolor(black) msymbol(circle) lpattern(solid)) plot2opts(lcolor(gs5) mcolor(gs5) msymbol(diamond) lpattern(shortdash)) xlabel(1 "<HS" 2 "HS" 3 "SC" 4 "AD" 5 "BD" 6 "MD" 7 "Ph.D", labsize(small)) xtitle("`XTITLE'") yscale(range(0 `YMAX')) ylabel(0(.005)`YMAX', nogrid angle(0) labsize(small)) ytitle("`YTITLE'") graphregion(fcolor(white) color(white)) legend(ring(1) pos(12) symxsize(*.8) symysize(*.6) order(3 "U.S. Born" 4 "Immigrant")) note("(HS) High School, (SC) Some College, (AD) Associate Degree," "(BD) Bachelor's, Degree, (MD) Master's Degree, (Ph.D) Doctorate") legend(size(small))
				graph export "`OUTCOME'_`r'_`m'_1.pdf", replace
			}

				
* PANEL 2				
			logit `OUTCOME' ``m'CONTROLS2' if `r'== 1 & `SAMPLE', cluster(oregion)
			outreg2 using "`OUTCOME'", dec (3)  label word excel ci `REPLACEorAPPEND'
			margins, at(meduc_sim=(1(1)7)) over(places2_b)
			if ("`m'" == "full" ) {
				set scheme s2mono
marginsplot, name(`OUTCOME'_`r'_`m'_2, replace) title("") subtitle("`SUBTITLE'") plot1opts(lcolor(black) mcolor(black) msymbol(circle) lpattern(solid)) plot2opts(lcolor(gs5) mcolor(gs5) msymbol(diamond) lpattern(shortdash)) plot3opts(lcolor(gs10) mcolor(gs10) msymbol(square) lpattern(longdash)) xlabel(1 "<HS" 2 "HS" 3 "SC" 4 "AD" 5 "BD" 6 "MD" 7 "Ph.D", labsize(small)) xtitle("`XTITLE'") yscale(range(0 `YMAX')) ylabel(0(.005)`YMAX', nogrid angle(0) labsize(small)) ytitle("`YTITLE'") graphregion(fcolor(white) color(white)) legend(ring(1) pos(12) symxsize(*.8) symysize(*.6) order(1 "U.S. Born" 2 "Carribean" 3 "Africa")) note("(HS) High School, (SC) Some College, (AD) Associate Degree," "(BD) Bachelor's, Degree, (MD) Master's Degree, (Ph.D) Doctorate") legend(size(small))
				graph export "`OUTCOME'_`r'_`m'_2.pdf", replace
			}
				
				
				
* PANEL 3				
				logit `OUTCOME' ``m'CONTROLS3' if `r'== 1 & `SAMPLE', cluster(oregion)
			outreg2 using "`OUTCOME'", dec (3)  label word excel ci `REPLACEorAPPEND'
			margins, at(meduc_sim=(1(1)7)) over(places3_b)
			if ("`m'" == "full" ) {
				set scheme s2mono
				marginsplot, name(`OUTCOME'_`r'_`m'_3, replace) title("") subtitle("`SUBTITLE'") plot1opts(lcolor(black) mcolor(black) msymbol(circle) lpattern(solid)) plot2opts(lcolor(gs5) mcolor(gs5) msymbol(diamond) lpattern(shortdash)) plot3opts(lcolor(gs10) mcolor(gs10) msymbol(square) lpattern(longdash)) plot4opts(lcolor(gs7) mcolor(gs10) msymbol(triangle) lpattern(longdash_dot)) xlabel(1 "<HS" 2 "HS" 3 "SC" 4 "AD" 5 "BD" 6 "MD" 7 "Ph.D", labsize(small)) xtitle("`XTITLE'") yscale(range(0 `YMAX')) ylabel(0(.005)`YMAX', nogrid angle(0) labsize(small)) ytitle("`YTITLE'") graphregion(fcolor(white) color(white)) legend(ring(1) pos(12) symxsize(*.8) symysize(*.6) order(1 "U.S. Born" 2 "Haiti" 3 "English-Speaking Caribbean" 4 "Spanish-Speaking Caribbean")) note("(HS) High School, (SC) Some College, (AD) Associate Degree," "(BD) Bachelor's, Degree, (MD) Master's Degree, (Ph.D) Doctorate") legend(size(small))
				graph export "`OUTCOME'_`r'_`m'_3.pdf", replace
			}	
			
* PANEL 4				
				logit `OUTCOME' ``m'CONTROLS4' if `r'== 1 & `SAMPLE', cluster(oregion)
			outreg2 using "`OUTCOME'", dec (3)  label word excel ci `REPLACEorAPPEND'
			margins, at(meduc_sim=(1(1)7)) over(/* places4_b */ native west_africa east_africa)
			if ("`m'" == "full" ) {
				set scheme s2mono
				marginsplot, name(`OUTCOME'_`r'_`m'_4, replace) title("") subtitle("`SUBTITLE'") plot1opts(lcolor(black) mcolor(black) msymbol(circle) lpattern(solid)) plot2opts(lcolor(gs5) mcolor(gs5) msymbol(diamond) lpattern(shortdash)) plot3opts(lcolor(gs10) mcolor(gs10) msymbol(square) lpattern(longdash)) plot4opts(lcolor(g7) mcolor(black) msymbol(circle) lpattern(solid)) plot5opts(lcolor(gs2) mcolor(gs2) msymbol(triangle) lpattern(shortdash)) xlabel(1 "<HS" 2 "HS" 3 "SC" 4 "AD" 5 "BD" 6 "MD" 7 "Ph.D", labsize(small)) xtitle("`XTITLE'") yscale(range(0 `YMAX')) ylabel(0(.005)`YMAX', nogrid angle(0) labsize(small)) ytitle("`YTITLE'") graphregion(fcolor(white) color(white)) legend(ring(1) pos(12) symxsize(*.8) symysize(*.6) order(3 "U.S. Born" 4 "West Africa" 5 "East Africa" 6 "Central Africa" 7 "Southern Africa")) note("(HS) High School, (SC) Some College, (AD) Associate Degree," "(BD) Bachelor's, Degree, (MD) Master's Degree, (Ph.D) Doctorate") legend(size(small))
				graph export "`OUTCOME'_`r'_`m'_4.pdf", replace
			}	
 			} /* m in base full */	
				
	grc1leg `OUTCOME'_mnh_black_full_1 `OUTCOME'_mnh_black_full_2 `OUTCOME'_mnh_black_full_3 `OUTCOME'_mnh_black_full_4, rows(2) pos(12) graphregion(fcolor(white) color(white)) 
	graph display, xsize(25) ysize(15) 
	graph export "foreign_mnh_black_graphs.pdf", replace
			}

// 			grc1leg neonatal_mnh_black_full_1 neonatal_mnh_black_full_2 neonatal_mnh_black_full_3 neonatal_mnh_black_full_4, cols(2) rows(2) legendfrom(neonatal_mnh_black_full_1) ring(1) pos(11) graphregion(fcolor(white) color(white))              
// 	graph display, xsize(25) ysize(15)
// 	graph export "foreign_mnh_black_graphs.pdf", replace
			

/*
Panel 1: Whites
NH Native Whites
White Immigrants

Panel 2:
NH Native Whites
Europe
North Africa/Middle East
Northern America
Oceania

Panel 3:
NH Native Whites
North Europe
Western Europe
Southern Europe
Central Europe
Russian Empire

Panel 4:
NH Native Whites
Russian Empire
Middle East
Northern Africa
*/

	if ("`r'" == "mnh_white") {
			local SUBTITLE "Non-Hispanic White"
			local XTITLE " "
			local YTITLE " "
			
			
			local baseCONTROLS1 "i.immigrant i.mager9##i.mager9 i.meduc_sim i.meduc_sim#i.immigrant"
			
			local baseCONTROLS2 "i.native i.europe i.nafrica_mideast i.namerica i.oceaniadum i.mager9##i.mager9 i.meduc_sim i.meduc_sim#i.native i.meduc_sim#i.europe i.meduc_sim#i.nafrica_mideast i.meduc_sim#i.namerica i.meduc_sim#i.oceaniadum"
			
			local baseCONTROLS3 "i.native i.neurope i.weurope i.seurope i.centeurope i.mager9##i.mager9 i.meduc_sim i.meduc_sim#i.native i.meduc_sim#i.neurope i.meduc_sim#i.weurope i.meduc_sim#i.seurope i.meduc_sim#i.centeurope"
			
			local baseCONTROLS4 "i.native i.russemp i.middle_east_asia i.northern_africa i.mager9##i.mager9 i.meduc_sim i.meduc_sim#i.native i.meduc_sim#i.russemp i.meduc_sim#i.middle_east_asia i.meduc_sim#i.northern_africa"

			local fullCONTROLS1 "i.immigrant i.mager9##i.mager9 i.meduc_sim i.meduc_sim#i.immigrant i.married i.m_gender i.lbo_rec i.oregion i.dob_yy"
			
			local fullCONTROLS2 "i.native i.europe i.nafrica_mideast i.namerica i.oceaniadum i.mager9##i.mager9 i.meduc_sim i.meduc_sim#i.native i.meduc_sim#i.europe i.meduc_sim#i.nafrica_mideast i.meduc_sim#i.namerica i.meduc_sim#i.oceaniadum i.married i.m_gender i.lbo_rec i.oregion i.dob_yy"
			
			local fullCONTROLS3 "i.native i.neurope i.weurope i.seurope i.centeurope i.mager9##i.mager9 i.meduc_sim i.meduc_sim#i.native i.meduc_sim#i.neurope i.meduc_sim#i.weurope i.meduc_sim#i.seurope i.meduc_sim#i.centeurope i.married i.m_gender i.lbo_rec i.oregion i.dob_yy"
			
			local fullCONTROLS4 "i.native i.russemp i.middle_east_asia i.northern_africa i.mager9##i.mager9 i.meduc_sim i.meduc_sim#i.native i.meduc_sim#i.russemp i.meduc_sim#i.middle_east_asia i.meduc_sim#i.northern_africa i.married i.m_gender i.lbo_rec i.oregion i.dob_yy"
			
			
			if ("`OUTCOME'" == "neonatal") {
				local YTITLE "pr(Neonatal Mortality)"
			}
			if ("`OUTCOME'" == "postneonatal") {
				local YTITLE "pr(Postneonatal Mortality)"
			}
			if ("`OUTCOME'" == "file_rec") {
				local YTITLE "pr(Infant Mortality)"
			}
		
		foreach m in base full {
			if ("`r'" == "mnh_white" & "`m'" == "base")  {
				local REPLACEorAPPEND replace
			}
			else {
				local REPLACEorAPPEND append
			}
* PANEL 1			
			logit `OUTCOME' ``m'CONTROLS1' if `r'== 1 & `SAMPLE', cluster(oregion)
			outreg2 using "`OUTCOME'", dec (3)  label word excel ci `REPLACEorAPPEND'
			margins, at(meduc_sim=(1(1)7)) over(places1_w)
			if ("`m'" == "full" ) {
				set scheme s2mono
				marginsplot, name(`OUTCOME'_`r'_`m'_1, replace) title("") subtitle("`SUBTITLE'") plot1opts(lcolor(black) mcolor(black) msymbol(circle) lpattern(solid)) plot2opts(lcolor(gs5) mcolor(gs5) msymbol(diamond) lpattern(shortdash)) xlabel(1 "<HS" 2 "HS" 3 "SC" 4 "AD" 5 "BD" 6 "MD" 7 "Ph.D", labsize(small)) xtitle("`XTITLE'") yscale(range(0 `YMAX')) ylabel(0(.005)`YMAX', nogrid angle(0) labsize(small)) ytitle("`YTITLE'") graphregion(fcolor(white) color(white)) legend(ring(1) pos(12) symxsize(*.8) symysize(*.6) order(1 "U.S. Born" 2 "Immigrant")) note("(HS) High School, (SC) Some College, (AD) Associate Degree," "(BD) Bachelor's, Degree, (MD) Master's Degree, (Ph.D) Doctorate")
				graph export "`OUTCOME'_`r'_`m'_1.pdf", replace
			}
				
				
* PANEL 2				
			logit `OUTCOME' ``m'CONTROLS2' if `r'== 1 & `SAMPLE', cluster(oregion)
			outreg2 using "`OUTCOME'", dec (3)  label word excel ci `REPLACEorAPPEND'
			margins, at(meduc_sim=(1(1)7)) over(place2_w)
			if ("`m'" == "full" ) {
				set scheme s2mono
				marginsplot, name(`OUTCOME'_`r'_`m'_2, replace) title("") subtitle("`SUBTITLE'") plot1opts(lcolor(black) mcolor(black) msymbol(circle) lpattern(solid)) plot2opts(lcolor(gs5) mcolor(gs5) msymbol(diamond) lpattern(shortdash)) plot3opts(lcolor(gs10) mcolor(gs10) msymbol(square) lpattern(longdash)) plot4opts(lcolor(gs7) mcolor(gs10) msymbol(triangle) lpattern(longdash_dot)) plot5opts(lcolor(gs10) mcolor(gs10) msymbol(circle) lpattern(solid)) xlabel(1 "<HS" 2 "HS" 3 "SC" 4 "AD" 5 "BD" 6 "MD" 7 "Ph.D", labsize(small)) xtitle("`XTITLE'") yscale(range(0 `YMAX')) ylabel(0(.005)`YMAX', nogrid angle(0) labsize(small)) ytitle("`YTITLE'") graphregion(fcolor(white) color(white)) legend(ring(1) pos(12) symxsize(*.8) symysize(*.6) order(1 "U.S. Born" 2 "Europe" 3 "MENA" 4 "Northern America" 5 "Oceania")) note("(HS) High School, (SC) Some College, (AD) Associate Degree," "(BD) Bachelor's, Degree, (MD) Master's Degree, (Ph.D) Doctorate")
				graph export "`OUTCOME'_`r'_`m'_2.pdf", replace
			}
				
				
				
* PANEL 3				
				logit `OUTCOME' ``m'CONTROLS3' if `r'== 1 & `SAMPLE', cluster(oregion)
			outreg2 using "`OUTCOME'", dec (3)  label word excel ci `REPLACEorAPPEND'
			margins, at(meduc_sim=(1(1)7)) over(place3_w)
			if ("`m'" == "full" ) {
				set scheme s2mono
				marginsplot, name(`OUTCOME'_`r'_`m'_3, replace) title("") subtitle("`SUBTITLE'") plot1opts(lcolor(black) mcolor(black) msymbol(circle) lpattern(solid)) plot2opts(lcolor(gs5) mcolor(gs5) msymbol(diamond) lpattern(shortdash)) plot3opts(lcolor(gs10) mcolor(gs10) msymbol(square) lpattern(longdash)) plot4opts(lcolor(gs7) mcolor(gs10) msymbol(triangle) lpattern(longdash_dot)) plot5opts(lcolor(gs10) mcolor(gs10) msymbol(circle) lpattern(solid)) xlabel(1 "<HS" 2 "HS" 3 "SC" 4 "AD" 5 "BD" 6 "MD" 7 "Ph.D", labsize(small)) xtitle("`XTITLE'") yscale(range(0 `YMAX')) ylabel(0(.005)`YMAX', nogrid angle(0) labsize(small)) ytitle("`YTITLE'") graphregion(fcolor(white) color(white)) legend(ring(1) pos(12) symxsize(*.8) symysize(*.6) order(1 "U.S. Born" 2 "Northern Europe" 3 "Western Europe" 4 "Southern Europe" 5 "Central Europe")) note("(HS) High School, (SC) Some College, (AD) Associate Degree," "(BD) Bachelor's, Degree, (MD) Master's Degree, (Ph.D) Doctorate")
				graph export "`OUTCOME'_`r'_`m'_3.pdf", replace
			}
				
				
* PANEL 4				
				logit `OUTCOME' ``m'CONTROLS4' if `r'== 1 & `SAMPLE', cluster(oregion)
			outreg2 using "`OUTCOME'", dec (3)  label word excel ci `REPLACEorAPPEND'
			margins, at(meduc_sim=(1(1)7)) over(place4_w)
			if ("`m'" == "full" ) {
				set scheme s2mono
				marginsplot, name(`OUTCOME'_`r'_`m'_4, replace) title("") subtitle("`SUBTITLE'") plot1opts(lcolor(black) mcolor(black) msymbol(circle) lpattern(solid)) plot2opts(lcolor(gs5) mcolor(gs5) msymbol(diamond) lpattern(shortdash)) plot3opts(lcolor(gs10) mcolor(gs10) msymbol(square) lpattern(longdash)) plot4opts(lcolor(gs7) mcolor(gs10) msymbol(triangle) lpattern(longdash_dot)) xlabel(1 "<HS" 2 "HS" 3 "SC" 4 "AD" 5 "BD" 6 "MD" 7 "Ph.D", labsize(small)) xtitle("`XTITLE'") yscale(range(0 `YMAX')) ylabel(0(.005)`YMAX', nogrid angle(0) labsize(small)) ytitle("`YTITLE'") graphregion(fcolor(white) color(white)) legend(ring(1) pos(12) symxsize(*.8) symysize(*.6) order(1 "U.S. Born" 2 "Russian Empire" 3 "Middle East Asia" 4 "Northern Africa")) note("(HS) High School, (SC) Some College, (AD) Associate Degree," "(BD) Bachelor's, Degree, (MD) Master's Degree, (Ph.D) Doctorate")
				graph export "`OUTCOME'_`r'_`m'_4.pdf", replace
				
			} /* m == full */
			} /* m in base full */	
				
	grc1leg `OUTCOME'_mnh_white_full_1 `OUTCOME'_mnh_white_full_2 `OUTCOME'_white_full_3 `OUTCOME'_mnh_white_full_4, rows(2) pos(12) graphregion(fcolor(white) color(white))
	graph display, xsize(25) ysize(15) 
	graph export "foreign_mnh_white_graphs.pdf", replace
			}
			
			
/*
Panel 1: Asian
NH  Native Aisan
Asian Immigrants

Panel 2: Asian
NH  Native Asian
East/Southern Asia
India/Southwest Asia

Panel 3:
NH  Native Asia
East Asia
Southeast Asia

Panel 4:
NH Native Asia
India
Bangladesh, Bhutan, Burma, Pakistan, Sri Lanka
Afghanistan, Iran, Maldives, Napal
*/
	
	if ("`r'" == "mnh_asian") {
			local SUBTITLE "Non-Hispanic Asian"
			local XTITLE " "
			local YTITLE " "
			
			local baseCONTROLS1 "i.immigrant i.mager9##i.mager9 i.meduc_sim i.meduc_sim#i.immigrant"
			
			local baseCONTROLS2 "i.native i.east_southeast_asia i.india_sw_asia i.mager9##i.mager9 i.meduc_sim i.meduc_sim#i.native i.meduc_sim#i.east_southeast_asia i.meduc_sim#i.india_sw_asia"
			
			local baseCONTROLS3 "i.native i.east_asia i.southeast_asia i.mager9##i.mager9 i.meduc_sim i.meduc_sim#i.native i.meduc_sim#i.east_asia i.meduc_sim#i.southeast_asia"
			
			local baseCONTROLS4 "i.native i.india i.south_asia1 i.south_asia2 i.mager9##i.mager9 i.meduc_sim i.meduc_sim#i.native i.meduc_sim#india i.meduc_sim#south_asia1 i.meduc_sim#south_asia2"

			local fullCONTROLS1 "i.immigrant i.mager9##i.mager9 i.meduc_sim i.meduc_sim#i.immigrant i.married i.m_gender i.lbo_rec i.oregion i.dob_yy"
			
			local fullCONTROLS2 "i.native i.east_southeast_asia i.india_sw_asia i.mager9##i.mager9 i.meduc_sim i.meduc_sim#i.native i.meduc_sim#i.east_southeast_asia i.meduc_sim#i.india_sw_asia i.married i.m_gender i.lbo_rec i.oregion i.dob_yy"
			
			local fullCONTROLS3 "i.native i.east_asia i.southeast_asia i.mager9##i.mager9 i.meduc_sim i.meduc_sim#i.native i.meduc_sim#i.east_asia i.meduc_sim#i.southeast_asia i.married i.m_gender i.lbo_rec i.oregion i.dob_yy"
			
			local fullCONTROLS4 "i.native i.india i.south_asia1 i.south_asia2 i.mager9##i.mager9 i.meduc_sim i.meduc_sim#i.native i.meduc_sim#india i.meduc_sim#south_asia1 i.meduc_sim#south_asia2 i.married i.m_gender i.lbo_rec i.oregion i.dob_yy"
			
			
			if ("`OUTCOME'" == "neonatal") {
				local YTITLE "pr(Neonatal Mortality)"
			}
			if ("`OUTCOME'" == "postneonatal") {
				local YTITLE "pr(Postneonatal Mortality)"
			}
			if ("`OUTCOME'" == "file_rec") {
				local YTITLE "pr(Infant Mortality)"
			}
		
		foreach m in base full {
			if ("`r'" == "mnh_asian" & "`m'" == "base")  {
				local REPLACEorAPPEND replace
			}
			else {
				local REPLACEorAPPEND append
			}
* PANEL 1			
			logit `OUTCOME' ``m'CONTROLS1' if `r'== 1 & `SAMPLE', cluster(oregion)
			outreg2 using "`OUTCOME'", dec (3)  label word excel ci `REPLACEorAPPEND'
			margins, at(meduc_sim=(1(1)7)) over(places1_a)
			if ("`m'" == "full" ) {
				set scheme s2mono
				marginsplot, name(`OUTCOME'_`r'_`m'_1, replace) title("") subtitle("`SUBTITLE'") plot1opts(lcolor(black) mcolor(black) msymbol(circle) lpattern(solid) ciopts(lcolor(black))) plot2opts(lcolor(gs5) mcolor(gs5) msymbol(diamond) lpattern(shortdash) ciopts(lcolor(gs5))) xlabel(1 "<HS" 2 "HS" 3 "SC" 4 "AD" 5 "BD" 6 "MD" 7 "Ph.D", labsize(small)) xtitle("`XTITLE'") yscale(range(0 `YMAX')) ylabel(0(.005)`YMAX', nogrid angle(0) labsize(small)) ytitle("`YTITLE'") graphregion(fcolor(white) color(white)) legend(ring(1) pos(12) symxsize(*.8) symysize(*.6) order(3 "U.S. Born" 4 "Immigrant")) note("(HS) High School, (SC) Some College, (AD) Associate Degree," "(BD) Bachelor's, Degree, (MD) Master's Degree, (Ph.D) Doctorate")
				graph export "`OUTCOME'_`r'_`m'_1.pdf", replace
			}
				
				
* PANEL 2				
			logit `OUTCOME' ``m'CONTROLS2' if `r'== 1 & `SAMPLE', cluster(oregion)
			outreg2 using "`OUTCOME'", dec (3)  label word excel ci `REPLACEorAPPEND'
			margins, at(meduc_sim=(1(1)7)) over(places2_a)
			if ("`m'" == "full" ) {
				set scheme s2mono
				marginsplot, name(`OUTCOME'_`r'_`m'_2, replace) title("") subtitle("`SUBTITLE'") plot1opts(lcolor(black) mcolor(black) msymbol(circle) lpattern(solid) ciopts(lcolor(black))) plot2opts(lcolor(gs5) mcolor(gs5) msymbol(diamond) lpattern(shortdash) ciopts(lcolor(gs5))) plot3opts(lcolor(gs10) mcolor(gs10) msymbol(square) lpattern(longdash) ciopts(lcolor(gs10))) xlabel(1 "<HS" 2 "HS" 3 "SC" 4 "AD" 5 "BD" 6 "MD" 7 "Ph.D", labsize(small)) xtitle("`XTITLE'") yscale(range(0 `YMAX')) ylabel(0(.005)`YMAX', nogrid angle(0) labsize(small)) ytitle("`YTITLE'") graphregion(fcolor(white) color(white)) legend(ring(1) pos(12) symxsize(*.8) symysize(*.6) order(1 "U.S. Born" 2 "East/Southeast Asia" 3 "India / Southwest Asia")) note("(HS) High School, (SC) Some College, (AD) Associate Degree," "(BD) Bachelor's, Degree, (MD) Master's Degree, (Ph.D) Doctorate")
				graph export "`OUTCOME'_`r'_`m'_2.pdf", replace
			}
				
				
				
* PANEL 3				
				logit `OUTCOME' ``m'CONTROLS3' if `r'== 1 & `SAMPLE', cluster(oregion)
			outreg2 using "`OUTCOME'", dec (3)  label word excel ci `REPLACEorAPPEND'
			margins, at(meduc_sim=(1(1)7)) over(places3_a)
			if ("`m'" == "full" ) {
				set scheme s2mono
				marginsplot, name(`OUTCOME'_`r'_`m'_3, replace) title("") subtitle("`SUBTITLE'") plot1opts(lcolor(black) mcolor(black) msymbol(circle) lpattern(solid)) plot2opts(lcolor(gs5) mcolor(gs5) msymbol(diamond) lpattern(shortdash)) plot3opts(lcolor(gs10) mcolor(gs10) msymbol(square) lpattern(longdash)) xlabel(1 "<HS" 2 "HS" 3 "SC" 4 "AD" 5 "BD" 6 "MD" 7 "Ph.D", labsize(small)) xtitle("`XTITLE'") yscale(range(0 `YMAX')) ylabel(0(.005)`YMAX', nogrid angle(0) labsize(small)) ytitle("`YTITLE'") graphregion(fcolor(white) color(white)) legend(ring(1) pos(12) symxsize(*.8) symysize(*.6) order(1 "U.S. Born" 2 "East Asia" 3 "Southeast Asia")) note("(HS) High School, (SC) Some College, (AD) Associate Degree," "(BD) Bachelor's, Degree, (MD) Master's Degree, (Ph.D) Doctorate")
				graph export "`OUTCOME'_`r'_`m'_3.pdf", replace
			}
				
				
* PANEL 4				
				logit `OUTCOME' ``m'CONTROLS4' if `r'== 1 & `SAMPLE', cluster(oregion)
			outreg2 using "`OUTCOME'", dec (3)  label word excel ci `REPLACEorAPPEND'
			margins, at(meduc_sim=(1(1)7)) over(places4_a)
			if ("`m'" == "full" ) {
				set scheme s2mono
				marginsplot, name(`OUTCOME'_`r'_`m'_4, replace) title("") subtitle("`SUBTITLE'")plot1opts(lcolor(black) mcolor(black) msymbol(circle) lpattern(solid)) plot2opts(lcolor(gs5) mcolor(gs5) msymbol(diamond) lpattern(shortdash)) plot3opts(lcolor(gs10) mcolor(gs10) msymbol(square) lpattern(longdash)) plot4opts(lcolor(gs7) mcolor(gs10) msymbol(triangle) lpattern(longdash_dot)) xlabel(1 "<HS" 2 "HS" 3 "SC" 4 "AD" 5 "BD" 6 "MD" 7 "Ph.D", labsize(small)) xtitle("`XTITLE'") yscale(range(0 `YMAX')) ylabel(0(.005)`YMAX', nogrid angle(0) labsize(small)) ytitle("`YTITLE'") graphregion(fcolor(white) color(white)) legend(ring(1) pos(12) symxsize(*.8) symysize(*.6) order(1 "U.S. Born" 2 "India" 3 "South Asia" 4 "South Asia Subdivision")) note("(HS) High School, (SC) Some College, (AD) Associate Degree," "(BD) Bachelor's, Degree, (MD) Master's Degree, (Ph.D) Doctorate")
				graph export "`OUTCOME'_`r'_`m'_4.pdf", replace
				
			} /* m == full */
			} /* m in base full */	
				
	grc1leg `OUTCOME'_mnh_asian_full_1 `OUTCOME'_mnh_asian_full_2 `OUTCOME'_mnh_asian_full_3 `OUTCOME'_mnh_asian_full_4, rows(2) pos(12) graphregion(fcolor(white) color(white))  
	graph display, xsize(25) ysize(15) 
	graph export "foreign_mnh_asian_graphs.pdf", replace
			}
			
/*
Panel 1:
Native Hispanic
Immigrant Hispanic

Panel 2:
Native Hispanic
Mexico/Central America/South America
Spanish-Speaking Caribean

Panel 3:
Native Hispanic
Mexico
Central America
South America

Panel 4:
Native Hispanic
Cuba
Dominican Republic
*/
	
	if ("`r'" == "m_hispanic") {
			local SUBTITLE "Hispanic"
			local XTITLE " "
			local YTITLE " "
			
			local baseCONTROLS1 "i.immigrant i.mager9##i.mager9 i.meduc_sim i.meduc_sim#i.immigrant"
			
			local baseCONTROLS2 "i.native i.hispplaces i.span_speak_carib i.mager9##i.mager9 i.meduc_sim i.meduc_sim#i.native i.meduc_sim#i.hispplaces i.meduc_sim#i.span_speak_carib"
			
			local baseCONTROLS3 "i.native i.mexico i.centamerica i.samerica i.mager9##i.mager9 i.meduc_sim i.meduc_sim#i.native i.meduc_sim#i.mexico i.meduc_sim#i.centamerica i.meduc_sim#i.samerica"
			
			local baseCONTROLS4 "i.native i.cuba i.domrep i.mager9##i.mager9 i.meduc_sim i.meduc_sim#i.native i.meduc_sim#i.cuba i.meduc_sim#i.domrep"

			local fullCONTROLS1 "i.immigrant i.mager9##i.mager9 i.meduc_sim i.meduc_sim#i.immigrant i.married i.m_gender i.lbo_rec i.oregion i.dob_yy"
			
			local fullCONTROLS2 "i.native i.hispplaces i.span_speak_carib i.mager9##i.mager9 i.meduc_sim i.meduc_sim#i.native i.meduc_sim#i.hispplaces i.meduc_sim#i.span_speak_carib i.married i.m_gender i.lbo_rec i.oregion i.dob_yy"
			
			local fullCONTROLS3 "i.native i.mexico i.centamerica i.samerica i.mager9##i.mager9 i.meduc_sim i.meduc_sim#i.native i.meduc_sim#i.mexico i.meduc_sim#i.centamerica i.meduc_sim#i.samerica i.married i.m_gender i.lbo_rec i.oregion i.dob_yy"
			
			local fullCONTROLS4 "i.native .cuba i.domrep i.mager9##i.mager9 i.meduc_sim i.meduc_sim#i.native i.meduc_sim#i.cuba i.meduc_sim#i.domrep i.married i.m_gender i.lbo_rec i.oregion i.dob_yy"
			
			
			if ("`OUTCOME'" == "neonatal") {
				local YTITLE "pr(Neonatal Mortality)"
			}
			if ("`OUTCOME'" == "postneonatal") {
				local YTITLE "pr(Postneonatal Mortality)"
			}
			if ("`OUTCOME'" == "file_rec") {
				local YTITLE "pr(Infant Mortality)"
			}
		
		foreach m in base full {
			if ("`r'" == "m_hispanic" & "`m'" == "base")  {
				local REPLACEorAPPEND replace
			}
			else {
				local REPLACEorAPPEND append
			}
* PANEL 1			
			logit `OUTCOME' ``m'CONTROLS1' if `r'== 1 & `SAMPLE', cluster(oregion)
			outreg2 using "`OUTCOME'", dec (3)  label word excel ci `REPLACEorAPPEND'
			margins, at(meduc_sim=(1(1)7)) over(places1_h)
			if ("`m'" == "full" ) {
				set scheme s2mono
				marginsplot, name(`OUTCOME'_`r'_`m'_1, replace) title("") subtitle("`SUBTITLE'") plot1opts(lcolor(black) mcolor(black) msymbol(circle) lpattern(solid)) plot2opts(lcolor(gs5) mcolor(gs5) msymbol(diamond) lpattern(shortdash)) xlabel(1 "<HS" 2 "HS" 3 "SC" 4 "AD" 5 "BD" 6 "MD" 7 "Ph.D", labsize(small)) xtitle("`XTITLE'") yscale(range(0 `YMAX')) ylabel(0(.005)`YMAX', nogrid angle(0) labsize(small)) ytitle("`YTITLE'") graphregion(fcolor(white) color(white)) legend(ring(1) pos(12) symxsize(*.8) symysize(*.6) order(3 "U.S. Born" 4 "Immigrant")) note("(HS) High School, (SC) Some College, (AD) Associate Degree," "(BD) Bachelor's, Degree, (MD) Master's Degree, (Ph.D) Doctorate")
				graph export "`OUTCOME'_`r'_`m'_1.pdf", replace
			}
				
				
* PANEL 2				
			logit `OUTCOME' ``m'CONTROLS2' if `r'== 1 & `SAMPLE', cluster(oregion)
			outreg2 using "`OUTCOME'", dec (3)  label word excel ci `REPLACEorAPPEND'
			margins, at(meduc_sim=(1(1)7)) over(places2_h)
			if ("`m'" == "full" ) {
				set scheme s2mono
				marginsplot, name(`OUTCOME'_`r'_`m'_2, replace) title("") subtitle("`SUBTITLE'") plot1opts(lcolor(black) mcolor(black) msymbol(circle) lpattern(solid)) plot2opts(lcolor(gs5) mcolor(gs5) msymbol(diamond) lpattern(shortdash)) plot3opts(lcolor(gs10) mcolor(gs10) msymbol(square) lpattern(longdash)) xlabel(1 "<HS" 2 "HS" 3 "SC" 4 "AD" 5 "BD" 6 "MD" 7 "Ph.D", labsize(small)) xtitle("`XTITLE'") yscale(range(0 `YMAX')) ylabel(0(.005)`YMAX', nogrid angle(0) labsize(small)) ytitle("`YTITLE'") graphregion(fcolor(white) color(white)) legend(ring(1) pos(12) symxsize(*.8) symysize(*.6) order(1 "U.S. Born" 2 "Mexico/Central America/South America" 3 "Spanish-Speaking Caribean")) note("(HS) High School, (SC) Some College, (AD) Associate Degree," "(BD) Bachelor's, Degree, (MD) Master's Degree, (Ph.D) Doctorate")
				graph export "`OUTCOME'_`r'_`m'_2.pdf", replace
			}
				
				
				
* PANEL 3				
				logit `OUTCOME' ``m'CONTROLS3' if `r'== 1 & `SAMPLE', cluster(oregion)
			outreg2 using "`OUTCOME'", dec (3)  label word excel ci `REPLACEorAPPEND'
			margins, at(meduc_sim=(1(1)7)) over(places3_h)
			if ("`m'" == "full" ) {
				set scheme s2mono
				marginsplot, name(`OUTCOME'_`r'_`m'_3, replace) title("") subtitle("`SUBTITLE'")plot1opts(lcolor(black) mcolor(black) msymbol(circle) lpattern(solid)) plot2opts(lcolor(gs5) mcolor(gs5) msymbol(diamond) lpattern(shortdash)) plot3opts(lcolor(gs10) mcolor(gs10) msymbol(square) lpattern(longdash)) plot4opts(lcolor(gs7) mcolor(gs10) msymbol(triangle) lpattern(longdash_dot)) xlabel(1 "<HS" 2 "HS" 3 "SC" 4 "AD" 5 "BD" 6 "MD" 7 "Ph.D", labsize(small)) xtitle("`XTITLE'") yscale(range(0 `YMAX')) ylabel(0(.005)`YMAX', nogrid angle(0) labsize(small)) ytitle("`YTITLE'") graphregion(fcolor(white) color(white)) legend(ring(1) pos(12) symxsize(*.8) symysize(*.6) order(1 "U.S. Born" 2 "Mexico" 3 "Central America" 4 "South America")) note("(HS) High School, (SC) Some College, (AD) Associate Degree," "(BD) Bachelor's, Degree, (MD) Master's Degree, (Ph.D) Doctorate")
				graph export "`OUTCOME'_`r'_`m'_3.pdf", replace
			}
				
				
* PANEL 4				
				logit `OUTCOME' ``m'CONTROLS4' if `r'== 1 & `SAMPLE', cluster(oregion)
			outreg2 using "`OUTCOME'", dec (3)  label word excel ci `REPLACEorAPPEND'
			margins, at(meduc_sim=(1(1)7)) over(places4_h)
			if ("`m'" == "full" ) {
				set scheme s2mono
				marginsplot, name(`OUTCOME'_`r'_`m'_4, replace) title("") subtitle("`SUBTITLE'") plot1opts(lcolor(black) mcolor(black) msymbol(circle) lpattern(solid)) plot2opts(lcolor(gs5) mcolor(gs5) msymbol(diamond) lpattern(shortdash)) plot3opts(lcolor(gs10) mcolor(gs10) msymbol(square) lpattern(longdash)) xlabel(1 "<HS" 2 "HS" 3 "SC" 4 "AD" 5 "BD" 6 "MD" 7 "Ph.D", labsize(small)) xtitle("`XTITLE'") yscale(range(0 `YMAX')) ylabel(0(.005)`YMAX', nogrid angle(0) labsize(small)) ytitle("`YTITLE'") graphregion(fcolor(white) color(white)) legend(ring(1) pos(12) symxsize(*.8) symysize(*.6) order(1 "U.S. Born" 2 "Cuba" 3 "Dominican Republic")) note("(HS) High School, (SC) Some College, (AD) Associate Degree," "(BD) Bachelor's, Degree, (MD) Master's Degree, (Ph.D) Doctorate")
				graph export "`OUTCOME'_`r'_`m'_4.pdf", replace
				
			} /* m == full */
			} /* m in base full */	
				
	grc1leg `OUTCOME'_m_hispanic_full_1 `OUTCOME'_m_hispanic_full_2 `OUTCOME'_m_hispanic_full_3 `OUTCOME'_m_hispanic_full_4, rows(2) pos(12) graphregion(fcolor(white) color(white))  
	graph display, xsize(25) ysize(15) 
	graph export "foreign_m_hispanic_graphs.pdf", replace
			}	
			
		} /* r in xmwhite xmblack xmlat xmasian */
} /* OUTCOME in neo postneo infant */
		
log close








// ************************ General **************************************************
//
// foreach OUTCOME in neonatal postneonatal file_rec {
// 	if ("`OUTCOME'" == "neonatal" | "`OUTCOME'" == "file_rec") {
// 		local SAMPLE " 1 == 1 "
// 	}
// 	else { 
// 		local SAMPLE "neonatal == 0 "
// 	}
// 	if ("`OUTCOME'" == "neonatal" | "`OUTCOME'" == "postneonatal") {
// 		local YMAX .01
// 	}
// 	else {
// 		local YMAX .015
// 	}
// 	if ("`OUTCOME'" == "neonatal") {
// 		local YTITLE "pr(Neonatal Mortality)"
// 	}
// 		if ("`OUTCOME'" == "postneonatal") {
// 		local YTITLE "pr(Postneonatal Mortality)"
// 	}
// 	if ("`OUTCOME'" == "file_rec") {
// 		local YTITLE "pr(Infant Mortality)"
// 	}
// 	foreach r in mnh_white mnh_black m_hispanic mnh_asian {
// 		if ("`r'" == "mnh_white") {
// 			local SUBTITLE "Non-Hispanic White"
// 			local XTITLE  " "
// 		}
// 		if ("`r'" == "mnh_black") {
// 			local SUBTITLE "Non-Hispanic Black"
// 			local XTITLE " "
// 			local YTITLE " "
// 		}
// 		if ("`r'" == "m_hispanic") {
// 			local SUBTITLE "Hispanic"
// 			local XTITLE "Maternal Education"
// 			if ("`OUTCOME'" == "neonatal") {
// 				local YTITLE "pr(Neonatal Mortality)"
// 			}
// 			if ("`OUTCOME'" == "postneonatal") {
// 				local YTITLE "pr(Postneonatal Mortality)"
// 			}
// 			if ("`OUTCOME'" == "file_rec") {
// 				local YTITLE "pr(Infant Mortality)"
// 			}
// 		}
// 		if ("`r'" == "mnh_asian") {
// 			local SUBTITLE "Non-Hispanic Asian"
// 			local XTITLE "Maternal Education"
// 			local YTITLE " "
// 		}
// 		foreach m in base full {
// 			if ("`r'" == "mnh_white" & "`m'" == "base")  {
// 				local REPLACEorAPPEND replace
// 			}
// 			else {
// 				local REPLACEorAPPEND append
// 			}
// 			logit `OUTCOME' ``m'CONTROLS' if `r'== 1 & `SAMPLE', cluster(oregion)
// 			outreg2 using "`OUTCOME'", dec (3)  label word excel ci `REPLACEorAPPEND'
// 			margins, at(meduc_sim=(1(1)7)) over(immigrant)
// 			if ("`m'" == "full" ) {
// 				set scheme s2mono
// 				marginsplot, name(`OUTCOME'_`r'_`m', replace) title("") subtitle("`SUBTITLE'") plot1opts(lcolor(black) mcolor(black) msymbol(circle)) ci1opts(lcolor(black)) plot2opts(lcolor(black) mcolor(black) msymbol(circle) lpattern(dash)) ci2opts(lcolor(black)) xlabel(1 "<HS" 2 "HS" 3 "SC" 4 "AD" 5 "BD" 6 "MD" 7 "Ph.D") xtitle("`XTITLE'") yscale(range(0 `YMAX')) ylabel(0(.005)`YMAX', nogrid angle(0)) ytitle("`YTITLE'") graphregion(fcolor(white) color(white)) legend(ring(1) pos(12) symxsize(*.8) symysize(*.6) order(3 "U.S. Born" 4 "Immigrant"))  xlabel(1 "<HS" 2 "HS" 3 "SC" 4 "AD" 5 "BD" 6 "MD" 7 "Ph.D") 
// 				graph export "`OUTCOME'_`r'_`m'.pdf", replace
// 			} /* m == full */
// 		} /* m in base full */	
// 	} /* r in xmwhite xmblack xmlat xmasian */
// 	grc1leg `OUTCOME'_mnh_white_full `OUTCOME'_mnh_black_full `OUTCOME'_m_hispanic_full `OUTCOME'_mnh_asian_full, rows(2) pos(12) graphregion(fcolor(white) color(white))  
// 	graph display, xsize(7.5) ysize(8.5) 
// 	graph export "`OUTCOME'_4graphs.pdf", replace
// } /* OUTCOME in neo postneo infant */
//
