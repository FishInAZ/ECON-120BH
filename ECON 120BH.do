*********************************************
*Econ 120BH, Winter 2023
*Name (First, Last): Chenyu Li and Chen Li
*********************************************

clear all
set more off
cap log close

capture cd "/Users/chenyu/Documents/GitHub/ECON-120BH/usa_00003.dta" //!!\\ PATH TO WORKING DIRECTORY HERE

// Load the dataset
use usa_00003.dta, clear

// describe the dataset
describe

// table of statitics
summarize

// Data Wrangling
// remove n/a and missing data
drop if citizen == 0 | citizen == 9
drop if yrsusa1 == 00
drop if speakeng == 0 | speakeng == 9
drop if gradeatt == 0
drop if degfield == 00
drop if degfieldd == 0000
drop if degfield2 == 00
drop if degfield2d == 0000
drop if empstat == 0
drop if empstatd == 00
drop if uhrswork == 00
drop if incwage == 9999999 | incwage == 999998
drop if vetstat == 0 | vetstat == 9
drop if vetstatd == 00 | vetstat == 99

// remove irrelevant vars
drop gradeattd degfieldd degfield2 degfield2 degfield2d degfieldd empstatd vetstatd
drop ind // un-recorded data

// mutate new dummy var: 0 is white and 1 is asian
gen race = .
replace race = 0 if racwht == 2 // the person is white
replace race = 1 if racasian == 2
label define race_lbl 0 "White" 1 "Asian"
label values race race_lbl

// remove race vars
drop if race == .
drop racasian racwht

* Adjust degree of field to generalized category:

* Generate the new variable with missing values
gen major_field = .

* STEM fields
foreach val in 11 13 14 21 24 25 36 37 50 51 {
    replace major_field = 1 if degfield == `val'
}

* Business
replace major_field = 2 if degfield == 62

* Arts and Humanities
foreach val in 15 33 34 48 49 60 64 {
    replace major_field = 3 if degfield == `val'
}

* Vocational
foreach val in 20 22 29 32 52 54 56 57 58 59 {
    replace major_field = 4 if degfield == `val'
}

* Others - Catch-all for any field not previously categorized
replace major_field = 5 if major_field == .

* Label the new categories
label define major_field_lbl 1 "STEM" 2 "Business" 3 "Arts and Humanities" 4 "Vocational" 5 "Other"
label values major_field major_field_lbl

//Data Analysis
// Revenue
tabulate race stateicp, summarize(incwage)
graph box incwage, over(race) horizontal
graph bar incwage, over(stateicp) over(race) asyvars

// Hourly wage
gen hourly_wage = incwage / (uhrswork*52)

// regression
gen ln_incwage = ln(hourly_wage) // create log wage

// Original Version
regress ln_incwage i.stateicp i.sex age i.marst i.citizen yrsusa1 i.speakeng i.gradeatt i.major_field i.empstat uhrswork i.vetstat i.race i.race##i.stateicp i.race##i.sex i.race##i.marst i.race##i.gradeatt i.race##i.major_field i.race##i.empstat i.race##c.uhrswork i.race##i.speakeng, robust
