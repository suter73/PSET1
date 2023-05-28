DROP DATABASE IF EXISTS uvv;
DROP USER If EXISTS gustavo; 
CREATE USER gustavo WITH createdb createrole encrypted password 'suter'; 
CREATE DATABASE uvv 
    WITH 
    OWNER = usuario
    TEMPLATE = template0
    ENCODING = 'UTF8'
    LC_COLLATE = 'pt_BR.UTF-8'
    LC_CTYPE = 'pt_BR.UTF-8'
    ALLOW_CONNECTIONS = true;
 \c "dbname=uvv user=gustavo password=suter"
CREATE SCHEMA IF NOT EXISTS lojas AUTHORIZATION gustavo;
ALTER USER gustavo
SET SEARCH_PATH TO lojas, "$user", public;

CREATE SCHEMA IF NOT EXISTS lojas AUTHORIZATION gustavo;
ALTER USER gustavo
SET SEARCH_PATH TO lojas, "$user", public;
CREATE TABLE lojas.produtos (
                produto_id NUMERIC(38) NOT NULL,
                nome VARCHAR(255) NOT NULL,
                preco_unitario NUMERIC(10,2),
                detalhes BYTEA,
                imagem BYTEA,
                imagem_mime_type VARCHAR(512),
                imagem_arquivo VARCHAR(512),
                imagem_charset VARCHAR(512),
                imagem_ultima_atualizacao DATE,
                CONSTRAINT produtos_id PRIMARY KEY (produto_id)
);
COMMENT ON TABLE lojas.produtos IS 'identificação de produto';
COMMENT ON COLUMN lojas.produtos.produto_id IS 'identificação de produto';
COMMENT ON COLUMN lojas.produtos.nome IS 'nome do produto';
COMMENT ON COLUMN lojas.produtos.preco_unitario IS 'preco do produto';
COMMENT ON COLUMN lojas.produtos.detalhes IS 'detalhes do produto';
COMMENT ON COLUMN lojas.produtos.imagem IS 'imagem do produto';
COMMENT ON COLUMN lojas.produtos.imagem_mime_type IS 'tipo da imagem';
COMMENT ON COLUMN lojas.produtos.imagem_arquivo IS 'imagem do arquivo';
COMMENT ON COLUMN lojas.produtos.imagem_charset IS 'charset da imagem';
COMMENT ON COLUMN lojas.produtos.imagem_ultima_atualizacao IS 'ultima atualizacao da imagem';


CREATE TABLE lojas.lojas (
                loja_id NUMERIC(38) NOT NULL,
                nome VARCHAR(255) NOT NULL,
                endereço_web VARCHAR(100),
                enedereço_fisico VARCHAR(512),
                latitude NUMERIC,
                longitude NUMERIC,
                logo BYTEA,
                logo_arquivo VARCHAR(512),
                logo_mime_type VARCHAR(512),
                logo_charset VARCHAR(512),
                logo_ultima_atualizaçao DATE,
                CONSTRAINT lojas_id PRIMARY KEY (loja_id)
);
COMMENT ON COLUMN lojas.lojas.loja_id IS 'identificação da loja';
COMMENT ON COLUMN lojas.lojas.nome IS 'nome da loja';
COMMENT ON COLUMN lojas.lojas.endereço_web IS 'endereço web da loja';
COMMENT ON COLUMN lojas.lojas.enedereço_fisico IS 'enedereço fisico da loja';
COMMENT ON COLUMN lojas.lojas.latitude IS 'latiude da loja';
COMMENT ON COLUMN lojas.lojas.longitude IS 'longitude da loja';
COMMENT ON COLUMN lojas.lojas.logo IS 'logo da loja';
COMMENT ON COLUMN lojas.lojas.logo_arquivo IS 'arquivo do logo';
COMMENT ON COLUMN lojas.lojas.logo_mime_type IS 'mime type da logo';
COMMENT ON COLUMN lojas.lojas.logo_charset IS 'charset do logo';
COMMENT ON COLUMN lojas.lojas.logo_ultima_atualizaçao IS 'ultima atualizaçao da logo';


CREATE TABLE lojas.estoques (
                estoque_id NUMERIC(38) NOT NULL,
                loja_id NUMERIC(38) NOT NULL,
                produto_id NUMERIC(38) NOT NULL,
                quantidade NUMERIC(38) NOT NULL,
                CONSTRAINT estoque_id PRIMARY KEY (estoque_id)
);
COMMENT ON TABLE lojas.estoques IS 'identificação de estoque';
COMMENT ON COLUMN lojas.estoques.estoque_id IS 'identificação do estoque';
COMMENT ON COLUMN lojas.estoques.loja_id IS 'identificação da loja';
COMMENT ON COLUMN lojas.estoques.quantidade IS 'quantidade do estoque';


CREATE TABLE lojas.clientes (
                cliente_id NUMERIC(38) NOT NULL,
                email VARCHAR(255) NOT NULL,
                nome VARCHAR(255) NOT NULL,
                telefone1 VARCHAR(20),
                telefone2 VARCHAR(20),
                telefone3 VARCHAR(20),
                CONSTRAINT clientes_id PRIMARY KEY (cliente_id)
);
COMMENT ON TABLE lojas.clientes IS 'tabela cliente';
COMMENT ON COLUMN lojas.clientes.cliente_id IS 'identificação cliente';
COMMENT ON COLUMN lojas.clientes.email IS 'email do cliente';
COMMENT ON COLUMN lojas.clientes.nome IS 'nome do cliente';
COMMENT ON COLUMN lojas.clientes.telefone1 IS 'telefone do cliente';
COMMENT ON COLUMN lojas.clientes.telefone2 IS 'telefone do cliente';
COMMENT ON COLUMN lojas.clientes.telefone3 IS 'telefone do cliente';


