--------------------------------------------------------------------------------
/*
    SUBQUERY
    QUERY�� �ȿ� ���Ե� �Ǵٸ� QUERY��
    SUBQUERY ��ü������ �ϼ��� �Ǿ�� ��
    �ݵ�� �Ұ�ȣ()�� ������� ��
    ���������� ����Ǳ� ���� ����Ǹ� �� ���� ���� ��
    
    SUBQUERY ��� ��ġ
        SELECT, FROM, WHERE, HAVING, GROUP BY, ORDER BY
        INSERT, UPDATE
        CREATE TABLE, CREATE VIEW
*/
--------------------------------------------------------------------------------
--���� ���̺��� �޿��� ��� �޿� �̻��� ���� ���, �̸�, �����ڵ�, �޿� ��ȸ
SELECT AVG(SALARY) FROM EMPLOYEE; --��� �޿� ���ϱ�
SELECT EMP_ID, EMP_NAME, JOB_CODE, SALARY FROM EMPLOYEE
    WHERE SALARY >= (SELECT AVG(SALARY) FROM EMPLOYEE);


--------------------------------------------------------------------------------
/*
    SUBQUERY ����
    1. ������ ��������
        ���������� ��ȸ ��� ���� ������ 1���� ��������
    2. ������ ��������
        ���������� ��ȸ ��� ���� ���� ���� ���� ��������
    3. ���߿� ��������
        ���������� ��ȸ ��� �÷��� ������ ���� ���� ��������
    4. ������ ��������
        ���������� ��ȸ ��� �÷��� ������ ���� ������ ���� ���� ��������
    5. ��(ȣ��)�� ��������
        ���������� ���� ��� ���� ���� ������ �� ������ �� ���� ����
        ���̺��� ���� ����Ǹ� �������� ��� ���� �ٲ�� ��������
    6. ��Į�� ��������
        ��������̸鼭 ��� ���� �� ���� ��������
        
    ���������� ������ ���� �������� �տ� �ٴ� �����ڰ� �ٸ�
*/
--------------------------------------------------------------------------------
--������ ��������
    --������ : <, >, <=, >=, =, !=|^=|<>
--���ö ������� �޿��� ���� �޴� ���� �̸�, ����, �޿� ��ȸ
SELECT * FROM EMPLOYEE;
SELECT SALARY FROM EMPLOYEE WHERE EMP_NAME='���ö';
SELECT EMP_NAME, DEPT_CODE, JOB_CODE, SALARY FROM EMPLOYEE
    WHERE SALARY>(SELECT SALARY FROM EMPLOYEE WHERE EMP_NAME='���ö');
    
--������ ��������
    --������ �������� �տ��� �Ϲ� �񱳿����� ��� �� ��
    --IN : ���� ���� ����� �߿��� �� ���� ��ġ�ϴ� ���� �ִٸ� TRUE
    --NOT IN : ���� ���� ����� �߿��� �� ���� ��ġ�ϴ� ���� ���ٸ� TRUE
    -- >ANY Ȥ�� <ANY : ���� ���� ����� �߿� �� ���� ū/���� ��� TRUE (>=, <= �����ڵ� ��밡��)
        --���� ���� ������ ū��? Ȥ�� ���� ū ������ ������?
    -- >ALL Ȥ�� <ALL : ��� ������ ū/���� ��� TRUE (>=, <= �����ڵ� ��밡��)
        --���� ū ������ ū��? Ȥ�� ���� ���� ������ ������?
    --EXISTS / NOT EXISTS : ���� �����ϴ���? �������� �ʴ���?
--�μ� �� �ְ� �޿��� �޴� ������ �̸�, ����, �μ�, �޿� ��ȸ
SELECT DEPT_CODE,MAX(SALARY) FROM EMPLOYEE GROUP BY DEPT_CODE;
SELECT EMP_NAME, JOB_CODE, DEPT_CODE, SALARY FROM EMPLOYEE 
    WHERE SALARY IN (SELECT MAX(SALARY) FROM EMPLOYEE GROUP BY DEPT_CODE);
--�븮 ������ ������ �߿��� ���� ������ �ּ� �޿����� ���� �޴� ������ ���, �̸�, ����, �޿� ��ȸ
SELECT EMP_ID, EMP_NAME, JOB_NAME, SALARY FROM EMPLOYEE
    JOIN JOB USING(JOB_CODE) WHERE JOB_NAME='�븮';
SELECT SALARY FROM EMPLOYEE JOIN JOB USING(JOB_CODE) WHERE JOB_NAME='����';
SELECT EMP_ID, EMP_NAME, JOB_NAME, SALARY FROM EMPLOYEE
    JOIN JOB USING(JOB_CODE) WHERE JOB_NAME='�븮' 
    AND SALARY > ANY (SELECT SALARY FROM EMPLOYEE JOIN JOB USING(JOB_CODE) WHERE JOB_NAME='����');
--���� ���� �޿��� ���� ū ������ ���� �޴� ���� ������ ���� ��ȸ
SELECT EMP_ID, EMP_NAME, JOB_NAME, SALARY FROM EMPLOYEE
    JOIN JOB USING(JOB_CODE) WHERE JOB_NAME='����';
