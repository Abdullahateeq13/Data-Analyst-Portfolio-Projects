/* 
COVID 19 DATA EXPLORATION
*/

select * from covid_deaths
order by 3,4;

select * from covid_vaccinations
order by 3,4;

--Select data that we are going to be starting with

select location, date, total_cases, new_cases, total_deaths, population
from covid_deaths
where continent is null
order by 1,2;



-- Total Cases vs Total Deaths
select location, date, total_cases, total_deaths, total_deaths::decimal/total_cases*100 as DeathPercentage
from covid_deaths
where location like '%States%'
and continent is not null
order by 1,2;

-- Total Cases vs Population
-- Shows what percentage of population got Covid
select location, date, total_cases, population, total_cases::decimal/population*100 as PopulationPercentage
from covid_deaths
order by 1,2;

-- Looking at Countries with Highest Infection Rate compared to Population

select location,population, max(total_cases) as HighestInfectionCount , max(total_cases::decimal/population*100) as InfectedPopulationPercentage 
from covid_deaths
--where location = 'India'
where continent is not null
group by location,population
order by 4 desc;

-- Showing Countries with Highest Death Count per Population

select location,max(total_deaths) as TotalDeathCount 
from covid_deaths
where continent is not null
group by location,total_deaths
order by total_deaths desc;

-- Order by continents
-- Showing continents with the highest death count per population

select continent, max(total_deaths) as TotalDeathCount
from covid_deaths
where continent is not null
group by continent
order by TotalDeathCount desc;

-- GLOBAL NUMBERS

select date, sum(new_cases) as total_cases, sum(new_deaths) as total_deaths, sum(new_deaths)::decimal/sum(new_cases)*100 as DeathPercentage
from covid_deaths
where continent is not null
group by date
order by 1,2;

-- Total Global Numbers
select sum(new_cases) as total_cases, sum(new_deaths) as total_deaths, sum(new_deaths)::decimal/sum(new_cases)*100 as DeathPercentage
from covid_deaths
where continent is not null
order by 1,2;

-- select from Covid vaccinations
select * from covid_vaccinations;

-- LET'S JOIN THESE TWO TABLES
	
select *
from covid_deaths as d
join covid_vaccinations as v
on d.location = v.location
and d.date = v.date
;

-- Looking at Total Population vs Vaccinations
select d.continent, d.location, d.date, d.population, v.new_vaccinations
from covid_deaths as d
join covid_vaccinations as v
on d.location = v.location
and d.date = v.date
where d.continent is not null
order by 2,3  ;

---- Shows Percentage of Population that has recieved at least one Covid Vaccine

select d.continent, d.location, d.date, d.population, v.new_vaccinations, sum(new_vaccinations) over (partition by d.location order by d.location , d.date) as RollingPeopleVaccinated
from covid_deaths as d
join covid_vaccinations as v
on d.location = v.location
and d.date = v.date
where d.continent is not null
order by 2,3  ;

-- USING CTE to perform Calculation on Partition By in previous query

With PopvsVac (Continent,Location,Date,Population,New_vaccinations,RollingPeopleVaccinated)
as
(
select d.continent, d.location, d.date, d.population, v.new_vaccinations, sum(new_vaccinations) over (partition by d.location order by d.location , d.date) as RollingPeopleVaccinated
from covid_deaths as d
join covid_vaccinations as v
on d.location = v.location
and d.date = v.date
where d.continent is not null

)
select *, RollingPeopleVaccinated::decimal/population * 100 as TotalVaccinated
from PopvsVac

-- CREATE A TEMP TABLE 
-- 		TEMPERORY table behave just like normal ones and can execute very quickly....
--drop table if exists #PercentPopulationVaccinated
drop table if exists PercentPopulationVaccinated
create temp table PercentPopulationVaccinated
(
	Continent varchar(255),
	Location varchar(255),
	Date date,
	Population numeric,
	New_vaccinations numeric,
	RollingPeopleVaccinated numeric
);

Insert into PercentPopulationVaccinated
(
select d.continent, d.location, d.date, d.population, v.new_vaccinations
,sum(new_vaccinations) over (partition by d.location order by d.location , d.date) as RollingPeopleVaccinated
from covid_deaths as d
join covid_vaccinations as v
on d.location = v.location
and d.date = v.date

);


select *, RollingPeopleVaccinated::decimal/Population * 100 as TotalVaccinated
from PercentPopulationVaccinated

-- CREATE A VIEW

create view PercentPopulationVaccinated as
select d.continent, d.location, d.date, d.population, v.new_vaccinations
,sum(new_vaccinations) over (partition by d.location order by d.location , d.date) as RollingPeopleVaccinated
from covid_deaths as d
join covid_vaccinations as v
on d.location = v.location
and d.date = v.date
where d.continent is not null;

-- select * from PercentPopulationVaccinated;

