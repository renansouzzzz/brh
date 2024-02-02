/* Listar nome de colaboradores e dependentes  */

SELECT c.nome AS "Nome colaborador",
       d.nome AS "Nome dependente",
	 to_char(d.data_nascimento, 'dd/mm/yyyy')
FROM brh.dependente d
INNER JOIN brh.colaborador c 
ON d.colaborador = c.matricula
WHERE upper(d.nome) LIKE '%H%'
  OR to_char(d.data_nascimento, 'MM') in (4, 5, 6)
ORDER BY c.nome, d.nome;

/* Listar nome e o maior salário  */

SELECT nome,
       salario
FROM brh.colaborador
WHERE salario =
    (SELECT max(salario)
     FROM brh.colaborador);

/* Lista de senioridade */

SELECT matricula,
       nome,
       salario, (CASE
                     WHEN salario <= 3000 THEN 'Júnior'
                     WHEN salario > 3000
                          AND salario < 6000 THEN 'Pleno'
                     WHEN salario > 6000
                          AND salario <= 20000 THEN 'Sênior'
                     ELSE 'Corpo diretor'
                 END)
FROM brh.colaborador
ORDER BY salario;


/* Listar quantos colaborador em projetos */

SELECT DISTINCT d.nome AS nome_departamento,
                pj.nome AS nome_projeto,
                count(*) AS colaboradores
FROM brh.atribuicao a
LEFT JOIN brh.projeto pj ON a.projeto = pj.id
INNER JOIN brh.colaborador c ON c.matricula = a.colaborador
RIGHT JOIN brh.departamento d ON d.sigla = c.departamento
WHERE pj.nome IS NOT NULL
GROUP BY d.nome,
         pj.nome
ORDER BY d.nome,
         pj.nome;

/* Listar quantidade de dependentes */

SELECT c.nome,
       count(*) AS quantidade_dependentes
FROM brh.colaborador c
INNER JOIN brh.dependente d ON c.matricula = d.colaborador
GROUP BY c.nome
HAVING count(*) >= 2
ORDER BY quantidade_dependentes DESC;


/* Listar dependentes e faixa etária */

SELECT d.cpf AS cpf_dependente,
       d.nome AS dependente_nome,
       to_char(d.data_nascimento, 'dd/mm/yyyy'),
       d.parentesco,
       c.matricula,
       CASE
           WHEN nvl(floor(months_between(sysdate, d.data_nascimento) / 12), 0) < 18 THEN 'Menor de 18 anos'
           ELSE 'Maior de idade'
       END
FROM brh.colaborador c
INNER JOIN brh.dependente d ON c.matricula = d.colaborador
ORDER BY d.colaborador,
         d.nome;


 /* DESAFIOS OPCIONAIS */
/*   Criando Views    */

CREATE OR REPLACE VIEW BRH.VW_F_ETARIA AS
SELECT colaborador,
       cpf,
       nome,
       data_nascimento,
       parentesco,
       nvl(floor((months_between(sysdate, data_nascimento) / 12)), 0) idade,
       'menor de 18' f_etaria
FROM brh.dependente
WHERE nvl(floor((months_between(sysdate, data_nascimento) / 12)), 0) < 18
UNION ALL
SELECT colaborador,
       cpf,
       nome,
       data_nascimento,
       parentesco,
       nvl(floor((months_between(sysdate, data_nascimento) / 12)), 0) idade,
       'maior de 18'
FROM brh.dependente
WHERE nvl(floor((months_between(sysdate, data_nascimento) / 12)), 0) >= 18;

/* Relatório Plano de Saúde */

SELECT colaborador,
       sum(valores) AS total
FROM
  (SELECT f.colaborador, CASE
                            WHEN f.parentesco = 'Cônjuge' THEN 100
                            WHEN f.parentesco = 'Filho(a)'
                                 AND f.f_etaria = 'Maior de 18' THEN 50
                            WHEN f.parentesco = 'Filho(a)'
                                 AND f.f_etaria = 'Menor de 18' THEN 25
                        END AS valores
   FROM brh.vw_f_etaria f
   UNION ALL SELECT c.matricula,
                    CASE
                        WHEN c.salario <= 3000 THEN c.salario * 0.01
                        WHEN c.salario <= 6000 THEN c.salario * 0.02
                        WHEN c.salario <= 20000 THEN c.salario * 0.03
                        ELSE c.salario * 0.05
                    END AS valores
   FROM brh.colaborador c)
GROUP BY colaborador
ORDER BY colaborador;

/* Criar Paginação 1-10 */

SELECT *
FROM
  (SELECT rownum AS line,
          c.*
   FROM brh.colaborador c
   ORDER BY nome)
WHERE line >= 1
  AND line <= 10;

/* Paginação 11-20 */

SELECT *
FROM
  (SELECT rownum AS line,
          c.*
   FROM brh.colaborador c
   ORDER BY nome)
WHERE line >= 11
  AND line <= 20;

/* Paginação 21-30 */

SELECT *
FROM
  (SELECT rownum AS line,
          c.*
   FROM brh.colaborador c
   ORDER BY nome)
WHERE line >= 21
  AND line <= 30;
