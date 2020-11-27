--------------------------------------------------------------------------------
/*
    PL/SQL(PROCEDURAL LANGUAGE EXTENSION TO SQL)
     ����Ŭ ��ü�� ����� ������ ���
     SQL�� ������ �����Ͽ� SQL���� ������
     ������ ����, ����ó��, �ݺ�ó��, ����ó�� ���� ����
     
    PL/SQL�� ����
    1. �͸���(Anonymous Block)
        �̸����� ����̶� �Ҹ��� ������ block ����� ����
    2. ���ν���(Procedure)
        ������ Ư�� ó���� �����ϴ� ���� ���α׷��� �� ��������, 
        �ܵ����� ����ǰų� �ٸ� ���ν�����, �ٸ� ��(oracle developer, sqlplus,..)� 
        ȣ��Ǿ� �����
    3. �Լ�(Function)
        ���ν����� ����Ǵ� ����� �����ϳ� �� ��ȯ ���ο� ���� ���̰� ����
        �Լ��� ��ȯ���� ����
    
    PL/SQL ��� ����
        DECLARE
            �����;
        BEGIN
            �����;
        EXCEPTION
            ����ó����;
        END;
        /
    
    PL/SQL ����
        �����, �����, ����ó���η� ����
        DECLARE SECETION (�����) - ����
        -> ������ ����� �����ϴ� �κ�
        -> DECLARE �� ������
        
        EXCUTABLE SECTION (�����) - �ʼ�
        -> SQL��, ���, �ݺ���, �Լ� ���� �� ���� �ۼ�
        -> BEGIN ���� ������
        
        EXCEPTION SECITION (���� ó����) - ����
        -> ���� ���� �߻� �� �ذ��ϱ� ���� ���� �ۼ�
        -> EXCEPTION ���� ������
        
        END (�����) - �ʼ�
        -> �ϳ��� ����� �������� ����ϴ� �κ�
        -> END; �� ����
        
        / - �ʼ�
        -> PL/SQL ���� �� ����
        -> ������ ������ ��Ÿ���� ��ȣ
        -> �࿡ '/' �� ������ ����� ������ ����
        
    PL/SQL ���α׷� �ۼ� ���
        - PL/SQL ��� �������� �� ������ ������ ������ �����ݷ�(;) �� �����
        - END �ڿ� �����ݷ�(;)�� ����Ͽ� �ϳ��� ����� �����ٴ� ���� ���
        - PL/SQL ����� �ۼ��� �޸���� ���� �����⸦ ���ؼ� SQL���Ϸ� ������ ���� �ְ�,
            SQL*PLUS ������Ʈ���� �ٷ� �ۼ��� ���� ����
        - SQL*PLUS ȯ�濡���� DECLARE�� BEGIN �̶�� Ű����� PL/SQL ����� �������� �˼� ����
        - �������� �����ϱ� ���ؼ� /�� �Է��� �Ǿ�� �ϸ�, PL/SQL����� �࿡ /�� ������ ����� ������ ������
*/
--------------------------------------------------------------------------------
--PL/SQL �⺻ �׽�Ʈ
    --SEVEROUTPUT : ���ν����� ����Ͽ� ����ϴ� ������ ȭ�鿡 �����ֵ��� �����ϴ� ȯ�溯��
                    -- �⺻���� OFF���� ON���� ��������� ��
--���� ���ǿ��� ����ϵ��� ����
SET SERVEROUTPUT ON;
    --PUT_LINE : DAMS_OUTPUT ��Ű���� �����ִ� ���ν��� - ȭ�鿡 ������ִ� ���
BEGIN   --����� ����
    DBMS_OUTPUT.PUT_LINE('HELLO WORLD');
END;    --��� ����
/       --PL/SQL ���� ���ÿ� ����

BEGIN
    SELECT * FROM EMPLOYEE;
END;
/


--------------------------------------------------------------------------------
/*
    ����
    DECLARE(�����)�ȿ� ��������� ��
    
    ǥ���� : 
        <������> [CONSTANT] DATATYPE [NOT NULL] [:= <�ʱⰪ> | DEFAULT <�ʱⰪ>]
            CONSTANT    ����� ����(�ʱⰪ�� �ݵ�� �Ҵ��ؾ� ��)
            DATATYPE    �ڷ���
            NOT NULL    ���� �ݵ�� ����(NULL ��� �� ��)
            <�ʱⰪ>     ���ͷ�, �ٸ� ����, �����ڳ� �Լ��� �����ϴ� ǥ����
    
    - �⺻�ڷ���
        ������ : VARCHAR2(ũ��), BLOB, CLOB
        ������ : NUMBER
        ��¥�� : DATE
        ���� : BOOLEAN := TRUE, FALSE, NULL
    - �����ڷ���
        ���ڵ�(RECORD)
        �÷���(COLLECTION)
        
    ���� ����
        �Ϲ� ����(��Į�� ����), ���, %TYPE, %ROWTYPE, ���ڵ�(RECORD)���� ����
*/
--------------------------------------------------------------------------------

