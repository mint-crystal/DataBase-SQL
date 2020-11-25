--------------------------------------------------------------------------------
/*
    TCL(Transaction Control Language)
    Ʈ����� ���� ���
    COMMIT, ROLLBACK, SAVEPOINT, ROLLBACK TO
    DDL, DCL���� ������� ����
        ����ϰ� �Ǹ� AUTO COMMIT(�ڵ� �Ϸ�)�� ��
    
    Ʈ������̶�?
        �Ѳ����� ����Ǿ�� �� �ּ��� �۾� ����(���� �۾� ����)
        �ϳ��� Ʈ��������� �̷���� �۾��� �ݵ�� �Ѳ����� �Ϸᰡ �Ǿ�� �ϸ�,
        �׷��� ���� ���� �Ѳ����� ��ҵǾ�� ��
        
    COMMIT : Ʈ������ �۾��� ���� �Ϸ�Ǹ� ���� ������ ������ ����
    ROLLBACK : Ʈ������ �۾��� ����ϰ� �ֱ� COMMIT�� �������� �̵�
    SAVEPOINT ���̺�����Ʈ �� : ���� Ʈ������ �۾� ������ �̸��� ������
                           �ϳ��� Ʈ������ �ȿ� ������ ����
    ROLLBACK TO ���̺�����Ʈ�� : Ʈ������ �۾��� ����ϰ� SAVEPOINT �������� �̵�
*/
--------------------------------------------------------------------------------
--��������� ��� �۾� �Ϸ�
    COMMIT;

--�׽�Ʈ ���̺� ����
CREATE TABLE USER_TBL(
    USERNO NUMBER UNIQUE,
    ID VARCHAR2(20) PRIMARY KEY,
    PASSWORD CHAR(20) NOT NULL
);

--KH����, KUSER �������� ��ȸ�غ��� (������ ��ܿ��� KUSER�� ����)
SELECT * FROM USER_TBL;
SELECT * FROM KH.USER_TBL;

--�׽�Ʈ�� ���� KUSER ������ KH.USER_TBL ���̺��� ��ȸ ���� �ο�(KH����)
GRANT SELECT ON KH.USER_TBL TO KUSER;

--������ ����(KH����)
INSERT INTO USER_TBL VALUES (1,'TEST1','PASS1');
INSERT INTO USER_TBL VALUES (2,'TEST2','PASS2');
INSERT INTO USER_TBL VALUES (3,'TEST3','PASS3');

--KH����, KUSER �������� ��ȸ�غ���
    --KH���������� ���Ե� ������ ��ȸ������, KUSER ���������� ��ȸ �ȵ� 
        --���� : �۾��� �Ϸ���� �ʾұ� ������
SELECT * FROM USER_TBL; --KH����
SELECT * FROM KH.USER_TBL; --KUSER ����

--������� �۾� �Ϸ�(KH����)
COMMIT;

--KH����, KUSER �������� ��ȸ�غ���
    --KH����, KUSER���� ��� ������ ��ȸ��
SELECT * FROM USER_TBL; --KH����
SELECT * FROM KH.USER_TBL; --KUSER ����

--������ ����(KH����)
INSERT INTO USER_TBL VALUES (4,'TEST4','PASS4');

--������ ��ȸ(KH����) - 4������ ���� ���Ե�
SELECT * FROM KH.USER_TBL;

--������ COMMIT �������� �ǵ�����
ROLLBACK;

--������ ��ȸ(KH����) - 3������ �Է��ϰ� COMMIT�� �߱� ������ ���� �۾��� ��� ������
SELECT * FROM KH.USER_TBL;

--������ ����(KH����)
INSERT INTO USER_TBL VALUES (4,'TEST4','PASS4');

--�ӽ� ���� ��ġ ���� (SAVEPOINT)
    --SAVEPOINT <SAVEPOINT ��>;
SAVEPOINT SP1;

--������ ��ȸ(KH����)
SELECT * FROM KH.USER_TBL;

--������ ����(KH����)
INSERT INTO USER_TBL VALUES (5,'TEST5','PASS5');
SELECT * FROM KH.USER_TBL;

--�ӽ� ���� ��ġ�� ���ư���(ROLLBACK TO)
    --ROLLBACK TO <SAVEPOINT ��>;
ROLLBACK TO SP1;
SELECT * FROM KH.USER_TBL;

--������ ����(KH����)
INSERT INTO USER_TBL VALUES (5,'TEST5','PASS5');
SELECT * FROM KH.USER_TBL;

--SP1 �ӽ� ���� ��ġ�� ���ư���(ROLLBACK TO)
    --�� �� ���ư� ���Ŀ��� �ٽ� ���ư� �� ����
ROLLBACK TO SP1;
SELECT * FROM KH.USER_TBL;

--������ ����(KH����)
INSERT INTO USER_TBL VALUES (5,'TEST5','PASS5');
SELECT * FROM KH.USER_TBL;

--�ӽ� ���� ��ġ ����
SAVEPOINT SP2;

--������ ����(KH����)
INSERT INTO USER_TBL VALUES (6,'TEST6','PASS6');
SELECT * FROM KH.USER_TBL;

--SP2�� ���ư���
ROLLBACK TO SP2;
SELECT * FROM KH.USER_TBL;

--������ ����(KH����)
INSERT INTO USER_TBL VALUES (6,'TEST6','PASS6');
SELECT * FROM KH.USER_TBL;

--SP1�� ���ư���
ROLLBACK TO SP1;
SELECT * FROM KH.USER_TBL;

--SP2�� ���ư���
    --SP1�� ���ư��鼭 SP2�� ������
ROLLBACK TO SP2;    --����

--ó������ ���ư���
    --������ COMMIT(�۾� �Ϸ�)�� �������� ���ư���
ROLLBACK;
SELECT * FROM KH.USER_TBL;