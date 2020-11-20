-----------------------------------------------------
/*  ORDER BY
    ���̺� �� ��ȸ�� �����͸� ����� �÷��� �������� ����
    SELECT ������ ���� �������� �ۼ��ϸ�, ���� ���� ���� ���� �������� �����
    
    ǥ���� : ORDER BY <�÷���|��Ī|�÷�����> [���Ĺ��] [NULLS FIRST|LAST]
        ���Ĺ�� : ASC(�⺻��) - ��������, DESC - ��������
        NULLS : NULL ���� ���� ���� ������ ��������, ���� ū������ �������� ���� ����
            FIRST : ���� ���� ������ �ν�
            LAST(�⺻��) : ���� ū ������ �ν�
*/
-----------------------------------------------------
-- �׳� ��ȸ : ���� ���̺��� �����ȣ,�̸�,�μ��ڵ�,�����ڵ带 ��ȸ
SELECT EMP_ID, EMP_NAME, DEPT_CODE, JOB_CODE FROM EMPLOYEE;
-- �μ��ڵ带 �������� ����(�⺻ ��������)
SELECT EMP_ID, EMP_NAME, DEPT_CODE, JOB_CODE FROM EMPLOYEE
    ORDER BY DEPT_CODE; -- ASC ���� ����
-- �μ��ڵ带 �������� �������� ����
SELECT EMP_ID, EMP_NAME, DEPT_CODE, JOB_CODE FROM EMPLOYEE
    ORDER BY DEPT_CODE DESC;
-- �μ��ڵ带 �������� ���� �� �����ڵ带 �������� �߰� ����
SELECT EMP_ID, EMP_NAME, DEPT_CODE, JOB_CODE FROM EMPLOYEE
    ORDER BY DEPT_CODE,JOB_CODE;
-- ��Ī���� ����
SELECT EMP_ID �����ȣ, EMP_NAME �̸�, DEPT_CODE �μ��ڵ�, JOB_CODE �����ڵ�
    FROM EMPLOYEE ORDER BY �̸�;
-- �÷� �������� ����
SELECT EMP_ID, EMP_NAME, DEPT_CODE, JOB_CODE FROM EMPLOYEE
    ORDER BY 3;
-- NULL ���� ���� ó������ ����(�⺻���� ���� �������� ���� - LAST)
SELECT EMP_ID, EMP_NAME, DEPT_CODE, JOB_CODE FROM EMPLOYEE
    ORDER BY 3 NULLS FIRST;

-----------------------------------------------------
/*  GROUP BY
    ������ �÷��� �������� �����͸� �׷���
    �׷��Լ��� �� �Ѱ��� ��� ���� �����ϱ� �빮�� �׷��� ���� ���� ��� ���� �߻�
        ���� ���� ��� ���� �����ϱ� ���� �׷��Լ��� ����� �׷��� ������ GROUP BY���� ����Ͽ� ���
    �������� ���� ��� �ϳ��� ó���� �������� �����    
    ǥ���� : GROUP BY <�׷��� ���� �÷���>
*/
-----------------------------------------------------
SELECT * FROM EMPLOYEE;
-- ������ �� �޿�
SELECT SUM(SALARY) FROM EMPLOYEE;
-- �� �μ��� ������ �� �޿�
    -- �μ� �ڵ带 �������� �׷� ��� �� �׷��� �޿� �հ� ��ȸ
SELECT DEPT_CODE, SUM(SALARY) FROM EMPLOYEE;    -- ���� �߻�
SELECT DEPT_CODE, SUM(SALARY) FROM EMPLOYEE 
    GROUP BY DEPT_CODE ORDER BY DEPT_CODE;
-- �μ��� �� �޿��� ��� �޿� ��ȸ
SELECT DEPT_CODE, SUM(SALARY) �ѱ޿�, AVG(SALARY) ��ձ޿� FROM EMPLOYEE 
    GROUP BY DEPT_CODE ORDER BY DEPT_CODE;

-- �μ��� ����� ��ȸ
SELECT DEPT_CODE �μ��ڵ�, COUNT(*) ����� FROM EMPLOYEE 
    GROUP BY DEPT_CODE;
    
