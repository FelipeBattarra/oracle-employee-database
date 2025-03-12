CREATE TABLE tb_region( 
id_region      NUMBER CONSTRAINT nn_id_region NOT NULL, 
nm_region      VARCHAR2(25)); 

CREATE UNIQUE INDEX pk_id_region
ON tb_region (id_region);

ALTER TABLE tb_region
ADD ( CONSTRAINT pk_id_region
      PRIMARY KEY (id_region));
      
-- Creating table "tb_country"

CREATE TABLE tb_country( 
id_country      CHAR(2) CONSTRAINT nn_id_country NOT NULL, 
nm_country      VARCHAR2(40), 
id_region    NUMBER, 
CONSTRAINT pk_id_country PRIMARY KEY (id_country)); 

ALTER TABLE tb_country
ADD ( CONSTRAINT fk_region_country
         FOREIGN KEY (id_region) REFERENCES tb_region(id_region)) ;
      
-- Creating table "tb_location"
CREATE TABLE tb_location( 
id_location    NUMBER(4), 
id_country           CHAR(2),
address          VARCHAR2(40), 
zipcode               VARCHAR2(12), 
city            VARCHAR2(30) CONSTRAINT nn_loc_city  NOT NULL, 
state            VARCHAR2(25));

CREATE UNIQUE INDEX pk_id_location
ON tb_location (id_location);

ALTER TABLE tb_location
ADD ( CONSTRAINT pk_id_loc
         PRIMARY KEY (id_location), 
      CONSTRAINT fk_id_country
       		 FOREIGN KEY (id_country)
        	  REFERENCES tb_country(id_country));

CREATE SEQUENCE sq_localizacao
 START WITH     3300
 INCREMENT BY   100
 MAXVALUE       9900
 NOCACHE
 NOCYCLE;
 
 -- Creating table "tb_department"
 CREATE TABLE tb_department( 
 id_department  NUMBER(4), 
 nm_department  VARCHAR2(30) CONSTRAINT nn_nm_depto NOT NULL, 
 id_manager       NUMBER(6), 
 id_location   NUMBER(4));

CREATE UNIQUE INDEX pk_id_department
ON tb_department (id_department);

ALTER TABLE tb_department
ADD ( CONSTRAINT pk_id_department
         PRIMARY KEY (id_department), 
      CONSTRAINT fk_loc_department
         FOREIGN KEY (id_location) REFERENCES tb_location (id_location));

CREATE SEQUENCE sq_departamento
 START WITH     280
 INCREMENT BY   10
 MAXVALUE       9990
 NOCACHE
 NOCYCLE;
 
-- Creating table "tb_job"
CREATE TABLE tb_job( 
id_job         VARCHAR2(10), 
ds_job         VARCHAR2(35) CONSTRAINT nn_ds_job NOT NULL, 
salary_base      NUMBER(6), 
salary_cap      NUMBER(6));

CREATE UNIQUE INDEX pk_id_job 
ON tb_job (id_job);

ALTER TABLE tb_job
ADD ( CONSTRAINT pk_id_job
      		 PRIMARY KEY(id_job)) ;

-- Criaçao table "tb_employee"
CREATE TABLE tb_employee( 
id_employee        NUMBER(6), 
first_name                VARCHAR2(20), 
sobrefirst_name           VARCHAR2(25) CONSTRAINT nn_emp_sobrefirst_name NOT NULL, 
email               VARCHAR2(25) CONSTRAINT nn_emp_email  NOT NULL, 
phone            VARCHAR2(20), 
hire_date       DATE CONSTRAINT  nn_emp_dt_admissao NOT NULL , 
id_job           VARCHAR2(10) CONSTRAINT nn_emp_funcao NOT NULL, 
salary             NUMBER(8,2), 
commission_pct NUMBER(2,2),
id_manager          NUMBER(6), 
id_department     NUMBER(4),
CONSTRAINT ck_emp_salary CHECK (salary > 0), 
CONSTRAINT un_emp_email UNIQUE (email));

CREATE UNIQUE INDEX pk_id_emp
ON tb_employee (id_employee);

ALTER TABLE tb_employee
ADD ( CONSTRAINT pk_id_emp
         PRIMARY KEY (id_employee), 
      CONSTRAINT fk_emp_dept
         FOREIGN KEY (id_department) REFERENCES tb_department, 
      CONSTRAINT fk_emp_job
         FOREIGN KEY (id_job) REFERENCES tb_job (id_job), 
      CONSTRAINT  fk_emp_manager
         FOREIGN KEY (id_manager) REFERENCES tb_employee);

ALTER TABLE tb_department
ADD ( CONSTRAINT fk_manager_dept
         FOREIGN KEY (id_manager) REFERENCES tb_employee (id_employee)) ;

CREATE SEQUENCE sq_empregado
 START WITH     207
 INCREMENT BY   1
 NOCACHE
 NOCYCLE;
 
 -- Creating table "tb_job_history"
 CREATE TABLE tb_job_history( 
 id_employee     NUMBER(6) CONSTRAINT nn_hist_emp_id_emp NOT NULL, 
 start_date      DATE CONSTRAINT nn_hist_emp_dt_inicio  NOT NULL, 
 end_date     DATE CONSTRAINT nn_hist_emp_dt_termino NOT NULL, 
 id_job        VARCHAR2(10) CONSTRAINT nn_hist_emp_id_job NOT NULL, 
 id_department  NUMBER(4), 
 CONSTRAINT  ck_emp_data_intervalo CHECK (end_date > start_date));

CREATE UNIQUE INDEX pk_hist_emp_id_emp 
ON tb_job_history (id_employee, start_date);

ALTER TABLE tb_job_history
ADD ( CONSTRAINT pk_hist_emp_id_emp
         PRIMARY KEY (id_employee, start_date), 
      CONSTRAINT  fk_hist_job_job
         FOREIGN KEY (id_job) REFERENCES tb_job, 
      CONSTRAINT  fk_hist_job_emp
        FOREIGN KEY (id_employee) REFERENCES tb_employee, 
      CONSTRAINT  fk_hist_job_dept
        FOREIGN KEY (id_department) REFERENCES tb_department);

-- Inserting data table "tb_region"
INSERT INTO tb_region 
VALUES 
(1, 'Europa');

INSERT INTO tb_region
VALUES 
(2, 'Américas');

INSERT INTO tb_region 
VALUES 
(3, 'Ásia');

INSERT INTO tb_region 
VALUES 
(4, 'Oriente Médio e África');

------------------------------
-- Inserting data table "tb_country"

INSERT INTO tb_country 
VALUES 
( 'IT', 'Itália', 1);

INSERT INTO tb_country 
VALUES 
( 'JP', 'Japão', 3);

INSERT INTO tb_country 
VALUES 
( 'US', 'EUA', 2);

INSERT INTO tb_country 
VALUES 
( 'CA', 'Canadá', 2);

INSERT INTO tb_country 
VALUES 
( 'CN', 'China', 3);

INSERT INTO tb_country 
VALUES 
( 'IN', 'Índia', 3);

INSERT INTO tb_country 
VALUES 
( 'AU', 'Austrália', 3);

