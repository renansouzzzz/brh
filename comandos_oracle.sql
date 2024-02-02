*------------------------------------------*
    MESMAS TAREFAS MYSQL NO ORACLE
*------------------------------------------*

SELECT nome,
       sigla
FROM brh.departamento
ORDER BY sigla,
         nome;


SELECT c.nome AS "nome do colaborador",
       d.nome AS "nome do dependente",
       d.data_nascimento,
       d.parentesco
FROM brh.colaborador c
INNER JOIN brh.dependente d ON c.matricula = d.colaborador;


INSERT INTO brh.endereco (CEP, UF, CIDADE, BAIRRO, LOGRADOURO)
VALUES(71222-100, 'SP', 'Taubaté', 'Jd. Mourisco', 'Avenida Itália');


INSERT INTO brh.colaborador (MATRICULA, CPF, NOME, EMAIL_PESSOAL, EMAIL_CORPORATIVO, SALARIO, DEPARTAMENTO, CEP, COMPLEMENTO_ENDERECO)
VALUES('F456', '764.765.876-60', 'Fulano de Tal', 'fulano.detal@outlook.com', 'fulano.detal@corp.com', 3000.00, 'DEPTI', 71222-100, 'Casa 505 - Avenida Itália');


INSERT INTO brh.projeto (ID, NOME, RESPONSAVEL, INICIO, FIM)
VALUES(9, 'BI', 'A123', '30/08/2021', '01/01/2022');


INSERT INTO brh.papel (ID, NOME)
VALUES (8, 'Especialista em Negócios');


INSERT INTO brh.telefone_colaborador (NUMERO, COLABORADOR, TIPO)
VALUES ('(61) 99999-9999', 'F456', 'R');


INSERT INTO brh.atribuicao (COLABORADOR, PROJETO, PAPEL)
VALUES ('F456', 9, 8);





*----------------------------------------------*
            TAREFAS OPCIONAIS


*----------------------------------------------*
            RELATÓRIO DE CONTATOS
*----------------------------------------------*

SELECT c.matricula,
       c.nome,
       c.email_corporativo,
       t.numero
FROM brh.colaborador c
INNER JOIN brh.telefone_colaborador t ON c.matricula=t.colaborador;


*----------------------------------------------*
      RELATÓRIO ANALÍTICO DE EQUIPES
*----------------------------------------------*

SELECT d.nome AS "Nome departamento",
       d.chefe AS "Chefe departamento",
       ch.nome AS "Nome Colaborador",
       pj.nome AS "Nome projeto",
       p.nome AS "Nome papel",
       t.numero AS "N° Colaborador",
       dep.nome AS "Nome dependente"
FROM brh.departamento d
INNER JOIN brh.colaborador ch ON d.chefe = ch.matricula
INNER JOIN brh.colaborador aloc ON d.sigla = aloc.departamento
LEFT JOIN brh.dependente dep ON dep.colaborador = aloc.matricula
LEFT JOIN brh.projeto pj ON pj.responsavel = ch.matricula
INNER JOIN brh.papel p ON p.id = pj.id
INNER JOIN brh.telefone_colaborador t ON t.colaborador = ch.matricula;
