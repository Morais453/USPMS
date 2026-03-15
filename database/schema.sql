CREATE DATABASE gestao_esportiva;
\c gestao_esportiva;
CREATE TABLE Usuario (
    id_usuario SERIAL PRIMARY KEY,
    nome VARCHAR(100) NOT NULL,
    email VARCHAR(100) UNIQUE NOT NULL,
    senha VARCHAR(100) NOT NULL,
    tipo_usuario VARCHAR(20) NOT NULL
);
CREATE TABLE Modalidade (
    id_modalidade SERIAL PRIMARY KEY,
    nome_modalidade VARCHAR(100) NOT NULL
);
CREATE TABLE Tecnico (
    id_tecnico SERIAL PRIMARY KEY,
    id_usuario INT REFERENCES Usuario(id_usuario),
    cref VARCHAR(20) NOT NULL,
    especialidade VARCHAR(100)
);
CREATE TABLE Time (
    id_time SERIAL PRIMARY KEY,
    nome_time VARCHAR(100) NOT NULL,
    id_modalidade INT REFERENCES Modalidade(id_modalidade),
    id_tecnico INT REFERENCES Tecnico(id_tecnico)
);
CREATE TABLE Atleta (
    id_atleta SERIAL PRIMARY KEY,
    id_usuario INT REFERENCES Usuario(id_usuario),
    data_nascimento DATE NOT NULL,
    altura NUMERIC(4,2),
    peso NUMERIC(5,2),
    id_time INT REFERENCES Time(id_time)
);
CREATE TABLE Campeonato (
    id_campeonato SERIAL PRIMARY KEY,
    nome VARCHAR(100) NOT NULL,
    data_inicio DATE,
    data_fim DATE
);
CREATE TABLE Jogo (
    id_jogo SERIAL PRIMARY KEY,
    data_jogo DATE NOT NULL,
    local VARCHAR(100),
    id_campeonato INT REFERENCES Campeonato(id_campeonato)
);
CREATE TABLE Estatistica (
    id_estatistica SERIAL PRIMARY KEY,
    id_atleta INT REFERENCES Atleta(id_atleta),
    id_jogo INT REFERENCES Jogo(id_jogo),
    pontos INT,
    assistencias INT,
    faltas INT,
    tempo_jogo INTERVAL
);
CREATE TABLE Treino (
    id_treino SERIAL PRIMARY KEY,
    data_treino DATE NOT NULL,
    descricao TEXT,
    id_tecnico INT REFERENCES Tecnico(id_tecnico)
);
CREATE TABLE SessaoTreino (
    id_sessao SERIAL PRIMARY KEY,
    id_treino INT REFERENCES Treino(id_treino),
    tipo_exercicio VARCHAR(100),
    carga VARCHAR(50),
    duracao INTERVAL
);
CREATE TABLE AvaliacaoFisica (
    id_avaliacao SERIAL PRIMARY KEY,
    id_atleta INT REFERENCES Atleta(id_atleta),
    data_avaliacao DATE NOT NULL,
    observacoes TEXT
);
CREATE TABLE MedidaCorporal (
    id_medida SERIAL PRIMARY KEY,
    id_avaliacao INT REFERENCES AvaliacaoFisica(id_avaliacao),
    tipo_medida VARCHAR(50) NOT NULL,
    valor NUMERIC(6,2) NOT NULL
);
CREATE TABLE Lesao (
    id_lesao SERIAL PRIMARY KEY,
    id_atleta INT REFERENCES Atleta(id_atleta),
    tipo_lesao VARCHAR(100),
    data_inicio DATE,
    data_fim DATE,
    gravidade VARCHAR(50)
);
CREATE TABLE Tratamento (
    id_tratamento SERIAL PRIMARY KEY,
    id_lesao INT REFERENCES Lesao(id_lesao),
    descricao TEXT,
    data_inicio DATE,
    data_fim DATE
);
CREATE TABLE Atleta_Modalidade (
    id_atleta INT REFERENCES Atleta(id_atleta),
    id_modalidade INT REFERENCES Modalidade(id_modalidade),
    PRIMARY KEY (id_atleta, id_modalidade));
