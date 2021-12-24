//------------------------------------------------------------------------------
//
//  Title: Research Practicum 1 (SASR04)
//  Author(s): Yuxuan Jin, Edit: Sven Strating
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
	
	usespss "SASR4_dataclean.dta", clear

//------------------------------------------------------------------------------


// Some sensitive analysis

* Jackknife procedure: exclude each country in turns
	reg wlb c.overtime ///
		    i.flex i.parental i.childcare ///
		    i.female c.age c.age2 c.edu c.incomehlog i.partner i.child c.age_child ///
			c.tenure i.supervisory c.size i.sector_g i.sector i.country_1 ///
			if country_1!=9
	est store a1
	
	reg wlb c.overtime ///
		    i.flex i.parental i.childcare ///
		    i.female c.age c.age2 c.edu c.incomehlog i.partner i.child c.age_child ///
			c.tenure i.supervisory c.size i.sector_g i.sector i.country_1 ///
			c.overtime#i.flex if country_1!=9
	est store a2
	
	reg wlb c.overtime ///
		    i.flex i.parental i.childcare ///
		    i.female c.age c.age2 c.edu c.incomehlog i.partner i.child c.age_child ///
			c.tenure i.supervisory c.size i.sector_g i.sector i.country_1 ///
			c.overtime#i.parental if country_1!=9
	est store a3
	
	reg wlb c.overtime ///
		    i.flex i.parental i.childcare ///
		    i.female c.age c.age2 c.edu c.incomehlog i.partner i.child c.age_child ///
			c.tenure i.supervisory c.size i.sector_g i.sector i.country_1 ///
			c.overtime#i.childcare if country_1!=9
	est store a4
	
	esttab a1 a2 a3 a4 ///
	using "U:\SaSR3/SASR4_UK.rtf", ///
	r2 bic cells(b(star fmt(3)) se(par fmt(2)))   ///
    legend label varlabels(_cons constant) ///
	replace nobaselevels
	eststo clear	

