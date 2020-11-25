--------------------------------------------------------------------------------
/*
    VIEW
    SELECT ������ ���� ����� ȭ�鿡 ������ ���� ���� ���̺�
    ���� ���̺���� �ٸ��� ���������� �����͸� �����ϰ� ���� ������ 
    ����ڴ� ���̺��� ����ϴ� �Ͱ� �����ϰ� ��� ����
    
    ǥ���� : CREATE [OR REPLACE] VIEW ���̸� AS SELECT��
*/
--------------------------------------------------------------------------------
--���� ������ ���� Ȯ��
SELECT * FROM SESSION_PRIVS;
    --RESOURCE ROLE���� CREATE VIEW�� ���� ������ ���ԵǾ� ���� ����
    --VIEW�� �����ϱ� ���ؼ��� ������ ������ �߰��������
--KH������ VIEW�� ������ �� �ִ� CREATE VIEW ���� �߰� (������ �������� �����ؾ���!!!!)
GRANT CREATE VIEW TO KH;

--�ٽ� KH �������� ���ƿͼ� ����
SELECT * FROM SESSION_PRIVS;

--�������̺��� ���, �̸�, �μ��� ������ VIEW�� ����
    --���, �̸�, �μ� ��ȸ
SELECT EMP_ID, EMP_NAME, DEPT_CODE FROM EMPLOYEE;
    --VIEW ����
CREATE VIEW V_EMP AS SELECT EMP_ID, EMP_NAME, DEPT_CODE FROM EMPLOYEE;

--���� ������ �信 ���� ������ Ȯ���ϴ� ������ ����
SELECT * FROM USER_VIEWS;

--�� ���
--�Ϲ� ���̺�� �����ϰ� ���
    --���� Ȯ��
DESC V_EMP;
    --�� ������ ��ȸ
SELECT * FROM V_EMP;

--���� ���̺��� �̿��� VIEW�� ����
--������ ���, �̸�, �μ���, �ٹ������� �� VIEW ����
CREATE VIEW V_EMPLOYEE  AS 
    SELECT EMP_ID, EMP_NAME, DEPT_TITLE, LOCAL_NAME FROM EMPLOYEE 
        LEFT JOIN DEPARTMENT ON (DEPT_CODE=DEPT_ID)
        LEFT JOIN LOCATION ON (LOCATION_ID=LOCAL_CODE);
SELECT * FROM USER_VIEWS;
SELECT * FROM V_EMPLOYEE;

--���� �۾����� �Ϸ�
COMMIT;

--VIEW�� ���̽��� �Ǵ� ���̺��� ������ ����Ǹ� VIEW�� ������ ���� ����
UPDATE EMPLOYEE SET EMP_NAME = '���߱�' WHERE EMP_ID=201;
SELECT * FROM EMPLOYEE WHERE EMP_ID=201;
SELECT * FROM V_EMPLOYEE WHERE EMP_ID=201; --���߱�� �����

ROLLBACK;

--�� ����
    --DROP VIEW <�� �̸�>;
DROP VIEW V_EMPLOYEE;
SELECT * FROM USER_VIEWS;

--���� �÷��� ��Ī �ο�
CREATE VIEW V_EMPLOYEE AS
SELECT EMP_ID ���, EMP_NAME �̸�, DEPT_TITLE �μ�, NATIONAL_NAME ���� FROM EMPLOYEE
    LEFT JOIN DEPARTMENT ON (DEPT_CODE=DEPT_ID)
    LEFT JOIN LOCATION ON (LOCATION_ID = LOCAL_CODE)
    LEFT JOIN NATIONAL USING (NATIONAL_CODE);
    
SELECT * FROM V_EMPLOYEE;
DROP VIEW V_EMPLOYEE;
    --���2 : ��� �÷��� ��Ī�� �ο����־�� ��
CREATE VIEW V_EMPLOYEE(���, �̸�, �μ�, ����) AS
SELECT EMP_ID, EMP_NAME, DEPT_TITLE, NATIONAL_NAME FROM EMPLOYEE
    LEFT JOIN DEPARTMENT ON (DEPT_CODE=DEPT_ID)
    LEFT JOIN LOCATION ON (LOCATION_ID = LOCAL_CODE)
    LEFT JOIN NATIONAL USING (NATIONAL_CODE);
SELECT * FROM V_EMPLOYEE;

--VIEW SELECT��(��������) �ȿ� ������ ����� ������ �� ����
CREATE VIEW V_EMP_JOB(���, �̸�, ����, ����, �ٹ����) AS
SELECT EMP_ID, EMP_NAME, JOB_NAME, DECODE(SUBSTR(EMP_NO,8,1),1,'��',2,'��'),
    EXTRACT(YEAR FROM SYSDATE)-EXTRACT(YEAR FROM HIRE_DATE) FROM EMPLOYEE
    JOIN JOB USING(JOB_CODE);
SELECT* FROM V_EMP_JOB;

--������ ���� ������ ����
    --������ �信�� DML����(INSERT, UPDATE, DELETE, SELECT) ��� ����
--�� ����
CREATE VIEW V_JOB AS SELECT JOB_CODE, JOB_NAME FROM JOB;
SELECT * FROM JOB;
SELECT * FROM V_JOB;

--�信 ������ ����
    --�並 ���� ���� ���̺� ������ ����
INSERT INTO V_JOB VALUES('J8', '����');
SELECT * FROM V_JOB; --�信 ���� ���Ե�
SELECT * FROM JOB;  --���� ���̺��� �����Ͱ� ���� ���Ե�

--�� ������ ����
    --�並 ���� ���� ���̺� �����͸� ����
UPDATE V_JOB SET JOB_NAME = '�˹�' WHERE JOB_CODE='J8';
SELECT * FROM V_JOB;    --���� �����
SELECT * FROM JOB; --���� ���̺��� �����Ͱ� ���� �����

--�� ������ ����
    --�並 ���� ���� ���̺��� �����͸� ����
DELETE FROM V_JOB WHERE JOB_CODE = 'J8';
SELECT * FROM V_JOB;
SELECT * FROM JOB;


/*
    DML��ɾ�� VIEW ������ �Ұ����� ���
    1. �� ���ǿ� ���Ե��� ���� �÷��� �����ϴ� ���
    2. �信 ���Ե��� ���� �÷� �߿� ���̽��� �Ǵ� �÷��� NOT NULL ���������� ������ ���
    3. ��� ǥ�������� ���ǵ� ���
    4. �׷��Լ��� GROUP BY���� ������ ���
    5. DISTINCT�� ������ ���
    6. JOIN�� �̿��� ���� ���̺��� ������ ���
*/
--�� ���ǿ� ���Ե��� ���� �÷��� �����ϴ� ���
    --SELECT, INSERT, UPDATE ���ۺҰ�, DELETE�� ���۰���
CREATE VIEW V_JOB2 AS SELECT JOB_CODE FROM JOB;
SELECT * FROM V_JOB2;
--������ ����
INSERT INTO V_JOB2 VALUES('J8','����'); --����
INSERT INTO V_JOB2 VALUES('J8');    --���� ����
SELECT * FROM V_JOB2;
SELECT * FROM JOB; --�信 ���ǵ��� ���� �÷��� NULL �� ���Ե�
--������ ����
UPDATE V_JOB2 SET JOB_NAME='����' WHERE JOB_CODE='J7'; --����
--������ ����
    --���ǵ��� ���� �÷��� �ִ��� ������ ������
DELETE FROM V_JOB2 WHERE JOB_CODE='J7'; --���� ����
SELECT * FROM JOB;
--������ ��ȸ
    --JOB_NAME�� ���ǵ��� �ʾƼ� ��ȸ �Ұ���
SELECT JOB_NAME, JOB_CODE FROM V_JOB2;

ROLLBACK;

--�信 ���Ե��� ���� �÷� �߿� ���̽��� �Ǵ� �÷��� NOT NULL ���������� ������ ���
CREATE VIEW V_JOB3 AS SELECT JOB_NAME FROM JOB;
SELECT * FROM V_JOB3;
--������ ����
INSERT INTO V_JOB VALUES('����'); --����
DESC JOB; --�������̺��� JOB���̺��� JOB_CODE�� NOT NULL ���������� �����Ǿ� ����
--������ ����
UPDATE V_JOB3 SET JOB_NAME='����' WHERE JOB_NAME='���'; --����
SELECT * FROM JOB;
--������ ����
DELETE FROM V_JOB3 WHERE JOB_NAME = '����'; --����
SELECT * FROM JOB;

ROLLBACK;

--��� ǥ�������� ���ǵ� ���
CREATE VIEW EMP_SAL AS 
    SELECT EMP_ID, EMP_NAME, SALARY, (SALARY+(SALARY*NVL(BONUS,0)))*12 ����
    FROM EMPLOYEE;
SELECT * FROM EMP_SAL;
--������ ����
    --������ ���� �������̺� ����� �÷��� ����
INSERT INTO EMP_SAL VALUES(800, '������', 3000000, 4000000); --����
--������ ����
UPDATE EMP_SAL SET ���� = 8000000 WHERE EMP_ID=200; --����
--������ ����
DELETE FROM EMP_SAL WHERE ���� = 72000000; --����
    --������ ������
SELECT * FROM EMP_SAL;
SELECT*FROM EMPLOYEE;

ROLLBACK;

--JOIN�� �̿��� ���� ���̺��� ������ ���
CREATE VIEW V_JOINEMP AS
    SELECT EMP_ID, EMP_NAME, DEPT_TITLE FROM EMPLOYEE
        JOIN DEPARTMENT ON (DEPT_CODE=DEPT_ID);
SELECT * FROM V_JOINEMP;
--������ ����
INSERT INTO V_JOINEMP VALUES (888,'������','�λ������'); --����
--������ ����
UPDATE V_JOINEMP SET DEPT_TITLE = '�λ������' WHERE EMP_ID=200; --����
UPDATE V_JOINEMP SET EMP_NAME = '������' WHERE EMP_ID=200; --����
UPDATE V_JOINEMP SET EMP_NAME = '������' WHERE DEPT_TITLE = '�ѹ���'; --����
SELECT * FROM V_JOINEMP;
--������ ����
DELETE FROM V_JOINEMP WHERE EMP_ID=200; --����
SELECT * FROM V_JOINEMP;    --���� ��
SELECT * FROM EMPLOYEE;     --���� ��
SELECT * FROM DEPARTMENT;   --���� �� ��

ROLLBACK;

--DISTINCT�� ������ ���
    --DISTINCTF�� ����� ��� INSERT/UPDATE/DELETE �� ���� �߻�
CREATE VIEW V_DTEMP AS SELECT DISTINCT JOB_CODE FROM EMPLOYEE;
SELECT * FROM V_DTEMP;
--������ ����
INSERT INTO V_DTEMP VALUES ('J9'); --����
--������ ����
UPDATE V_DTEMP SET JOB_CODE='J9' WHERE JOB_CODE = 'J7'; --����
--������ ����
DELETE FROM V_DTEMP WHERE JOB_CODE='J1'; --����

ROLLBACK;

--�׷��Լ��� GROUP BY���� ������ ���
    --INSERT/UPDATE/DELETE �� ��� ���� �߻�
CREATE VIEW V_GROUPDEPT AS
    SELECT DEPT_CODE, SUM(SALARY) �հ�, AVG(SALARY) ��� FROM EMPLOYEE
    GROUP BY DEPT_CODE;
SELECT * FROM V_GROUPDEPT;
--������ ����
INSERT INTO V_GROUPDEPT VALUES ('D10', 6000000, 4000000); --����
--������ ����
UPDATE V_GROUPDEPT SET DEPT_CODE = 'D10' WHERE DEPT_CODE = 'D1'; --����
--������ ����
DELETE FROM V_GROUPDEPT WHERE DEPT_CODE = 'D1'; --����


/* VIEW �ɼ� */
--OR REPLACE : ������ ������ �� �̸��� �����ϴ� ��� �����, �������� ������ ���� ����
    --VIEW ����
CREATE VIEW V_OPT1 AS SELECT EMP_ID, EMP_NAME FROM EMPLOYEE;
SELECT * FROM V_OPT1;
    --������ �̸����� VIEW �����ϸ� ���� �߻�
CREATE VIEW V_OPT1 AS SELECT EMP_ID, EMP_NAME, PHONE, EMAIL FROM EMPLOYEE;
SELECT * FROM V_OPT1;
    --OR REPLACE �ɼ� ���� ����
CREATE OR REPLACE VIEW V_OPT1 AS SELECT EMP_ID, EMP_NAME, PHONE, EMAIL FROM EMPLOYEE;
SELECT * FROM V_OPT1;

--NOFORCE �ɼ� : ������������ ���� ���̺��� �����ؾ߸� �� ������(�⺻��)
CREATE OR REPLACE /*NOFORCE*/ VIEW V_OPT2 AS SELECT TCODE, TNAME, TCONNECT FROM TT;

--FORCE �ɼ� : ������������ ���� ���̺��� �������� �ʾƵ� �� ������
    --������ ���Ǹ� �� ����. �̿ϼ� ��. DML ��� �� ��
CREATE OR REPLACE FORCE VIEW V_OPT2 AS SELECT TCODE, TNAME, TCONNECT FROM TT;
SELECT * FROM USER_VIEWS;
SELECT * FROM V_OPT2; --TT���̺� ���� �� ��ȸ ���� / ���� ���� ����
    --TT���̺� ����
CREATE TABLE TT(
    TCODE NUMBER,
    TNAME VARCHAR2(20),
    TCONNECT VARCHAR2(50),
    TSUBJECT VARCHAR2 (30)
    );

--WITH CHECK OPTION : �ɼ��� ������ �÷��� ���� �������� �� �ϰ� ��
    --WHERE���� WITH CHECK OPTION�� ���
    --����(WHERE��)�� ���Ǿ��� �÷��� ���ǿ� ����Ǹ� INSERT/UPDATE �Ұ�
CREATE OR REPLACE VIEW V_OPT3 AS SELECT * FROM JOB WHERE JOB_CODE='J4' WITH CHECK OPTION;
SELECT * FROM V_OPT3;
SELECT * FROM JOB;
--������ ����
INSERT INTO V_OPT3 VALUES ('J8', '����'); --����
--������ ����
UPDATE V_OPT2 SET JOB_CODE='J8' WHERE JOB_CODE='J4'; --����
--������ ����
DELETE FROM V_OPT3; --����
SELECT * FROM JOB;

ROLLBACK;

--WITH READ ONLY �ɼ� : DML(INSERT/UPDATE/DELETE) ���� �Ұ���
CREATE OR REPLACE VIEW V_OPT4 AS SELECT * FROM DEPARTMENT WITH READ ONLY;
SELECT * FROM V_OPT4;
--������ ����
INSERT INTO V_OPT4 VALUES ('D10','�����','L1'); --����
--������ ����
UPDATE V_OPT4 SET LOCATION_ID='L5' WHERE DEPT_ID='D1'; --����;
--������ ����
DELETE FROM V_OPT4; --����