INSERT INTO tb_country 
VALUES 
( 'ZW', 'Zimbábue', 4);

INSERT INTO tb_country 
VALUES 
( 'SG', 'Cingapura', 3);

INSERT INTO tb_country 
VALUES 
( 'UK', 'Reino Unido', 1);

INSERT INTO tb_country 
VALUES 
( 'FR', 'França', 1);

INSERT INTO tb_country 
VALUES 
( 'DE', 'Alemanha', 1);

INSERT INTO tb_country 
VALUES 
( 'ZM', 'Zâmbia', 4);

INSERT INTO tb_country 
VALUES 
( 'EG', 'Egito', 4);

INSERT INTO tb_country 
VALUES 
( 'BR', 'Brasil', 2);

INSERT INTO tb_country 
VALUES 
( 'CH', 'Suíça', 1);

INSERT INTO tb_country 
VALUES 
( 'NL', 'Holanda', 1);

INSERT INTO tb_country 
VALUES 
( 'MX', 'México', 2);

INSERT INTO tb_country 
VALUES 
( 'KW', 'Kuweit', 4);

INSERT INTO tb_country 
VALUES 
( 'IL', 'Israel', 4 );

INSERT INTO tb_country 
VALUES 
( 'DK', 'Dinamarca', 1);

INSERT INTO tb_country 
VALUES 
( 'HK', 'Hong Kong', 3);

INSERT INTO tb_country 
VALUES 
( 'NG', 'Nigéria', 4 );

INSERT INTO tb_country 
VALUES 
( 'AR', 'Argentina', 2);

INSERT INTO tb_country 
VALUES 
( 'BE', 'Bélgica', 1 );

---------------------------
-- Inserting data table "tb_location"
INSERT INTO tb_location 
VALUES 
( 1000, 'IT', 'Via Cola di Rie, 1297', '00989', 'Roma', NULL);

INSERT INTO tb_location 
VALUES 
( 1100, 'IT', 'Calle della Testa, 93091', '10934', 'Veneza', NULL);

INSERT INTO tb_location 
VALUES 
( 1200, 'JP', 'Shinjuku-ku, 2017 ', '1689', 'Tóquio', 'Prefeitura de Tóquio');

INSERT INTO tb_location 
VALUES 
( 1300, 'JP', 'Kamiya-cho, 9450 ', '6823', 'Hiroshima', NULL);

INSERT INTO tb_location 
VALUES 
( 1400, 'US' , 'Jabberwocky Rd, 2014 ', '26192', 'Southlake', 'Texas');

INSERT INTO tb_location 
VALUES 
 (1500, 'US', 'Interiors Blvd, 2011 ', '99236', 'Sul de São Francisco', 'Califórnia');

INSERT INTO tb_location 
VALUES 
(1600, 'US', 'Zagora St, 2007 ', '50090', 'South Brunswick', 'New Jersey');

INSERT INTO tb_location 
VALUES 
(1700, 'US', 'Charade Rd, 2004 ', '98199', 'Seattle', 'Washington');

INSERT INTO tb_location 
VALUES 
(1800, 'CA', 'Spadina Ave, 147 ', 'M5V 2L7', 'Toronto', 'Ontário');

INSERT INTO tb_location 
VALUES 
(1900, 'CA', 'Boxwood St, 6092 ', 'YSW 9T2', 'Whitehorse', 'Yukon');

INSERT INTO tb_location 
VALUES 
(2000, 'CN', 'Laogianggen, 40-5-12', '190518', 'Pequim', NULL);

INSERT INTO tb_location 
VALUES 
(2100, 'IN', 'Vileparle (E), 1298 ', '490231', 'Bombaim', 'Maharashtra');

INSERT INTO tb_location 
VALUES 
(2200, 'AU', 'Victoria Street, 12-98', '2901', 'Sydney', 'Nova Gales do Sul');

INSERT INTO tb_location 
VALUES 
(2300, 'SG', 'Clementi North, 198 ', '540198', 'Cingapua', NULL);

INSERT INTO tb_location 
VALUES 
(2400, 'UK', 'Arthur St, 8204 ', NULL, 'Londres', NULL);

INSERT INTO tb_location 
VALUES 
(2500, 'UK', 'Magdalen Centre, The Oxford Science Park', 'OX9 9ZB', 'Oxford', 'Oxford');

INSERT INTO tb_location
VALUES 
(2600, 'UK', 'Chester Road, 9702 ', '09629850293', 'Stretford', 'Manchester');

INSERT INTO tb_location 
VALUES 
(2700, 'DE', 'Schwanthalerstr. 7031', '80925', 'Munique', 'Bavaria');

INSERT INTO tb_location 
VALUES 
(2800, 'BR', 'Rua Frei Caneca 1360 ', '01307-002', 'São Paulo', 'São Paulo');

INSERT INTO tb_location 
VALUES 
(2900, 'CH', 'Rue des Corps-Saints, 20', '1730', 'Geneva', 'Geneve');

INSERT INTO tb_location 
VALUES 
(3000, 'CH', 'Murtenstrasse 921', '3095', 'Bern', 'BE');

INSERT INTO tb_location 
VALUES 
(3100, 'NL', 'Pieter Breughelstraat 837', '3029SK', 'Utrecht', 'Utrecht');

INSERT INTO tb_location 
VALUES 
(3200, 'MX', 'Mariano Escobedo 9991', '11932', 'Cidade do México', 'Distrito Federal');

----------------------
-- Inserting data table "tb_department"
-- Disabling integrity constraint da tb_employee para carregar os dados
ALTER TABLE tb_department
  DISABLE CONSTRAINT fk_manager_dept;

INSERT INTO tb_department 
VALUES 
(10, 'Administração', 200, 1700);

INSERT INTO tb_department 
VALUES 
(20, 'Marketing', 201, 1800);
                                
INSERT INTO tb_department 
VALUES 
(30, 'Aquisição', 114, 1700);
                
INSERT INTO tb_department 
VALUES 
(40, 'Recursos Humanos', 203, 2400);

INSERT INTO tb_department 
VALUES 
(50, 'Expedição', 121, 1500);
                
INSERT INTO tb_department 
VALUES 
(60, 'TI', 103, 1400);
                
INSERT INTO tb_department 
VALUES 
(70, 'Relações Públicas', 204, 2700);
                
INSERT INTO tb_department 
VALUES 
(80, 'Vendas', 145, 2500);
                
INSERT INTO tb_department 
VALUES 
(90, 'Executivo', 100, 1700);

INSERT INTO tb_department 
VALUES 
(100, 'Financeiro', 108, 1700);
                
INSERT INTO tb_department 
VALUES 
(110, 'Contabilidade', 205, 1700);

INSERT INTO tb_department 
VALUES 
(120, 'Tesouraria', NULL, 1700);

INSERT INTO tb_department 
VALUES 
(130, 'Corporativo', NULL, 1700);

INSERT INTO tb_department 
VALUES 
(140, 'Controle de Crédito', NULL, 1700);

INSERT INTO tb_department 
VALUES 
(150, 'Suporte de Serviços', NULL, 1700);

