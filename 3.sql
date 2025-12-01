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

INSERT INTO Cliente (nome, cpf, email, endereco) VALUES
('Carlos Silva', '12345678900', 'carlos@email.com', 'Rua A, 123'),
('Juliana Souza', '98765432100', 'juliana@email.com', 'Rua B, 456'),
('Pedro Oliveira', '11122233344', 'pedro@email.com', 'Rua C, 789');
INSERT INTO Produto (nome_produto, categoria, preco_venda, estoque_atual) VALUES
('Camiseta Preta', 'Vestuário', 39.90, 50),
('Calça Jeans', 'Vestuário', 89.90, 30),
('Tênis Esportivo', 'Calçados', 159.90, 20);
INSERT INTO Fornecedor (nome_fornecedor, cnpj, telefone, email) VALUES
('Fornecedor Alpha', '12345678000111', '11999990000', 'contato@alpha.com'),
('Fornecedor Beta', '98765432000199', '11888880000', 'suporte@beta.com');
INSERT INTO Estoque (data_entrada, quantidade, custo_unitario, id_produto) VALUES
('2025-12-01', 20, 25.00, 1),
('2025-12-01', 15, 60.00, 2),
('2025-12-01', 10, 100.00, 3);
INSERT INTO Venda (data_venda, valor_total, forma_pagamento, id_cliente) VALUES
('2025-12-01', 129.80, 'Cartão', 1),
('2025-12-02', 89.90, 'Pix', 2);
INSERT INTO Item_vendido (quantidade, preco_unitario, subtotal, id_venda, id_produto) VALUES
(2, 39.90, 79.80, 1, 1),
(1, 50.00, 50.00, 1, 2),
(1, 89.90, 89.90, 2, 2);


SELECT *
FROM Cliente
ORDER BY nome ASC;
SELECT nome_produto, categoria, preco_venda
FROM Produto
WHERE categoria = 'Vestuário';
SELECT id_venda, data_venda, valor_total
FROM Venda
ORDER BY data_venda DESC
LIMIT 2;
SELECT 
    Item_vendido.id_item_vendido,
    Produto.nome_produto,
    Item_vendido.quantidade,
    Item_vendido.subtotal
FROM Item_vendido
JOIN Produto ON Item_vendido.id_produto = Produto.id_produto;
SELECT 
    Venda.id_venda,
    Venda.data_venda,
    Venda.valor_total,
    Cliente.nome AS nome_cliente
FROM Venda
JOIN Cliente ON Venda.id_cliente = Cliente.id_cliente
WHERE valor_total > 50;

