--------------------------------------------------------------------------------
/*
    ���Ǿ�(SYNONYM)
    �ٸ� �����ͺ��̽�(�����)�� ���� ��ü�� ���� ����, Ȥ�� ���Ӹ�
    ���� ����ڰ� ���̺��� ������ ���, 
    �ٸ� ������� ��ü�� ������ ���� [����� ID].[��ü��]���� ������ �ؾ���
    ��ó�� ��� ǥ���Ǵ� ���� ���Ǿ�(SYNONYM)���� ���� �� ������ ��� ����
    
    ����� ���Ǿ�
        ��ü�� ���� ���� ������ �ο����� ����ڰ� ������ ���Ǿ�� �ش� ����ڸ� ��� ����
    ���� ���Ǿ�
        ������ �ִ� �����(DBA,������)�� ������ ���Ǿ�� ��� ����ڰ� ��� ����(PUBLIC)
        EX) DUAL
*/
--------------------------------------------------------------------------------
SELECT * FROM DBA_SYS_PRIVS WHERE GRANTEE='KH';
SELECT * FROM DBA_ROLE_PRIVS WHERE GRANTEE='KH';
--KUSER ������ ���� ���� �ο�(������ ����)
GRANT CREATE SESSION TO KUSER;
--�׽�Ʈ�� ���� KUSER ������ KH.EMPLOYEE ���̺� ��ȸ ���� �ο�(������ OR KH ����)
GRANT SELECT ON KH.EMPLOYEE TO KUSER;

--���̺� ��ȸ �غ���(KUSER ����)
SELECT * FROM KH.EMPLOYEE;

--------------------------------------------------------------------------------
/*
    ���Ǿ� ����
    CREATE [PUBLIC|PRIVATE] SYNONYM <���Ӹ�> FOR [����ڸ�.]<��ü��>;
*/
--------------------------------------------------------------------------------
--����� ���Ǿ� ����(KH����)
    --CREATE SYNONYM ���� ������ ���� �߻�
CREATE /*PRIVATE*/ SYNONYM EMP FOR /*KH.*/ EMPLOYEE; --����
SELECT * FROM SESSION_PRIVS;
    --KH������ CREATE SYNONYM ���� �ο�(������ ����)
GRANT CREATE SYNONYM TO KH;
    --���� �ο� �� SYSNONYM ����(KH����)
CREATE SYNONYM EMP FOR EMPLOYEE; --���� ������
    --���� ������ ���Ǿ� ���� ��ȸ(KH����)
SELECT * FROM USER_SYNONYMS;
    --��� ���Ǿ� ���� ��ȸ
SELECT * FROM ALL_SYNONYMS;
SELECT * FROM TAB; --������ SYS.TAB������ ���Ǿ� �����Ͽ� TAB���� ��ȸ����
SELECT * FROM ALL_SYNONYMS WHERE TABLE_OWNER='KH';
    --���� Ȯ��(KH����)
SELECT * FROM EMPLOYEE;
SELECT * FROM EMP;
    --�ٸ� �������� ��� �õ�(������, KUSER����)
SELECT * FROM KH.EMPLOYEE;
SELECT * FROM EMP;  --������, KUSER ��� EMP ���Ǿ�� ��� �Ұ���

--���� ���Ǿ� ����(������ ����)
CREATE PUBLIC SYNONYM PUB_EMP FOR KH.EMPLOYEE;
    --���Ǿ� ���� ��ȸ(������ ����)
SELECT * FROM USER_SYNONYMS;
SELECT * FROM ALL_SYNONYMS WHERE TABLE_OWNER = 'KH';
    --���� Ȯ��(������, KH, KUSER ����)
SELECT * FROM PUB_EMP;


--------------------------------------------------------------------------------
/*
    ���Ǿ� ����
    DROP SYNONYM <���Ǿ��>;
    PUBLIC ���Ǿ ������ ���� DROP PUBLIC SYNONYM ������ �־�� ��
*/
--------------------------------------------------------------------------------
--����� ���Ǿ� ����(KH ����)
DROP SYNONYM EMP;
--���� ���Ǿ� ����(������ ����)
DROP PUBLIC SYNONYM PUB_EMP; --���� ������ ����(������ �������� ����)