--------------------------------------------------------------------------------
/*
    �Ϲ� ����(��Į�� ����)
    ���� SQL �ڷ����� ������
    ǥ���� : <������> DATATYPE [:=�ʱⰪ]
*/
--------------------------------------------------------------------------------
--������ ����� �ʱ�ȭ, ������ ��� 1
DECLARE 
    EMP_ID NUMBER;
    EMP_NAME VARCHAR2(30);
BEGIN
    DBMS_OUTPUT.PUT_LINE('���� ��� �׽�Ʈ');
END;
/

DECLARE 
    EMP_ID NUMBER := 888;
    EMP_NAME VARCHAR2(30) := 'ȫ�浿';
BEGIN
    DBMS_OUTPUT.PUT_LINE('���� ��� �׽�Ʈ');
    DBMS_OUTPUT.PUT_LINE('1_EMP_ID �� : '||EMP_ID);  --|| : ���ڿ� ����
    DBMS_OUTPUT.PUT_LINE('1_EMP_NAME �� : '||EMP_NAME);
END;
/

--������ ����� �ʱ�ȭ, ������ ��� 2
DECLARE
    EMP_ID NUMBER DEFAULT 888;
    EMP_NAME VARCHAR2(20) DEFAULT 'ȫ�浿';
BEGIN
    DBMS_OUTPUT.PUT_LINE('���� ��� �׽�Ʈ');
    DBMS_OUTPUT.PUT_LINE('2_EMP_ID �� : '||EMP_ID);  --|| : ���ڿ� ����
    DBMS_OUTPUT.PUT_LINE('2_EMP_NAME �� : '||EMP_NAME);
END;
/

--������ ����� �ʱ�ȭ, ������ ��� 3 : ���� �� ����ο��� �� ����
DECLARE 
    EMP_ID NUMBER;
    EMP_NAME VARCHAR2(20);
BEGIN
    EMP_ID := 888;
    EMP_NAME := 'ȫ�浿';
    
    DBMS_OUTPUT.PUT_LINE('���� ��� �׽�Ʈ');
    DBMS_OUTPUT.PUT_LINE('3_EMP_ID �� : '||EMP_ID);  --|| : ���ڿ� ����
    DBMS_OUTPUT.PUT_LINE('3_EMP_NAME �� : '||EMP_NAME);
END;
/

--������ ����� �ʱ�ȭ, ������ ��� 4 : ���� �� ����ο��� �� ����
    --DEFAULT�δ� ����ο��� �� ���� �Ұ���
DECLARE 
    EMP_ID NUMBER;
    EMP_NAME VARCHAR2(20);
BEGIN
    EMP_ID DEFAULT 888; --����
    EMP_NAME DEFAULT 'ȫ�浿'; --����
    
    DBMS_OUTPUT.PUT_LINE('���� ��� �׽�Ʈ');
    DBMS_OUTPUT.PUT_LINE('3_EMP_ID �� : '||EMP_ID);  --|| : ���ڿ� ����
    DBMS_OUTPUT.PUT_LINE('3_EMP_NAME �� : '||EMP_NAME);
END;
/

--SELECT���� ��ȸ ����� ������ ����
    --ǥ���� : SELECT <�÷���, ...> INTO <������, ...> FROM <���̺��> WHERE <����>;
    --��ȸ�Ǵ� �÷� ������ ������ ����, �ڷ����� ��ġ�ؾ� ��
    --����� ��ȸ�Ǵ� ���� �ϳ��� ���� �� �ֵ��� ������ ����
--�������̺��� '������'�̶�� ������ EMP_ID ���� �����Ͽ� ID��� ����, �̸��� NAME�̶�� ������ �ְ� ���
DESC EMPLOYEE;
DECLARE 
    ID VARCHAR2(7);
    NAME VARCHAR(20);
