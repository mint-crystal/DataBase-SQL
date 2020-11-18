/*
    SELECT
    �����͸� ��ȸ�ϱ� ���� SQL��
    ��ȸ�� ����� ���̺� ���·� ��ȯ���� - RESULT SET
    ǥ���� : SELECT �÷��� [, �÷���, ...] FROM <���̺��> [WHERE ���ǽ�];
        -�÷� ���� ���ϴ� �÷��� ���ϴ� ������� (,)�� �����ؼ� ����
*/
--���̺� ��� ��ȸ
SELECT * FROM TABS;

--���̺� ���� : �÷� ���� Ȯ��
DESC EMPLOYEE;

--���� ���̺�(EMPLOYEE)���� ���̵�(EMP_ID), �̸�(EMP_NAME), ��ȭ��ȣ(PHONE)�� ��ȸ
SELECT EMP_ID, EMP_NAME, PHONE FROM EMPLOYEE;

--���� ���̺�(EMPLOYEE)���� ��� ������ ��ȸ
    -- * : ��� �÷�
SELECT * FROM EMPLOYEE;

--���� ���̺�(EMPLOYEE)���� �̸�, ��ȭ��ȣ, �̸��� ������� ��ȸ
SELECT EMP_NAME, PHONE, EMAIL FROM EMPLOYEE;

--���� ���̺�(EMPLOYEE)���� �̸��� '�����'�� ���ڵ�(��)�� ��ȸ
SELECT * FROM EMPLOYEE WHERE EMP_NAME='�����';

--���� ���̺�(EMPLOYEE)���� �����ڵ�(JOB_CODE)�� 'J3'�� ���ڵ带 ��ȸ
SELECT * FROM EMPLOYEE WHERE JOB_CODE='J3';

--�÷� �� ��� ���� : �÷� ���� ���� ��� ������ ��� �� ��ȸ ����
SELECT EMP_NAME, SALARY FROM EMPLOYEE;  --�̸��� �޿� ��ȸ
SELECT EMP_NAME, SALARY*5 FROM EMPLOYEE;    --�޿� �÷��� ���� �� ��� �� ��ȸ
SELECT EMP_NAME, SALARY, SALARY*BONUS, SALARY+(SALARY*BONUS) FROM EMPLOYEE;

--�÷� ��Ī : ��ȸ�� �÷��� ��Ī ������ �� �� ����
    --ǥ����1 : �÷��� AS ��Ī
    --ǥ����2 : �÷��� ��Ī
    SELECT EMP_NAME AS �̸�, SALARY �޿�, SALARY*BONUS ���ʽ�,  --AS ���� ����(�������� ����)
    SALARY+(SALARY*BONUS) AS "�� �޿�(��)" FROM EMPLOYEE;
    --����, Ư������, ���Ⱑ ���ԵǴ� ��� " " ���
    
--���ͷ� : ���Ƿ� ������ ���ڿ��� SELECT ������ ����ϸ� ���̺� �����ϴ� ������ó�� Ȱ�� ����
    -- ���ڳ� ��¥ ���ͷ��� ' ' ���
    -- ���ͷ��� RESULT SET�� ��� �࿡ �ݺ� ǥ�� ��
SELECT EMP_NAME, SALARY, '��' AS ���� FROM EMPLOYEE;
SELECT EMP_NAME, SALARY+10 FROM EMPLOYEE;   --10�� ���ͷ�

--�ߺ����� : DISTINCT
    --�÷��� ���Ե� ������ �� �ߺ� ���� �����ϰ� �� ������ ��ȸ�ϰ��� �� �� ���
    --�ϳ��� SELECT ������ 1���� ��� ����
SELECT JOB_CODE FROM EMPLOYEE;  --�ߺ� �� ��� ��ȸ
SELECT DISTINCT JOB_CODE FROM EMPLOYEE; --�ߺ� �� ���� ��ȸ
SELECT DISTINCT JOB_CODE, DISTINCT DEPT_CODE FROM EMPLOYEE; --���� �߻�
SELECT DISTINCT JOB_CODE, DEPT_CODE FROM EMPLOYEE;  --���� �÷��� ��� �ߺ� �� ����
    --JOB_CODE�� DEPT_CODE�� ��� ������ ���� �ߺ����� ó��

