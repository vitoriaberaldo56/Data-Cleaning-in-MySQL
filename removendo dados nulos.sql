#Removendo dados nulos


#Coluna industry
	
	select * #seleciona registros vazios
	from layoffs_staging2
	where industry = 'null'
	or industry = '';
	
	update layoffs_staging2 #muda os registros vazios para null
	set industry = null
	where industry = '';
	
	select *
	from layoffs_staging2 ls 
	where company like '%bally%';

#faz um self join na tabela para trazer linhas que estejam com industry faltando e procura outra linha que esteja com essa informação preenchida

select * from
layoffs_staging2 st1
join layoffs_staging2 st2
	on st1.company = st2.company 
where (st1.industry is null or st1.industry = '')	
and st2.industry is not null;

#usando o script acima para o update

update layoffs_staging2 st1
join layoffs_staging2 st2
	on st1.company = st2.company 
set st1.industry = st2.industry
where st1.industry is null	
and st2.industry is not null;
	
	
	
#deletando a coluna que criamos anteriormente para contar as duplicatas

alter table layoffs_staging2 
drop column row_num;


	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
