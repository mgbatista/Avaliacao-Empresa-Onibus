create database AvLinhasOnibus;
use AvLinhasOnibus;

create table EmpresasOnibus
(
	cod_empresa int not null identity(1,1),
	nome_empresa varchar(50) not null,
	end_logradouro varchar(50) not null,
	end_numero int not null,
	end_complemento varchar(50),
	end_bairro varchar(50) not null,
	end_cep char(8) not null,
	end_uf char(2) not null,
	end_localidade varchar(50) not null,
	web_site varchar(50),
		constraint pk_cod_empresa primary key (cod_empresa),
);


create table TelefonesEmpresa
(
	cod_empresa int not null,
	numero char(11) not null,
	tipo varchar(15) not null,
	constraint pk_telefone_empresa primary key (numero),
	constraint fk_cod_empresa foreign key (cod_empresa) references EmpresasOnibus (cod_empresa)
);


create table LinhaOnibus
(
	cod_linha int not null identity(1,1),
	nome_linha varchar(50) not null,
	constraint pk_cod_linha primary key (cod_linha)
);


create table Itinerario 
(
	cod_itinerario int not null identity(1,1),
	sentido_itinerario varchar(100) not null,
	constraint pk_cod_itinerario primary key (cod_itinerario)
);


create table QdrHorario
(
	cod_horario int not null identity(1,1),
	dias_semana varchar(20) not null,
	horario_saida time not null,
	constraint pk_cod_horario primary key (cod_horario)
);


create table Percurso
(
	cod_percurso int not null identity(1,1),
	cod_linha int not null,
	cod_itinerario int not null,
	percurso_descricao varchar(300) not null,
	constraint pk_cod_percurso primary key (cod_percurso),
	constraint fk_percurso_cod_linha foreign key (cod_linha) references LinhaOnibus (cod_linha),
	constraint fk_percurso_cod_itinerario foreign key (cod_itinerario) references Itinerario (cod_itinerario),
);


create table LinhaCompleta
(
	cod_linha int not null,
	cod_itinerario int not null,
	cod_horario int not null,
	nome_linha varchar(50) not null,
	constraint fk_cod_Linha_LinhaOnibus foreign key (cod_linha) references LinhaOnibus (cod_linha),
	constraint fk_Itinerario foreign key(cod_itinerario) references Itinerario (cod_itinerario),
	constraint fk_Qdr_horario foreign key (cod_horario) references QdrHorario(cod_horario),
	constraint fk_nome_linha foreign key (cod_linha) references LinhaOnibus(cod_linha),
);


create table EmpresaLinhas
(
	cod_empresa int not null,
	cod_linha int not null,
	constraint fk_cod_empresa_empresa foreign key (cod_empresa) references EmpresasOnibus (cod_empresa),
	constraint fk_cod_linha_linha foreign key (cod_linha) references LinhaOnibus (cod_linha),
);


-- Inserindo dados para testes

-- Empresas Onibus
insert into EmpresasOnibus (nome_empresa, end_logradouro, end_numero, end_complemento, end_bairro, end_cep, end_uf, end_localidade, web_site)
values ('Paraty', 'Rua Jose Lopes', 253, 'Bloco 3', 'Jardim Brasil', '15888965', 'SP', 'Matao', 'www.paraty.com.br');
insert into EmpresasOnibus (nome_empresa, end_logradouro, end_numero, end_complemento, end_bairro, end_cep, end_uf, end_localidade, web_site)
values ('Danubio Azul', 'Rua Marcio Freitas', 553, 'Bloco 5', 'Jardim Primavera', '14588963', 'SP', 'Araraquara', 'www.danubioazul.com.br');
insert into EmpresasOnibus (nome_empresa, end_logradouro, end_numero, end_complemento, end_bairro, end_cep, end_uf, end_localidade, web_site)
values ('Petitto', 'Rua Jose Zago', 101, 'Predio B', 'Bela Vista', '14585858', 'SP', 'Araraquara', 'www.petitto.com.br');
insert into EmpresasOnibus (nome_empresa, end_logradouro, end_numero, end_complemento, end_bairro, end_cep, end_uf, end_localidade, web_site)
values ('Itamaraty', 'Rua Belem', 600, 'Predio A', 'Centro', '14558587', 'SP', 'Araraquara', 'www.itamaraty.com.br');

select * from EmpresasOnibus;

-- Telefones empresas
insert into TelefonesEmpresa (cod_empresa, numero, tipo) values (1, '16338259781', 'Empresarial');
insert into TelefonesEmpresa (cod_empresa, numero, tipo) values (1, '16988259781', 'Celular');
insert into TelefonesEmpresa (cod_empresa, numero, tipo) values (2, '16338258585', 'Empresarial');
insert into TelefonesEmpresa (cod_empresa, numero, tipo) values (3, '16998259781', 'Celular');
insert into TelefonesEmpresa (cod_empresa, numero, tipo) values (4, '16888259781', 'Celular');

