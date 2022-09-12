
# Projeto Sistema BRH

O projeto BRH, consiste em um sistema de cadastro de colaboradores onde podemos armazenar os dados 
dos principais colaboradores da empresa, assim tendo facilidade em adicionar e manipular estes dados.
Podendo analisar com precisão relatórios, fichas descritivas etc.


## Entidades

- Colaboradores;
- Dependentes;
- Departamentos;
- Projetos interno;
- Funções de colaboradores.

## Relatórios importantes


#### Obtemos diversos relatórios, mas os principais utilizamos são: 
 - `Relatório de departamentos` 
 - `Relatório de participantes de projetos`
 - `Relatório de colaboradores sem dependentes`
 - `Relatório de dependentes`
 - `Relatório de contatos`
 - `Relatório de senioridade`
 - `Relatório de plano de saúde`

## Procedures e funções

#### Procedures

```bash
  	exec brh.insere_projeto
  	exec brh.define_atribuicao
```

#### Funções
```bash
	exec brh.calcula_idade
	exec brh.finaliza_projeto
```



