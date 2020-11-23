--------------------------------------------------------------------------------
/*
    INSERT
    ���̺� ���ο� ���� �߰��Ͽ� ���̺��� �� ������ ������Ű�� ����
    ���̺� �����͸� ����(�߰�)
    
    - ���̺��� ��� �÷��� ���� ���� INSERT �� �� ���
    INSERT INTO <���̺��> VALUES(������1, ������2, ...);
        ���̺��� �÷��� ��������ִ� ������� �����͸� �Է��� �����
    - ���̺��� Ư�� �÷��� ���� ���� INSERT �� �� ���
    INSERT INTO <���̺��(�÷���1, �÷���2, ...)> VALUES(������1, ������2, ...);
        ���̺�� �ڿ� ������ �÷��� ������� �����͸� �Է��� �����
*/
--------------------------------------------------------------------------------
DESC EMPLOYEE;
SELECT * FROM EMPLOYEE;

--��� �÷��� ������ �Է�
INSERT INTO EMPLOYEE VALUES('900', '��ä��', '901123-1080503', 'jang_ch@kh.or.kr',
    '01055569512','D1','J7','S3',4300000,0.2,'200',SYSDATE,NULL,DEFAULT);
    
--Ư�� �÷��� ������ �Է�
INSERT INTO EMPLOYEE (EMP_ID, EMP_NAME, EMP_NO, JOB_CODE, SAL_LEVEL) 
    VALUES('901','ȫ�浿','981205-1587456','J5','S1');
    
--���������� �̿��� ������ ����
    --VALUES�� ���� ���� �Է��ϴ� ��� �ٸ� ���̺��� ��ȸ�� �����͸� ����
--���̺� ����
CREATE TABLE EMP_01(
    EMP_ID NUMBER,
    EMP_NAME VARCHAR2(30),
    DEPT_TITLE VARCHAR2(20)
);
SELECT * FROM EMP_01;
--EMPLOYEE ���̺��� ��ȸ�� �����͸� EMP_01 ���̺� ����
    --EMPLOYEE ���̺��� DEPT_CODE�� NULL �� ���� �����ϱ� ���� LEFT OUTER JOIN ���
SELECT EMP_ID, EMP_NAME, DEPT_TITLE FROM EMPLOYEE LEFT JOIN DEPARTMENT ON (DEPT_CODE=DEPT_ID);
INSERT INTO EMP_01(
    SELECT EMP_ID, EMP_NAME, DEPT_TITLE FROM EMPLOYEE
        LEFT JOIN DEPARTMENT ON (DEPT_CODE=DEPT_ID)
);


--------------------------------------------------------------------------------
/*
    INSERT ALL
    - INSERT �� ���Ǵ� ���������� ���̺��� ���� ���, 
        �ΰ� �̻��� ���̺� INSERT ALL�� �̿��Ͽ� �� ���� ����
*/
--------------------------------------------------------------------------------
--���̺� ������ ��ȸ�Ǵ� �ٸ� ���̺��� �÷�(�÷� ��, ������Ÿ��)�� �״�� �������� ���
    --�����;��� ��ȸ
SELECT EMP_ID, EMP_NAME, DEPT_CODE, HIRE_DATE FROM EMPLOYEE WHERE 1=0;
    --���̺� ���� �� �÷� ���� �����ͱ��� ��� ������
CREATE TABLE EMP_DEPT_01 AS SELECT EMP_ID, EMP_NAME, DEPT_CODE, HIRE_DATE
    FROM EMPLOYEE;
    --������ ���� �� ������ �����ؼ� ������ (������X) : 1=0
CREATE TABLE EMP_DEPT_01 AS SELECT EMP_ID, EMP_NAME, DEPT_CODE, HIRE_DATE
    FROM EMPLOYEE WHERE 1=0;
SELECT * FROM EMP_DEPT_01;

CREATE TABLE EMP_MANAGE AS SELECT EMP_ID, EMP_NAME, MANAGER_ID
    FROM EMPLOYEE WHERE 1=0;
SELECT * FROM EMP_MANAGE;

--EMP_DEPT_01 �׾ƺ� EMPLOYEE �׾ƺ� �ִ� �μ��ڵ尡 D1�� ������ ��ȸ�ؼ� ����
    --(���, �̸�, �μ��ڵ�, �Ի���)