INSERT INTO tb_department 
VALUES 
(160, 'Benefícios', NULL, 1700);

INSERT INTO tb_department 
VALUES 
(170, 'Fábrica', NULL, 1700);

INSERT INTO tb_department 
VALUES 
(180, 'Construção', NULL, 1700);

INSERT INTO tb_department 
VALUES 
(190, 'Contratante', NULL, 1700);

INSERT INTO tb_department 
VALUES 
(200, 'Operações', NULL, 1700);

INSERT INTO tb_department 
VALUES 
(210, 'Suporte de TI', NULL, 1700);

INSERT INTO tb_department 
VALUES 
(220, 'NOC', NULL, 1700);

INSERT INTO tb_department 
VALUES 
(230, 'Helpdesk', NULL, 1700);

INSERT INTO tb_department 
VALUES 
(240, 'Vendas Governo', NULL, 1700);

INSERT INTO tb_department 
VALUES 
(250, 'Vendas Varejo', NULL, 1700);

INSERT INTO tb_department 
VALUES 
(260, 'Recrutamento', NULL, 1700);

INSERT INTO tb_department 
VALUES 
(270, 'Folha de Pagamentos', NULL, 1700);


-------------------------
-- Inserting data table "tb_job"
INSERT INTO tb_job 
VALUES 
('AD_PRES', 'Presidente', 20000, 40000);

INSERT INTO tb_job 
VALUES 
('AD_VP', 'Vice Presidente Administrativo', 15000, 30000);

INSERT INTO tb_job 
VALUES 
('AD_ASST', 'Assistente Administrativo', 3000, 6000);

INSERT INTO tb_job 
VALUES 
('FI_MGR', 'Gerente Financeiro', 8200, 16000);

INSERT INTO tb_job 
VALUES 
('FI_ACCOUNT', 'Contador', 4200, 9000);

INSERT INTO tb_job 
VALUES 
('AC_MGR', 'Gerente de Contabilidade', 8200, 16000);

INSERT INTO tb_job 
VALUES 
('AC_ACCOUNT', 'Contador Público', 4200, 9000);

INSERT INTO tb_job 
VALUES 
('SA_MAN', 'Gerente de Vendas', 10000, 20000);

INSERT INTO tb_job 
VALUES 
('SA_REP', 'Representante de Vendas', 6000, 12000);

INSERT INTO tb_job 
VALUES 
('PU_MAN', 'Gerente de Compras', 8000, 15000);

INSERT INTO tb_job 
VALUES 
('PU_CLERK', 'Compras', 2500, 5500);

INSERT INTO tb_job 
VALUES 
('ST_MAN', 'Gerente de Estoque', 5500, 8500);

INSERT INTO tb_job 
VALUES 
('ST_CLERK', 'Estoque', 2000, 5000);

INSERT INTO tb_job 
VALUES 
('SH_CLERK', 'Despachante', 2500, 5500);

INSERT INTO tb_job 
VALUES 
('IT_PROG', 'Programador', 4000, 10000);

INSERT INTO tb_job 
VALUES 
('MK_MAN', 'Gerente de Marketing', 9000, 15000);

INSERT INTO tb_job 
VALUES 
('MK_REP', 'Representante de Marketing', 4000, 9000);

INSERT INTO tb_job 
VALUES 
( 'HR_REP', 'Representante de RH', 4000, 9000);

INSERT INTO tb_job 
VALUES 
('PR_REP', 'Representante de Relacoes Publica', 4500, 10500);


-------------------------------
-- Inserting data table "tb_employee"


INSERT INTO tb_employee 
VALUES 
        ( 100
        , 'Steven'
        , 'King'
        , 'SKING'
        , '515.123.4567'
        , TO_DATE('17-JUN-1987', 'dd-MON-yyyy')
        , 'AD_PRES'
        , 24000
        , NULL
        , NULL
        , 90
        );

INSERT INTO tb_employee 
VALUES 
        ( 101
        , 'Neena'
        , 'Kochhar'
        , 'NKOCHHAR'
        , '515.123.4568'
        , TO_DATE('21-09-1989', 'DD-MM-YYYY')
        , 'AD_VP'
        , 17000
        , NULL
        , 100
        , 90
        );

INSERT INTO tb_employee 
VALUES 
        ( 102
        , 'Lex'
        , 'De Haan'
        , 'LDEHAAN'
        , '515.123.4569'
        , TO_DATE('13-01-1993', 'DD-MM-YYYY')
        , 'AD_VP'
        , 17000
        , NULL
        , 100
        , 90
        );

INSERT INTO tb_employee 
VALUES 
        ( 103
        , 'Alexander'
        , 'Hunold'
        , 'AHUNOLD'
        , '590.423.4567'
        , TO_DATE('03-01-1990', 'DD-MM-YYYY')
        , 'IT_PROG'
        , 9000
        , NULL
        , 102
        , 60
        );

INSERT INTO tb_employee 
VALUES 
        ( 104
        , 'Bruce'
        , 'Ernst'
        , 'BERNST'
        , '590.423.4568'
        , TO_DATE('21-05-1991', 'DD-MM-YYYY')
        , 'IT_PROG'
        , 6000
        , NULL
        , 103
        , 60
        );

INSERT INTO tb_employee 
VALUES 
        ( 105
        , 'David'
        , 'Austin'
        , 'DAUSTIN'
        , '590.423.4569'
        , TO_DATE('25-06-1997', 'DD-MM-YYYY')
        , 'IT_PROG'
        , 4800
        , NULL
        , 103
        , 60
        );

INSERT INTO tb_employee 
VALUES 
        ( 106
        , 'Valli'
        , 'Pataballa'
        , 'VPATABAL'
        , '590.423.4560'
        , TO_DATE('05-02-1998', 'DD-MM-YYYY')
        , 'IT_PROG'
        , 4800
        , NULL
        , 103
        , 60
        );

INSERT INTO tb_employee 
VALUES 
        ( 107
        , 'Diana'
        , 'Lorentz'
        , 'DLORENTZ'
        , '590.423.5567'
        , TO_DATE('07-02-1999', 'DD-MM-YYYY')
        , 'IT_PROG'
        , 4200
        , NULL
        , 103
        , 60
        );

INSERT INTO tb_employee 
VALUES 
        ( 108
        , 'Nancy'
        , 'Greenberg'
        , 'NGREENBE'
        , '515.124.4569'
        , TO_DATE('17-08-1994', 'DD-MM-YYYY')
        , 'FI_MGR'
        , 12000
        , NULL
        , 101
        , 100
        );

INSERT INTO tb_employee 
VALUES 
        ( 109
        , 'Daniel'
        , 'Faviet'
        , 'DFAVIET'
        , '515.124.4169'
        , TO_DATE('16-08-1994', 'DD-MM-YYYY')
        , 'FI_ACCOUNT'
        , 9000
        , NULL
        , 108
        , 100
        );

INSERT INTO tb_employee 
VALUES 
        ( 110
        , 'John'
        , 'Chen'
        , 'JCHEN'
        , '515.124.4269'
        , TO_DATE('28-09-1997', 'DD-MM-YYYY')
        , 'FI_ACCOUNT'
        , 8200
        , NULL
        , 108
        , 100
        );

