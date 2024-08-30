//PTB by Race, Hispanic Ethnicity and Nativity

//2014 & 2015 appended file

clear

capture log close

cd "/Users/billyswartwout/Dropbox (Princeton)/Swartwout_Hamilton/Data Sets"

log using ptb_latinx_birthplace_billy,text replace

use "/Users/billyswartwout/Dropbox (Princeton)/Swartwout_Hamilton/Data Sets/LKBC2014USDenom_plus.AllCnty_madevars.dta", clear

append using "/Users/billyswartwout/Dropbox (Princeton)/Swartwout_Hamilton/Data Sets/LKBC2015USDenom_plus.AllCnty_madevars.dta"

save "/Users/billyswartwout/Dropbox (Princeton)/Swartwout_Hamilton/Data Sets/LKBC2014_15appendedUSDenom_plus.AllCnty.dta", replace


