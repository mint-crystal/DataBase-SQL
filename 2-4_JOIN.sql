-------------------------------------------------------
/*  JOIN
    �ڡڡڡڡڵ� �� �̻��� ���̺��� �������� ������ �ִ� �����͵��� ���� �����Ͽ�
                ���ο� ������ ���̺��� �̿��Ͽ� �����͸� ����ϴ� ����
    �� �� �̻��� ���̺��� �ϳ��� ���ļ� ����� ��ȸ
    �� �� �̻��� ���̺��� �÷����� �����ؼ� ���ο� ������ ���̺�� ��ȸ
*/
-------------------------------------------------------
-- ���� ���̺��� ���, �̸�, �μ��ڵ带 ��ȸ
SELECT EMP_ID, EMP_NAME, DEPT_CODE FROM EMPLOYEE;

-- �μ� ���̺��� �μ��ڵ�, �μ����� ��ȸ
SELECT DEPT_ID, DEPT_TITLE FROM DEPARTMENT;

-- ����Ŭ ���� ����(�Ͻ��� ����)
    -- JOIN Ű���带 ������� �ʰ�, ���� SELECT ���� �̿��ؼ� JOIN�� ������ ����� ��ȸ
    -- FROM���� �޸�(,)�� �����Ͽ� ��ġ�� ���� ���̺���� �߰��� ��� ����
    -- �� ���̺��� �÷����� �ٸ� ���
    SELECT EMP_ID, EMP_NAME, DEPT_CODE, DEPT_ID, DEPT_TITLE 
        FROM EMPLOYEE,DEPARTMENT WHERE DEPT_CODE = DEPT_ID;
    -- �� ���̺��� �÷����� ���� ���
    SELECT EMP_ID, EMP_NAME, EMPLOYEE.JOB_CODE, JOB.JOB_CODE, JOB_NAME
        FROM EMPLOYEE,JOB WHERE EMPLOYEE.JOB_CODE = JOB.JOB_CODE;
        -- ���̺� �̸��� ��Ī ����
    SELECT EMP_ID, EMP_NAME, E.JOB_CODE, J.JOB_CODE, JOB_NAME
        FROM EMPLOYEE E,JOB J WHERE E.JOB_CODE = J.JOB_CODE;
    DESC JOB;
    SELECT * FROM JOB;    
    DESC EMPLOYEE;
-- ANSI ǥ�ر���(����� ����)
    -- �� ���̺��� �÷����� �ٸ� ���
    SELECT EMP_ID, EMP_NAME, DEPT_CODE, DEPT_ID, DEPT_TITLE FROM EMPLOYEE
        JOIN DEPARTMENT ON (DEPT_CODE = DEPT_ID);
    -- �� ���̺��� �÷����� ���� ���
    SELECT EMP_ID, EMP_NAME, E.JOB_CODE, J.JOB_CODE, JOB_NAME FROM EMPLOYEE E
        JOIN JOB J ON (E.JOB_CODE = J.JOB_CODE);
        -- �Ǵ�
    SELECT EMP_ID, EMP_NAME, JOB_CODE, JOB_NAME FROM EMPLOYEE
        JOIN JOB USING(JOB_CODE);
        
/*
    �⺻������ JOIN�� INNER JOIN
    1. INNER JOIN : �� �� �̻��� ���̺��� ������ �� ��ġ�ϴ� ���� ���� ���� ���ο��� ���ܵ�
    2. OUTER JOIN : �� ���̺��� �����ϴ� �÷����� ��ġ���� �ʴ� �൵ ���ο� ������ ��Ŵ
                      �ݵ�� OUTER JOIN���� ����ؾ� �Ѵ�.
-- 2-1. LEFT OUTER JOIN : ��ġ�⿡ ����� �� ���̺� �� ���� ����� ���̺���
--                      �÷� ���� �������� JOIN
-- 2-2. RIGHT OUTER JOIN : ��ġ�⿡ ����� �� ���̺� �� ������ ����� ���̺���
--                       �÷� ���� �������� JOIN
-- 2-3. FULL OUTER JOIN : ��ġ�⿡ ����� �� ���̺��� ���� ��� ���� ����� ����    
*/

-- INNER JOIN
SELECT EMP_NAME, DEPT_TITLE, DEPT_CODE, DEPT_ID FROM EMPLOYEE
    JOIN DEPARTMENT ON (DEPT_CODE = DEPT_ID);
SELECT * FROM DEPARTMENT;

-- LEFT OUTER JOIN
-- ANSI ǥ��
SELECT EMP_NAME, DEPT_TITLE, DEPT_CODE, DEPT_ID FROM EMPLOYEE
    LEFT OUTER JOIN DEPARTMENT ON (DEPT_CODE = DEPT_ID);
-- ����Ŭ ���� ����
SELECT EMP_NAME, DEPT_TITLE, E.DEPT_CODE, D.DEPT_ID FROM EMPLOYEE E , DEPARTMENT D
    WHERE E.DEPT_CODE = D.DEPT_ID(+);
    -- �ƿ��� ������ �� ��� �÷��� "(+)" ��ȣ�� �ٿ��� ����
    