INSERT INTO tb_employee 
VALUES 
        ( 111
        , 'Ismael'
        , 'Sciarra'
        , 'ISCIARRA'
        , '515.124.4369'
        , TO_DATE('30-09-1997', 'DD-MM-YYYY')
        , 'FI_ACCOUNT'
        , 7700
        , NULL
        , 108
        , 100
        );

INSERT INTO tb_employee 
VALUES 
        ( 112
        , 'Jose Manuel'
        , 'Urman'
        , 'JMURMAN'
        , '515.124.4469'
        , TO_DATE('07-03-1998', 'DD-MM-YYYY')
        , 'FI_ACCOUNT'
        , 7800
        , NULL
        , 108
        , 100
        );

INSERT INTO tb_employee 
VALUES 
        ( 113
        , 'Luis'
        , 'Popp'
        , 'LPOPP'
        , '515.124.4567'
        , TO_DATE('07-12-1999', 'DD-MM-YYYY')
        , 'FI_ACCOUNT'
        , 6900
        , NULL
        , 108
        , 100
        );

INSERT INTO tb_employee 
VALUES 
        ( 114
        , 'Den'
        , 'Raphaely'
        , 'DRAPHEAL'
        , '515.127.4561'
        , TO_DATE('07-12-1994', 'DD-MM-YYYY')
        , 'PU_MAN'
        , 11000
        , NULL
        , 100
        , 30
        );

INSERT INTO tb_employee 
VALUES 
        ( 115
        , 'Alexander'
        , 'Khoo'
        , 'AKHOO'
        , '515.127.4562'
        , TO_DATE('18-05-1995', 'DD-MM-YYYY')
        , 'PU_CLERK'
        , 3100
        , NULL
        , 114
        , 30
        );

INSERT INTO tb_employee 
VALUES 
        ( 116
        , 'Shelli'
        , 'Baida'
        , 'SBAIDA'
        , '515.127.4563'
        , TO_DATE('24-12-1997', 'DD-MM-YYYY')
        , 'PU_CLERK'
        , 2900
        , NULL
        , 114
        , 30
        );

INSERT INTO tb_employee 
VALUES 
        ( 117
        , 'Sigal'
        , 'Tobias'
        , 'STOBIAS'
        , '515.127.4564'
        , TO_DATE('24-07-1997', 'DD-MM-YYYY')
        , 'PU_CLERK'
        , 2800
        , NULL
        , 114
        , 30
        );

INSERT INTO tb_employee 
VALUES 
        ( 118
        , 'Guy'
        , 'Himuro'
        , 'GHIMURO'
        , '515.127.4565'
        , TO_DATE('15-11-1998', 'DD-MM-YYYY')
        , 'PU_CLERK'
        , 2600
        , NULL
        , 114
        , 30
        );

INSERT INTO tb_employee 
VALUES 
        ( 119
        , 'Karen'
        , 'Colmenares'
        , 'KCOLMENA'
        , '515.127.4566'
        , TO_DATE('10-08-1999', 'DD-MM-YYYY')
        , 'PU_CLERK'
        , 2500
        , NULL
        , 114
        , 30
        );

INSERT INTO tb_employee 
VALUES 
        ( 120
        , 'Matthew'
        , 'Weiss'
        , 'MWEISS'
        , '650.123.1234'
        , TO_DATE('18-07-1996', 'DD-MM-YYYY')
        , 'ST_MAN'
        , 8000
        , NULL
        , 100
        , 50
        );

INSERT INTO tb_employee 
VALUES 
        ( 121
        , 'Adam'
        , 'Fripp'
        , 'AFRIPP'
        , '650.123.2234'
        , TO_DATE('10-04-1997', 'DD-MM-YYYY')
        , 'ST_MAN'
        , 8200
        , NULL
        , 100
        , 50
        );

INSERT INTO tb_employee 
VALUES 
        ( 122
        , 'Payam'
        , 'Kaufling'
        , 'PKAUFLIN'
        , '650.123.3234'
        , TO_DATE('01-05-1995', 'DD-MM-YYYY')
        , 'ST_MAN'
        , 7900
        , NULL
        , 100
        , 50
        );

INSERT INTO tb_employee 
VALUES 
        ( 123
        , 'Shanta'
        , 'Vollman'
        , 'SVOLLMAN'
        , '650.123.4234'
        , TO_DATE('10-10-1997', 'DD-MM-YYYY')
        , 'ST_MAN'
        , 6500
        , NULL
        , 100
        , 50
        );

INSERT INTO tb_employee 
VALUES 
        ( 124
        , 'Kevin'
        , 'Mourgos'
        , 'KMOURGOS'
        , '650.123.5234'
        , TO_DATE('16-11-1999', 'DD-MM-YYYY')
        , 'ST_MAN'
        , 5800
        , NULL
        , 100
        , 50
        );

INSERT INTO tb_employee 
VALUES 
        ( 125
        , 'Julia'
        , 'Nayer'
        , 'JNAYER'
        , '650.124.1214'
        , TO_DATE('16-07-1997', 'DD-MM-YYYY')
        , 'ST_CLERK'
        , 3200
        , NULL
        , 120
        , 50
        );

INSERT INTO tb_employee 
VALUES 
        ( 126
        , 'Irene'
        , 'Mikkilineni'
        , 'IMIKKILI'
        , '650.124.1224'
        , TO_DATE('28-09-1998', 'DD-MM-YYYY')
        , 'ST_CLERK'
        , 2700
        , NULL
        , 120
        , 50
        );

INSERT INTO tb_employee VALUES 
        ( 127
        , 'James'
        , 'Landry'
        , 'JLANDRY'
        , '650.124.1334'
        , TO_DATE('14-01-1999', 'DD-MM-YYYY')
        , 'ST_CLERK'
        , 2400
        , NULL
        , 120
        , 50
        );

INSERT INTO tb_employee 
VALUES 
        ( 128
        , 'Steven'
        , 'Markle'
        , 'SMARKLE'
        , '650.124.1434'
        , TO_DATE('08-03-2000', 'DD-MM-YYYY')
        , 'ST_CLERK'
        , 2200
        , NULL
        , 120
        , 50
        );

INSERT INTO tb_employee 
VALUES 
        ( 129
        , 'Laura'
        , 'Bissot'
        , 'LBISSOT'
        , '650.124.5234'
        , TO_DATE('20-08-1997', 'DD-MM-YYYY')
        , 'ST_CLERK'
        , 3300
        , NULL
        , 121
        , 50
        );

INSERT INTO tb_employee 
VALUES 
        ( 130
        , 'Mozhe'
        , 'Atkinson'
        , 'MATKINSO'
        , '650.124.6234'
        , TO_DATE('30-10-1997', 'DD-MM-YYYY')
        , 'ST_CLERK'
        , 2800
        , NULL
        , 121
        , 50
        );

