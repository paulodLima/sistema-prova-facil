CREATE SCHEMA IF NOT EXISTS provas_db;
SET search_path TO provas_db;

CREATE TABLE provas_db.professores(
    id SERIAL PRIMARY KEY,
    nome TEXT NOT NULL,
    email TEXT NOT NULL UNIQUE,
    senha TEXT NOT NULL
);

CREATE TABLE provas_db.series(
    id SERIAL PRIMARY KEY,
    nome TEXT NOT NULL
);

CREATE TABLE provas_db.roles(
    professor_id INT NOT NULL REFERENCES provas_db.professores (id) ON DELETE CASCADE,
    roles TEXT NOT NULL
);


select * from provas_db.roles;
CREATE TABLE provas_db.assuntos(
    id SERIAL PRIMARY KEY,
    nome TEXT NOT NULL
);

CREATE TABLE provas_db.perguntas(
    id SERIAL PRIMARY KEY,
    enunciado TEXT NOT NULL,
    tipo TEXT NOT NULL CHECK (tipo IN ('DISSERTATIVA', 'OBJETIVA')),
    resposta_correta TEXT,
    serie_id INT NOT NULL REFERENCES provas_db.series (id) ON DELETE CASCADE,
    assunto_id INT NOT NULL REFERENCES provas_db.assuntos (id) ON DELETE CASCADE,
    professor_id INT NOT NULL REFERENCES provas_db.professores (id) ON DELETE CASCADE,
    data_criacao TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

CREATE TABLE provas_db.alternativas_erradas(
    id SERIAL PRIMARY KEY,
    texto TEXT NOT NULL,
    pergunta_id INT NOT NULL REFERENCES provas_db.perguntas (id) ON DELETE CASCADE
);

CREATE TABLE provas_db.questoes(
    id SERIAL PRIMARY KEY,
    enunciado TEXT NOT NULL,
    resposta_correta TEXT NOT NULL,
    nivel TEXT NOT NULL CHECK (nivel IN ('FACIL', 'MEDIO', 'DIFICIL')),
    serie TEXT NOT NULL
);

ALTER TABLE provas_db.perguntas
ADD COLUMN nivel TEXT  CHECK (nivel IN ('FACIL', 'MEDIO', 'DIFICIL'));