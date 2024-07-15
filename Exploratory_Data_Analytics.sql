select * from layoffs_stagging2;

select MAX(total_laid_off) from layoffs_stagging2;

select * from layoffs_stagging2 
where percentage_laid_off=1 
order by funds_raised_millions desc;

select company,SUM(total_laid_off) 
from layoffs_stagging2 
group by company
order by 2 desc;

select MIN(`date`), MAX(`date`)
from layoffs_stagging2;

select country,SUM(total_laid_off) 
from layoffs_stagging2 
group by country
order by 2 desc;

select industry,SUM(total_laid_off) 
from layoffs_stagging2 
group by industry
order by 2 desc;

select year(`date`),SUM(total_laid_off) 
from layoffs_stagging2 
group by year(`date`)
order by 1 desc;


select stage,SUM(total_laid_off) 
from layoffs_stagging2 
group by stage
order by 2 desc;


select company,SUM(percentage_laid_off) 
from layoffs_stagging2 
group by company
order by 2 desc;

select substring(`date`,1,7) as `month` , sum(total_laid_off)
from layoffs_stagging2
where substring(`date`,1,7) is not null
group by `month`
order by 1 asc;

select company,year(`date`),sum(total_laid_off) 
from layoffs_stagging2 
group by company,year(`date`)
order by 3 desc;

with company_year(company,years,total_laid_off) as 
(
select company,year(`date`),sum(total_laid_off) 
from layoffs_stagging2 
group by company,year(`date`)
),company_year_Rank as
(select * , dense_rank() over (partition by years order by total_laid_off desc)
from company_year
where years is not null
)
select * from company_year_Rank
where ranking>=5
;
