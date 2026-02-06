#Padronizando os dados


#Coluna Company
	select company,(trim(company))#"trim" remove os espaços em brancos de colunas, usaremos isso para atualizar
	from layoffs_staging2;
	
	update layoffs_staging2
	set company = trim(company);


#coluna Industry

	select distinct industry
	from layoffs_staging2 ls 
	order by 1;

#industria Crypto
	
	select industry , count(*)
	from layoffs_staging2 
	where industry like 'crypto%'
	group by industry;
	
	update layoffs_staging2
	set industry ='Crypto'
	where industry like 'crypto%';



#Coluna Country

select distinct country, trim(trailing '.' from country)
from layoffs_staging2
order by 1;

update layoffs_staging2 ls 
set country = trim(trailing '.' from country)
where country like 'United States%';


#Mudando o tipo de dado da coluna date

select `date`
str_to_date(`date`,'%m/%d/%Y') converte strings para datas e formata do jeito que queremos
from layoffs_staging2 ls2 ;


update layoffs_staging2 ls 
set `date` = str_to_date(`date`,'%m/%d/%Y');

alter table layoffs_staging2 
modify column `date` date;


select * from layoffs_staging2 ls 
