CREATE TABLE lojas.envios (
                envio_id NUMERIC(38) NOT NULL,
                loja_id NUMERIC(38) NOT NULL,
                cliente_id NUMERIC(38) NOT NULL,
                endereco_entrega VARCHAR(512) NOT NULL,
                status VARCHAR(15) NOT NULL,
                CONSTRAINT envio_id PRIMARY KEY (envio_id)
);
COMMENT ON COLUMN lojas.envios.envio_id IS 'identificação de envio';
COMMENT ON COLUMN lojas.envios.loja_id IS 'identificação da loja';
COMMENT ON COLUMN lojas.envios.cliente_id IS 'identificação de cliente';
COMMENT ON COLUMN lojas.envios.endereco_entrega IS 'endereço de entrega';
COMMENT ON COLUMN lojas.envios.status IS 'status do envio';


CREATE TABLE lojas.pedidos (
                pedido_id NUMERIC(38) NOT NULL,
                data_hora TIMESTAMP NOT NULL,
                cliente_id NUMERIC(38) NOT NULL,
                status VARCHAR(15) NOT NULL,
                loja_id NUMERIC(38) NOT NULL,
                CONSTRAINT pedidos_pk PRIMARY KEY (pedido_id)
);
COMMENT ON COLUMN lojas.pedidos.pedido_id IS 'identificação do pedido';
COMMENT ON COLUMN lojas.pedidos.data_hora IS 'data e hora do pedido';
COMMENT ON COLUMN lojas.pedidos.cliente_id IS 'identificação do cliente';
COMMENT ON COLUMN lojas.pedidos.status IS 'status do pedido';
COMMENT ON COLUMN lojas.pedidos.loja_id IS 'identificação da loja';


CREATE TABLE lojas.pedidos_itens (
                pedido_id NUMERIC(38) NOT NULL,
                produto_id NUMERIC(38) NOT NULL,
                numero_da_linha NUMERIC(38) NOT NULL,
                preco_unitario NUMERIC(10,2) NOT NULL,
                quantidade NUMERIC(38) NOT NULL,
                envio_id NUMERIC(38),
                CONSTRAINT pedidos_itens_id PRIMARY KEY (pedido_id, produto_id)
);
COMMENT ON COLUMN lojas.pedidos_itens.pedido_id IS 'identificação do pedido';
COMMENT ON COLUMN lojas.pedidos_itens.produto_id IS 'identificaao de produto';
COMMENT ON COLUMN lojas.pedidos_itens.numero_da_linha IS 'numero da linha';
COMMENT ON COLUMN lojas.pedidos_itens.preco_unitario IS 'preço de cada pedido';
COMMENT ON COLUMN lojas.pedidos_itens.quantidade IS 'quantidade de pedidos';
COMMENT ON COLUMN lojas.pedidos_itens.envio_id IS 'identificação de envio';


ALTER TABLE lojas.estoques ADD CONSTRAINT produtos_estoques_fk
FOREIGN KEY (produto_id)
REFERENCES lojas.produtos (produto_id)
ON DELETE NO ACTION
ON UPDATE NO ACTION
NOT DEFERRABLE;

ALTER TABLE lojas.pedidos_itens ADD CONSTRAINT produtos_pedidos_itens_fk
FOREIGN KEY (produto_id)
REFERENCES lojas.produtos (produto_id)
ON DELETE NO ACTION
ON UPDATE NO ACTION
NOT DEFERRABLE;

ALTER TABLE lojas.pedidos ADD CONSTRAINT lojas_pedidos_fk
FOREIGN KEY (loja_id)
REFERENCES lojas.lojas (loja_id)
ON DELETE NO ACTION
ON UPDATE NO ACTION
NOT DEFERRABLE;

ALTER TABLE lojas.envios ADD CONSTRAINT lojas_envios_fk
FOREIGN KEY (loja_id)
REFERENCES lojas.lojas (loja_id)
ON DELETE NO ACTION
ON UPDATE NO ACTION
NOT DEFERRABLE;

ALTER TABLE lojas.estoques ADD CONSTRAINT lojas_estoques_fk
FOREIGN KEY (loja_id)
REFERENCES lojas.lojas (loja_id)
ON DELETE NO ACTION
ON UPDATE NO ACTION
NOT DEFERRABLE;

ALTER TABLE lojas.pedidos ADD CONSTRAINT clientes_pedidos_fk
FOREIGN KEY (cliente_id)
REFERENCES lojas.clientes (cliente_id)
ON DELETE NO ACTION
ON UPDATE NO ACTION
NOT DEFERRABLE;

ALTER TABLE lojas.envios ADD CONSTRAINT clientes_envios_fk
FOREIGN KEY (cliente_id)
REFERENCES lojas.clientes (cliente_id)
ON DELETE NO ACTION
ON UPDATE NO ACTION
NOT DEFERRABLE;

ALTER TABLE lojas.pedidos_itens ADD CONSTRAINT envios_pedidos_itens_fk
FOREIGN KEY (envio_id)
REFERENCES lojas.envios (envio_id)
ON DELETE NO ACTION
ON UPDATE NO ACTION
NOT DEFERRABLE;

ALTER TABLE lojas.pedidos_itens ADD CONSTRAINT pedidos_pedidos_itens_fk
FOREIGN KEY (pedido_id)
REFERENCES lojas.pedidos (pedido_id)
ON DELETE NO ACTION
ON UPDATE NO ACTION
NOT DEFERRABLE;
