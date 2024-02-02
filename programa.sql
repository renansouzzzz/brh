/* Criar procedure insere_projeto */

CREATE OR REPLACE PROCEDURE brh.insere_projeto
    (p_ID PROJETO.ID%type,
        p_NOME PROJETO.NOME%type,
        p_RESPONSAVEL PROJETO.RESPONSAVEL%type,
        p_INICIO PROJETO.INICIO%type,
        p_FIM PROJETO.FIM%type)
IS
BEGIN

    INSERT INTO brh.PROJETO (ID, NOME, RESPONSAVEL, INICIO, FIM) VALUES (p_ID, p_NOME, 	p_RESPONSAVEL, p_INICIO, p_FIM);
END;



/* Criar funcao calcular_idade */

CREATE OR REPLACE FUNCTION brh.calcular_idade
(v_DATA_NASCIMENTO IN DATE)

RETURN FLOAT

IS
BEGIN
    RETURN (nvl(floor(months_between(sysdate, v_DATA_NASCIMENTO ) / 12), 0));
END;



 /** TAREFAS OPCIONAIS **/
/* Finaliza projeto   */

CREATE OR REPLACE FUNCTION brh.finaliza_projeto
  (p_ID in brh.PROJETO.ID%type)
  RETURN DATE
IS
  v_DATA_TERMINA DATE;
  
BEGIN
  v_DATA_TERMINA := SYSDATE;

UPDATE brh.PROJETO
    SET FIM = v_DATA_TERMINA
    WHERE ID = p_ID;
    
  RETURN v_DATA_TERMINA;
END;

DECLARE
  ENCERRA date;
BEGIN
  ENCERRA := brh.FINALIZA_PROJETO('ID DE QUEM QUEIRA FINALIZAR');
  dbms_output.put_line(ENCERRA);
END;


/* Valida insere_projeto */


CREATE OR REPLACE PROCEDURE brh.insere_projeto
    (p_ID PROJETO.ID%type,
        p_NOME PROJETO.NOME%type,
        p_RESPONSAVEL PROJETO.RESPONSAVEL%type,
        p_INICIO PROJETO.INICIO%type,
        p_FIM PROJETO.FIM%type)
IS
BEGIN
    IF length(p_NOME) <= 2 THEN raise_application_error(-20111,'Nome de projeto invalido! Deve ter dois ou mais caracteres.');
    ELSIF p_NOME IS NULL THEN raise_application_error(-20111,'Nome de projeto invalido! Deve NOT NULL.');

    ELSE
    INSERT INTO brh.PROJETO (ID, NOME, RESPONSAVEL, INICIO, FIM) VALUES (p_ID, p_NOME, 	p_RESPONSAVEL, p_INICIO, p_FIM);
    END IF;
END;

/* Valida calcular_idade */

CREATE OR REPLACE FUNCTION brh.calcular_idade
(v_DATA_NASCIMENTO IN DATE)

RETURN FLOAT

IS
BEGIN
    IF v_DATA_NASCIMENTO > SYSDATE THEN raise_application_error(-20111,'Impossível calcular idade! Data inválida: ' || v_DATA_NASCIMENTO || '.');
    ELSIF v_DATA_NASCIMENTO IS NULL THEN raise_application_error(-20111,'Impossível calcular idade com data NULL! Data inválida: ' || v_DATA_NASCIMENTO || '.');
    ELSE
    RETURN (nvl(floor(months_between(sysdate, v_DATA_NASCIMENTO ) / 12), 0));
    END IF;
END;

SELECT brh.calcular_idade(to_date('05/06/2000', 'dd/mm/yyyy')) FROM dual;



 /*        Mover procedures e funcoes para package       */
/*             OBS: Cabeçalho do package já criado      */


CREATE OR REPLACE PACKAGE BODY brh.pkg_projeto
IS

PROCEDURE insere_projeto
    (p_ID PROJETO.ID%type,
        p_NOME PROJETO.NOME%type,
        p_RESPONSAVEL PROJETO.RESPONSAVEL%type,
        p_INICIO PROJETO.INICIO%type,
        p_FIM PROJETO.FIM%type)