--------------------------------------------------------------------------------

/*
    WHERE �� : �˻��� �÷��� ������ �����Ͽ� �� ����
    ���̺��� ������ �����ϴ� ���� ���� ���� ���
    ���� ���� ������ �����ϴ� ���� ��� ���� AND Ȥ�� OR�� ����� �� ����
*/

--�μ��ڵ尡 'D9'�� ������ �̸�, �μ��ڵ� ��ȸ
SELECT EMP_NAME, DEPT_CODE FROM EMPLOYEE WHERE DEPT_CODE='D9';

--�޿��� 4000000���� ���� ���� �̸��� �޿� ��ȸ
SELECT EMP_NAME, SALARY FROM EMPLOYEE WHERE SALARY>=4000000;

--------------------------------------------------------------------------------

/*
    �� ������
    ���� ���� ���� ���� ����� �ϳ��� �� ����� ����� ��
    ������ ���� �� �����ؼ� ��ȸ�ϰ� ���� ��� ���
        AND, OR
    ���ǰ� �ݴ��� ����� ��ȸ�ϰ� ���� ���
        NOT
*/
-- �μ��ڵ尡 'D6'�̰�, �޿��� 2000000 ���� ���� �޴� ������ �̸�, �μ��ڵ�, �޿� ��ȸ
SELECT EMP_NAME, DEPT_CODE, SALARY FROM EMPLOYEE
    WHERE DEPT_CODE = 'D6' AND SALARY >= 2000000;
---- �μ��ڵ尡 'D6'�̰ų�, �޿��� 2000000 ���� ���� �޴� ������ �̸�, �μ��ڵ�, �޿� ��ȸ
SELECT EMP_NAME, DEPT_CODE, SALARY FROM EMPLOYEE
    WHERE DEPT_CODE = 'D6' OR SALARY >= 2000000;
---- �μ��ڵ尡 'D6'�� �ƴϰ�, �޿��� 2000000 �̸� �޴� ������ �̸�, �μ��ڵ�, �޿� ��ȸ
SELECT EMP_NAME, DEPT_CODE, SALARY FROM EMPLOYEE
    WHERE DEPT_CODE != 'D6' AND SALARY < 2000000;
    --�Ǵ�
SELECT EMP_NAME, DEPT_CODE, SALARY FROM EMPLOYEE
    WHERE NOT DEPT_CODE = 'D6' AND NOT SALARY >= 2000000;
    --DEPT_CODE�� D6�� �ƴϰ�, SALARY�� 2000000 �̻��� �ƴ� ������
SELECT EMP_NAME, DEPT_CODE, SALARY FROM EMPLOYEE
    WHERE NOT (DEPT_CODE = 'D6' AND NOT SALARY >= 2000000);
    --DEPT_CODE�� D6�̰ų� SALARY�� 2000000 �̻��� �ƴ� ������
SELECT EMP_NAME, DEPT_CODE, SALARY FROM EMPLOYEE
    WHERE NOT (DEPT_CODE = 'D6' OR SALARY >= 2000000);
    --DEPT_CODE�� D6�̰� SALARY�� 2000000 �̻��� �ƴ� ������
    
--------------------------------------------------------------------------------

/*
    ���� ������
    ���� �÷��� �ϳ��� �÷��� ��ó�� �����ϰų� �÷��� ���ͷ��� ������
    ORACLE : ||
    MYSQL : +
    MSSQL : (����)
*/

--�÷��� �÷��� ������ ���
SELECT EMP_NAME, EMP_ID || DEPT_CODE || JOB_CODE FROM EMPLOYEE;
SELECT EMP_NAME, EMP_ID || DEPT_CODE || JOB_CODE AS ����ĺ���ȣ FROM EMPLOYEE;

--�÷��� ���ͷ��� ������ ���
SELECT EMP_NAME || '���� ������ ' || SALARY || '�� �Դϴ�' FROM EMPLOYEE;

--------------------------------------------------------------------------------

/*
    �� ������
    ǥ���� ������ ���踦 ���ϱ� ���� ���
    �� ����� �� ��(TRUE/FALSE/NULL) �� �ϳ��� ��
    ��, ���ϴ� �� ���� ������ ������ Ÿ���̾�� ��
    �ֿ� �� ������ : = , > , < , >= , <= , <> ,!= , ^= .
                    BETWEEN AND, LIKE, NOT LIKE, IS NOT NULL, IN, NOT IN 
*/

