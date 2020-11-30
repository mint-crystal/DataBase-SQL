--------------------------------------------------------------------------------
/*
    ���� ���ν���(STORED PROCEDURE)
    PL/SQL���� �����ϴ� ��ü
    �Ϸ��� �۾� ������ �̸� �����ؼ� ������ �� ��
    ���� SQL���� ��� �̸� �����صΰ� �ϳ��� ��û���� ������ �� ����
    ���� ���Ǵ� ������ �۾����� �����ϰ� �̸� �����θ� ���� ����� ������
    
    ���ν��� �ۼ� ���
    - �Ű������� ���������� ũ��� �����ϸ� �� ��(���̺�.�÷�%TYPE�� ����)
    - SELECT ���� INTO�� ���� ������ ���� �����ؼ� ����ؾ� ��(SELECT ��ü�����δ� ��� �� ��)
    
    ���� ���
        CREATE PROCEDURE <���ν�����> (<�Ű�����> [MODE] DATATYPE [, ...])
        IS
            �������� ����;
        BEGIN
            ������ ����;
        END;
        /
    
        [MODE]
            IN : �����͸� �Է¹��� ��(�⺻ ��)
            OUT : �����͸� ��ȯ�� ��
            INOUT : �� ���� ���� ��ο� ���(�����δ� ������ ����)
    
    ���� ���
        EXECUTE <���ν�����>[<���ް�>[, ...]];
*/
--------------------------------------------------------------------------------
--�⺻ ���ν��� ����
CREATE OR REPLACE PROCEDURE TEST_PRO
IS
BEGIN
    DBMS_OUTPUT.PUT_LINE('���ν��� ����1');
END;
/
--���ν��� Ȯ��
SELECT * FROM ALL_PROCEDURES; --��� ���ν��� Ȯ��
SELECT * FROM USER_PROCEDURES; --���� ����ڰ� ������ ���ν��� ��� Ȯ��
SELECT * FROM USER_SOURCE; --���� ����ڰ� ������ ���ν��� �� �ڵ� Ȯ��
SELECT * FROM USER_SOURCE WHERE NAME = 'TEST_PRO'; --Ư�� ���ν����� �� �ڵ� Ȯ��

--���ν��� ����
EXECUTE TEST_PRO;
EXEC TEST_PRO; --�ٿ��� ��밡��

--�Ű������ִ� ���ν���
CREATE OR REPLACE PROCEDURE TEST_PRO2 (NUM NUMBER)
IS
BEGIN
    DBMS_OUTPUT.PUT_LINE('�Է� �� : '||NUM);
END;
/

EXEC TEST_PRO2(100);

CREATE OR REPLACE PROCEDURE TEST_PRO3 (NAME VARCHAR2) --�Ű����� �κп� ũ�� ����X
IS
BEGIN
    DBMS_OUTPUT.PUT_LINE('�Է� �� : '||NAME);
END;
/

EXEC TEST_PRO3('ȫ�浿');
EXEC TEST_PRO3('��浿');

--�̸��� �Է¹��� �� �������̺��� �̸��� �˻��ؼ� �̸�, ��ȭ��ȣ, �޿� ���
CREATE OR REPLACE PROCEDURE TEST_PRO4 (NAME EMPLOYEE.EMP_NAME%TYPE) 
IS
    V_NAME EMPLOYEE.EMP_NAME%TYPE;
    TEL EMPLOYEE.PHONE%TYPE;
    SAL EMPLOYEE.SALARY%TYPE;
BEGIN
    SELECT EMP_NAME, PHONE, SALARY INTO V_NAME, TEL, SAL
        FROM EMPLOYEE WHERE EMP_NAME=NAME;
    DBMS_OUTPUT.PUT_LINE('�̸� : '||V_NAME);
    DBMS_OUTPUT.PUT_LINE('��ȣ : '||TEL);
    DBMS_OUTPUT.PUT_LINE('�޿� : '||SAL);
END;
/
EXEC TEST_PRO4('������');

--��ȯ���� �ִ� ���ν���
CREATE OR REPLACE PROCEDURE TEST_PRO5(
    V_NAME OUT EMPLOYEE.EMP_NAME%TYPE,
    V_SAL OUT EMPLOYEE.SALARY%TYPE
    )
