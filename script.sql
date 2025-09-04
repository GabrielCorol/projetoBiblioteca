create database bdBiblioteca;

use bdBiblioteca;

create table Usuarios(
id int primary key auto_increment,
nome varchar(100),
email varchar(100),
senha_hash varchar(255),
role enum ("Bibiotecario","Admin"),
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

	
select * from usuarios;