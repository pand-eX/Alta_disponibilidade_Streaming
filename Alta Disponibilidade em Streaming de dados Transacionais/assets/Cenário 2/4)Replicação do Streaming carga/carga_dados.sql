 CREATE TABLE ggtest.TB_EMP
 (EMPNO INT,
  ENAME VARCHAR(10),
  JOB VARCHAR(9),
  MGR INT,
  HIREDATE DATE,
  SAL DECIMAL(7,2),
  COMM DECIMAL(7,2),
  DEPTNO INT,
  LAST_UPDT_DT_TM TIMESTAMP DEFAULT current_timestamp);

grant unlimited tablespace to ggtest;

Execute estes comandos para inserir alguns registros na tabela:

INSERT INTO ggtest.TB_EMP VALUES (1000, 'Pele', 'Analista', NULL, NULL, 80000, 250, 90, sysdate);
INSERT INTO ggtest.TB_EMP VALUES (1001, 'Zico', 'Contador', NULL, NULL, 76000, 340, 100, sysdate);
INSERT INTO ggtest.TB_EMP VALUES (1002, 'Messi', 'Advogado', NULL, NULL, 98000, 560, 120, sysdate);

