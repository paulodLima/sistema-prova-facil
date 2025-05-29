CREATE TABLE professores(
    id SERIAL PRIMARY KEY,
    nome TEXT NOT NULL,
    email TEXT NOT NULL UNIQUE,
    senha TEXT NOT NULL
);

CREATE TABLE series(
    id SERIAL PRIMARY KEY,
    nome TEXT NOT NULL
);

CREATE TABLE roles(
    professor_id INT NOT NULL REFERENCES professores (id) ON DELETE CASCADE,
    roles TEXT NOT NULL
);

CREATE TABLE assuntos(
    id SERIAL PRIMARY KEY,
    nome TEXT NOT NULL
);

CREATE TABLE perguntas(
    id SERIAL PRIMARY KEY,
    enunciado TEXT NOT NULL,
    tipo TEXT NOT NULL CHECK (tipo IN ('DISSERTATIVA', 'OBJETIVA')),
    resposta_correta TEXT,
    serie_id INT NOT NULL REFERENCES series (id) ON DELETE CASCADE,
    assunto_id INT NOT NULL REFERENCES assuntos (id) ON DELETE CASCADE,
    professor_id INT NOT NULL REFERENCES professores (id) ON DELETE CASCADE,
    data_criacao TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

CREATE TABLE alternativas_erradas(
    id SERIAL PRIMARY KEY,
    texto TEXT NOT NULL,
    pergunta_id INT NOT NULL REFERENCES perguntas (id) ON DELETE CASCADE
);

CREATE TABLE questoes(
    id SERIAL PRIMARY KEY,
    enunciado TEXT NOT NULL,
    resposta_correta TEXT NOT NULL,
    nivel TEXT NOT NULL CHECK (nivel IN ('FACIL', 'MEDIO', 'DIFICIL')),
    serie TEXT NOT NULL
);

ALTER TABLE perguntas
ADD COLUMN nivel TEXT  CHECK (nivel IN ('FACIL', 'MEDIO', 'DIFICIL'));