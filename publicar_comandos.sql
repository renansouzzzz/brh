*-------------------------------------------*
                TAREFAS MYSQL
*-------------------------------------------*

# listar e ordenar departamento

SELECT sigla,
       nome
FROM departamento
ORDER BY sigla,
         nome;

# relatório dependentes

SELECT c.nome AS "nome do colaborador",
       d.nome AS "nome do dependente",
       d.data_nascimento,
       d.parentesco
FROM colaborador c
INNER JOIN dependente d ON c.matricula = d.colaborador
ORDER BY c.nome;

# cadastrando novo colaborador

INSERT INTO colaborador
VALUES("F456","746.572.234-67", "Fulano de Tal", "fulano.detal@outlook.com", "fulano.detal@corp.com", 3000.00, "DEPTI", 71222-100, "Casa 505 - Av. Italia");

# criando projeto novo

INSERT INTO projeto
VALUES (6, "BI", "A123", 20210830, 20220101);

# novo papel

INSERT INTO papel
VALUES(8, "Especialista de Negócios");

# novo telefone

INSERT INTO telefone_colaborador
VALUES("(61) 99999-9999", "F456", "R");


INSERT INTO atribuicao
VALUES ("F456", 6, 8);

# deletar Secap

DELETE
FROM atribuicao
WHERE colaborador in ("H123",
                      "M123",
                      "R123",
                      "W123");


DELETE
FROM telefone_colaborador
WHERE colaborador in ("H123",
                      "M123",
                      "R123",
                      "W123");


DELETE
FROM dependente
WHERE colaborador in ("H123",
                      "M123",
                      "R123",
                      "W123");


UPDATE departamento
SET chefe = "A123"
WHERE sigla = "SECAP";


DELETE
FROM colaborador
WHERE departamento = "SECAP";


DELETE
FROM departamento
WHERE sigla = 'SECAP';