-- RIGHT OUTER JOIN
-- ANSI ǥ��
SELECT EMP_NAME, DEPT_TITLE, DEPT_CODE, DEPT_ID FROM EMPLOYEE
    RIGHT OUTER JOIN DEPARTMENT ON (DEPT_CODE = DEPT_ID);
-- ����Ŭ ���� ����
SELECT EMP_NAME, DEPT_TITLE, E.DEPT_CODE, D.DEPT_ID FROM EMPLOYEE E , DEPARTMENT D
    WHERE E.DEPT_CODE(+) = D.DEPT_ID;
    -- �ƿ��� ������ �� ��� �÷��� "(+)" ��ȣ�� �ٿ��� ����
    
-- FULL OUTER JOIN
-- ANSI ǥ��
SELECT EMP_NAME, DEPT_TITLE, DEPT_CODE, DEPT_ID FROM EMPLOYEE
    FULL OUTER JOIN DEPARTMENT ON (DEPT_CODE = DEPT_ID);
-- ����Ŭ ���� ����
SELECT EMP_NAME, DEPT_TITLE, E.DEPT_CODE, D.DEPT_ID FROM EMPLOYEE E , DEPARTMENT D
    WHERE E.DEPT_CODE(+) = D.DEPT_ID(+);
    -- FULL OUTER JOIN �� ����Ŭ ���� �������� ��� �Ұ���
    
-- CROSS JOIN : ī�׽þȰ�(CARTESIAN PRODUCT)
    -- ���εǴ� ���̺��� �� ����� ��� ���ε� �����Ͱ� �˻��Ǵ� ���
    -- �� ��ȸ�Ǵ� ���ڵ�(ROW) ���� : �� ���̺� ���ڵ�(ROW) ���� * �� ���̺� ���ڵ�(ROW) ����
-- ANSI ǥ��
SELECT EMP_NAME, DEPT_TITLE, DEPT_CODE, DEPT_ID FROM EMPLOYEE
    CROSS JOIN DEPARTMENT;
-- ����Ŭ ���� ����
SELECT EMP_NAME, DEPT_TITLE, DEPT_CODE, DEPT_ID FROM EMPLOYEE,DEPARTMENT;

-- NON EQUAL JOIN(NON_EQU JOIN �̶�� ��)
    -- ������ �÷� ���� ��ġ�ϴ� ��찡 �ƴ�, ���� ������ ���ԵǴ� ����� �����ϴ� ���
SELECT EMP_NAME, SALARY, E.SAL_LEVEL, S.SAL_LEVEL FROM EMPLOYEE E
    JOIN SAL_GRADE S ON(SALARY BETWEEN MIN_SAL AND MAX_SAL);
SELECT EMP_NAME, SALARY, E.SAL_LEVEL, S.SAL_LEVEL FROM EMPLOYEE E
    JOIN SAL_GRADE S ON(E.SAL_LEVEL = S.SAL_LEVEL);
    
-- SELF JOIN 
    -- �� �� �̻��� ���� �ٸ� ���̺��� �����ϴ� ���� �ƴ� ���� ���̺��� �����ϴ� ��
-- ANSI ǥ��
SELECT E.EMP_ID, E.EMP_NAME, E.DEPT_CODE, E.MANAGER_ID, M.EMP_NAME 
    FROM EMPLOYEE E
    JOIN EMPLOYEE M ON(E.MANAGER_ID = M.EMP_ID);
-- ����Ŭ ����
SELECT E.EMP_ID, E.EMP_NAME, E.DEPT_CODE, E.MANAGER_ID, M.EMP_NAME 
    FROM EMPLOYEE E, EMPLOYEE M
    WHERE E.MANAGER_ID = M.EMP_ID;
    
-- ���� JOIN : N���� ���̺��� ��ȸ�� �� ���
-- ANSI ǥ��
SELECT * FROM EMPLOYEE;
SELECT EMP_NAME, DEPT_CODE, DEPT_TITLE, JOB_CODE, JOB_NAME FROM EMPLOYEE E
    LEFT OUTER JOIN DEPARTMENT ON (DEPT_CODE = DEPT_ID)
    LEFT OUTER JOIN JOB USING(JOB_CODE);
-- ����Ŭ ����
SELECT EMP_NAME, DEPT_CODE, DEPT_TITLE, E.JOB_CODE, JOB_NAME 
    FROM EMPLOYEE E, DEPARTMENT D, JOB J
    WHERE DEPT_CODE = DEPT_ID(+) AND E.JOB_CODE = J.JOB_CODE(+);
    
-- ���� ���� ��� �� ���� ����
    -- ���� ������ ��� ���� ������ �߿�!!
SELECT EMP_NAME, DEPT_CODE, DEPT_TITLE, LOCATION_ID, LOCAL_NAME
    FROM EMPLOYEE
    JOIN DEPARTMENT ON(DEPT_CODE = DEPT_ID)
    JOIN LOCATION ON(LOCATION_ID = LOCAL_CODE);
    
SELECT EMP_NAME, DEPT_CODE, DEPT_TITLE, LOCATION_ID, LOCAL_NAME
    FROM EMPLOYEE , DEPARTMENT , LOCATION
    WHERE DEPT_CODE = DEPT_ID AND LOCATION_ID = LOCAL_CODE;