--------------------------------------------------------------------------------
/*
    �ε���(INDEX)
    SQL��ɹ��� ó�� �ӵ��� ����Ű�� ���ؼ� �÷��� ���� �����ϴ� 
    ����Ŭ ��ü�� ���� ������ B*Ʈ�� �������� �����Ǿ� ����
    
    ����
        �˻� �ӵ��� ������
        �ý��ۿ� �ɸ��� ���ϸ� �ٿ��� �ý��� ��ü�� ������ ����Ŵ
    
    ����
        �ε����� ���� �߰� ���� ������ �ʿ���
        �ε����� �����ϴµ� �ð��� �ɸ�
        �������� �����۾�(INSERT/UPDATE/DELETE)�� ���� �Ͼ�� ��쿡�� ������ ������ ���ϵ�
        
     �ε��� ����
     1. �����ε���(UNIQUE INDEX)
        �ߺ� ���� ���Ե� �� ����
        PRIMARY KEY ���������� �����ϸ� �ڵ����� ������
     2. ������ε���(NONUINQUE INDEX)
        ����ϰ� ���Ǵ� �Ϲ� �÷��� ������� ����
        �ַ� ���� ����� ���� �������� ����
     3. �����ε���(SINGLE INDEX)
        �� ���� �÷����� ������ �ε���
     4. �����ε���(COMPOSITE INDEX)
        �� �� �̻��� �÷����� ������ �ε���
     5. �Լ� ��� �ε���(FUNCTION-BASED INDEX)
        SELECT���̳� WHERE���� ��� ����/�Լ����� ���� ���
        ������ �ε����� ������ ���� ����
*/
--------------------------------------------------------------------------------
--�ε����� �����ϴ� ������ ���� ��ȸ
    --�ε��� ��ȸ
SELECT * FROM USER_IND_COLUMNS;
--Ư�� ���������� ������ �÷��� �ڵ����� �ε����� �����ϱ⵵ ��
    --PRIMARY KEY, UNIQUE
SELECT * FROM USER_CONSTRAINTS WHERE TABLE_NAME='USER_TBL';
SELECT * FROM USER_CONS_COLUMNS WHERE TABLE_NAME='USER_TBL';

--�ε��� ID ��ȸ
    --ROWID : ROW(��)�� ID(IDENTIFY)
    --��� ���� �����ϴ� �ĺ���
    --��ũ�� ����� ���� ������ ��ġ�� ��Ÿ���� ����
SELECT ROWID, EMP_ID, EMP_NAME FROM EMPLOYEE;
/*
    �ε��� ID ����
    AAAE7UAABAAALC5AAA
    AAAE7U : ������ ������Ʈ ��ȣ
    AAB : ���� ��ȣ
    AAALC5 : BLOCK ��ȣ
    AAA : ROW ��ȣ
*/


--------------------------------------------------------------------------------
/*
    �ε��� ����
    CREATE [UNIQUE] INDEX <�ε�����> ON <���̺��> (�÷���[, ...]|�Լ���|�Լ� ����);
*/
--------------------------------------------------------------------------------

--------------------------------------------------------------------------------
--���� �ε���(UNIQUE INDEX)
    --UNIQUE INDEX�� ������ �÷����� �ߺ����� ���Ե� �� ����(NULL�� ���)
    --����Ŭ PRIMARY KEY ���������� �����ϸ� �ڵ����� �ش� �÷��� UNIQUE INDEX�� ������
    --PRIMARY KEY�� �̿��Ͽ� ACCESS�ϴ� ��� ���� ��� ȿ���� ����
SELECT * FROM EMPLOYEE;
SELECT EMP_NO FROM EMPLOYEE;
SELECT * FROM EMPLOYEE WHERE EMP_NO = '1111';
CREATE UNIQUE INDEX IDX_EMPNO ON EMPLOYEE(EMP_NO);
SELECT * FROM EMPLOYEE WHERE EMP_NO > '000101-1111111';
SELECT * FROM USER_IND_COLUMNS;
    --�ߺ����� �ִ� �÷��� UNIQUE INDEX ���� �� ��
CREATE UNIQUE INDEX IDX_DEPTCODE ON EMPLOYEE(DEPT_CODE); --����

--------------------------------------------------------------------------------
--����� �ε���(NONUNIQUE INDEX)
    --����ϰ� ���Ǵ� �Ϲ� �÷��� ������� ����
    --�ַ� ���� ����� ���� �������� ������
    --�ߺ����� �ִ� �÷����� ���� ����
CREATE INDEX IDX_DEPTCODE ON EMPLOYEE(DEPT_CODE);
SELECT * FROM USER_IND_COLUMNS;

--------------------------------------------------------------------------------
--���� �ε���(COMPOSITE INDEX)
    --�� �� �̻��� �÷��� ���� �������� �����ؼ� ��ȸ�� ��� Ȱ��
CREATE INDEX IDX_DEPT ON DEPARTMENT(DEPT_ID, DEPT_TITLE);
SELECT * FROM USER_IND_COLUMNS;
SELECT * FROM DEPARTMENT WHERE DEPT_ID>'0' AND DEPT_TITLE>'0';