INSERT INTO tb_employee 
VALUES 
        ( 131
        , 'James'
        , 'Marlow'
        , 'JAMRLOW'
        , '650.124.7234'
        , TO_DATE('16-02-1997', 'DD-MM-YYYY')
        , 'ST_CLERK'
        , 2500
        , NULL
        , 121
        , 50
        );

INSERT INTO tb_employee 
VALUES 
        ( 132
        , 'TJ'
        , 'Olson'
        , 'TJOLSON'
        , '650.124.8234'
        , TO_DATE('10-04-1999', 'DD-MM-YYYY')
        , 'ST_CLERK'
        , 2100
        , NULL
        , 121
        , 50
        );

INSERT INTO tb_employee 
VALUES 
        ( 133
        , 'Jason'
        , 'Mallin'
        , 'JMALLIN'
        , '650.127.1934'
        , TO_DATE('14-06-1996', 'DD-MM-YYYY')
        , 'ST_CLERK'
        , 3300
        , NULL
        , 122
        , 50
        );

INSERT INTO tb_employee 
VALUES 
        ( 134
        , 'Michael'
        , 'Rogers'
        , 'MROGERS'
        , '650.127.1834'
        , TO_DATE('26-08-1998', 'DD-MM-YYYY')
        , 'ST_CLERK'
        , 2900
        , NULL
        , 122
        , 50
        );

INSERT INTO tb_employee 
VALUES 
        ( 135
        , 'Ki'
        , 'Gee'
        , 'KGEE'
        , '650.127.1734'
        , TO_DATE('12-12-1999', 'DD-MM-YYYY')
        , 'ST_CLERK'
        , 2400
        , NULL
        , 122
        , 50
        );

INSERT INTO tb_employee 
VALUES 
        ( 136
        , 'Hazel'
        , 'Philtanker'
        , 'HPHILTAN'
        , '650.127.1634'
        , TO_DATE('06-02-2000', 'DD-MM-YYYY')
        , 'ST_CLERK'
        , 2200
        , NULL
        , 122
        , 50
        );

INSERT INTO tb_employee 
VALUES 
        ( 137
        , 'Renske'
        , 'Ladwig'
        , 'RLADWIG'
        , '650.121.1234'
        , TO_DATE('14-07-1995', 'DD-MM-YYYY')
        , 'ST_CLERK'
        , 3600
        , NULL
        , 123
        , 50
        );

INSERT INTO tb_employee 
VALUES 
        ( 138
        , 'Stephen'
        , 'Stiles'
        , 'SSTILES'
        , '650.121.2034'
        , TO_DATE('26-10-1997', 'DD-MM-YYYY')
        , 'ST_CLERK'
        , 3200
        , NULL
        , 123
        , 50
        );

INSERT INTO tb_employee 
VALUES 
        ( 139
        , 'John'
        , 'Seo'
        , 'JSEO'
        , '650.121.2019'
        , TO_DATE('12-02-1998', 'DD-MM-YYYY')
        , 'ST_CLERK'
        , 2700
        , NULL
        , 123
        , 50
        );

INSERT INTO tb_employee 
VALUES 
        ( 140
        , 'Joshua'
        , 'Patel'
        , 'JPATEL'
        , '650.121.1834'
        , TO_DATE('06-04-1998', 'DD-MM-YYYY')
        , 'ST_CLERK'
        , 2500
        , NULL
        , 123
        , 50
        );

INSERT INTO tb_employee 
VALUES 
        ( 141
        , 'Trenna'
        , 'Rajs'
        , 'TRAJS'
        , '650.121.8009'
        , TO_DATE('17-10-1995', 'DD-MM-YYYY')
        , 'ST_CLERK'
        , 3500
        , NULL
        , 124
        , 50
        );

INSERT INTO tb_employee 
VALUES 
        ( 142
        , 'Curtis'
        , 'Davies'
        , 'CDAVIES'
        , '650.121.2994'
        , TO_DATE('29-01-1997', 'DD-MM-YYYY')
        , 'ST_CLERK'
        , 3100
        , NULL
        , 124
        , 50
        );

INSERT INTO tb_employee 
VALUES 
        ( 143
        , 'Randall'
        , 'Matos'
        , 'RMATOS'
        , '650.121.2874'
        , TO_DATE('15-03-1998', 'DD-MM-YYYY')
        , 'ST_CLERK'
        , 2600
        , NULL
        , 124
        , 50
        );

INSERT INTO tb_employee 
VALUES 
        ( 144
        , 'Peter'
        , 'Vargas'
        , 'PVARGAS'
        , '650.121.2004'
        , TO_DATE('09-07-1998', 'DD-MM-YYYY')
        , 'ST_CLERK'
        , 2500
        , NULL
        , 124
        , 50
        );

INSERT INTO tb_employee 
VALUES 
        ( 145
        , 'John'
        , 'Russell'
        , 'JRUSSEL'
        , '011.44.1344.429268'
        , TO_DATE('01-10-1996', 'DD-MM-YYYY')
        , 'SA_MAN'
        , 14000
        , .4
        , 100
        , 80
        );

INSERT INTO tb_employee 
VALUES 
        ( 146
        , 'Karen'
        , 'Partners'
        , 'KPARTNER'
        , '011.44.1344.467268'
        , TO_DATE('05-01-1997', 'DD-MM-YYYY')
        , 'SA_MAN'
        , 13500
        , .3
        , 100
        , 80
        );

INSERT INTO tb_employee 
VALUES 
        ( 147
        , 'Alberto'
        , 'Errazuriz'
        , 'AERRAZUR'
        , '011.44.1344.429278'
        , TO_DATE('10-03-1997', 'DD-MM-YYYY')
        , 'SA_MAN'
        , 12000
        , .3
        , 100
        , 80
        );

INSERT INTO tb_employee 
VALUES 
        ( 148
        , 'Gerald'
        , 'Cambrault'
        , 'GCAMBRAU'
        , '011.44.1344.619268'
        , TO_DATE('15-10-1999', 'DD-MM-YYYY')
        , 'SA_MAN'
        , 11000
        , .3
        , 100
        , 80
        );

INSERT INTO tb_employee 
VALUES 
        ( 149
        , 'Eleni'
        , 'Zlotkey'
        , 'EZLOTKEY'
        , '011.44.1344.429018'
        , TO_DATE('29-01-2000', 'DD-MM-YYYY')
        , 'SA_MAN'
        , 10500
        , .2
        , 100
        , 80
        );

INSERT INTO tb_employee 
VALUES 
        ( 150
        , 'Peter'
        , 'Tucker'
        , 'PTUCKER'
        , '011.44.1344.129268'
        , TO_DATE('30-01-1997', 'DD-MM-YYYY')
        , 'SA_REP'
        , 10000
        , .3
        , 145
        , 80
        );

INSERT INTO tb_employee 
VALUES 
        ( 151
        , 'David'
        , 'Bernstein'
        , 'DBERNSTE'
        , '011.44.1344.345268'
        , TO_DATE('24-03-1997', 'DD-MM-YYYY')
        , 'SA_REP'
        , 9500
        , .25
        , 145
        , 80
        );