BEGIN
    SELECT EMP_ID, EMP_NAME INTO ID, NAME
        FROM EMPLOYEE WHERE EMP_ID=200;
    DBMS_OUTPUT.PUT_LINE('���̵� : ' || ID);
    DBMS_OUTPUT.PUT_LINE('�̸� : ' || NAME);
END;
/

--------------------------------------------------------------------------------
/*
    ��ü ����
    ���� ���� ��Ÿ���� �۷ι� �Ǵ� ���ø����̼� ���� �ڸ� ǥ����
    ������ �̸� ������ �ʿ���� �Ͻ������� ���� �Է¹޾� �����ؼ� ���
    
    ��ü ������ ����� �� �ִ� ��ġ
        WHERE ����
        ORDER BY ��
        COLUMN ǥ����
        TABLE �̸�
        SELECT �� ��ü
    
    ���� : <��ü ���� ��ȣ> <������>
*/
--------------------------------------------------------------------------------
--��ü ���� ��ȣ Ȯ��
    --��ü ���� �⺻ ��ȣ : &
SHOW DEFINE;
--��ü ���� ������(�⺻���� ��������� �Ǿ� ����)
    --��Ȥ ' ' ���ڿ� ó�� �� &�� ����ϸ� ��ü ������ �ν��ؼ� ����� ��� �� �Ǵ� �������
    --��ü ���� ���� OFF �� ��� ����
SET DEFINE OFF;
SHOW DEFINE;
--��ü ���� ���
SET DEFINE ON;
SHOW DEFINE;
--��ü ���� ��ȣ ����
    --���� ���ǿ����� ����
    --��ü���� ������ ���� Ű�� �ٽ� &�� �ʱ�ȭ��
SET DEFINE $;
SHOW DEFINE;
--'&'��ȣ�� ��ü������ ���������, �տ� '\'�� ����ϸ� ESCAPEó��(���� �״�� �ν��ϵ��� ����)
SET ESCAPE ON;

--��ü ������ ���� �Է¹޾Ƽ� SELECT�� ��ȸ
DECLARE 
    ID VARCHAR2(7);
    NAME VARCHAR(20);
BEGIN
    SELECT EMP_ID, EMP_NAME INTO ID, NAME
        FROM EMPLOYEE WHERE EMP_NAME='&TMP_NAME';
    DBMS_OUTPUT.PUT_LINE('���̵� : ' || ID);
    DBMS_OUTPUT.PUT_LINE('�̸� : ' || NAME);
END;
/

--����ó��
    --���� ��ȸ�� �����Ͱ� ������ '�������� �ʴ� �����Դϴ�.' ��� ���ڿ� ���
DECLARE 
    ID VARCHAR2(7);
    NAME VARCHAR(20);
BEGIN
    SELECT EMP_ID, EMP_NAME INTO ID, NAME
        FROM EMPLOYEE WHERE EMP_NAME='&TMP_NAME';
    DBMS_OUTPUT.PUT_LINE('���̵� : ' || ID);
    DBMS_OUTPUT.PUT_LINE('�̸� : ' || NAME);
EXCEPTION
    WHEN NO_DATA_FOUND THEN 
        DBMS_OUTPUT.PUT_LINE('�������� �ʴ� �����Դϴ�.');
END;
/

    --����ó���ο��� ��ü ������ �Է¹��� �����͸� ����ϰ� ���� ���
        --�Ϲ� ������ ���� �� ��� ����
DECLARE 
    ID VARCHAR2(7);
    NAME VARCHAR(20);
BEGIN
    NAME := '&TMP_NAME';
    SELECT EMP_ID, EMP_NAME INTO ID, NAME
        FROM EMPLOYEE WHERE EMP_NAME=NAME;
    DBMS_OUTPUT.PUT_LINE('���̵� : ' || ID);
    DBMS_OUTPUT.PUT_LINE('�̸� : ' || NAME);
EXCEPTION
    WHEN NO_DATA_FOUND THEN 
        DBMS_OUTPUT.PUT_LINE(NAME||'�� �������� �ʴ� �����Դϴ�.');
END;
/

--------------------------------------------------------------------------------
/*
    ���
    �Ϲ� ������ �����ϳ� CONSTANT Ű���尡 �ڷ��� �տ� �ٰ�, ���� �� ���� �Ҵ��� �־�� ��
    ���� ���Ŀ��� �� ������ �Ұ���
    
    ǥ���� : <������> CONSTANT DATATYPE := <�ʱⰪ>;
*/
--------------------------------------------------------------------------------
DECLARE
    USER_NAME1 CONSTANT VARCHAR2(20) := 'ȫ�浿';
    USER_NAME2 VARCHAR2(20) := '��浿';
