CREATE DATABASE IF NOT EXISTS bertof CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;
USE bertof;


DROP TABLE IF EXISTS Item_vendido;
DROP TABLE IF EXISTS Venda;
DROP TABLE IF EXISTS Estoque;
DROP TABLE IF EXISTS Fornecedor;
DROP TABLE IF EXISTS Produto;
DROP TABLE IF EXISTS Cliente;


CREATE TABLE Cliente (
    id_cliente INT AUTO_INCREMENT PRIMARY KEY,
    nome VARCHAR(100) NOT NULL,
    cpf VARCHAR(20) UNIQUE,
    email VARCHAR(100),
    endereco VARCHAR(150)
) ENGINE=InnoDB;

CREATE TABLE Produto (
    id_produto INT AUTO_INCREMENT PRIMARY KEY,
    nome_produto VARCHAR(100) NOT NULL,
    categoria VARCHAR(50),
    preco_venda DECIMAL(10,2),
    estoque_atual INT
) ENGINE=InnoDB;

CREATE TABLE Fornecedor (
    id_fornecedor INT AUTO_INCREMENT PRIMARY KEY,
    nome_fornecedor VARCHAR(100),
    cnpj VARCHAR(20) UNIQUE,
    telefone VARCHAR(20),
    email VARCHAR(100)
) ENGINE=InnoDB;

CREATE TABLE Estoque (
    id_estoque INT AUTO_INCREMENT PRIMARY KEY,
    data_entrada DATE,
    quantidade INT,
    custo_unitario DECIMAL(10,2),
    id_produto INT,
    FOREIGN KEY (id_produto) REFERENCES Produto(id_produto)
        ON DELETE SET NULL
        ON UPDATE CASCADE
) ENGINE=InnoDB;

CREATE TABLE Venda (
    id_venda INT AUTO_INCREMENT PRIMARY KEY,
    data_venda DATE,
    valor_total DECIMAL(10,2),
    forma_pagamento VARCHAR(30),
    id_cliente INT,
    FOREIGN KEY (id_cliente) REFERENCES Cliente(id_cliente)
        ON DELETE SET NULL
        ON UPDATE CASCADE
) ENGINE=InnoDB;

CREATE TABLE Item_vendido (
    id_item_vendido INT AUTO_INCREMENT PRIMARY KEY,
    quantidade INT,
    preco_unitario DECIMAL(10,2),
    subtotal DECIMAL(10,2),
    id_venda INT,
    id_produto INT,
    FOREIGN KEY (id_venda) REFERENCES Venda(id_venda)
        ON DELETE CASCADE
        ON UPDATE CASCADE,
    FOREIGN KEY (id_produto) REFERENCES Produto(id_produto)
        ON DELETE SET NULL
        ON UPDATE CASCADE
) ENGINE=InnoDB;


