create table covid_deaths(		
iso_code	varchar(5)	,
continent	varchar(20)	,
location	varchar(50)	,
date	date	,
population	bigint	,
total_cases	int	,
new_cases	int	,
new_cases_smoothed	numeric,
total_deaths	int	,
new_deaths	int	,
new_deaths_smoothed	numeric	,
total_cases_per_million	numeric	,
new_cases_per_million	numeric	,
new_cases_smoothed_per_million	numeric	,
total_deaths_per_million	numeric	,
new_deaths_per_million	numeric	,
new_deaths_smoothed_per_million	numeric	,
reproduction_rate	numeric	,
icu_patients	int	,
icu_patients_per_million	numeric	,
hosp_patients	int	,
hosp_patients_per_million	numeric	,
weekly_icu_admissions	int	,
weekly_icu_admissions_per_million	numeric	,
weekly_hosp_admissions	int	,
weekly_hosp_admissions_per_million	numeric	
)		

select * from covid_deaths;



copy covid_deaths from 'E:\Study Material\Data Science Projects\Covid 19 Data\covid_deaths.csv' header csv;

select * from covid_deaths  order by iso_code asc;