BEGIN
    DBMS_OUTPUT.PUT_LINE('NAME1 : ' || USER_NAME1);
    DBMS_OUTPUT.PUT_LINE('NAME2 : ' || USER_NAME2);
    --USER_NAME1 := 'ȫ����'; --����� ������ �� ���� �Ұ���
    USER_NAME2 := '�踻��';
     DBMS_OUTPUT.PUT_LINE('NAME1 : ' || USER_NAME1);
     DBMS_OUTPUT.PUT_LINE('NAME2 : ' || USER_NAME2);
END;
/

--------------------------------------------------------------------------------
/*
    ����(REFERENCE) ����
    ������ ����� �ٸ� ���� �Ǵ� ���̺��� �÷��� �ڷ����� ���߾� ������ �����ϴ� ���
    
    �������� ����
        %TYPE : �÷��� �������� ������ Ÿ�� ����
        %ROWTYPE : ���� �������� ������ ������ Ÿ���� ����
*/
--------------------------------------------------------------------------------
/*
    %TYPE �Ӽ��� ����� ���� ����
    ǥ���� : <������> <���̺��>.<�÷���>%TYPE
    
    ��� ��) 
        ID EMPLOYEE.EMP_ID%TYPE
        EMPLOYEE���̺��� EMP_ID�� ������ Ÿ������ ID��� �̸��� ������ ����
*/
--�������̺��� ����� �������� �̸��� ��ȸ�ؼ� NAME ������ ����
DECLARE
    NAME NUMBER;    --������ Ÿ���� ���� �ʾ� ���� �߻�
BEGIN
    SELECT EMP_NAME 
        INTO NAME 
        FROM EMPLOYEE 
        WHERE EMP_ID='&���';
END;
/
--%TYPE ���������� �̿��� ���� ����
DECLARE
    ID EMPLOYEE.EMP_ID%TYPE;
    NAME EMPLOYEE.EMP_NAME%TYPE;
BEGIN
    SELECT EMP_ID, EMP_NAME
        INTO ID, NAME
        FROM EMPLOYEE
        WHERE EMP_ID='&���';
    DBMS_OUTPUT.PUT_LINE('��� : '||ID);
    DBMS_OUTPUT.PUT_LINE('�̸� : '||NAME);
EXCEPTION
    WHEN NO_DATA_FOUND THEN
        DBMS_OUTPUT.PUT_LINE('��ȸ�� �����Ͱ� �����ϴ�.');
END;
/

/*
    %ROWTYPE �Ӽ��� ����� ���� ����
    %TYPE�� �����ϰ� ������ �������� Ÿ���� �ڵ����� ������ ��
    1���� �÷��� �ƴ϶� ���� ���� �÷��� �ڵ����� ������ �� ����
    
    ���� ���� ��� : <������> <���̺��>%ROWTYPE;
    ���� ��� ��� : <������>.<�÷���>;
    
    ��� ��)
        USERINFO EMPLOYEE%ROWTYPE;
            EMPLOYEE ���̺��� ��� �÷��� ���� ������ ������ USERINFO�� ����
        USERINFO.EMP_ID;
        USERINFO.EMP_NAME;
*/
DECLARE
    USERINFO EMPLOYEE%ROWTYPE;
BEGIN
    SELECT * INTO USERINFO FROM EMPLOYEE WHERE EMP_ID='&���';
    DBMS_OUTPUT.PUT_LINE('��� : ' || USERINFO.EMP_ID);
    DBMS_OUTPUT.PUT_LINE('�̸� : ' || USERINFO.EMP_NAME);
    DBMS_OUTPUT.PUT_LINE('�޿� : ' || USERINFO.SALARY);
    DBMS_OUTPUT.PUT_LINE('����ó : ' || USERINFO.PHONE);
    DBMS_OUTPUT.PUT_LINE('�̸��� : ' || USERINFO.EMAIL);
EXCEPTION
    WHEN NO_DATA_FOUND THEN
        DBMS_OUTPUT.PUT_LINE('���� ������ �����ϴ�.');
END;
/

