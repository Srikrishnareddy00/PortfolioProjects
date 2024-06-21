-- Data Cleaning


SELECT *
FROM world_layloff.layoffs;

-- REMOVE DUPLICATES


CREATE TABLE layoff_staging
LIKE layoffs;


SELECT *
FROM world_layloff.layoff_staging;

INSERT layoff_staging
SELECT *
FROM world_layloff.layoffs;

SELECT *,
ROW_NUMBER() OVER(PARTITION BY company, industry, total_laid_off, percentage_laid_off, 'date') AS row_num
FROM world_layloff.layoff_staging;

WITH duplicate_cte AS
(
SELECT *,
ROW_NUMBER() OVER(PARTITION BY company, location, industry, total_laid_off, percentage_laid_off,date,stage, country,funds_raised_millions) AS row_num
FROM world_layloff.layoff_staging
)
SELECT *
FROM duplicate_cte
WHERE row_num > 1;

SELECT *
FROM world_layloff.layoff_staging
WHERE company = "Casper";

CREATE TABLE `layoff_staging4` (
  `company` text,
  `location` text,
  `industry` text,
  `total_laid_off` int DEFAULT NULL,
  `percentage_laid_off` text,
  `date` text,
  `stage` text,
  `country` text,
  `funds_raised_millions` int DEFAULT NULL,
  `row_nums` INT
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;


SELECT *
FROM world_layloff.layoff_staging4;

INSERT INTO layoff_staging4
SELECT *,
ROW_NUMBER() OVER(PARTITION BY company, location, industry, total_laid_off, percentage_laid_off,date,stage, country,funds_raised_millions) AS row_num
FROM world_layloff.layoff_staging;


SELECT *
FROM world_layloff.layoff_staging4
WHERE row_nums > 1;


DELETE
FROM world_layloff.layoff_staging4
WHERE row_nums > 1;