--EMP_MANAGE ���̺� EMPLOYEE ���̺� �ִ� �μ��ڵ尡 D1�� ������ ��ȭ�ؼ� ����
    --(���, �̸�, �����ڻ��)
--���� ��Ĵ�� �Է�
INSERT INTO EMP_DEPT_01(
    SELECT EMP_ID, EMP_NAME, DEPT_CODE, HIRE_DATE FROM EMPLOYEE
        WHERE DEPT_CODE='D1'
);
INSERT INTO EMP_MANAGE(
    SELECT EMP_ID, EMP_NAME, MANAGER_ID
    FROM EMPLOYEE WHERE DEPT_CODE = 'D1'
);
    --�Ϻ� �÷����� ���� ���� ��
INSERT INTO EMP_DEPT_01(EMP_ID,EMP_NAME)(
    SELECT EMP_ID, EMP_NAME, DEPT_CODE, HIRE_DATE FROM EMPLOYEE
        WHERE DEPT_CODE='D1'
);
SELECT * FROM EMP_DEPT_01;
SELECT * FROM EMP_MANAGE;
DELETE FROM EMP_DEPT_01;
DELETE FROM EMP_MANAGE;
--INSERT ALL ���
INSERT ALL INTO EMP_DEPT_01 VALUES(EMP_ID, EMP_NAME, DEPT_CODE, HIRE_DATE)
            INTO EMP_MANAGE VALUES(EMP_ID, EMP_NAME, MANAGER_ID)
    SELECT EMP_ID, EMP_NAME, DEPT_CODE, HIRE_DATE, MANAGER_ID FROM EMPLOYEE
        WHERE DEPT_CODE='D1';

--���� ���̺��� ������ �ٸ��� �ؼ� ��ȸ�� �����͸� ������ �ٸ� ���̺� ����
--EMPLOYEE ���̺��� �Ի��� �������� 2010�� 1�� 1�� ���� �Ի��� �����
    --���, �̸�, �Ի���, �޿��� ��ȸ�ؼ� EMP_OLD ���̺� ����
    --�� ���� �Ի��� ����� ������ EMP_NEW ���̺� ����
--���̺� ����
CREATE TABLE EMP_OLD AS 
    SELECT EMP_ID, EMP_NAME, HIRE_DATE, SALARY FROM EMPLOYEE WHERE 1=0;
CREATE TABLE EMP_NEW AS 
    SELECT EMP_ID, EMP_NAME, HIRE_DATE, SALARY FROM EMPLOYEE WHERE 1=0;
SELECT * FROM EMP_OLD;
SELECT * FROM EMP_NEW;
--������ ����
INSERT ALL WHEN HIRE_DATE <'2010/01/01' THEN 
        INTO EMP_OLD VALUES (EMP_ID, EMP_NAME, HIRE_DATE, SALARY)
    WHEN HIRE_DATE >= '2010/01/01' THEN 
        INTO EMP_NEW VALUES (EMP_ID, EMP_NAME, HIRE_DATE, SALARY)
    SELECT EMP_ID, EMP_NAME, HIRE_DATE, SALARY FROM EMPLOYEE;


--------------------------------------------------------------------------------
/*
    UPDATE
    ���̺� ��ϵ� �÷� ���� �����ϴ� ����
    
    ǥ���� : UPDATE ���̺�� SET �÷���=�ٲܰ� [WHERE ����];
    ������ �������� ������ ���̺� �� �ش� �÷��� ��� ���� ���� ����
*/
--------------------------------------------------------------------------------
--�μ� ���̺� ���纻 ���̺� ����
CREATE TABLE DEPT_COPY AS SELECT * FROM DEPARTMENT;
SELECT * FROM DEPT_COPY;
--�μ��ڵ尡 'D9'�� �μ����� '������ȹ��'���� ����
UPDATE DEPT_COPY SET DEPT_TITLE = '������ȹ��' WHERE DEPT_ID='D9';
--������ �� �ָ� �ش� �÷��� ��ü �� �����Ͱ� ���汯
UPDATE DEPT_COPY SET DEPT_TITLE = '�ѹ���';
ROLLBACK;
--UPDATE �ÿ��� �������� ��� ����
    --UPDATE ���̺�� SET �÷��� = (��������) [WHERE ����];
