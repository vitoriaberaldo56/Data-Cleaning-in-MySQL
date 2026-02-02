#Limpeza de dados

# 1. Remover dados duplicados
# 2. Padronizar os dados
# 3. Valores nulos ou vazios
# 4. Remover colunas


#Criando uma tabela com os mesmos dados da tabela original(para mantermos os dados)

create table layoffs_staging
like layoffs;

insert into layoffs_staging 
select *
from layoffs;