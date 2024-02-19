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

