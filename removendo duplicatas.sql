#1. Removendo dados duplicados

# =======================================================================================
#agrupa as linhas caso sejam iguais em todos os campos que colocamos após o "partition by"
# =======================================================================================


select *,
row_number() over(
partition by company,location, industry,total_laid_off,percentage_laid_off,`date`,stage,country,funds_raised_millions) as row_num
from layoffs_staging;




# =======================================================================================
#cria uma tabela com a consulta acima para depois filtramos somente quando o row_num for maior que 1 (ou seja, existem registros duplicados)
# =======================================================================================



with duplicate_cte as
(
select *,
row_number() over(
partition by company,location, industry,total_laid_off,percentage_laid_off,`date`,stage,country,funds_raised_millions) as row_num
from layoffs_staging 
)
select *
from duplicate_cte
where row_num >1;



# =======================================================================================
#CRIANDO UMA TABELA COM A COLUNA "ROW_NUM" PARA INSERIR OS REGISTROS DUPLICADOS , PARA DEPOIS EXCLUIR
# =======================================================================================


CREATE TABLE `layoffs_staging2` (
  `company` varchar(50) DEFAULT NULL,
  `location` varchar(50) DEFAULT NULL,
  `industry` varchar(50) DEFAULT NULL,
  `total_laid_off` varchar(50) DEFAULT NULL,
  `percentage_laid_off` varchar(50) DEFAULT NULL,
  `date` varchar(50) DEFAULT NULL,
  `stage` varchar(50) DEFAULT NULL,
  `country` varchar(50) DEFAULT NULL,
  `funds_raised_millions` varchar(50) DEFAULT null,
  `row_num` INT
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;



#Inserindo os dados

insert into layoffs_staging2 
select *,
row_number() over(
partition by company,location, industry,total_laid_off,percentage_laid_off,`date`,stage,country,funds_raised_millions) as row_num
from layoffs_staging;

#filtrando

select * from 
layoffs_staging2
where row_num >1;

#deletando as duplicatas

delete from 
layoffs_staging2
where row_num >1;
