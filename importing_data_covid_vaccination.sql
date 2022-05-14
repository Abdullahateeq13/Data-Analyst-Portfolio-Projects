create table covid_vaccinations(		
iso_code	varchar(15)	,
continent	varchar(40)	,
location	varchar(40)	,
date	date	,
total_tests	bigint	,
new_tests	bigint	,
total_tests_per_thousand	numeric	,
new_tests_per_thousand	numeric	,
new_tests_smoothed	bigint	,
new_tests_smoothed_per_thousand	numeric	,
positive_rate	numeric	,
tests_per_case	numeric	,
tests_units	varchar(100)	,
total_vaccinations	bigint	,
people_vaccinated	bigint	,
people_fully_vaccinated	bigint	,
total_boosters	bigint	,
new_vaccinations	bigint	,
new_vaccinations_smoothed	bigint	,
total_vaccinations_per_hundred	numeric	,
people_vaccinated_per_hundred	numeric	,
people_fully_vaccinated_per_hundred	numeric	,
total_boosters_per_hundred	numeric	,
new_vaccinations_smoothed_per_million	bigint	,
new_people_vaccinated_smoothed	bigint	,
new_people_vaccinated_smoothed_per_hundred	numeric	,
stringency_index	numeric	,
population_density	numeric	,
median_age	numeric	,
aged_65_older	numeric	,
aged_70_older	numeric	,
gdp_per_capita	numeric	,
extreme_poverty	numeric	,
cardiovasc_death_rate	numeric	,
diabetes_prevalence	numeric	,
female_smokers	numeric	,
male_smokers	numeric	,
handwashing_facilities	numeric	,
hospital_beds_per_thousand	numeric	,
life_expectancy	numeric	,
human_development_index	numeric	,
excess_mortality_cumulative_absolute	numeric	,
excess_mortality_cumulative	numeric	,
excess_mortality	numeric	,
excess_mortality_cumulative_per_million	numeric	
)		

select * from covid_vaccinations;

copy covid_vaccinations from 'E:\Study Material\Data Science Projects\Covid 19 Data\covid_vaccinations.csv' header csv;