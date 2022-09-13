create schema brh;
use brh;
create table DEPARTAMENTO(
	sigla VARCHAR(5) NOT NULL,
	nome VARCHAR(80) NOT NULL,
	chefe INT NOT NULL,
	departamento_superior VARCHAR(10) NOT NULL,
	
	PRIMARY KEY (sigla)
);

create table COLABORADOR(
	matricula INT NOT NULL,
	cpf VARCHAR(15) NOT NULL,
    email_corporativo VARCHAR(100) NOT NULL,
	salario DECIMAL(8,2) NOT NULL,
	complemento VARCHAR(30) NOT NULL,
	departamento VARCHAR(10) NOT NULL,
	id_cep INT NOT NULL,
	
	PRIMARY KEY (matricula)
);

create table DEPENDENTE(
	cpf VARCHAR(15) NOT NULL,
	colaborador INT NOT NULL,
	nome VARCHAR(100) NOT NULL,
	data_nascimento DATE NOT NULL,
	parentesco VARCHAR(15) NOT NULL,
	
	PRIMARY KEY (cpf, colaborador)
);

create table TELEFONE (
	matricula INT NOT NULL,
	telefone1 VARCHAR(16) NOT NULL,
	telefone2 VARCHAR(16) NOT NULL,
	
	PRIMARY KEY (matricula)
);

create table CEP (
	id_Cep INT NOT NULL,
	cep VARCHAR(15) NOT NULL,
	logradouro VARCHAR(100) NOT NULL,
	bairro VARCHAR(100) NOT NULL,
	cidade VARCHAR(100) NOT NULL,
	estado VARCHAR(15) NOT NULL,
	
	PRIMARY KEY (id_cep)
);

create table PROJETO(
	id_Projeto INT NOT NULL,
	nome VARCHAR(100) NOT NULL,
	responsavel INT NOT NULL,
	inicio DATE NOT NULL,
	fim DATE NOT NULL,
	
	PRIMARY KEY (id_Projeto)
);

create table ATRIBUICAO(
	colaborador INT NOT NULL,
	projeto INT NOT NULL,
	papel INT NOT NULL,
    
	PRIMARY KEY (colaborador,projeto,papel)
);

create table PAPEL(
	id_Papel INT NOT NULL,
	nome VARCHAR(100) NOT NULL,
	
	PRIMARY KEY (id_Papel)
);


ALTER TABLE DEPARTAMENTO ADD CONSTRAINT PK_DEPARTAMENTO_COLABORADOR
FOREIGN KEY (chefe)
REFERENCES COLABORADOR (matricula)
ON DELETE NO ACTION
ON UPDATE NO ACTION;

ALTER TABLE DEPARTAMENTO ADD CONSTRAINT PK_DEPARTAMENTO_SUPERIOR
FOREIGN KEY (departamento_superior)
REFERENCES DEPARTAMENTO (sigla)
ON DELETE NO ACTION
ON UPDATE NO ACTION;

ALTER TABLE COLABORADOR ADD CONSTRAINT PK_COLABORADOR_DEPARTAMENTO
FOREIGN KEY (departamento)
REFERENCES DEPARTAMENTO (sigla)
ON DELETE NO ACTION
ON UPDATE NO ACTION;

ALTER TABLE COLABORADOR ADD CONSTRAINT PK_COLABORADOR_CEP
FOREIGN KEY (id_Cep)
REFERENCES CEP (id_Cep)
ON DELETE NO ACTION
ON UPDATE NO ACTION;

ALTER TABLE DEPENDENTE ADD CONSTRAINT PK_DEPENDENTE_COLABORADOR
FOREIGN KEY (colaborador)
REFERENCES COLABORADOR (matricula)
ON DELETE NO ACTION
ON UPDATE NO ACTION;

ALTER TABLE TELEFONE ADD CONSTRAINT PK_TELEFONE_COLABORADOR
FOREIGN KEY (matricula)
REFERENCES COLABORADOR (matricula)
ON DELETE NO ACTION
ON UPDATE NO ACTION;

ALTER TABLE PROJETO ADD CONSTRAINT PK_PROJETO_COLABORADOR
FOREIGN KEY (responsavel)
REFERENCES COLABORADOR (matricula)
ON DELETE NO ACTION
ON UPDATE NO ACTION;

ALTER TABLE ATRIBUICAO ADD CONSTRAINT PK_ATRIBUICAO_COLABORADOR
FOREIGN KEY (colaborador)
REFERENCES COLABORADOR (matricula)
ON DELETE NO ACTION
ON UPDATE NO ACTION;

ALTER TABLE ATRIBUICAO ADD CONSTRAINT PK_ATRIBUICAO_PROJETO
FOREIGN KEY (projeto)
REFERENCES PROJETO (id_Projeto)
ON DELETE NO ACTION
ON UPDATE NO ACTION;

ALTER TABLE ATRIBUICAO ADD CONSTRAINT _ATRIBUICAO_PAPEL
FOREIGN KEY (papel)
REFERENCES PAPEL (id_Papel)
ON DELETE NO ACTION
ON UPDATE NO ACTION;