--------------------------------------------------------------------------------
/*
    ���ڵ� ����
    ������ �÷��� ���� �����ؼ� ���
    %ROWTYPE�� ������ ���̺��� ��� �÷��� �ڵ����� ������
    Ư�� �÷��� �����ͼ� ����ϰ� ���� ��� ���ڵ� ������ ��� ����
    ������ �÷����� �����ؼ� �̸� ���ο� Ÿ���� �����س���, �ش� Ÿ������ ���� �����ؼ� ���
    
    Ÿ�� ���� ��� : TYPE <���ڵ� Ÿ�Ը�> IS RECORD(<������> <����Ÿ��>[, ...]);
    ���� ���� ��� : <������> <���ڵ� Ÿ�Ը�>;
*/
--------------------------------------------------------------------------------
--�������̺��� ���, �̸�, �μ�, ���޿� ���� ������ �����ͼ� ���
DECLARE
    --���ڵ� Ÿ�� ����
    TYPE USERINFO_TYPE IS RECORD(
        ID EMPLOYEE.EMP_ID%TYPE,
        NAME EMPLOYEE.EMP_NAME%TYPE,
        DEPT_NAME DEPARTMENT.DEPT_TITLE%TYPE,
        JOB_NAME JOB.JOB_NAME%TYPE
    );
    --���ǵ� ���ڵ� Ÿ���� �̿��ؼ� ���� ����
    USER USERINFO_TYPE;
BEGIN
    SELECT EMP_ID,EMP_NAME,DEPT_TITLE,JOB_NAME
        INTO USER
        FROM EMPLOYEE
        LEFT JOIN DEPARTMENT ON (DEPT_CODE=DEPT_ID)
        LEFT JOIN JOB USING (JOB_CODE)
        WHERE EMP_NAME='&�̸�';
    DBMS_OUTPUT.PUT_LINE('��� : ' || USER.ID);
    DBMS_OUTPUT.PUT_LINE('�̸� : ' || USER.NAME);
    DBMS_OUTPUT.PUT_LINE('�μ� : ' || USER.DEPT_NAME);
    DBMS_OUTPUT.PUT_LINE('���� : ' || USER.JOB_NAME);
EXCEPTION
    WHEN NO_DATA_FOUND THEN
        DBMS_OUTPUT.PUT_LINE('���� ������ �����ϴ�.');
END;
/


--------------------------------------------------------------------------------
/*
    ���ǹ�
    IF�� : ���ǿ� ���� ������ ������ ����
    ���� : 
        IF <����> THEN 
            ������ ������ ��� ó���� ����;
        END IF;
*/
--------------------------------------------------------------------------------
--�����ȣ�� �Է¹޾Ƽ� ����� ���, �̸�, �޿�, ���ʽ����� ���
    --���ʽ����� ������ '���ʽ��� ���޹��� �ʴ� ����Դϴ�.' ���
DECLARE
    ID EMPLOYEE.EMP_ID%TYPE;
    NAME EMPLOYEE.EMP_NAME%TYPE;
    SALARY EMPLOYEE.SALARY%TYPE;
    BONUS EMPLOYEE.BONUS%TYPE;
BEGIN
    SELECT EMP_ID, EMP_NAME, SALARY, NVL(BONUS,0)
        INTO ID, NAME, SALARY, BONUS
        FROM EMPLOYEE WHERE EMP_ID='&���';
    DBMS_OUTPUT.PUT_LINE('��� : '||ID);
    DBMS_OUTPUT.PUT_LINE('�̸� : '||NAME);
    DBMS_OUTPUT.PUT_LINE('�޿� : '||SALARY);
    IF(BONUS=0) THEN 
        DBMS_OUTPUT.PUT_LINE('���ʽ��� ���޹��� �ʴ� ����Դϴ�.');
    END IF;
    DBMS_OUTPUT.PUT_LINE('���ʽ��� : '||BONUS*100||'%');
EXCEPTION
    WHEN NO_DATA_FOUND THEN
        DBMS_OUTPUT.PUT_LINE('���� ������ ã�� �� �����ϴ�.');
END;
/

/*
    IF~ELSE��
    ���� : 
        IF <����> THEN
            ������ ������ ��� ó���� ����;
        ELSE
            ������ �������� ���� ��� ó���� ����;
        END IF;
*/
DECLARE
    ID EMPLOYEE.EMP_ID%TYPE;
    NAME EMPLOYEE.EMP_NAME%TYPE;
    SALARY EMPLOYEE.SALARY%TYPE;
    BONUS EMPLOYEE.BONUS%TYPE;
