create database bdBiblioteca;

use bdBiblioteca;

create table Usuarios(
id int primary key auto_increment,
nome varchar(100),
email varchar(100),
senha_hash varchar(255),
role enum ("Bibliotecario","Admin"),
ativo tinyint(1) Default 1,
criado_em datetime default current_timestamp
);



DELIMITER $$

DROP PROCEDURE IF EXISTS sp_usuario_criar $$
CREATE PROCEDURE sp_usuario_criar (
    IN p_nome VARCHAR(100),
    IN p_email VARCHAR(100),
    IN p_senha_hash VARCHAR(255),
    IN p_role VARCHAR(20)  -- precisa ser VARCHAR, não ENUM
)
BEGIN
    INSERT INTO Usuarios (nome, email, senha_Hash, role, ativo, criado_Em)
    VALUES (p_nome, p_email, p_senha_hash, p_role, 1, NOW());
END $$

DELIMITER ;

-- Exemplo de uso (ATENÇÃO: role deve ser 'Adm', não 'Admin')
CALL sp_usuario_criar(
    'Henrique Admin',
    'Henrique@biblioteca.com',
    '$1234',
    'Admin'
);

-- CRIANDO A TABELA EDITORA

Create table editora(
id int primary key auto_increment,
nome varchar(150) not null,
criado_em datetime not null default current_timestamp
);

-- CRIANDO A PROCEDURE PARA INSERIR NA TABELA EDITORA

DELIMITER $$

CREATE PROCEDURE sp_editora_criar(
    IN p_nome VARCHAR(100)
)
BEGIN
    INSERT INTO editora (nome,criado_em)
    VALUES (p_nome, NOW());
END $$

DELIMITER ;


-- Criando a tabela genero

Create table genero(
id int primary key auto_increment,
nome varchar(150) not null,
criado_em datetime not null default current_timestamp
);

-- CRIANDO A PROCEDURE PARA INSERIR NA TABELA GENERO

DELIMITER $$

CREATE PROCEDURE sp_genero_criar(
    IN p_nome VARCHAR(100)
)
BEGIN
    INSERT INTO genero (nome,criado_em)
    VALUES (p_nome, NOW());
END $$

DELIMITER ;

-- Criando a tabela autor 

Create table autor(
id int primary key auto_increment,
nome varchar(150) not null,
criado_em datetime not null default current_timestamp
);

-- CRIANDO A PROCEDURE PARA INSERIR NA TABELA AUTOR

DELIMITER $$

CREATE PROCEDURE sp_autor_criar(
    IN p_nome VARCHAR(100)
)
BEGIN
    INSERT INTO autor (nome,criado_em)
    VALUES (p_nome, NOW());
END $$

DELIMITER ;
	
CALL sp_editora_criar(
    'Darkus'
);
CALL sp_genero_criar(
 'Nerf'
);
CALL sp_autor_criar(
'The rock'
);    

-- Criando a tabela livros
    
Create table livros(
id int primary key auto_increment,
titulo varchar(200),
autor int,
editora int,
genero int,
ano int,
isbn varchar(32),
quantidade_total int,
quantidade_disponivel int,
criado_em datetime default current_timestamp
);    

-- Criando  as foreign keys para conectar as tabelas

alter table livros add constraint fk_livros_autor foreign key(autor)
  references autor(id),
  add constraint fk_livros_editora foreign key (editora) 
  references editora(id),
  add constraint fk_livros_genero foreign key (genero)
  references genero(id);
  
-- Criando a  procedure para cadastrar os LIVROS

delimiter $$

CREATE PROCEDURE sp_livro_criar (
    IN p_titulo VARCHAR(200),
    IN p_autor VARCHAR(100),
    IN p_editora VARCHAR(100),
    IN p_genero VARCHAR(100),
    IN p_ano int,
    IN p_isbn VARCHAR(32),
	IN p_quantidade_total int,
    IN p_quantidade_disponivel int
)
BEGIN
	DECLARE dAutor INT;
	DECLARE dEditora INT;
	DECLARE dGenero INT;

    
   
    -- Autor
    IF NOT EXISTS (SELECT id FROM autor WHERE nome = p_autor) THEN 
		INSERT INTO autor(nome)
        VALUES(p_autor);
    END IF;
    
    
    SET dAutor := (SELECT id FROM autor WHERE nome = p_autor);
        
    -- Editora
    IF NOT EXISTS (SELECT id FROM editora WHERE nome = p_editora) THEN 
		INSERT INTO editora(nome)
        VALUES(p_editora);
    END IF;
    
    SET dEditora := (SELECT id FROM editora WHERE nome = p_editora);
        
    -- Genero
    IF NOT EXISTS (SELECT id FROM genero WHERE nome = p_genero) THEN 
		INSERT INTO genero(nome)
        VALUES(p_genero);
    END IF;
    
    SET dGenero := (SELECT id FROM genero WHERE nome = p_genero);
    
    insert into livros (titulo,autor,editora,genero,ano,isbn,quantidade_total,quantidade_disponivel,criado_em)
    values(p_titulo,dAutor,dEditora, dGenero, p_ano,p_isbn,p_quantidade_total,p_quantidade_disponivel,now());
    

END
$$
delimiter ;

call sp_livro_criar ('Test O começo','Pedro','Panini','Ação',2025,'978-985-00512-3-7',120,80);

select * from livros;    
select * from usuarios;
select * from editora;
select * from genero;
select * from autor;