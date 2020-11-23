--------------------------------------------------------------------------------
/*
    DCL (DATA CONTROL LANGUAGE)
    DB�� ���� ����, ���Ἲ, ���� �� DBMS�� �����ϱ� ���� ���
    ������� �����̳� ������ ���� ���� ó��
        GRANT(���� ���� ����), REVOKE(���� ���� ����)
    Ʈ����ǿ� ���õ� ���(TCL)
        COMMIT(����), ROLLBACK(����)
*/
--------------------------------------------------------------------------------


--------------------------------------------------------------------------------
/*
    ��������
    ������ ���̽��� ����ϱ� ���� ����
    ������ ���̽��� �����ϱ� ���ؼ��� �ش� ����ڷ� �α����ؼ� ����ؾ� ��
    
    �����ͺ��̽��� ������ ����
        �����ͺ��̽��� ������ ������ ����ϴ� ����
        ��� ��ȯ�� å���� ������ ����
    �����ͺ��̽��� ����� ����
        �����ͺ��̽��� ���Ͽ� ����, ����, ���� �ۼ� ���� �۾��� ������ �� �ִ� ����
        ������ �ʿ��� �ּ����� ���Ѹ� ������ ���� ��Ģ���� ��
*/
--------------------------------------------------------------------------------
--������ ���̽� �� ������ ���� Ȯ��
SELECT * FROM DBA_USERS;
--���� ���� ���� Ȯ��
SHOW USER;

--���� ����
/*
    CREATE USER <USER_NAME>
    [
        IDENTIFIED BY <PASSWORD>
        DEFAULT TABLESPACE <TABLESPACE_NAME>
        TEMPORARY TABLESPACE <TEMP_TABLESPACE_NAME>
        QUOTA <SIZE | UNLIMITIED> ON <TABLESPACE_NAME>
        PROFILE <PROFILE | DEFAULT>
        PASSWORD EXPIRE
        ACCOUNT <LOCK | UNLOCK>
    ];
        
       --�ɼ�--
        IDENTIFIED BY [PASSWORD] : �ش� ������ ��й�ȣ�� �����ϴ� �ɼ�
        DEFAULT TABLESPACE [TABLESPACE_NAME] : 
                �ش� ������ ���׸�Ʈ�� �������� ��� ����ϴ� �⺻ ���̺����̽� 
        TEMPORARY TABLESPACE [TEMP_TABLESPACE_NAME] : 
                �ش� ������ �����Ͽ� ���� ���� �۾� ���� �� ����ϴ� ���̺����̽�
        QUOTA [SIZE / UNLIMITED] ON [TABLESPACE_NAME] :
                Ư�� ���̺����̽��� �ش� ������ ����� �� �ִ� ���� �뷮�� �����ϴ� �ɼ�
        PROFILE [PROFILE | DEFAULT] : user�� password�� resource�� ���� ����
        PASSWORD EXPIRE : ���� ���� �� password �缳��
        ACCOUNT [LOCK | UNLOCK] : ������ ���� lock ����
*/
--KUSER ��� �̸��� ������ �����ϸ鼭 ��й�ȣ�� KUSERPASS�� �����ϰ� ���� ��� ���·� ����
CREATE USER KUSER IDENTIFIED BY KUSERPASS ACCOUNT LOCK;

--������ȸ
SELECT * FROM DBA_USERS;

--�����׽�Ʈ(GUI�� �ص� ��) : ������ ��� �־ ���� �� ��
CONNECT KUSER/KUSERPASS;


--���� ����
/*
    ALTER USER <USERNAME>
    [
        IDENTIFIED BY <PASSWORD>
        DEFAULT TABLESPACE <TABLESPACE_NAME>
        TEMPORARY TABLESPACE <TEMP_TABLESPACE_NAME>
        QUOTA <SIZE | UNLIMITIED> ON <TABLESPACE_NAME>
        ACCOUNT <LOCK | UNLOCK>
    ];
*/
--���� ��� ����
ALTER USER KUSER ACCOUNT UNLOCK; --�����ڰ����̾ ��й�ȣ ���̵� ��� ���� ����
SELECT * FROM DBA_USERS;
 
--���� �׽�Ʈ : LOCK�� Ǯ������ ���ӱ����� ��� ���� �� ��
CONNECT KUSER/KUSERPASS;

--���� ��й�ȣ ����
ALTER USER KUSER IDENTIFIED BY KPASS;

--���� �׽�Ʈ : ��й�ȣ Ʋ���� ���� �� ��
CONNECT KUSER/KUSERPASS;
--���� �׽�Ʈ : ��й�ȣ�� ������ ���� ������ ��� ���� �� ��
CONNECT KUSER/KPASS;


--���� ����
/*
    DROP USER <USERNAME> [CASCADE];
    CASCADE : ������ ���õ� ��� �����ͺ��̽� ��Ű���� ������ �������κ��� �����ǰ�
            ��� ��Ű�� ��ü�� ���������� ����
*/
--KUSER ������ ����
DROP USER KUSER CASCADE;
--���� Ȯ��
SELECT * FROM DBA_USERS;


--------------------------------------------------------------------------------
/*
    ���� ����
*/
--------------------------------------------------------------------------------
--���� �ǽ��� ���� ���� ����
CREATE USER KUSER IDENTIFIED BY KUSER;

--���� ��ȸ
SELECT * FROM DBA_USERS;

--���� �õ� : ���� ���� ����
CONNECT KUSER/KUSER;

--�ý��� ���� �ο�
    --GRANT <����, ...> TO USER<USERNAME>;
GRANT CREATE SESSION TO KUSER;
    --���� �õ� : ���ӱ�
    CONNECT KUSER/KUSER;
    
--KUSER �������� KH.EMPLOYEE ��ȸ �õ� : �� ��
--SELECT * FROM KH.EMPLOYEE;

--������Ʈ ���� �ο�
    --GRANT <����, ...> ON <OBJECT_NAME> TO <USERNAME>;
GRANT SELECT ON KH.EMPLOYEE TO KUSER;
--KUSER �������� KH.EMPLOYEE ��ȸ �õ� : ��ȸ ����
--SELECT * FROM KH.EMPLOYEE;

/* ��ȯ Ȯ�� */
--����ڿ��� �ο��� �ý��� ���� Ȯ�� (������)
SELECT * FROM DBA_SYS_PRIVS WHERE GRANTEE = 'KUSER';
--����ڿ��� �ο��� ������Ʈ ��ȯ Ȯ�� (������)
SELECT * FROM DBA_TAB_PRIVS WHERE GRANTEE = 'KUSER';
    
--���� ���� ���� �ý��� ���� Ȯ��
SELECT * FROM SESSION_PRIVS;
--���� ���� ���� ������Ʈ ��ȯ Ȯ��
SELECT * FROM USER_TAB_PRIVS_RECD; --����ڿ��� �ο��� ����

--������Ʈ ���� ����
    --REVOKE <����, ...> ON <OBJECT_NAME> FROM <USERNAME>;
REVOKE SELECT ON KH.EMPLOYEE FROM KUSER;

--�ý��� ���� ����
    --REVOKE <����, ...> FROM <USERNAME>;
REVOKE CREATE SESSION FROM KUSER;
CONNECT KUSER/KUSER; --���� ���ŷ� ����