-----------------------------------------------------
/*  HAVING
    �׷��Լ��� ���� ���ؿ� �׷쿡 ���� ������ ���� �� �� ���
    (WHERE ���� SELECT�� ���� ����)
    ǥ���� : HAVING <�÷���|�׷��Լ���> �񱳿����� �񱳰�
*/
-----------------------------------------------------
-- �μ��� �޿� �հ� �� 1000���� �̻��� �μ��� ��ȸ
SELECT DEPT_CODE, SUM(SALARY) FROM EMPLOYEE 
    GROUP BY DEPT_CODE HAVING SUM(SALARY) >= 10000000;

/*  SELECT �� ���� ����
    5 : SELECT �÷���
    1 : FROM ���̺��
    2 : WHERE ����
    3 : GROUP BY �׷� ���� �÷���
    4 : HAVING �׷쿡 ���� ����
    6 : ORDER BY ������ ���� �÷���
*/

-----------------------------------------------------
/*  �����Լ�
    GROUP BY �������� ����ϴ� �Լ�
    �׷캰 ������ ��� ���� ���踦 ����ϴ� �Լ�
    -- ROLLUP �Լ� : �׷캰�� �߰� ���� ó���� �ϴ� �Լ�
        -- �׷캰�� ������ ���� ���� �߰� ����� �� ���踦 ���� �� ���
        -- �׷��Լ��� ���� ������鿡 ���� �� ���谡 �ڵ����� �߰���
    -- CUBE �Լ� : �׷캰 ������ ����� �����ϴ� �Լ�
        -- ���ڷ� ������ �׷��� ������ ��� ���� ���� ������ ����� ��ȯ
*/
-----------------------------------------------------
-- �����ڵ庰�� �޿� �հ� �ݾ��� ��ȸ
SELECT JOB_CODE, SUM(SALARY) FROM EMPLOYEE
    GROUP BY JOB_CODE ORDER BY 1;
    
-- �����ڵ庰�� �޿� �հ� �ݾ��� ��ȸ�ϰ� �������� �� �հ� ��ȸ
SELECT JOB_CODE, SUM(SALARY) FROM EMPLOYEE
    GROUP BY ROLLUP(JOB_CODE) ORDER BY 1;
    
SELECT JOB_CODE, SUM(SALARY) FROM EMPLOYEE
    GROUP BY CUBE(JOB_CODE) ORDER BY 1;
    
SELECT SUM(SALARY) FROM EMPLOYEE;   -- �� �հ谪 ��ȸ�غ���

-- �����ڵ庰�� �޿� ��� �ݾ��� ��ȸ�ϰ� �������� ��ü ��� ��ȸ
SELECT JOB_CODE, AVG(SALARY) FROM EMPLOYEE
    GROUP BY ROLLUP(JOB_CODE) ORDER BY 1;
SELECT JOB_CODE, AVG(SALARY) FROM EMPLOYEE
    GROUP BY CUBE(JOB_CODE) ORDER BY 1;
    
SELECT AVG(SALARY) FROM EMPLOYEE;   -- ��ü ��� ��ȸ�غ���

-- �� �μ� �� ���� ���� �׷� �����ؼ� �޿� ��ȸ
SELECT DEPT_CODE, JOB_CODE, SUM(SALARY) FROM EMPLOYEE
    GROUP BY DEPT_CODE, JOB_CODE ORDER BY 1;
    
-- �� �μ� �� ���� ���� �׷� �����ؼ� �޿� ��ȸ�ϰ� �μ��� �� �޿�, ��ü �� �޿��� ���� ��ȸ
    -- �μ��ڵ�+�����ڵ忡 ���� �޿� �հ� (GROUP BY)
    -- �μ��ڵ忡���� �޿� �հ� (ROLLUP���� �ڵ� ����)
    -- �� �޿� �հ� �� ���� ���� ��� ��ȯ (ROLLUP���� �ڵ� ����)
SELECT DEPT_CODE, JOB_CODE, SUM(SALARY) FROM EMPLOYEE
    GROUP BY ROLLUP(DEPT_CODE, JOB_CODE) ORDER BY 1;
    
-- ���ڷ� ������ �׷��� ������ ��� ���� �� ���� ����� ��ȯ
    -- �μ��ڵ�+�����ڵ忡 ���� �޿� �հ�
    -- �μ��ڵ忡 ���� �޿� �հ�
    -- �����ڵ忡 ���� �޿� �հ�
    -- �� �޿� �հ�
SELECT DEPT_CODE, JOB_CODE, SUM(SALARY) FROM EMPLOYEE
    GROUP BY CUBE(DEPT_CODE, JOB_CODE) ORDER BY 1;
    