--'���� �ʴ�' �� ��� 3����
SELECT EMP_ID, EMP_NAME, DEPT_CODE FROM EMPLOYEE WHERE DEPT_CODE != 'D9';
SELECT EMP_ID, EMP_NAME, DEPT_CODE FROM EMPLOYEE WHERE DEPT_CODE ^= 'D9';
SELECT EMP_ID, EMP_NAME, DEPT_CODE FROM EMPLOYEE WHERE DEPT_CODE <> 'D9';

--BETWEEN AND : ���Ϸ��� ���� ������ ������ ���ԵǸ� TRUE�� ����
        --������ ���Ѱ��� ���Ѱ��� ��赵 ���Ե�( >= , <= )
    --�޿��� 350������ ���� �ް� 600������ ���� �޴� ������ �̸��� �޿� ��ȸ
SELECT EMP_NAME, SALARY FROM EMPLOYEE WHERE SALARY>=3500000 AND SALARY<=6000000;
    --�Ǵ�
SELECT EMP_NAME, SALARY FROM EMPLOYEE WHERE SALSRY BETWEEN 3500000 AND 6000000;
    --�޿��� 350�� �̸�, �Ǵ� 600���� �ʰ��ϴ� ������ �̸��� �޿� ��ȸ
SELECT EMP_NAME, SALARY FROM EMPLOYEE WHERE SALARY<3500000 OR SALARY>6000000;
    --�Ǵ�
    SELECT EMP_NAME, SALARY FROM EMPLOYEE WHERE SALARY NOT BETWEEN 3500000 AND 6000000;
    --NOT �����ڴ� �÷��� �տ� �ٿ��� �ǰ� BETWEEN �տ� �ٿ��� ��;

--LIKE : ���Ϸ��� ���� ������ Ư�� ������ �����ϸ� TRUE ����
    --ǥ���� :  �÷��� LIKE '��������'
SELECT EMP_NAME, SALARY FROM EMPLOYEE WHERE EMP_NAME LIKE '������'; --�̸��� '������'�� ���� ��ȸ
SELECT EMP_NAME, SALARY FROM EMPLOYEE WHERE EMP_NAME LIKE '��'; --�̸��� '��'���� �����ϴ� ���� ��ȸ
        --'��'�� ��Ȯ�ϰ� ��ġ�ϴ� �����͸� ã�� ������ �ƹ��͵� ��ȸ �ȵ�
    --���ϵ�ī�幮�� ���
        --  % : ���� �� ������� ��� ���ڸ� �ǹ�
        --  _ : �� �ڸ��� ��� ���ڸ� �ǹ�
SELECT EMP_NAME, SALARY FROM EMPLOYEE WHERE EMP_NAME LIKE '��%'; --�̸��� '��'���� �����ϴ� ���� ��ȸ
SELECT EMP_NAME, SALARY FROM EMPLOYEE WHERE EMP_NAME LIKE '��__'; --�̸��� '��'���� �����ϴ� ���� ��ȸ
                                                        --  _ 2��
--�ֹε�Ϲ�ȣ 8��° �ڸ��� 1�� ���� ��ȸ(�������� ��ȸ)
SELECT EMP_NAME, EMP_NO FROM EMPLOYEE WHERE EMP_NO LIKE '_______1%'; 

/*
    ���ϵ�ī�� ���ڿ� ã�����ϴ� ������ ���ڰ� ������ ���,
    � ���� �������� �����ϴ��� ������ �� ��(%, _���ڸ� ã�� ���� ��)
    �����ͷ� ó���� ���ϵ� ī�� ���� �տ� ������ Ư�����ڸ� ����ϰ� ESCAPE OPTION���� ����ؼ� ó��
*/
--EMAIL�� 4��° �ڸ��� _ ���ڰ� ���� ���� �̸�, �̸��� ��ȸ
     --4��° _�� ���ڰ� �ƴ� ���ϵ�ī��� �ν��Ͽ� ��� ������ ��ȸ
