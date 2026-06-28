--Portfolio Project Queries
--a.Datewise Likelihood of dying due to covid-Totalcases vs TotalDeath- in India
select date,total_cases,total_deaths from "CovidDeaths"
WHERE location like '%India%';
--b.Total % of deaths out of entire population- in India
SELECT max(total_deaths)/avg(population)*100 from "CovidDeaths"
where location = 'India';
--c.Verify b by getting info separately
Select total_deaths, population from "CovidDeaths" where location = 'India';
--d.Country with highest death as a % of population
Select location,max(total_deaths)/avg(population)*100 AS "PercentDeath" from "CovidDeaths"
GROUP BY location
HAVING max(total_deaths)/avg(population)*100 <>0
ORDER BY "PercentDeath" DESC
Limit 1;
--e.Total % of covid +ve cases- in India
SELECT max(total_cases)/avg(population)*100 as percentage_positive_cases from "CovidDeaths"
WHERE location = 'India';
--f.Total % of covid +ve cases- in world
SELECT location, max(total_cases)/avg(population)*100 as percentage_positive_cases from "CovidDeaths"
GROUP BY location
Order by percentage_positive_cases DESC;
--g.Continentwise +ve cases
SELECT location, max(total_cases) as total_positive_cases from "CovidDeaths"
WHERE continent is null
GROUP BY location
ORDER BY total_positive_cases DESC;
--h.Continentwise deaths
SELECT location, max(total_deaths) as total_deaths from "CovidDeaths"
WHERE continent is Null
GROUP BY location
ORDER BY total_deaths DESC;
--i.Daily newcases vs hospitalizations vs icu_patients- India
select location, date, new_cases,icu_patients, hosp_patients from "CovidDeaths"
WHERE location = 'India' and new_cases <> '0';
--j.countrywise age>65
select D.date, D.location, aged_65_older from "CovidDeaths" AS D
join "CovidVaccinations" AS V
ON D.iso_code=V.iso_code
AND D.date=V.date;
--k. Countrywise total vaccinated persons
Select D.location AS country, max(people_vaccinated) AS people_vaccinated from "CovidDeaths" AS D
JOIN "CovidVaccinations" AS V
ON D.iso_code=V.iso_code AND D.date=V.date
WHERE D.continent IS not NULL
GROUP BY D.location
ORDER BY people_vaccinated DESC;
--l. Countrywise total fully vaccinated persons
Select D.location AS country, max(people_fully_vaccinated) AS people_fully_vacc from "CovidDeaths" AS D
JOIN "CovidVaccinations" AS V
ON D.iso_code=V.iso_code AND D.date=V.date
WHERE D.continent is not NULL
GROUP BY country
ORDER BY people_fully_vacc DESC;
--m. Countrywise top 10 extreme poverty
SELECT D.location, Max(extreme_poverty) AS poverty FROM "CovidDeaths" AS D
JOIN "CovidVaccinations" AS V
ON D.location = V.location AND D.date=V.date
WHERE D.continent IS NOT NULL AND V.extreme_poverty is NOT NULL
GROUP BY D.location
ORDER BY poverty DESC
LIMIT 10;
--n. Countrywise top 10 extreme poverty without JOIN
SELECT location, max(extreme_poverty) AS poverty FROM "CovidVaccinations" AS V
WHERE continent is NOT NULL AND extreme_poverty is NOT NULL
GROUP BY location
ORDER BY poverty DESC
LIMIT 10;