--------------------------------------------------------------------------------
--�Լ� ��� �ε���
    --SELECT���̳� WHERE���� ��������̳� �Լ����� ���� ���
    --������ �ε����� ������ ���� ����
    --�������� �˻��ϴ� ��찡 ���ٸ�, �����̳� �Լ����� �ε����� ���� �� ����
CREATE TABLE EMP_IDX01 AS SELECT * FROM EMPLOYEE;
CREATE INDEX IDX_EMP02_SALARY ON EMP_IDX01((SALARY+SALARY*NVL(BONUS,0))*12);
SELECT * FROM USER_IND_COLUMNS WHERE TABLE_NAME='EMP_IDX01';
SELECT EMP_ID, EMP_NAME, SALARY, ((SALARY+SALARY*NVL(BONUS,0))*12) ���� 
    FROM EMP_IDX01 WHERE ((SALARY+SALARY*NVL(BONUS,0))*12) = 72000000;


--------------------------------------------------------------------------------
/*
    INDEX �� ����
    DML�۾�(Ư�� DELETE)����� ������ ���,
     �ش� �ε��� ������ ���帮�� �������θ� ���ŵǰ� ���� ���帮�� �׳� �����ְ� �ȴ�.
     �ε����� �ʿ� ���� ������ �����ϰ� �ֱ� ������ �ε����� �� ������ �ʿ䰡 �ִ�.
    ALTER INDEX �ε����� REBUILD;  
*/
--------------------------------------------------------------------------------
SELECT * FROM USER_IND_COLUMNS WHERE TABLE_NAME='EMPLOYEE';
ALTER INDEX IDX_EMPNO REBUILD;


--------------------------------------------------------------------------------
/*
    �ε��� ����
    DROP INDEX<�ε��� ��>;
*/
--------------------------------------------------------------------------------
SELECT * FROM USER_IND_COLUMNS;
DROP INDEX IDX_DEPTCODE;
DROP INDEX IDX_DEPT;


--------------------------------------------------------------------------------
/*
    �ε��� Ȱ�� �׽�Ʈ
    1. �ε��� �׽�Ʈ �� ���̺� ���� �� ������ ����
    -> USER_MOCK_DATA@KH.sql ��ũ��Ʈ ���� ���
    2. �ε��� ��� ���� Ȯ��
    -> SQL ��ũ��Ʈ ��� �޴� �� ���� ��ȹ(F10) OR �ڵ� ����(F6)���� Ȯ��
        ���� ��ȹ : �����ϱ� �� ��� �������� Ȯ�� - ���� : ��ȹ�� ���� ������ �ٸ� �� ����
        �ڵ� ���� : �����ϰ� ���� ��� �����ߴ��� ��� Ȯ�� - ���� : ���� ���뿡 ���� ���� �ɸ� ���� ����
        OPTIONS : �ε��� ��ĵ = BY INDEX ROWID..., Ǯ ��ĵ = FULL SCAN
        CADINALITY : ������ ũ��
        COST : ���
    -> �ڵ� ������ ����Ϸ��� ������ �־���� (���� ���� �� ��� ������ �������� ���� �ο����ְ� ����)
*/
--------------------------------------------------------------------------------
--�ڵ� ������ ���� ���� �ο�(������ ����)
GRANT SELECT ANY DICTIONARY TO KH;

--��ü ������ Ȯ��
    --���� ��ȹ OR �ڵ� �������� Ȯ���غ���
SELECT * FROM USER_MOCK_DATA;

--���� �����Ǿ� �ִ� �ε��� ��ȸ
SELECT * FROM USER_IND_COLUMNS WHERE TABLE_NAME = 'USER_MOCK_DATA';

--�ε��� ���� �� ���� ��ȹ Ȯ��
    --ID �÷� ���� �˻�
SELECT * FROM USER_MOCK_DATA WHERE ID = '22222';
    --EMAIL �÷� �˻�
SELECT * FROM USER_MOCK_DATA WHERE EMAIL = 'kbresland0@comsenz.com';
    --GENDER �÷� ���� �˻�
SELECT * FROM USER_MOCK_DATA WHERE GENDER = 'Male';
    --FIRST_NAME �÷� LIKE ����
SELECT * FROM USER_MOCK_DATA WHERE FIRST_NAME LIKE 'R%';

--���������� �̿��ؼ� �ε��� ����(PK)
ALTER TABLE USER_MOCK_DATA ADD CONSTRAINT PK_USERDATA_ID PRIMARY KEY (ID);
--���������� �̿��ؼ� �ε��� ����(UQ)
ALTER TABLE USER_MOCK_DATA ADD CONSTRAINT UQ_USERDATA_EMAIL UNIQUE(EMAIL);
SELECT * FROM USER_IND_COLUMNS WHERE TABLE_NAME='USER_MOCK_DATA';

--�ε��� ���� �� ���� ��ȹ Ȯ��
    --ID �÷� ���� �˻�
SELECT * FROM USER_MOCK_DATA WHERE ID = '22222';
    --EMAIL �÷� �˻�
SELECT * FROM USER_MOCK_DATA WHERE EMAIL = 'kbresland0@comsenz.com';
    --GENDER �÷� ���� �˻�
SELECT * FROM USER_MOCK_DATA WHERE GENDER = 'Male';
    --FIRST_NAME �÷� LIKE ����
SELECT * FROM USER_MOCK_DATA WHERE FIRST_NAME LIKE 'R%';