IS
BEGIN
    IF length(p_NOME) <= 2 THEN raise_application_error(-20111,'Nome de projeto invalido! Deve ter dois ou mais caracteres.');
    ELSIF p_NOME IS NULL THEN raise_application_error(-20111,'Nome de projeto invalido! Deve NOT NULL.');

    ELSE
    INSERT INTO brh.PROJETO (ID, NOME, RESPONSAVEL, INICIO, FIM) VALUES (p_ID, p_NOME, 	p_RESPONSAVEL, p_INICIO, p_FIM);
    END IF;
END;

-----

FUNCTION calcular_idade
(v_DATA_NASCIMENTO IN DATE)

RETURN FLOAT

IS
BEGIN
    IF v_DATA_NASCIMENTO > SYSDATE THEN raise_application_error(-20111,'Impossível calcular idade! Data inválida: ' || v_DATA_NASCIMENTO || '.');
    ELSIF v_DATA_NASCIMENTO IS NULL THEN raise_application_error(-20111,'Impossível calcular idade com data NULL! Data inválida: ' || v_DATA_NASCIMENTO || '.');
    ELSE
    RETURN (nvl(floor(months_between(sysdate, v_DATA_NASCIMENTO ) / 12), 0));
    END IF;
END;

-----

FUNCTION finaliza_projeto
  (p_ID in brh.PROJETO.ID%type)
  RETURN DATE
IS
  v_DATA_TERMINA DATE;
  
BEGIN
  v_DATA_TERMINA := SYSDATE;

UPDATE brh.PROJETO
    SET FIM = v_DATA_TERMINA
    WHERE ID = p_ID;
    
  RETURN v_DATA_TERMINA;
END;
 
-----
 
PROCEDURE brh.DEFINE_ATRIBUICAO
    (p_NOME_COLAB IN COLABORADOR.nome%type,
        p_NOME_PROJ IN PROJETO.nome%type,
        p_NOME_PAP IN PAPEL.nome%type,
        p_ID_PAP IN PAPEL.id%type)
        
IS 
    ERROR_PROJ_NOT_EXISTS EXCEPTION;
    ERROR_PAP_NOT_EXISTS EXCEPTION;
    ERROR_COLAB_NOT_EXISTS EXCEPTION;
    
    v_NOME_COLAB COLABORADOR.nome%type;
    v_NOME_MAT COLABORADOR.matricula%type;
    v_NOME_PROJ PROJETO.nome%type;
    
      
BEGIN 
    BEGIN
        SELECT nome INTO v_NOME_COLAB FROM brh.COLABORADOR WHERE nome = p_NOME_COLAB;
        IF v_NOME_MAT <> p_NOME_COLAB
            THEN RAISE ERROR_COLAB_NOT_EXISTS;
        END IF;
      
        SELECT nome INTO v_NOME_PROJ FROM brh.PROJETO WHERE nome = p_NOME_PROJ;
            IF p_NOME_PROJ = v_NOME_PROJ
                THEN INSERT INTO brh.ATRIBUICAO
                (COLABORADOR, PROJETO, PAPEL) VALUES (v_NOME_MAT, p_NOME_PROJ, p_ID_PAP);
        ELSE RAISE ERROR_PROJ_NOT_EXISTS;
    END IF;
END;  

EXCEPTION
    WHEN 
        ERROR_COLAB_NOT_EXISTS THEN raise_application_error(-20001, 'Colaborador inexistente: ' || p_NOME_COLAB || '.');        
    WHEN 
        ERROR_PROJ_NOT_EXISTS THEN raise_application_error(-20002, 'Nome de projeto inexistente: ' || p_NOME_PROJ || '.');
    WHEN 
        ERROR_PAP_NOT_EXISTS THEN INSERT INTO brh.PAPEL (ID, NOME) VALUES (p_ID_PAP, p_NOME_PAP);
        dbms_output.put_line ('Não encontramos o papel, por isso criamos o papel: ' || p_NOME_PAP || ' com o ID: ' || p_ID_PAP);  
END;

END;

 