//------------------------------------------------------------------------------
//
//  Title: Research Practicum 1 (SASR04)
//  Author(s): Yuxuan Jin, Sven Strating
//  Date: 16-12-2021
//  Code version: 16
//  Availability: (GitHub)
//
//------------------------------------------------------------------------------
    cd "U:\SaSR3" // Change this working directory"
    clear all
    set more off
    set linesize 80
	version 16
	
	use "SASR4_dataclean.dta", clear

//------------------------------------------------------------------------------


**1. Descriptive statistics
	desctable  wlb overtime///
			 i.flex i.parental i.childcare ///
			 i.female age edu incomehlog i.partner i.child age_child /// 
			 tenure i.supervisory size i.sector_g i.sector i.country_1, ///
			 filename("descriptive statistics") decimals(3)	


**2. Regression analysis

// A. Direct effects
	reg wlb overtime
	reg wlb c.overtime ///
		    i.flex i.parental i.childcare ///
		    i.female c.age c.edu c.incomehlog i.partner ///
			i.child c.age_child c.tenure i.supervisory c.size /// 
			i.sector_g i.sector i.country_1
	est store A

	reg wlb c.overtime ///
		    i.flex i.parental i.childcare ///
		    i.female c.age c.age2 c.edu c.incomehlog i.partner ///
			i.child c.age_child c.tenure i.supervisory c.size ///
			i.sector_g i.sector i.country_1, allbase
	est store B
	
	lrtest A B // it is better to include age2

// B. Interaction effects
	reg wlb c.overtime ///
		    i.flex i.parental i.childcare ///
		    i.female c.age c.age2 c.edu c.incomehlog i.partner ///
			i.child c.age_child c.tenure i.supervisory c.size ///
			i.sector_g i.sector i.country_1 c.overtime#i.flex
	est store C
	
	reg wlb c.overtime ///
		    i.flex i.parental i.childcare ///
		    i.female c.age c.age2 c.edu c.incomehlog i.partner ///
			i.child c.age_child c.tenure i.supervisory c.size ///
			i.sector_g i.sector i.country_1 c.overtime#i.parental
	est store D
	
	reg wlb c.overtime ///
		    i.flex i.parental i.childcare ///
		    i.female c.age c.age2 c.edu c.incomehlog i.partner ///
			i.child c.age_child c.tenure i.supervisory c.size ///
			i.sector_g i.sector i.country_1 c.overtime#i.childcare
	est store E

	esttab B C D E ///
	using "U:\SaSR3/SASR4_reg.rtf", ///
	r2 bic cells(b(star fmt(3)) se(par fmt(2)))   ///
    legend label varlabels(_cons constant) ///
	replace nobaselevels
	eststo clear	
	
// Interaction - graphical representation
   est restore C
   quietly margins, at(over=(0(2)30)) over(flex) saving(file_1, replace)
   marginsplot
   
   est restore D
   quietly margins, at(over=(0(2)30)) over(parental) saving(file_2, replace)
   marginsplot
	
   est restore E
   quietly margins, at(over=(0(2)30)) over(childcare) saving(file_3, replace)
   marginsplot

   ssc instal combomarginsplot
   combomarginsplot file_1 file_2 file_3, ///
   labels("Flexiblity" "Parental" "Childcare") noci
   // remaining formatting can be done by 'hand'

//------------------------------------------------------------------------------
exit
	
	