SELECT SALARY FROM EMPLOYEE JOIN JOB USING (JOB_CODE) WHERE JOB_NAME='����';
SELECT EMP_ID, EMP_NAME, JOB_NAME, SALARY FROM EMPLOYEE
    JOIN JOB USING(JOB_CODE) WHERE JOB_NAME='����' AND 
    SALARY > ALL(SELECT SALARY FROM EMPLOYEE JOIN JOB USING (JOB_CODE) WHERE JOB_NAME='����');

--���߿� ��������
--����� �������� ���� �μ�, ���� ���޿� �ش��ϴ� ����� �̸�, ����, �μ�, �Ի��� ��ȸ
    --����� �������� �μ�, �����ڵ带 ��ȸ
SELECT DEPT_CODE, JOB_CODE FROM EMPLOYEE 
    WHERE SUBSTR(EMP_NO,8,1)='2' AND ENT_YN='Y';
    --����� �̸�, ����, �μ�, �Ի��� ��ȸ
SELECT EMP_NAME, JOB_CODE, DEPT_CODE, HIRE_DATE FROM EMPLOYEE;    
    --���Ͽ�/���������� ��ȸ
SELECT EMP_NAME, JOB_CODE, DEPT_CODE, HIRE_DATE FROM EMPLOYEE
    WHERE DEPT_CODE = (SELECT DEPT_CODE FROM EMPLOYEE 
        WHERE SUBSTR(EMP_NO,8,1)='2' AND ENT_YN='Y')
    AND JOB_CODE = (SELECT JOB_CODE FROM EMPLOYEE 
        WHERE SUBSTR(EMP_NO,8,1)='2' AND ENT_YN='Y')
    AND EMP_NAME <> (SELECT EMP_NAME FROM EMPLOYEE 
        WHERE SUBSTR(EMP_NO,8,1)='2' AND ENT_YN='Y');
    --���߿��� ��ȸ
SELECT EMP_NAME, JOB_CODE, DEPT_CODE, HIRE_DATE FROM EMPLOYEE
    WHERE (DEPT_CODE, JOB_CODE) IN (SELECT DEPT_CODE, JOB_CODE FROM EMPLOYEE 
        WHERE SUBSTR(EMP_NO,8,1)='2' AND ENT_YN='Y')
     AND EMP_NAME <> (SELECT EMP_NAME FROM EMPLOYEE 
        WHERE SUBSTR(EMP_NO,8,1)='2' AND ENT_YN='Y');

--���߿�/������ ��������
--���޺� �ּ� �޿��� �޴� ������ ���, �̸�, ����, �޿� ��ȸ
SELECT JOB_CODE, MIN(SALARY) FROM EMPLOYEE GROUP BY JOB_CODE;
SELECT EMP_ID, EMP_NAME, JOB_CODE, SALARY FROM EMPLOYEE
    WHERE (JOB_CODE, SALARY) IN (SELECT JOB_CODE, MIN(SALARY) FROM EMPLOYEE GROUP BY JOB_CODE);
    
--�ζ��� ��(INLINE VIEW) : ���������� ���� ��� ����(RESULT SET)�� ���� �߰� ��ȸ
    --FROM ������ ���������� ��� : ���̺� ��� ���
    --ROWNUM : �� ��ȣ�� �ǹ���
    --ROWNUM ��ü�� FROM ������ �ٿ���
    --ORDER BY �� ������ ROWRUM�� �������� ��������(�ζ��κ�)�� �̿��ؾ� ��
SELECT * FROM EMPLOYEE ORDER BY SALARY DESC;
--ROWNUM�� �̿��ؼ� �� ��ȣ ��ȸ
SELECT ROWNUM, EMP_NAME, EMP_NO FROM EMPLOYEE;
--�� ��ȣ�� �̿��� ������� ������ �߶����
SELECT ROWNUM, EMP_NAME, EMP_NO FROM EMPLOYEE WHERE ROWNUM <= 5;
--�ֹι�ȣ ������ ����
SELECT ROWNUM, EMP_NAME, EMP_NO FROM EMPLOYEE ORDER BY EMP_NO;
--�ֹι�ȣ ������ �����ؼ� �ֹι�ȣ�� ���� ������� 5�� �ڸ��� ������ �� ��
SELECT ROWNUM, EMP_NAME, EMP_NO FROM EMPLOYEE WHERE ROWNUM <= 5 ORDER BY EMP_NO;
--���������� ���ĵ� ������ �Ѱ���
SELECT ROWNUM, EMP_NAME, EMP_NO FROM (SELECT * FROM EMPLOYEE ORDER BY EMP_NO);
--���ĵ� �����͸� �ֹι�ȣ�� ���� ������� 5�� �ڸ���
SELECT ROWNUM, EMP_NAME, EMP_NO FROM (SELECT * FROM EMPLOYEE ORDER BY EMP_NO)
    WHERE ROWNUM<=5;