INSERT INTO tb_employee 
VALUES 
        ( 152
        , 'Peter'
        , 'Hall'
        , 'PHALL'
        , '011.44.1344.478968'
        , TO_DATE('20-08-1997', 'DD-MM-YYYY')
        , 'SA_REP'
        , 9000
        , .25
        , 145
        , 80
        );

INSERT INTO tb_employee 
VALUES 
        ( 153
        , 'Christopher'
        , 'Olsen'
        , 'COLSEN'
        , '011.44.1344.498718'
        , TO_DATE('30-03-1998', 'DD-MM-YYYY')
        , 'SA_REP'
        , 8000
        , .2
        , 145
        , 80
        );

INSERT INTO tb_employee 
VALUES 
        ( 154
        , 'Nanette'
        , 'Cambrault'
        , 'NCAMBRAU'
        , '011.44.1344.987668'
        , TO_DATE('09-12-1998', 'DD-MM-YYYY')
        , 'SA_REP'
        , 7500
        , .2
        , 145
        , 80
        );

INSERT INTO tb_employee 
VALUES 
        ( 155
        , 'Oliver'
        , 'Tuvault'
        , 'OTUVAULT'
        , '011.44.1344.486508'
        , TO_DATE('23-11-1999', 'DD-MM-YYYY')
        , 'SA_REP'
        , 7000
        , .15
        , 145
        , 80
        );

INSERT INTO tb_employee 
VALUES 
        ( 156
        , 'Janette'
        , 'King'
        , 'JKING'
        , '011.44.1345.429268'
        , TO_DATE('30-01-1996', 'DD-MM-YYYY')
        , 'SA_REP'
        , 10000
        , .35
        , 146
        , 80
        );

INSERT INTO tb_employee 
VALUES 
        ( 157
        , 'Patrick'
        , 'Sully'
        , 'PSULLY'
        , '011.44.1345.929268'
        , TO_DATE('04-03-1996', 'DD-MM-YYYY')
        , 'SA_REP'
        , 9500
        , .35
        , 146
        , 80
        );

INSERT INTO tb_employee 
VALUES 
        ( 158
        , 'Allan'
        , 'McEwen'
        , 'AMCEWEN'
        , '011.44.1345.829268'
        , TO_DATE('01-08-1996', 'DD-MM-YYYY')
        , 'SA_REP'
        , 9000
        , .35
        , 146
        , 80
        );

INSERT INTO tb_employee 
VALUES 
        ( 159
        , 'Lindsey'
        , 'Smith'
        , 'LSMITH'
        , '011.44.1345.729268'
        , TO_DATE('10-03-1997', 'DD-MM-YYYY')
        , 'SA_REP'
        , 8000
        , .3
        , 146
        , 80
        );

INSERT INTO tb_employee 
VALUES 
        ( 160
        , 'Louise'
        , 'Doran'
        , 'LDORAN'
        , '011.44.1345.629268'
        , TO_DATE('15-12-1997', 'DD-MM-YYYY')
        , 'SA_REP'
        , 7500
        , .3
        , 146
        , 80
        );

INSERT INTO tb_employee 
VALUES 
        ( 161
        , 'Sarath'
        , 'Sewall'
        , 'SSEWALL'
        , '011.44.1345.529268'
        , TO_DATE('03-11-1998', 'DD-MM-YYYY')
        , 'SA_REP'
        , 7000
        , .25
        , 146
        , 80
        );

INSERT INTO tb_employee 
VALUES 
        ( 162
        , 'Clara'
        , 'Vishney'
        , 'CVISHNEY'
        , '011.44.1346.129268'
        , TO_DATE('11-11-1997', 'DD-MM-YYYY')
        , 'SA_REP'
        , 10500
        , .25
        , 147
        , 80
        );

INSERT INTO tb_employee 
VALUES 
        ( 163
        , 'Danielle'
        , 'Greene'
        , 'DGREENE'
        , '011.44.1346.229268'
        , TO_DATE('19-03-1999', 'DD-MM-YYYY')
        , 'SA_REP'
        , 9500
        , .15
        , 147
        , 80
        );

INSERT INTO tb_employee 
VALUES 
        ( 164
        , 'Mattea'
        , 'Marvins'
        , 'MMARVINS'
        , '011.44.1346.329268'
        , TO_DATE('24-01-2000', 'DD-MM-YYYY')
        , 'SA_REP'
        , 7200
        , .10
        , 147
        , 80
        );

INSERT INTO tb_employee 
VALUES 
        ( 165
        , 'David'
        , 'Lee'
        , 'DLEE'
        , '011.44.1346.529268'
        , TO_DATE('23-02-2000', 'DD-MM-YYYY')
        , 'SA_REP'
        , 6800
        , .1
        , 147
        , 80
        );

INSERT INTO tb_employee 
VALUES 
        ( 166
        , 'Sundar'
        , 'Ande'
        , 'SANDE'
        , '011.44.1346.629268'
        , TO_DATE('24-03-2000', 'DD-MM-YYYY')
        , 'SA_REP'
        , 6400
        , .10
        , 147
        , 80
        );

INSERT INTO tb_employee 
VALUES 
        ( 167
        , 'Amit'
        , 'Banda'
        , 'ABANDA'
        , '011.44.1346.729268'
        , TO_DATE('21-04-2000', 'DD-MM-YYYY')
        , 'SA_REP'
        , 6200
        , .10
        , 147
        , 80
        );

INSERT INTO tb_employee 
VALUES 
        ( 168
        , 'Lisa'
        , 'Ozer'
        , 'LOZER'
        , '011.44.1343.929268'
        , TO_DATE('11-03-1997', 'DD-MM-YYYY')
        , 'SA_REP'
        , 11500
        , .25
        , 148
        , 80
        );

INSERT INTO tb_employee 
VALUES 
        ( 169  
        , 'Harrison'
        , 'Bloom'
        , 'HBLOOM'
        , '011.44.1343.829268'
        , TO_DATE('23-03-1998', 'DD-MM-YYYY')
        , 'SA_REP'
        , 10000
        , .20
        , 148
        , 80
        );

INSERT INTO tb_employee 
VALUES 
        ( 170
        , 'Tayler'
        , 'Fox'
        , 'TFOX'
        , '011.44.1343.729268'
        , TO_DATE('24-01-1998', 'DD-MM-YYYY')
        , 'SA_REP'
        , 9600
        , .20
        , 148
        , 80
        );

INSERT INTO tb_employee 
VALUES 
        ( 171
        , 'William'
        , 'Smith'
        , 'WSMITH'
        , '011.44.1343.629268'
        , TO_DATE('23-02-1999', 'DD-MM-YYYY')
        , 'SA_REP'
        , 7400
        , .15
        , 148
        , 80
        );

INSERT INTO tb_employee 
VALUES 
        ( 172
        , 'Elizabeth'
        , 'Bates'
        , 'EBATES'
        , '011.44.1343.529268'
        , TO_DATE('24-03-1999', 'DD-MM-YYYY')
        , 'SA_REP'
        , 7300
        , .15
        , 148
        , 80
        );