* Welfare states
	*only Finland and Sweden
	reg wlb c.overtime ///
		    i.flex i.parental i.childcare ///
		    i.female c.age c.age2 c.edu c.incomehlog i.partner i.child c.age_child ///
			c.tenure i.supervisory c.size i.sector_g i.sector i.country_1 ///
			if country_1!=2 & country_1!=8
	est store a1
	
	reg wlb c.overtime ///
		    i.flex i.parental i.childcare ///
		    i.female c.age c.age2 c.edu c.incomehlog i.partner i.child c.age_child ///
			c.tenure i.supervisory c.size i.sector_g i.sector i.country_1 ///
			c.overtime#i.flex if country_1!=2 & country_1!=8
	est store a2
	
	reg wlb c.overtime ///
		    i.flex i.parental i.childcare ///
		    i.female c.age c.age2 c.edu c.incomehlog i.partner i.child c.age_child ///
			c.tenure i.supervisory c.size i.sector_g i.sector i.country_1 ///
			c.overtime#i.parental if country_1!=2 & country_1!=8
	est store a3
	
	reg wlb c.overtime ///
		    i.flex i.parental i.childcare ///
		    i.female c.age c.age2 c.edu c.incomehlog i.partner i.child c.age_child ///
			c.tenure i.supervisory c.size i.sector_g i.sector i.country_1 ///
			c.overtime#i.childcare if country_1!=2 & country_1!=8
	est store a4
	
	esttab a1 a2 a3 a4 ///
	using "U:\SaSR3/SASR4_Finland&Sweden.rtf", ///
	r2 bic cells(b(star fmt(3)) se(par fmt(3)))   ///
    legend label varlabels(_cons constant) ///
	replace nobaselevels
	eststo clear
	
	
	*Only Germany and Netherlands
	reg wlb c.overtime ///
		    i.flex i.parental i.childcare ///
		    i.female c.age c.age2 c.edu c.incomehlog i.partner i.child c.age_child ///
			c.tenure i.supervisory c.size i.sector_g i.sector i.country_1 ///
			if country_1!=3 & country_1!=5
	est store a1
	
	reg wlb c.overtime ///
		    i.flex i.parental i.childcare ///
		    i.female c.age c.age2 c.edu c.incomehlog i.partner i.child c.age_child ///
			c.tenure i.supervisory c.size i.sector_g i.sector i.country_1 ///
			c.overtime#i.flex if country_1!=3 & country_1!=5
	est store a2
	
	reg wlb c.overtime ///
		    i.flex i.parental i.childcare ///
		    i.female c.age c.age2 c.edu c.incomehlog i.partner i.child c.age_child ///
			c.tenure i.supervisory c.size i.sector_g i.sector i.country_1 ///
			c.overtime#i.parental if country_1!=3 & country_1!=5
	est store a3
	
	reg wlb c.overtime ///
		    i.flex i.parental i.childcare ///
		    i.female c.age c.age2 c.edu c.incomehlog i.partner i.child c.age_child ///
			c.tenure i.supervisory c.size i.sector_g i.sector i.country_1 ///
			c.overtime#i.childcare if country_1!=3 & country_1!=5
	est store a4
	
	esttab a1 a2 a3 a4 ///
	using "U:\SaSR3/SASR4_Germany&NL.rtf", ///
	r2 bic cells(b(star fmt(3)) se(par fmt(3)))   ///
    legend label varlabels(_cons constant) ///
	replace nobaselevels
	eststo clear	
	
	*Only UK
	tab country
	reg wlb c.overtime ///
		    i.flex i.parental i.childcare ///
		    i.female c.age c.age2 c.edu c.incomehlog i.partner i.child c.age_child ///
			c.tenure i.supervisory c.size i.sector_g i.sector ///
			if country_1==9
	est store a1
	
	reg wlb c.overtime ///
		    i.flex i.parental i.childcare ///
		    i.female c.age c.age2 c.edu c.incomehlog i.partner i.child c.age_child ///
			c.tenure i.supervisory c.size i.sector_g i.sector ///
			c.overtime#i.flex if country_1==9
	est store a2
	
	reg wlb c.overtime ///
		    i.flex i.parental i.childcare ///
		    i.female c.age c.age2 c.edu c.incomehlog i.partner i.child c.age_child ///
			c.tenure i.supervisory c.size i.sector_g i.sector ///
			c.overtime#i.parental if country_1==9
	est store a3
	
	reg wlb c.overtime ///
		    i.flex i.parental i.childcare ///
		    i.female c.age c.age2 c.edu c.incomehlog i.partner i.child c.age_child ///
			c.tenure i.supervisory c.size i.sector_g i.sector ///
			c.overtime#i.childcare if country_1==9
	est store a4
	
	esttab a1 a2 a3 a4 ///
	using "U:\SaSR3/SASR4_only_UK.rtf", ///
	r2 bic cells(b(star fmt(3)) se(par fmt(3)))   ///
    legend label varlabels(_cons constant) ///
	replace nobaselevels
	eststo clear	

	*Other countries
	reg wlb c.overtime ///
		    i.flex i.parental i.childcare ///
		    i.female c.age c.age2 c.edu c.incomehlog i.partner i.child c.age_child ///
			c.tenure i.supervisory c.size i.sector_g i.sector i.country_1 ///
			if (country_1==1 | country_1==4 | country_1==6 | country_1==7 | country_1==9)
	est store a1
	
	reg wlb c.overtime ///
		    i.flex i.parental i.childcare ///
		    i.female c.age c.age2 c.edu c.incomehlog i.partner i.child c.age_child ///
			c.tenure i.supervisory c.size i.sector_g i.sector i.country_1 ///
			c.overtime#i.flex if (country_1==1 | country_1==4 | country_1==6 | country_1==7 | country_1==9)
	est store a2
	
	reg wlb c.overtime ///
		    i.flex i.parental i.childcare ///
		    i.female c.age c.age2 c.edu c.incomehlog i.partner i.child c.age_child ///
			c.tenure i.supervisory c.size i.sector_g i.sector i.country_1 ///
			c.overtime#i.parental if (country_1==1 | country_1==4 | country_1==6 | country_1==7 | country_1==9)
	est store a3
	
	reg wlb c.overtime ///
		    i.flex i.parental i.childcare ///
		    i.female c.age c.age2 c.edu c.incomehlog i.partner i.child c.age_child ///
			c.tenure i.supervisory c.size i.sector_g i.sector i.country_1 ///
			c.overtime#i.childcare if (country_1==1 | country_1==4 | country_1==6 | country_1==7 | country_1==9)
	est store a4
	
	esttab a1 a2 a3 a4 ///
	using "U:\SaSR3/SASR4_Other.rtf", ///
	r2 bic cells(b(star fmt(3)) se(par fmt(3)))   ///
    legend label varlabels(_cons constant) ///
	replace nobaselevels
	eststo clear	
	