-- GROUPING �Լ�
    -- �� ���ڵ�(ROW)�� ��� ���տ� ���� ��ȸ�� ����������,
    -- ROLLUP�̳� CUBE�� ���ؼ� ����� ���������� �����ϴ� �Լ�
    -- ���ڷ� ���޹��� �÷��� ���� ���⹰�̸� 1, �ƴϸ� 0�� ��ȯ
SELECT DEPT_CODE, JOB_CODE, SUM(SALARY), 
    GROUPING(DEPT_CODE) �μ������λ���, 
    GROUPING(JOB_CODE) ���޺����λ���
    FROM EMPLOYEE
    GROUP BY CUBE(DEPT_CODE, JOB_CODE) ORDER BY 1;

SELECT DEPT_CODE, JOB_CODE, SUM(SALARY),
    CASE WHEN GROUPING(DEPT_CODE) = 0 AND GROUPING(JOB_CODE) = 1
        THEN '�μ��� ����'
        WHEN GROUPING(DEPT_CODE) = 1 AND GROUPING(JOB_CODE) = 0
        THEN '���޺� ����'
        WHEN GROUPING(DEPT_CODE) = 0 AND GROUPING(JOB_CODE) = 0
        THEN '�׷캰 ����'
        ELSE '���հ�'
    END AS ���� FROM EMPLOYEE GROUP BY CUBE(DEPT_CODE, JOB_CODE) ORDER BY 1;


SELECT CASE WHEN GROUPING(DEPT_CODE) = 0 AND GROUPING(JOB_CODE) = 1
        THEN DEPT_CODE
        WHEN GROUPING(DEPT_CODE) = 1 AND GROUPING(JOB_CODE) = 0
        THEN '���޺� ����'
        WHEN GROUPING(DEPT_CODE) = 0 AND GROUPING(JOB_CODE) = 0
        THEN DEPT_CODE
        ELSE '���հ�'
    END AS �μ��ڵ�,
    CASE WHEN GROUPING(DEPT_CODE) = 0 AND GROUPING(JOB_CODE) = 1
        THEN '�μ��� ����'
        WHEN GROUPING(DEPT_CODE) = 1 AND GROUPING(JOB_CODE) = 0
        THEN JOB_CODE
        WHEN GROUPING(DEPT_CODE) = 0 AND GROUPING(JOB_CODE) = 0
        THEN JOB_CODE
        ELSE '���հ�'
    END AS �����ڵ�,
    SUM(SALARY) 
    FROM EMPLOYEE GROUP BY CUBE(DEPT_CODE, JOB_CODE) ORDER BY 1;
    
-----------------------------------------------------
/*  ���տ�����(SET OPERATOR)
    ���� ���� SELECT ������� �ϳ��� ������ ����� ������
    UNION : ���� ���� ���� ����� ��ġ�� �����ڷ� �ߺ��� ������ �����Ͽ� ��ħ(������)
    UNION ALL : ���� ���� ���� ����� ��ġ�� �����ڷ� �ߺ��� ���� ��� �����Ͽ� ��ħ
    INTERSECT : ���� ���� ���� ������� ����� �κи� ����� ����(������)
    MINUS : ���� SELECT ������� ���� SELECT ����� ��ġ�� �κ��� ������ ������ �κ� ����(������)

    ���� : 
    1. ���� SELECT���� ��ȸ�� �÷� ������ 
            ���� SELECT���� ��ȸ�� �÷� ������ �ݵ�� ��ġ�ؾ� ��
    2. ���� SELECT���� ��ȸ�� �÷� ������ Ÿ�԰� 
            ���� SELECT���� ��ȸ�� �÷� ������ Ÿ���� �ݵ�� ��ġ�ؾ� ��
*/
-----------------------------------------------------
DESC EMPLOYEE;
-- UNION 
-- �������̺� ��ȸ�� ��� �Ʒ��κп� �ι�° SELECT ������ ��ȸ�� ��� ���� ��ȸ ��
SELECT EMP_ID, EMP_NAME, DEPT_CODE, SALARY FROM EMPLOYEE
UNION
SELECT 'A','B','C',10 FROM DUAL;

-- �������̺��� ��ȸ�� ����� �ߺ��� ���� ���� ��
SELECT EMP_ID, EMP_NAME, DEPT_CODE, SALARY FROM EMPLOYEE
UNION
SELECT '200','������','D9',8000000 FROM DUAL;