INSERT INTO tb_employee 
VALUES 
        ( 173
        , 'Sundita'
        , 'Kumar'
        , 'SKUMAR'
        , '011.44.1343.329268'
        , TO_DATE('21-04-2000', 'DD-MM-YYYY')
        , 'SA_REP'
        , 6100
        , .10
        , 148
        , 80
        );

INSERT INTO tb_employee 
VALUES 
        ( 174
        , 'Ellen'
        , 'Abel'
        , 'EABEL'
        , '011.44.1644.429267'
        , TO_DATE('11-05-1996', 'DD-MM-YYYY')
        , 'SA_REP'
        , 11000
        , .30
        , 149
        , 80
        );

INSERT INTO tb_employee 
VALUES 
        ( 175
        , 'Alyssa'
        , 'Hutton'
        , 'AHUTTON'
        , '011.44.1644.429266'
        , TO_DATE('19-03-1997', 'DD-MM-YYYY')
        , 'SA_REP'
        , 8800
        , .25
        , 149
        , 80
        );

INSERT INTO tb_employee 
VALUES 
        ( 176
        , 'Jonathon'
        , 'Taylor'
        , 'JTAYLOR'
        , '011.44.1644.429265'
        , TO_DATE('24-03-1998', 'DD-MM-YYYY')
        , 'SA_REP'
        , 8600
        , .20
        , 149
        , 80
        );

INSERT INTO tb_employee 
VALUES 
        ( 177
        , 'Jack'
        , 'Livingston'
        , 'JLIVINGS'
        , '011.44.1644.429264'
        , TO_DATE('23-04-1998', 'DD-MM-YYYY')
        , 'SA_REP'
        , 8400
        , .20
        , 149
        , 80
        );

INSERT INTO tb_employee 
VALUES 
        ( 178
        , 'Kimberely'
        , 'Grant'
        , 'KGRANT'
        , '011.44.1644.429263'
        , TO_DATE('24-05-1999', 'DD-MM-YYYY')
        , 'SA_REP'
        , 7000
        , .15
        , 149
        , NULL
        );

INSERT INTO tb_employee 
VALUES 
        ( 179
        , 'Charles'
        , 'Johnson'
        , 'CJOHNSON'
        , '011.44.1644.429262'
        , TO_DATE('04-01-2000', 'DD-MM-YYYY')
        , 'SA_REP'
        , 6200
        , .10
        , 149
        , 80
        );

INSERT INTO tb_employee 
VALUES 
        ( 180
        , 'Winston'
        , 'Taylor'
        , 'WTAYLOR'
        , '650.507.9876'
        , TO_DATE('24-01-1998', 'DD-MM-YYYY')
        , 'SH_CLERK'
        , 3200
        , NULL
        , 120
        , 50
        );

INSERT INTO tb_employee 
VALUES 
        ( 181
        , 'Jean'
        , 'Fleaur'
        , 'JFLEAUR'
        , '650.507.9877'
        , TO_DATE('23-02-1998', 'DD-MM-YYYY')
        , 'SH_CLERK'
        , 3100
        , NULL
        , 120
        , 50
        );

INSERT INTO tb_employee VALUES 
        ( 182
        , 'Martha'
        , 'Sullivan'
        , 'MSULLIVA'
        , '650.507.9878'
        , TO_DATE('21-06-1999', 'DD-MM-YYYY')
        , 'SH_CLERK'
        , 2500
        , NULL
        , 120
        , 50
        );

INSERT INTO tb_employee 
VALUES 
        ( 183
        , 'Girard'
        , 'Geoni'
        , 'GGEONI'
        , '650.507.9879'
        , TO_DATE('03-02-2000', 'DD-MM-YYYY')
        , 'SH_CLERK'
        , 2800
        , NULL
        , 120
        , 50
        );

INSERT INTO tb_employee 
VALUES 
        ( 184
        , 'Nandita'
        , 'Sarchand'
        , 'NSARCHAN'
        , '650.509.1876'
        , TO_DATE('27-01-1996', 'DD-MM-YYYY')
        , 'SH_CLERK'
        , 4200
        , NULL
        , 121
        , 50
        );

INSERT INTO tb_employee 
VALUES 
        ( 185
        , 'Alexis'
        , 'Bull'
        , 'ABULL'
        , '650.509.2876'
        , TO_DATE('20-02-1997', 'DD-MM-YYYY')
        , 'SH_CLERK'
        , 4100
        , NULL
        , 121
        , 50
        );

INSERT INTO tb_employee 
VALUES 
        ( 186
        , 'Julia'
        , 'Dellinger'
        , 'JDELLING'
        , '650.509.3876'
        , TO_DATE('24-06-1998', 'DD-MM-YYYY')
        , 'SH_CLERK'
        , 3400
        , NULL
        , 121
        , 50
        );

INSERT INTO tb_employee 
VALUES 
        ( 187
        , 'Anthony'
        , 'Cabrio'
        , 'ACABRIO'
        , '650.509.4876'
        , TO_DATE('07-02-1999', 'DD-MM-YYYY')
        , 'SH_CLERK'
        , 3000
        , NULL
        , 121
        , 50
        );

INSERT INTO tb_employee 
VALUES 
        ( 188
        , 'Kelly'
        , 'Chung'
        , 'KCHUNG'
        , '650.505.1876'
        , TO_DATE('14-06-1997', 'DD-MM-YYYY')
        , 'SH_CLERK'
        , 3800
        , NULL
        , 122
        , 50
        );

INSERT INTO tb_employee 
VALUES 
        ( 189
        , 'Jennifer'
        , 'Dilly'
        , 'JDILLY'
        , '650.505.2876'
        , TO_DATE('13-08-1997', 'DD-MM-YYYY')
        , 'SH_CLERK'
        , 3600
        , NULL
        , 122
        , 50
        );

INSERT INTO tb_employee 
VALUES 
        ( 190
        , 'Timothy'
        , 'Gates'
        , 'TGATES'
        , '650.505.3876'
        , TO_DATE('11-07-1998', 'DD-MM-YYYY')
        , 'SH_CLERK'
        , 2900
        , NULL
        , 122
        , 50
        );

INSERT INTO tb_employee 
VALUES 
        ( 191
        , 'Randall'
        , 'Perkins'
        , 'RPERKINS'
        , '650.505.4876'
        , TO_DATE('19-12-1999', 'DD-MM-YYYY')
        , 'SH_CLERK'
        , 2500
        , NULL
        , 122
        , 50
        );

INSERT INTO tb_employee 
VALUES 
        ( 192
        , 'Sarah'
        , 'Bell'
        , 'SBELL'
        , '650.501.1876'
        , TO_DATE('04-02-1996', 'DD-MM-YYYY')
        , 'SH_CLERK'
        , 4000
        , NULL
        , 123
        , 50
        );

INSERT INTO tb_employee 
VALUES 
        ( 193
        , 'Britney'
        , 'Everett'
        , 'BEVERETT'
        , '650.501.2876'
        , TO_DATE('03-03-1997', 'DD-MM-YYYY')
        , 'SH_CLERK'
        , 3900
        , NULL
        , 123
        , 50
        );