SELECT EMP_NAME, EMAIL FROM EMPLOYEE WHERE EMAIL LIKE '____%'; 
    --# �ڿ� ���� ���ϵ�ī��� ���� �״�� �ν��ؼ� ��ȸ(@�� $���� �ٸ� Ư�����ڵ� ����)
SELECT EMP_NAME, EMAIL FROM EMPLOYEE WHERE EMAIL LIKE '___#_%' ESCAPE '#';

--NOT LIKE
    --'��'�� ���� �ƴ� ���� �̸�, �̸��� ��ȸ
SELECT EMP_NAME, EMAIL FROM EMPLOYEE WHERE EMP_NAME NOT LIKE '��%';

--IS NULL, IS NOT NULL : NULL ���θ� ���ϴ� ������
    --NULL �� ��ȸ : ���ʽ��� ���� ����
SELECT EMP_ID, EMP_NAME, SALARY, BONUS FROM EMPLOYEE WHERE BONUS IS NULL;
    --NULL�� �ƴ� �� ��ȸ : ���ʽ��� �ִ� ����
SELECT EMP_ID, EMP_NAME, SALARY, BONUS FROM EMPLOYEE WHERE BONUS IS NOT NULL;
    --�����ڵ� ����, �μ���ġ�� ���� ���� ���� ��ȸ
SELECT EMP_NAME, SALARY, BONUS, MANAGER_ID, DEPT_CODE FROM EMPLOYEE 
    WHERE MANAGER_ID IS NULL AND DEPT_CODE IS NULL;
    --�μ� ��ġ�� ���� �ʾ����� �������� ���޹޴� ���� ��ȸ
SELECT EMP_NAME, SALARY, BONUS, DEPT_CODE FROM EMPLOYEE 
    WHERE DEPT_CODE IS NULL AND BONUS IS NOT NULL;
    
-- IN : ���Ϸ��� �� ��Ͽ� ��ġ�ϴ� ���� ������ TRUE�� ��ȯ
    --D6 �μ��� D8 �μ������� �̸�, �μ��ڵ�, �޿� ��ȸ
SELECT EMP_NAME, DEPT_CODE, SALARY FROM EMPLOYEE WHERE DEPT_CODE = 'D6' OR DEPT_CODE = 'D8';
    --�Ǵ�
SELECT EMP_NAME, DEPT_CODE, SALARY FROM EMPLOYEE WHERE DEPT_CODE IN ('D6', 'D8');
--NOT IN : ��Ͽ� ���Ե��� �ʴ� ������ ��ȸ
     --D6 �μ��� D8 �μ������� ������ �μ������� �̸�, �μ��ڵ�, �޿� ��ȸ
SELECT EMP_NAME, DEPT_CODE, SALARY FROM EMPLOYEE WHERE DEPT_CODE NOT IN ('D6', 'D8');

/*
    ������ �켱 ����
    ���ǿ� ���� ���� �����ڰ� �� ��� ���� ����� ����  
    1. ��� ������
    2. ���� ������
    3. �� ������
    4. IS NULL / IS NOT NULL , LIKE , IN / NOT IN
    5. BETWEEN AND / NOT BETWEEN AND
    6. �� ������ ? NOT
    7. �� ������ ? AND
    8. �������� ? OR
*/

--------------------------------------------------------------------------------

--'J2' �Ǵ� 'J7' ���� �ڵ� �� �޿��� 200�� ���� ���� �޴� ���� �̸�, �޿�, �����ڵ� ��ȸ
    --������ �켱������ ���� AND ���� ����Ǿ� 200�� ���� ������ ��ȸ
SELECT EMP_NAME, SALARY, JOB_CODE FROM EMPLOYEE 
    WHERE JOB_CODE = 'J4' OR JOB_CODE = 'J7' AND SALARY>=2000000; 
    --OR ������ ���� ó���� �� �ֵ��� ( )���
SELECT EMP_NAME, SALARY, JOB_CODE FROM EMPLOYEE 
    WHERE (JOB_CODE = 'J4' OR JOB_CODE = 'J7') AND SALARY>=2000000; 
    --IN �����ڸ� ����� ��ȸ
SELECT EMP_NAME, SALARY, JOB_CODE FROM EMPLOYEE 
    WHERE JOB_CODE IN ('J4', 'J7') AND SALARY>=2000000;