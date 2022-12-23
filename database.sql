create database projeto_final;
use projeto_final;

create table paciente(
cpfPaciente varchar(11) not null,
primeiroNome varchar(30) not null,
nomeMeio varchar(2) default null,
ultimoNome varchar(30) not null,
dataNascimento date not null, -- AAAA-MM-DD
sexo char(1) not null,
celular bigint unsigned not null,
primary key(cpfPaciente)
);

create table particular(
cpfParticular varchar(11) not null, -- um mesmo cpf pode fazer varias consultas particular
valorConsulta decimal(5,2) not null,
constraint particular_paciente foreign key(cpfParticular) references paciente(cpfPaciente)
);

create table convenio(
cpfConvenio varchar(11) not null unique,
email varchar(50) default null,
dataMatriConvenio date not null,
logradouro varchar(30) not null,
tipoLogradouro varchar(20) not null,
cep int unsigned not null,
uf char(2) not null,
cidade varchar(25) not null,
bairro varchar(20) not null,
complemento varchar(30) default null,
numeroLocal smallint unsigned not null,
constraint convenio_paciente foreign key(cpfConvenio) references paciente(cpfPaciente)
);

create table clinica(
codClinica smallint unsigned not null,
cnpj varchar(14) not null unique,
nomeFantasia varchar(30) not null,
logradouro varchar(30) not null,
tipoLogradouro varchar(20) not null,
cep int unsigned not null,
uf char(2) not null,
cidade varchar(25) not null,
bairro varchar(20) not null,
complemento varchar(30) default null,
numeroLocal smallint unsigned not null,
email varchar(50) default null,
site varchar(50) default null,
celular bigint unsigned default null,
telefone bigint unsigned default null,
primary key(codClinica)
);

create table clinica_convenio(
clinica_codclinica smallint unsigned not null,
convenio_cpf varchar(11) not null,
constraint para_convenio foreign key(convenio_cpf) references convenio(cpfConvenio),
constraint para_clinica foreign key(clinica_codclinica) references clinica(codClinica)
);

create table funcionario(
codFuncionario smallint unsigned not null,
cod_clinica smallint unsigned not null,
cpf varchar(11) not null unique,
primeiroNome varchar(30) not null,
nomeMeio varchar(2) default null,
ultimoNome varchar(30) not null,
dataNascimento date not null, -- AAAA-MM-DD
sexo char(1) not null,
celular bigint unsigned not null,
logradouro varchar(30) not null,
tipoLogradouro varchar(20) not null,
cep int unsigned not null,
uf char(2) not null,
cidade varchar(25) not null,
bairro varchar(20) not null,
complemento varchar(30) default null,
numeroLocal smallint unsigned not null,
constraint funcionario_clinica foreign key(cod_clinica) references clinica(codClinica),
primary key(codFuncionario)
);

create table atendente(
codAtendente smallint unsigned not null unique,
constraint atendente_funcionario foreign key(codAtendente) references funcionario(codFuncionario)
);

create table especialidade(
codEspecialidade tinyint unsigned not null,
nomeEspecialidade varchar(30) not null,
primary key(codEspecialidade)
);

create table medico(
crm varchar(13) unique not null,
codMedico smallint unsigned not null,
cod_especialidade tinyint unsigned not null,
constraint medico_funcionario foreign key(codMedico) references funcionario(codFuncionario),
constraint medico_especialidade foreign key(cod_especialidade) references especialidade(codEspecialidade)
);

create table exame(
codExame int unsigned not null,
nomeExame varchar(20) not null,
descExame text not null,
primary key(codExame)
);

create table medicamento(
codMedicamento int unsigned not null,
nomeMedicamento varchar(20) not null,
descMedicamento text not null,
primary key(codMedicamento)
);

create table consulta(
codConsulta int unsigned not null,
dataConsulta date not null,
idPaciente varchar(11) not null,
idAtendente smallint unsigned not null,
idMedico smallint unsigned not null,
idClinica smallint unsigned not null,
idExame int unsigned not null,
idMedicamento int unsigned not null,
constraint consulta_paciente foreign key(idPaciente) references paciente(cpfPaciente),
constraint consulta_atendente foreign key(idAtendente) references atendente(codAtendente),
constraint consulta_medico foreign key(idMedico) references medico(codMedico),
constraint consulta_clinica foreign key(idClinica) references clinica(codClinica),
constraint consulta_exame foreign key(idExame) references exame(codExame),
constraint consulta_medicamento foreign key(idMedicamento) references medicamento(codMedicamento),
primary key(codConsulta)
);