INSERT INTO tb_employee 
VALUES 
        ( 194
        , 'Samuel'
        , 'McCain'
        , 'SMCCAIN'
        , '650.501.3876'
        , TO_DATE('01-07-1998', 'DD-MM-YYYY')
        , 'SH_CLERK'
        , 3200
        , NULL
        , 123
        , 50
        );

INSERT INTO tb_employee 
VALUES 
        ( 195
        , 'Vance'
        , 'Jones'
        , 'VJONES'
        , '650.501.4876'
        , TO_DATE('17-03-1999', 'DD-MM-YYYY')
        , 'SH_CLERK'
        , 2800
        , NULL
        , 123
        , 50
        );

INSERT INTO tb_employee 
VALUES 
        ( 196
        , 'Alana'
        , 'Walsh'
        , 'AWALSH'
        , '650.507.9811'
        , TO_DATE('24-04-1998', 'DD-MM-YYYY')
        , 'SH_CLERK'
        , 3100
        , NULL
        , 124
        , 50
        );

INSERT INTO tb_employee 
VALUES 
        ( 197
        , 'Kevin'
        , 'Feeney'
        , 'KFEENEY'
        , '650.507.9822'
        , TO_DATE('23-05-1998', 'DD-MM-YYYY')
        , 'SH_CLERK'
        , 3000
        , NULL
        , 124
        , 50
        );

INSERT INTO tb_employee 
VALUES 
        ( 198
        , 'Donald'
        , 'OConnell'
        , 'DOCONNEL'
        , '650.507.9833'
        , TO_DATE('21-06-1999', 'DD-MM-YYYY')
        , 'SH_CLERK'
        , 2600
        , NULL
        , 124
        , 50
        );

INSERT INTO tb_employee 
VALUES 
        ( 199
        , 'Douglas'
        , 'Grant'
        , 'DGRANT'
        , '650.507.9844'
        , TO_DATE('13-01-2000', 'DD-MM-YYYY')
        , 'SH_CLERK'
        , 2600
        , NULL
        , 124
        , 50
        );

INSERT INTO tb_employee 
VALUES 
        ( 200
        , 'Jennifer'
        , 'Whalen'
        , 'JWHALEN'
        , '515.123.4444'
        , TO_DATE('17-09-1987', 'DD-MM-YYYY')
        , 'AD_ASST'
        , 4400
        , NULL
        , 101
        , 10
        );

INSERT INTO tb_employee 
VALUES 
        ( 201
        , 'Michael'
        , 'Hartstein'
        , 'MHARTSTE'
        , '515.123.5555'
        , TO_DATE('17-02-1996', 'DD-MM-YYYY')
        , 'MK_MAN'
        , 13000
        , NULL
        , 100
        , 20
        );

INSERT INTO tb_employee 
VALUES 
        ( 202
        , 'Pat'
        , 'Fay'
        , 'PFAY'
        , '603.123.6666'
        , TO_DATE('17-08-1997', 'DD-MM-YYYY')
        , 'MK_REP'
        , 6000
        , NULL
        , 201
        , 20
        );

INSERT INTO tb_employee 
VALUES 
        ( 203
        , 'Susan'
        , 'Mavris'
        , 'SMAVRIS'
        , '515.123.7777'
        , TO_DATE('07-06-1994', 'DD-MM-YYYY')
        , 'HR_REP'
        , 6500
        , NULL
        , 101
        , 40
        );

INSERT INTO tb_employee 
VALUES 
        ( 204
        , 'Hermann'
        , 'Baer'
        , 'HBAER'
        , '515.123.8888'
        , TO_DATE('07-06-1994', 'DD-MM-YYYY')
        , 'HR_REP'
        , 10000
        , NULL
        , 101
        , 70
        );

INSERT INTO tb_employee 
VALUES 
        ( 205
        , 'Shelley'
        , 'Higgins'
        , 'SHIGGINS'
        , '515.123.8080'
        , TO_DATE('07-06-1994', 'DD-MM-YYYY')
        , 'AC_MGR'
        , 12000
        , NULL
        , 101
        , 110
        );

INSERT INTO tb_employee 
VALUES 
        ( 206
        , 'William'
        , 'Gietz'
        , 'WGIETZ'
        , '515.123.8181'
        , TO_DATE('07-06-1994', 'DD-MM-YYYY')
        , 'AC_ACCOUNT'
        , 8300
        , NULL
        , 205
        , 110
        );



---------------------------------
-- Inserting data table "tb_job_history"
INSERT INTO tb_job_history
VALUES (102
       , TO_DATE('13-01-1993', 'DD-MM-YYYY')
       , TO_DATE('24-07-1998', 'DD-MM-YYYY')
       , 'IT_PROG'
       , 60);

INSERT INTO tb_job_history
VALUES (101
       , TO_DATE('21-09-1989', 'DD-MM-YYYY')
       , TO_DATE('27-10-1993', 'DD-MM-YYYY')
       , 'AC_ACCOUNT'
       , 110);

INSERT INTO tb_job_history
VALUES (101
       , TO_DATE('28-10-1993', 'DD-MM-YYYY')
       , TO_DATE('15-03-1997', 'DD-MM-YYYY')
       , 'AC_MGR'
       , 110);

INSERT INTO tb_job_history
VALUES (201
       , TO_DATE('17-02-1996', 'DD-MM-YYYY')
       , TO_DATE('19-12-1999', 'DD-MM-YYYY')
       , 'MK_REP'
       , 20);

INSERT INTO tb_job_history
VALUES  (114
        , TO_DATE('24-03-1998', 'DD-MM-YYYY')
        , TO_DATE('31-12-1999', 'DD-MM-YYYY')
        , 'ST_CLERK'
        , 50
        );

INSERT INTO tb_job_history
VALUES  (122
        , TO_DATE('01-01-1999', 'DD-MM-YYYY')
        , TO_DATE('31-12-1999', 'DD-MM-YYYY')
        , 'ST_CLERK'
        , 50
        );

INSERT INTO tb_job_history
VALUES  (200
        , TO_DATE('17-09-1987', 'DD-MM-YYYY')
        , TO_DATE('17-06-1993', 'DD-MM-YYYY')
        , 'AD_ASST'
        , 90
        );

INSERT INTO tb_job_history
VALUES  (176
        , TO_DATE('24-03-1998', 'DD-MM-YYYY')
        , TO_DATE('31-12-1998', 'DD-MM-YYYY')
        , 'SA_REP'
        , 80
        );

INSERT INTO tb_job_history
VALUES  (176
        , TO_DATE('01-01-1999', 'DD-MM-YYYY')
        , TO_DATE('31-12-1999', 'DD-MM-YYYY')
        , 'SA_MAN'
        , 80
        );

INSERT INTO tb_job_history
VALUES  (200
        , TO_DATE('01-07-1994', 'DD-MM-YYYY')
        , TO_DATE('31-12-1998', 'DD-MM-YYYY')
        , 'AC_ACCOUNT'
        , 90
        );


-- Enabling integrity constraint para a table tb_department

ALTER TABLE tb_department 
  ENABLE CONSTRAINT fk_manager_dept;

COMMIT;