CREATE TABLE EMP_SALARY AS SELECT EMP_ID, EMP_NAME, DEPT_CODE, SALARY, BONUS FROM EMPLOYEE;
SELECT * FROM EMP_SALARY;
--������� �޿��� ���ʽ��� ��ȸ�ؿͼ� ������ �޿��� ���ʽ��� ����
UPDATE EMP_SALARY SET 
    SALARY = (SELECT SALARY FROM EMPLOYEE WHERE EMP_NAME='�����'),
    BONUS = (SELECT BONUS FROM EMPLOYEE WHERE EMP_NAME='�����')
    WHERE EMP_NAME='����';
--���� ��, ���� �� ���������� �̿��� UPDATE��
UPDATE EMP_SALARY SET 
    (SALARY, BONUS) = (SELECT SALARY, BONUS FROM EMPLOYEE WHERE EMP_NAME='�����')
    WHERE EMP_NAME IN ('���ö','������','������','�ϵ���');
SELECT * FROM EMP_SALARY WHERE EMP_NAME IN ('�����','����','���ö','������','������','�ϵ���');
--EMP_SALARY ���̺��� �ƽþ� ������ �ٹ��ϴ� ������ ���ʽ��� 0.5�� ����
SELECT EMP_ID, LOCAL_NAME FROM EMPLOYEE JOIN DEPARTMENT ON (DEPT_CODE=DEPT_ID)
    JOIN LOCATION ON (LOCATION_ID=LOCAL_CODE)
    WHERE LOCAL_NAME LIKE 'ASIA%';
UPDATE EMP_SALARY SET BONUS = 0.5
    WHERE EMP_ID IN (SELECT EMP_ID FROM EMPLOYEE 
                    JOIN DEPARTMENT ON (DEPT_CODE=DEPT_ID)
                    JOIN LOCATION ON (LOCATION_ID=LOCAL_CODE)
                    WHERE LOCAL_NAME LIKE 'ASIA%');

--UADATE�� ������ ���� �ش� �÷��� �������ǿ� ������� �ʾƾ� ��!!
UPDATE EMPLOYEE SET EMP_NAME = NULL WHERE EMP_ID = 200; --NOT NULL ����


--------------------------------------------------------------------------------
/*
    DELETE 
    ���̺��� ���� �����ϴ� ����
    ǥ���� : DELE FROM ���̺�� [WHERE ����];
    ���� WHERE ������ �������� ������ ��� ���� �� ������
*/
--------------------------------------------------------------------------------
COMMIT;
SELECT * FROM EMPLOYEE;
DELETE FROM EMPLOYEE WHERE EMP_NAME='��ä��';
DELETE FROM EMPLOYEE; --��� �� ����
ROLLBACK;

--FOREIGN KEY(�ܷ�Ű) ���������� �����Ǿ� �ִ� ��� ����
    --�������� Ȯ��
SELECT * FROM USER_CONSTRAINTS WHERE TABLE_NAME = 'EMPLOYEE';
SELECT * FROM USER_CONS_COLUMNS WHERE TABLE_NAME = 'EMPLOYEE';
    --EMPLOYEE ���̺��� DEPT_CODE �÷��� �ܷ�Ű ���� (�θ� : DEPARTMENT ���̺� DEPT_ID)
ALTER TABLE EMPLOYEE ADD /* CONSTRAINT '�������� ��' */ 
    FOREIGN KEY (DEPT_CODE) REFERENCES DEPARTMENT/* (�����÷���) */;
    --�ܷ�Ű�� ���� �ǰ� �ִ� ���� ���ؼ��� ���� �Ұ���
DELETE FROM DEPARTMENT WHERE DEPT_ID='D1'; --����
    --�ܷ�Ű �����Ǿ� �ִ��� ���� �����ǰ� ���� ���� ���� ���ؼ��� ���� ����
DELETE FROM DEPARTMENT WHERE DEPT_ID='D3';
ROLLBACK;
    --���� �� �ܷ�Ű ������������ ������ �Ұ����� ��� �ӽ÷� �ӽ÷� ���������� ��Ȱ��ȭ �� �� ����
ALTER TABLE EMPLOYEE DISABLE CONSTRAINT SYS_C007123 CASCADE;
DELETE FROM DEPARTMENT WHERE DEPT_ID='D1';
SELECT * FROM DEPARTMENT;
ROLLBACK;
ALTER TABLE EMPLOYEE ENABLE CONSTRAINT SYS_C007123;


--------------------------------------------------------------------------------
/*
    MERGE
    ������ ���� �� ���� ���̺��� �ϳ��� ���̺�� ��ġ�� ��� ����
    �� ���̺��� �����ϴ� ������ ���� �����ϸ� UPDATE�ǰ�, ���ǰ��� ������ INSERT ��
*/
--------------------------------------------------------------------------------
CREATE TABLE EMP_M01 AS SELECT * FROM EMPLOYEE;
CREATE TABLE EMP_M02 AS SELECT * FROM EMPLOYEE WHERE JOB_CODE = 'J4';
SELECT * FROM EMP_M01;
SELECT * FROM EMP_M02;

INSERT INTO EMP_M02 VALUES('999','���ο�','561016-1234567','kwack_dw@kh.or.kr', 
    '01011112222', 'D9','J4','S1',9000000,0.5,NULL,SYSDATE,NULL,DEFAULT);
UPDATE EMP_M02 SET SALARY = 0;

MERGE INTO EMP_M01 USING EMP_M02 ON (EMP_M01.EMP_ID = EMP_M02.EMP_ID)
    WHEN MATCHED THEN UPDATE SET 
                        EMP_M01.EMP_NAME = EMP_M02.EMP_NAME,
                        EMP_M01.EMP_NO = EMP_M02.EMP_NO,
                        EMP_M01.EMAIL = EMP_M02.EMAIL,
                        EMP_M01.PHONE = EMP_M02.PHONE,
                        EMP_M01.DEPT_CODE = EMP_M02.DEPT_CODE,
                        EMP_M01.JOB_CODE = EMP_M02.JOB_CODE,
                        EMP_M01.SAL_LEVEL = EMP_M02.SAL_LEVEL,
                        EMP_M01.SALARY = EMP_M02.SALARY,
                        EMP_M01.BONUS = EMP_M02.BONUS,
                        EMP_M01.MANAGER_ID = EMP_M02.MANAGER_ID,
                        EMP_M01.HIRE_DATE = EMP_M02.HIRE_DATE,
                        EMP_M01.ENT_DATE = EMP_M02.ENT_DATE,
                        EMP_M01.ENT_YN = EMP_M02.ENT_YN
    WHEN NOT MATCHED THEN 
    INSERT VALUES(EMP_M02.EMP_ID, EMP_M02.EMP_NAME, EMP_M02.EMP_NO, EMP_M02.EMAIL, EMP_M02.PHONE,
        EMP_M02.DEPT_CODE, EMP_M02.JOB_CODE, EMP_M02.SAL_LEVEL, EMP_M02.SALARY, EMP_M02.BONUS, EMP_M02.MANAGER_ID,
        EMP_M02.HIRE_DATE, EMP_M02.ENT_DATE, EMP_M02.ENT_YN);
SELECT * FROM EMP_M02;
SELECT * FROM EMP_M01; --EMP_M02�� �����͸� EMP_M01�� �߰�(������), ����(SALARY=0)


--------------------------------------------------------------------------------
/*
    DDL - TRUNCATE(�ʱ�ȭ)
    ���̺� ��ü �� ���� �� ����ϸ� DELETE���� ����ӵ��� ����
    ���̺��� ������ �����ߴٰ� �ٽ� ����
    DDL�̱� ������ ROLLBACK���� ���� �Ұ���(DROP�� ���� �Ұ�)
*/
--------------------------------------------------------------------------------
SELECT * FROM EMP_SALARY;
COMMIT;
DELETE FROM EMP_SALARY; --��� ������ ����
SELECT * FROM EMP_SALARY; --������ ����
ROLLBACK;
SELECT * FROM EMP_SALARY; --������ ������

TRUNCATE TABLE EMP_SALARY; --���̺� �ʱ�ȭ
SELECT * FROM EMP_SALARY; --������ ����
ROLLBACK;
SELECT * FROM EMP_SALARY; --������ ����