IS
BEGIN
    SELECT EMP_NAME, SALARY INTO V_NAME, V_SAL FROM EMPLOYEE
        WHERE EMP_ID='201';
    DBMS_OUTPUT.PUT_LINE('���ν���5 ����');
    DBMS_OUTPUT.PUT_LINE('�̸� : '||V_NAME);
    DBMS_OUTPUT.PUT_LINE('�޿� : '||V_SAL);
END;
/
--���ε� ����
    --��ȯ ���� �޾��� ����
    -- VAR[IABLE] <������> DATATYPE;
    --���ε� ������ �Ű������� �ڷ����� �ݵ�� ���ƾ���
VARIABLE VAR_NAME VARCHAR2(30);
VAR VAR_SAL NUMBER;
    --��ȯ�� ���� ������ �� ���ε� ���� ����
EXEC TEST_PRO5(:VAR_NAME, :VAR_SAL); 
--���ε� ���� �� Ȯ��
PRINT VAR_NAME;
PRINT VAR_SAL;
--���ν��� ����� ���ÿ� ��� ���ε� ������ ������ ���
SET AUTOPRINT ON;
EXEC TEST_PRO5(:VAR_NAME, :VAR_SAL);

--�Ű������� ��ȯ���� ��� �ִ� ���ν���
CREATE OR REPLACE PROCEDURE TEST_PRO6(
    V_ID IN EMPLOYEE.EMP_ID%TYPE,
    V_NAME OUT EMPLOYEE.EMP_NAME%TYPE,
    V_SAL OUT EMPLOYEE.SALARY%TYPE
    )
IS
BEGIN
    SELECT EMP_NAME, SALARY INTO V_NAME, V_SAL FROM EMPLOYEE
        WHERE EMP_ID=V_ID;
    DBMS_OUTPUT.PUT_LINE('���ν���6 ����');
    DBMS_OUTPUT.PUT_LINE('�̸� : '||V_NAME);
    DBMS_OUTPUT.PUT_LINE('�޿� : '||V_SAL);
END;
/
--���ε� ����
    --��ȯ ���� �޾��� ����
    -- VAR[IABLE] <������> DATATYPE;
    --���ε� ������ �Ű������� �ڷ����� �ݵ�� ���ƾ���
VARIABLE VAR_NAME VARCHAR2(30);
VAR VAR_SAL NUMBER;
    --��ȯ�� ���� ������ �� ���ε� ���� ����
EXEC TEST_PRO6('&���',:VAR_NAME, :VAR_SAL); 

SELECT * FROM USER_PROCEDURES;
SELECT * FROM USER_SOURCE;
SELECT * FROM USER_SOURCE WHERE NAME='TEST_PRO6';

/*
    ���ν��� ����
    DROP PROCEDURE <���ν��� ��>;
*/
DROP PROCEDURE TEST_PRO4;
SELECT * FROM USER_PROCEDURES;


--------------------------------------------------------------------------------
/*
    STORED FUNCTION(���� �Լ�)
    ���ν����� ��� �뵵�� ���� �����
    ���� ����� �ǵ��� ���� �� ����(RETURN ���� �����ϴ� ��ü)
    
    �Լ� ���� ���
        CREATE [OR REPLACE] FUNCTION <�Լ���>(<�Ű�������> DATATYPE [, ...])
        RETURN DATATYPE;
        IS
            �������� ����;
        BEGIN
            ������ ����;
            RETURN ��ȯ��;
        END;
        /
    �Լ� ���� ���
        1. EXEC <���ε庯����> := <�Լ���>(�Ű�����);
        2. �ٸ� SQL�� ���ο��� <�Լ���>(�Ű�����)
*/
--------------------------------------------------------------------------------
--�⺻ �Լ� ����
CREATE OR REPLACE FUNCTION TEST_FUNC1
    RETURN NUMBER
IS
BEGIN
    DBMS_OUTPUT.PUT_LINE('�Լ�1');
    RETURN 10;
END;
/
--�Լ� ��� Ȯ��
SELECT * FROM USER_PROCEDURES;
--�Լ� �� �ڵ� Ȯ��
SELECT * FROM USER_SOURCE;
--���ε� ����
VAR VAR_FUNC NUMBER;
--�Լ� ����1
EXEC :VAR_FUNC := TEST_FUNC1;
--�Լ� ����2 -���ν����� ��� �Ұ���
SELECT TEST_FUNC1 FROM DUAL;