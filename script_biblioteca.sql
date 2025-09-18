create database bdbiblioteca;

use bdbiblioteca;

create table usuarios
(
Id int primary key auto_increment,
Nome varchar(100),
Email varchar(100),
Senha_hash varchar(255),
Role enum("Bibliotecario","Admin"),
Ativo tinyint(1) default 1,
Criado_em datetime default current_timestamp
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
    INSERT INTO Usuarios (Nome, Email, Senha_hash, Role, Ativo, Criado_em)
    VALUES (p_nome, p_email, p_senha_hash, p_role, 1, NOW());
END $$

DELIMITER ;

-- Exemplo de uso (ATENÇÃO: role deve ser 'Adm', não 'Admin')
CALL sp_usuario_criar(
    'João Admin',
    'joao@biblioteca.com',
    '$2a$11$HASHADMINEXEMPLO9876543210',
    'Admin'
);


select * from usuarios;