select * from TelefonesEmpresa;

-- Linhas Onibus
insert into LinhaOnibus (nome_linha) values ('Aguas do Paiol/Terminal');
insert into LinhaOnibus (nome_linha) values ('Fonte/Altos Villa Xavier');
insert into LinhaOnibus (nome_linha) values ('Centro/Terminal');
insert into LinhaOnibus (nome_linha) values ('Vale do Sol/Centro');

select * from LinhaOnibus;

-- Itinerario
insert into Itinerario (sentido_itinerario) values (' Fonte - Sentido Altos Villa Xavier');
insert into Itinerario (sentido_itinerario) values (' Aguas do Paiol - Sentido Terminal');
insert into Itinerario (sentido_itinerario) values (' Centro - Sentido Terminal');
insert into Itinerario (sentido_itinerario) values (' Vale do Sol - Sentido Centro');

select * from Itinerario;

-- Quadro Horários
insert into QdrHorario (dias_semana, horario_saida) values ('Domingos e Feriados', '12:00');
insert into QdrHorario (dias_semana, horario_saida) values ('Sabados', '09:00');
insert into QdrHorario (dias_semana, horario_saida) values ('Dias Úteis', '08:00');

select * from QdrHorario format (cast ('horario_saida' as datetime2), n 'HH:mm');

-- Percurso
insert into Percurso (cod_linha, cod_itinerario, percurso_descricao) 
values (1, 1, '1- Rua Domingos Barbieri, 2- Av. Luiz Alberto, 3- Alameda Paulista');
insert into Percurso (cod_linha, cod_itinerario, percurso_descricao) 
values (2, 2, '1- Avenida 36, 2- Rua Moreira Junior, 3- Rua Pereira');
insert into Percurso (cod_linha, cod_itinerario, percurso_descricao) 
values (3, 3, '1- Rua Jardinopolis, 2- Avenida Brasil, 3- Rua Balin');
insert into Percurso (cod_linha, cod_itinerario, percurso_descricao) 
values (4, 4, '1- Rua Pedro Cabral, 2- Rua Santos, 3- Rua Aldo Nicolucci');

select * from Percurso

-- Linha Completa
insert into LinhaCompleta (cod_linha, cod_itinerario, cod_horario, nome_linha)
values (1, 1, 1, 'Aguas do Paiol/Terminal');
insert into LinhaCompleta (cod_linha, cod_itinerario, cod_horario, nome_linha)
values (2, 2, 2, 'Fonte/Altos Villa Xavier');
insert into LinhaCompleta (cod_linha, cod_itinerario, cod_horario, nome_linha)
values (3, 3, 3, 'Centro/Terminal');
insert into LinhaCompleta (cod_linha, cod_itinerario, cod_horario, nome_linha)
values (4, 4, 1, 'Vale do sol/Centro');

select * from LinhaCompleta

-- EmpresaLinhas
insert into EmpresaLinhas (cod_empresa, cod_linha) values (1, 1);
insert into EmpresaLinhas (cod_empresa, cod_linha) values (2, 2);
insert into EmpresaLinhas (cod_empresa, cod_linha) values (3, 3);
insert into EmpresaLinhas (cod_empresa, cod_linha) values (4, 4);

select * from EmpresaLinhas

--resolução item a
select lo.nome_linha from EmpresaLinhas el
inner join EmpresasOnibus eo on 
	el.cod_empresa = eo.cod_empresa
inner join LinhaOnibus lo on 
	el.cod_linha = lo.cod_linha
	where eo.nome_empresa = 'Paraty'
	

-- resolução item b
select iti.sentido_itinerario from LinhaCompleta lc
inner join Itinerario iti on 
	lc.cod_itinerario = iti.cod_itinerario
	where lc.nome_linha = 'Aguas do Paiol/Terminal'


-- resolução item c
select lc.nome_linha, qdr.dias_semana, cast(qdr.horario_saida as time(0)) horario_saida  from LinhaCompleta lc
inner join QdrHorario qdr on
	lc.cod_horario = qdr.cod_horario
	where lc.nome_linha = 'Vale do sol/Centro'


-- resolução item d
select eo.nome_empresa, lo.nome_linha from Percurso pc
inner join EmpresaLinhas el on
	pc.cod_linha = el.cod_linha 
inner join EmpresasOnibus eo on
	el.cod_empresa = eo.cod_empresa
inner join LinhaOnibus lo on
	el.cod_linha = lo.cod_linha
	where percurso_descricao like '%Nicolucci%'


