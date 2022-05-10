/*
QUERIES FOR TABLEAU DESKTOP TO VISUALIZE 
*/

1.
select sum(new_cases) as total_cases, sum(new_deaths) as total_deaths, sum(new_deaths)::decimal/sum(new_cases)*100 as DeathPercentage
from covid_deaths
where continent is not null
order by 1,2;

2.
select location, sum(new_deaths) as TotalDeathCount
from covid_deaths
where continent is null
and location not in ('World','European Union','International','Upper middle income','High income','Lower middle income','Low income')
group by location
order by TotalDeathCount
desc;

3.

Select location, population, max(total_cases) as HighestInfectionCount,  max(total_cases::decimal/population)*100 as PercentPopulationInfected
from covid_deaths
--Where location like '%states%'
group by location, population
order by PercentPopulationInfected desc;


4.
Select location, population, date, max(total_cases) as HighestInfectionCount,  max(total_cases::decimal/population)*100 as PercentPopulationInfected
from covid_deaths
--Where location like '%states%'
group by location, population, date
order by PercentPopulationInfected desc;

5.

select location, date, population, total_cases, total_deaths
from covid_deaths
where continent is not null
order by 1,2;

6.
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

7. 

select location, population, max(total_cases) as highestinfectioncount, max(total_cases::decimal/population*100)
as percentpopulationinfected
from covid_deaths
group by location, population, date
order by percentpopulationinfected desc;