-- UNION ALL
-- �������̺� ��ȸ�� ��� �Ʒ��κп� �ι�° SELECT ������ ��ȸ�� ��� ���� ��ȸ ��
Select Emp_Id, Emp_Name, Dept_Code, Salary From Employee
Union All
Select 'A','B','C',10 From Dual;

-- �������̺��� ��ȸ�� ����� �ߺ��� ���� ���� ��ȸ ��
Select Emp_Id, Emp_Name, Dept_Code, Salary From Employee
Union All
Select '200','������','D9',8000000 From Dual;

-- INTERSECT : �������� SELECT �� ������� ���� �κи� ����� ����(������)
-- �������̺� ��ȸ�� ��� �Ʒ��κп� �ι�° SELECT ������ ��ȸ�� ��� ���� ��ȸ ��
Select Emp_Id, Emp_Name, Dept_Code, Salary From Employee
INTERSECT
Select 'A','B','C',10 From Dual;

-- �������̺��� ��ȸ�� ����� �ߺ��� ���� ���� ��ȸ ��
Select Emp_Id, Emp_Name, Dept_Code, Salary From Employee
INTERSECT
Select '200','������','D9',8000000 From Dual;

-- MINUS : ���� SELECT ������� ���� SELECT ����� ��ġ�� �κ��� ������ �������� ����(������)
-- �������̺� ��ȸ�� ��� �Ʒ��κп� �ι�° SELECT ������ ��ȸ�� ��� ���� ��ȸ ��
Select Emp_Id, Emp_Name, Dept_Code, Salary From Employee
MINUS
Select 'A','B','C',10 From Dual;

-- �������̺��� ��ȸ�� ����� �ߺ��� ���� ���� ��ȸ ��
Select Emp_Id, Emp_Name, Dept_Code, Salary From Employee
MINUS
Select '200','������','D9',8000000 From Dual;

-- ���� ���̺��� �μ��ڵ尡 'D5'�� ������� ���, �̸�, �μ��ڵ�, �޿� ��ȸ
SELECT EMP_ID, EMP_NAME, DEPT_CODE, SALARY FROM EMPLOYEE
    WHERE DEPT_CODE = 'D5'
UNION
-- ���� ���̺��� �޿��� 3000000 �ʰ��� ����� ���, �̸�, �μ��ڵ�, �޿� ��ȸ
SELECT EMP_ID, EMP_NAME, DEPT_CODE, SALARY FROM EMPLOYEE
    WHERE SALARY > 3000000;
    
-- ���� ���̺��� �μ��ڵ尡 'D5'�� ������� ���, �̸�, �μ��ڵ�, �޿� ��ȸ
SELECT EMP_ID, EMP_NAME, DEPT_CODE, SALARY FROM EMPLOYEE
    WHERE DEPT_CODE = 'D5'
UNION ALL
-- ���� ���̺��� �޿��� 3000000 �ʰ��� ����� ���, �̸�, �μ��ڵ�, �޿� ��ȸ
SELECT EMP_ID, EMP_NAME, DEPT_CODE, SALARY FROM EMPLOYEE
    WHERE SALARY > 3000000;
    
-- ���� ���̺��� �μ��ڵ尡 'D5'�� ������� ���, �̸�, �μ��ڵ�, �޿� ��ȸ
SELECT EMP_ID, EMP_NAME, DEPT_CODE, SALARY FROM EMPLOYEE
    WHERE DEPT_CODE = 'D5'
INTERSECT
-- ���� ���̺��� �޿��� 3000000 �ʰ��� ����� ���, �̸�, �μ��ڵ�, �޿� ��ȸ
SELECT EMP_ID, EMP_NAME, DEPT_CODE, SALARY FROM EMPLOYEE
    WHERE SALARY > 3000000;
    
-- ���� ���̺��� �μ��ڵ尡 'D5'�� ������� ���, �̸�, �μ��ڵ�, �޿� ��ȸ
SELECT EMP_ID, EMP_NAME, DEPT_CODE, SALARY FROM EMPLOYEE
    WHERE DEPT_CODE = 'D5'
MINUS
-- ���� ���̺��� �޿��� 3000000 �ʰ��� ����� ���, �̸�, �μ��ڵ�, �޿� ��ȸ
SELECT EMP_ID, EMP_NAME, DEPT_CODE, SALARY FROM EMPLOYEE
    WHERE SALARY > 3000000;