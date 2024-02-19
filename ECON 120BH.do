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

// Cluster data based on citizenship and race