BEGIN
    SELECT EMP_ID, EMP_NAME, SALARY, NVL(BONUS,0)
        INTO ID, NAME, SALARY, BONUS
        FROM EMPLOYEE WHERE EMP_ID='&���';
    DBMS_OUTPUT.PUT_LINE('��� : '||ID);
    DBMS_OUTPUT.PUT_LINE('�̸� : '||NAME);
    DBMS_OUTPUT.PUT_LINE('�޿� : '||SALARY);
    IF(BONUS=0) THEN 
        DBMS_OUTPUT.PUT_LINE('���ʽ��� ���޹��� �ʴ� ����Դϴ�.');
    ELSE
        DBMS_OUTPUT.PUT_LINE('���ʽ��� : '||BONUS*100||'%');
    END IF;
EXCEPTION
    WHEN NO_DATA_FOUND THEN
        DBMS_OUTPUT.PUT_LINE('���� ������ ã�� �� �����ϴ�.');
END;
/

/*
    IF~ELSIF~ELSE ��
    ���� : 
        IF <����1> THEN
            ����1�� ������ ��� ó���� ����;
        ELSIF <����2> THEN
            ����2�� ������ ��� ó���� ����;
        ELSIF <����3> THEN
            ����3�� ������ ��� ó���� ����;
        ELSE
            ��� ������ �������� ���� ��� ó���� ����;
        END IF;
*/
--����� �Է¹޾Ƽ� ���, �̸�, �޿�, �޿� ��� ���
    /*  �޿� ���
        500���� �̻� A, 
        400���� �̻� B, 
        300���� �̻� C, 
        200���� �̻� D, 
        100���� �̻� E, 
        100���� �̸� F  */
DECLARE
    ID EMPLOYEE.EMP_ID%TYPE;
    NAME EMPLOYEE.EMP_NAME%TYPE;
    SALARY EMPLOYEE.SALARY%TYPE;
    SALGRADE VARCHAR(1);
BEGIN
    SELECT EMP_ID, EMP_NAME, SALARY 
        INTO ID, NAME, SALARY
        FROM EMPLOYEE 
        WHERE EMP_ID='&���';
    DBMS_OUTPUT.PUT_LINE('��� : ' || ID);
    DBMS_OUTPUT.PUT_LINE('�̸� : ' || NAME);
    DBMS_OUTPUT.PUT_LINE('�޿� : ' || SALARY);
    
    IF(SALARY >= 5000000) THEN
        SALGRADE := 'A';
    ELSIF (SALARY >= 4000000) THEN
        SALGRADE := 'B';
    ELSIF (SALARY >= 3000000) THEN
        SALGRADE := 'C';
    ELSIF (SALARY >= 2000000) THEN
        SALGRADE := 'D';
    ELSIF (SALARY >= 1000000) THEN
        SALGRADE := 'E';
    ELSE
        SALGRADE := 'F';
    END IF;
    DBMS_OUTPUT.PUT_LINE('�޿���� : '||SALGRADE);
EXCEPTION
    WHEN NO_DATA_FOUND THEN
        DBMS_OUTPUT.PUT_LINE('���� ������ �����ϴ�.');
END;
/

--------------------------------------------------------------------------------
/*
    ���ù� - CASE��
    �ڹ��� SWITCH���� ����
    
    ���� : 
        CASE <������>
            WHEN ���ǰ�1 THEN ���ǰ�1 �϶� ���๮;
            WHEN ���ǰ�2 THEN ���ǰ�2 �϶� ���๮;
            ELSE ��� ������ �ƴҶ� ���๮;
            END CASE;
*/
--------------------------------------------------------------------------------
--1~3������ ���� �Է¹ް� 
    --1�� �Է¹����� '1�Է�', 2�� �Է¹����� '2�Է�', 3�� �Է¹����� '3�Է�,
    --�� �ܿ��� �ٸ� '�ٸ� �Է�'
DECLARE
    INPUTVALUE NUMBER;
BEGIN
    INPUTVALUE := &�����Է�;
    CASE INPUTVALUE
        WHEN 1 THEN DBMS_OUTPUT.PUT_LINE('1�Է�');
        WHEN 2 THEN DBMS_OUTPUT.PUT_LINE('2�Է�');
        WHEN 3 THEN DBMS_OUTPUT.PUT_LINE('3�Է�');
        ELSE DBMS_OUTPUT.PUT_LINE('�ٸ� �Է� : ' || INPUTVALUE);
        END CASE;
END;
/