* Seperate child 
	reg wlb c.overtime ///
		    i.flex i.parental i.childcare ///
		    i.female c.age c.age2 c.edu c.incomehlog i.partner c.age_child ///
			c.tenure i.supervisory c.size i.sector_g i.sector i.country_1 ///
			if child==1
	est store B

	reg wlb c.overtime ///
		    i.flex i.parental i.childcare ///
		    i.female c.age c.age2 c.edu c.incomehlog i.partner c.age_child ///
			c.tenure i.supervisory c.size i.sector_g i.sector i.country_1 ///
			c.overtime#i.flex if child==1

	est store C
	
	reg wlb c.overtime ///
		    i.flex i.parental i.childcare ///
		    i.female c.age c.age2 c.edu c.incomehlog i.partner c.age_child ///
			c.tenure i.supervisory c.size i.sector_g i.sector i.country_1 ///
			c.overtime#i.parental if child==1

	est store D
	
	reg wlb c.overtime ///
		    i.flex i.parental i.childcare ///
		    i.female c.age c.age2 c.edu c.incomehlog i.partner c.age_child ///
			c.tenure i.supervisory c.size i.sector_g i.sector i.country_1 ///
			c.overtime#i.childcare if child==1
	est store E

	esttab B C D E ///
	using "U:\SaSR3/data/SASR4_child.rtf", ///
	r2 bic cells(b(star fmt(3)) se(par fmt(2)))   ///
    legend label varlabels(_cons constant) ///
	replace nobaselevels
	eststo clear	

* Seprate children under 4 years old
	reg wlb c.overtime ///
		    i.flex i.parental i.childcare ///
		    i.female c.age c.age2 c.edu c.incomehlog i.partner ///
			c.tenure i.supervisory c.size i.sector_g i.sector i.country_1 ///
			if child==1 & age_child<=4
	est store B

	reg wlb c.overtime ///
		    i.flex i.parental i.childcare ///
		    i.female c.age c.age2 c.edu c.incomehlog i.partner ///
			c.tenure i.supervisory c.size i.sector_g i.sector i.country_1 ///
			c.overtime#i.flex if child==1 & age_child<=4

	est store C
	
	reg wlb c.overtime ///
		    i.flex i.parental i.childcare ///
		    i.female c.age c.age2 c.edu c.incomehlog i.partner ///
			c.tenure i.supervisory c.size i.sector_g i.sector i.country_1 ///
			c.overtime#i.parental if child==1 & age_child<=4

	est store D
	
	reg wlb c.overtime ///
		    i.flex i.parental i.childcare ///
		    i.female c.age c.age2 c.edu c.incomehlog i.partner ///
			c.tenure i.supervisory c.size i.sector_g i.sector i.country_1 ///
			c.overtime#i.childcare if child==1 & age_child<=4
	est store E

	esttab B C D E ///
	using "U:\SaSR3/SASR4_child_age4.rtf", ///
	r2 bic cells(b(star fmt(3)) se(par fmt(3)))   ///
    legend label varlabels(_cons constant) ///
	replace nobaselevels
	eststo clear

//------------------------------------------------------------------------------
exit
	