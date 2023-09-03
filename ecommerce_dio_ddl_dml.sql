-- Desafio de projeto do bootcamp da DIO - Potência Tech powered by IFood - Ciências de Dados com Python

-- Construindo seu Primeiro Projeto Lógico de Banco de Dados.

-- DDL & DML:

-- Criação do BD
CREATE DATABASE ecommerce;
USE ecommerce;

-- Criação das tabelas
CREATE TABLE Cliente (
    ID_Cliente INT PRIMARY KEY,
    Nome VARCHAR(255),
    Tipo ENUM('PF', 'PJ'),
    CPF VARCHAR(14),
    CNPJ VARCHAR(18),
    Endereco VARCHAR(255)
);

CREATE TABLE FormaDePagamento (
    ID_FormaDePagamento INT PRIMARY KEY,
    Tipo VARCHAR(50)
);

CREATE TABLE Pedido (
    ID_Pedido INT PRIMARY KEY,
    ID_Cliente INT,
    DataPedido DATE,
    FOREIGN KEY (ID_Cliente) REFERENCES Cliente(ID_Cliente)
);

CREATE TABLE Produto (
    ID_Produto INT PRIMARY KEY,
    Nome VARCHAR(255),
    Preco DECIMAL(10, 2)
);

CREATE TABLE Fornecedor (
    ID_Fornecedor INT PRIMARY KEY,
    Nome VARCHAR(255)
);

CREATE TABLE Estoque (
    ID_Estoque INT PRIMARY KEY,
    ID_Produto INT,
    ID_Fornecedor INT,
    Quantidade INT,
    FOREIGN KEY (ID_Produto) REFERENCES Produto(ID_Produto),
    FOREIGN KEY (ID_Fornecedor) REFERENCES Fornecedor(ID_Fornecedor)
);

CREATE TABLE Entrega (
    ID_Entrega INT PRIMARY KEY,
    ID_Pedido INT,
    Status VARCHAR(50),
    CodigoRastreio VARCHAR(255),
    FOREIGN KEY (ID_Pedido) REFERENCES Pedido(ID_Pedido)
);

-- Exemplo de inserção de dados
INSERT INTO Cliente (ID_Cliente, Nome, Tipo, CPF, CNPJ, Endereco)
VALUES (1, 'Cliente PF', 'PF', '123.456.789-00', NULL, 'Rua PF, 123');

INSERT INTO Cliente (ID_Cliente, Nome, Tipo, CPF, CNPJ, Endereco)
VALUES (2, 'Cliente PJ', 'PJ', NULL, '12.345.678/0001-00', 'Av. PJ, 456');


-- Exemplo de consulta: Quantos pedidos foram feitos por cada cliente?
SELECT C.Nome, COUNT(P.ID_Pedido) AS QuantidadePedidos
FROM Cliente C
LEFT JOIN Pedido P ON C.ID_Cliente = P.ID_Cliente
GROUP BY C.Nome;