--����� �Է¹޾Ƽ� ���, �̸�, �޿�, �޿� ��� ���
    /*  �޿� ���
        500���� �̻� A, 
        400���� �̻� B, 
        300���� �̻� C, 
        200���� �̻� D, 
        100���� �̻� E, 
        100���� �̸� F  */
DECLARE
    ID EMPLOYEE.EMP_ID%TYPE;
    NAME EMPLOYEE.EMP_NAME%TYPE;
    SALARY EMPLOYEE.SALARY%TYPE;
    SALGRADE VARCHAR(1);
BEGIN
    SELECT EMP_ID, EMP_NAME, SALARY 
        INTO ID, NAME, SALARY
        FROM EMPLOYEE 
        WHERE EMP_ID='&���';
    DBMS_OUTPUT.PUT_LINE('��� : ' || ID);
    DBMS_OUTPUT.PUT_LINE('�̸� : ' || NAME);
    DBMS_OUTPUT.PUT_LINE('�޿� : ' || SALARY);
    
    CASE SALARY / 1000000 
        WHEN 0 THEN SALGRADE := 'F';
        WHEN 1 THEN SALGRADE := 'E';
        WHEN 2 THEN SALGRADE := 'D';
        WHEN 3 THEN SALGRADE := 'C';
        WHEN 4 THEN SALGRADE := 'B';
        ELSE SALGRADE := 'A';
    END CASE;
    DBMS_OUTPUT.PUT_LINE('�޿���� : '||SALGRADE);
EXCEPTION
    WHEN NO_DATA_FOUND THEN
        DBMS_OUTPUT.PUT_LINE('���� ������ �����ϴ�.');
END;
/

--------------------------------------------------------------------------------
/*
    �ݺ���
    1. BASIC LOOP : ���Ǿ��� ���� �ݺ�
        LOOP
            �ݺ��� ����;
        END LOOP;
    2. FOR LOOP : ī��Ʈ�� ������ �̿��� ���ϴ� Ƚ����ŭ �ݺ�
        FOR <ī��Ʈ�� ������> IN [REVERSE] <���ۼ�>..<���ᰪ> LOOP
            �ݺ��� ����;
        END LOOP;
*/
--------------------------------------------------------------------------------
--LOOP�� ���
DECLARE
    N NUMBER := 1;  --�ʱⰪ ����
BEGIN
    LOOP
        DBMS_OUTPUT.PUT_LINE('HELLO');
        N := N+1;
        IF N>5 THEN EXIT;
        END IF;
    END LOOP;
END;
/

--FOR LOOP��
    --FOR LOOP������ ���Ǵ� ī��Ʈ�� ������ �ڵ����� ����� - DECLARE���� ���� �� ���൵ ��
    --ī��Ʈ ���� �ڵ����� 1�� ������
BEGIN 
    FOR N IN 1..5 LOOP
        DBMS_OUTPUT.PUT_LINE(N);
    END LOOP;
END;
/

--FOR LOOP REVERSE
    --���ᰪ���� ���۰����� 1�� ����
BEGIN 
    FOR N IN REVERSE 1..5 LOOP
        DBMS_OUTPUT.PUT_LINE(N);
    END LOOP;
END;
/

SELECT COUNT(*) FROM EMPLOYEE;
--�������̺��� ��� ���� ������ ���
DECLARE
    TYPE USERINFO_TYPE IS RECORD (
        NO NUMBER,
        ID EMPLOYEE.EMP_ID%TYPE,
        NAME EMPLOYEE.EMP_NAME%TYPE,
        TEL EMPLOYEE.PHONE%TYPE,
        HIREDATE EMPLOYEE.HIRE_DATE%TYPE
    );
    USERINFO USERINFO_TYPE;
    CNT NUMBER;
    N NUMBER := 1;
BEGIN
    DBMS_OUTPUT.PUT_LINE('--------------- ������� ---------------');
    DBMS_OUTPUT.PUT_LINE('���    �̸�     ����ó          �Ի���');
    --���� ���̺��� �� ������ �˾ƿͼ� CNT������ ����
    SELECT COUNT(*) INTO CNT FROM EMPLOYEE;
    LOOP
        SELECT * INTO USERINFO FROM
            (SELECT ROWNUM AS NUM, EMP_ID, EMP_NAME, PHONE, HIRE_DATE FROM EMPLOYEE)
            WHERE NUM = N;
        DBMS_OUTPUT.PUT_LINE(USERINFO.ID||'    '||
                            USERINFO.NAME||'    '||
                            USERINFO.TEL||'   '||
                            USERINFO.HIREDATE);
        N := N+1;
        IF N > CNT THEN EXIT;
        END IF;
    END LOOP;
