//------------------------------------------------------------------------------
//
//  Title: Research Practicum 1 (SASR04)
//  Author(s): Yuxuan Jin, Edit: Sven Strating
//  Date: 16-12-2021
//  Code version: 16
//  Availability: (GitHub)
//
//------------------------------------------------------------------------------
    cd "U:\SaSR4" // Change this working directory"
    clear all
    set more off
    set linesize 80
	version 16
	
	usespss "SWS EQ SASR4_inc income & education.sav", clear

//------------------------------------------------------------------------------


**1. Construct new variables - IV AND DV

// A. Overtime
	codebook Q6_1 Q7
	tab Q6
	summ Q6_1 if !missing(Q6_1)
	summ Q7 if !missing(Q7)
	gen overtime = Q7-Q6_1 if !missing(Q6_1,Q7)
	summ overtime if !missing(overtime)
	
	replace overtime=0 if overtime<0
	
	// As Tanja mentioned, I change time<0 = 0 
	// Because they do not work overtime
	
	summ overtime if !missing(overtime)	
	tab overtime
	mvdecode overtime, mv(120)

	label var overtime "overtime"
		
// B. Work-life balance (abbrev. WLB)
	codebook Q75*
	tab Q75_1
	tab Q75_2
	tab Q75_3
	
	factor Q75_1 Q75_2 Q75_3 if !missing(Q75_1, Q75_2, Q75_3)
	screeplot
	pca Q75_1 Q75_2 Q75_3 if !missing(Q75_1, Q75_2, Q75_3)
	screeplot
	
	// Conclusion: they can measure the only one same concept
	
	alpha Q75_1 Q75_2 Q75_3, casewise item std 
	// Alpha: 0.8562 high reliability

	egen wlb = rowmean(Q75_1 Q75_2 Q75_3)
	label var wlb "work-life balance"
	// Construct new variables of work-life balance 

// C. The use of family-friendly policies (individual level)

*1. Flexibility policy 
*Q15 In the past 12 months, 
     //did you decide your own starting and finishing times?	
	codebook Q15
	recode Q15 (1=1 "Yes") (2=0 "No")(*=.), gen(flex)
	label var flex "flexibility policy"
	codebook flex
	
*2. Leave policy  - parental leave
*Q44 Did you use any of the following leave arrangements 
     //in connection with the birth of your youngest child?
	codebook Q44_2
	recode Q44_2 (1=0 "No")(2=1 "Yes")(*=.), gen(parental)
	replace parental=0 if missing(parental)
	codebook parental
	label var parental "parental leave"
	
*3. Childcare policy 	
*Q51 Do you make use of childcare assistance offered by the organisation 
     //(or have you done so in the past)?Multiple answers are possible.	
	codebook Q51*
	gen childcare = 0
	replace childcare = 1 if (Q51_1==1 | Q51_2==1 | Q51_3==1)
	label define child_l 1 "Yes" 0 "No"
	label values childcare child_1
	label var childcare "childcare policy"
	codebook childcare


**2. Construct new variables - Control variables
	
// A. Individual level
*1. Gender
	codebook Q11
	recode Q11 (1=0 "male") (2=1 "female")(*=.), gen(female)
	label var female "female"
	
*2. Age / Age2
	codebook Q12
	gen age = Q12
	label var age "age"
	
	gen age2 = age*age
	label var age2 "age squared"
	
*3. Education (treat as continous)
	codebook edu
	label var edu "highest educational level"

*4. Income
	codebook incomehlog
	
*5. Live with partner
	tab Q82
	recode Q82 (1=1 "Yes")(2=0 "No")(*=.), gen(partner)
	label var partner "living with partner"
	
*6  Live with children
	codebook Q89 
	recode Q89 (1=1 "Yes")(2=0 "No")(*=.), gen(child)
	label var child "living with children"
	
*7  Age of youngest child
	codebook Q90_1
	gen age_child = Q90_1
	summ age_child
	replace age_child = r(mean) if missing(age_child)
	summ age_child
	label var age_child "age of youngest child"
	
*8  Tenure
	codebook Q1_1 Q1_2
	gen tenure1 = Q1_2/12
	
	gen tenure=.
	replace tenure=Q1_1 if !missing(Q1_1)
	replace tenure=tenure1 if !missing(Q1_2)
	
	codebook tenure
	label var tenure "tenure"
	
*9. Supervisory
	codebook Q3
	recode Q3 (1=1 "Yes")(2=0 "No")(*=.),gen(supervisory)
	label var supervisory "supervisory"
	
// B. Organizational level
*1. Size (log)
	codebook OQ4
	gen size = log(OQ4)
	label var size "size(log)"
	
*2. Public/private/mixed
	codebook OQ2
	recode OQ2 (1=1 "public") (2=2 "private") ///
			   (3=3 "mixed") (4=4 "other")(*=.),gen(sector_g)
	label var sector_g "public"
*3. Sector 
	codebook sector, tab(7)
	
// C. Country level
	codebook country
	tab country
	encode country, gen(country_1)
	codebook country_1

////////////////////////////////////////////////////////////////////////////////

	keep overtime wlb ///
		 flex parental childcare ///
		 female age age2 edu incomehlog partner child age_child tenure ///
		 supervisory size sector_g sector country_1
	codebook *
	
	drop if missing(overtime, wlb, ///
		 flex, parental, childcare, ///
		 female, age, edu, incomehlog, /// 
		 partner, child, age_child, tenure, /// 
		 supervisory, size, sector_g, sector, country_1)
	
	count
	save "SASR4_dataclean.dta", replace

//------------------------------------------------------------------------------
exit
	
	
	
	
	
	
	
	
	
	