END;
/
--��ü ������ ��ȸ �� ���ȣ(ROWNUM) �ο�
SELECT ROWNUM, EMP_NO, EMP_NAME, PHONE, HIRE_DATE FROM EMPLOYEE;
--Ư�� ������ ��ȸ �� ������� ���ȣ(ROWNUM) �ο�
SELECT ROWNUM, EMP_NO, EMP_NAME, PHONE, HIRE_DATE FROM EMPLOYEE WHERE EMP_NAME LIKE '��%';
--Ư�� ��ġ�� �����͸� ��ȸ�ϱ�
    --��ü �����Ϳ� ������� ���ȣ(ROWNUM)�� �ٿ��� ���� ���̺� ���� �� �� ��ȣ�� ������ �����ؼ� ��ȸ
SELECT * FROM 
    (SELECT ROWNUM AS NUM, EMP_ID, EMP_NAME, PHONE, HIRE_DATE FROM EMPLOYEE)
    WHERE NUM = 2;
--������� Ư�� ������ �����͸� ��ȸ
SELECT ROWNUM, EMP_NO, EMP_NAME, PHONE, HIRE_DATE FROM EMPLOYEE WHERE ROWNUM<=3;
--���� �� �����Ϳ� ������ȣ �ű��
SELECT ROWNUM, EMP_ID, EMP_NAME, PHONE, HIRE_DATE FROM (SELECT * FROM EMPLOYEE ORDER BY EMP_NAME);

--�������̺��� ��� ���� ������ ���(FOR LOOP)
DECLARE
    TYPE USERINFO_TYPE IS RECORD (
        NO NUMBER,
        ID EMPLOYEE.EMP_ID%TYPE,
        NAME EMPLOYEE.EMP_NAME%TYPE,
        TEL EMPLOYEE.PHONE%TYPE,
        HIREDATE EMPLOYEE.HIRE_DATE%TYPE
    );
    USERINFO USERINFO_TYPE;
    CNT NUMBER;
BEGIN
    DBMS_OUTPUT.PUT_LINE('--------------- ������� ---------------');
    DBMS_OUTPUT.PUT_LINE('���    �̸�     ����ó          �Ի���');
    --���� ���̺��� �� ������ �˾ƿͼ� CNT������ ����
    SELECT COUNT(*) INTO CNT FROM EMPLOYEE;
    FOR N IN 1..CNT LOOP
        SELECT * INTO USERINFO FROM
            (SELECT ROWNUM AS NUM, EMP_ID, EMP_NAME, PHONE, HIRE_DATE FROM EMPLOYEE)
            WHERE NUM = N;
        DBMS_OUTPUT.PUT_LINE(USERINFO.ID||'    '||
                            USERINFO.NAME||'    '||
                            USERINFO.TEL||'   '||
                            USERINFO.HIREDATE);
    END LOOP;
END;
/

--�������̺��� ��� ���� ������ ���(LOOP ���2)
DECLARE
    TYPE USERINFO_TYPE IS RECORD (
        NO NUMBER,
        ID EMPLOYEE.EMP_ID%TYPE,
        NAME EMPLOYEE.EMP_NAME%TYPE,
        TEL EMPLOYEE.PHONE%TYPE,
        HIREDATE EMPLOYEE.HIRE_DATE%TYPE
    );
    USERINFO USERINFO_TYPE;
    N NUMBER := 1;
BEGIN
    DBMS_OUTPUT.PUT_LINE('--------------- ������� ---------------');
    DBMS_OUTPUT.PUT_LINE('���    �̸�     ����ó          �Ի���');
    LOOP
        SELECT * INTO USERINFO FROM
            (SELECT ROWNUM AS NUM, EMP_ID, EMP_NAME, PHONE, HIRE_DATE FROM EMPLOYEE)
            WHERE NUM = N;
        DBMS_OUTPUT.PUT_LINE(USERINFO.ID||'    '||
                            USERINFO.NAME||'    '||
                            USERINFO.TEL||'   '||
                            USERINFO.HIREDATE);
        N := N+1;
    END LOOP;
EXCEPTION
    WHEN NO_DATA_FOUND THEN
        DBMS_OUTPUT.PUT_LINE('--------------------------------------------');
END;
/