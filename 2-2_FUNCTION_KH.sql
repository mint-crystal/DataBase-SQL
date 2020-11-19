/*
    �Լ�(FUNCITION)
    Ư�� ����� ���� ����
    �÷��� ���� �о ����� �����ϰ� ��� ���� ��������
    - ������(SINGLE ROW)�Լ� : �÷��� ��ϵ� N���� ���� �о N���� ����� ����
    - �׷�(GROUP)�Լ� : �÷��� ��ϵ� N���� ���� �о M���� ����� ����
    
    SQL������ �Լ��� ����� �� �ִ� ��ġ : 
        SELECT ��, WHERE ��, GROUP BY ��, HAVING ��, ORDER BY ��
        - SELECT ���� ������ �Լ��� �׷� �Լ��� �Բ� ������� ���� : ��� ���� ������ �ٸ��� ������
    
    ���� : �Լ���(�Է� ��)
*/

/*   DUAL TABLE
    ����Ŭ �⺻ ���̺�
    ��� ����ڰ� ��� ������ �ӽ� ���̺�
    SYS ������ ���̺��̱� ������ ���̺� ����Ʈ���� ���Ե��� ����
    
    �뵵
        SELECT������ �����͸� ��ȸ�ϰ� ������
        �����Լ� ����ϰ� ���� ��
        ���� ����غ��� ���� ��
        �ӽ� �����͸� ���� ��
*/
SELECT * FROM DUAL;

-------------------------------------------------------------------------------
--������ �Լ�
    --���ڿ� ó�� �Լ�
    --���� ó�� �Լ�
    --��¥ �Լ�
    --�� ��ȯ �Լ�
    --NULLó�� �Լ�
-------------------------------------------------------------------------------

-------------------------------------------------------------------------------
--���� ó�� �Լ�
    --LENGTH, LENGTHB, SUBSTR, UPPER, LOWER, INSRT ...
-------------------------------------------------------------------------------
--LENGTH(�÷��� | '���ڿ� ��') : ������ ������ ����
SELECT LENGTH('HELLO') FROM DUAL;   --'HELLO' ���ڿ��� ���� : 5
SELECT LENGTH('���ݼ�����....') FROM DUAL;
SELECT * FROM EMPLOYEE;
SELECT EMP_NAME, LENGTH(EMAIL) FROM EMPLOYEE; --�������̺��� �̸��� ����

--LENGTHB(�÷��� | '���ڿ� ��') : ������ ����Ʈ ���� ����
SELECT LENGTHB('HELLO') FROM DUAL;  --'HELLO' ���ڿ��� ���� : 5
SELECT LENGTHB('���ݼ�����....') FROM DUAL; --'���ݼ�����....' ���ڿ��� ���� : 19
                                         --�ѱ��� 3BYTE�� '.'�� 1BYTE�� ó��

--INSTR : ������ ��ġ���� ������ ���� ��°�� ��Ÿ���� ������ ���� ��ġ ��ȯ
    --Ư�� ���ڿ����� ���ϴ� ���ڸ� ã�Ƽ� ��ġ�� ��ȯ
    --���� ��ġ ��ȣ�� 1���� ����(�ڹٴ� 0����)
    --INSTR('���ڿ�'|�÷���, 'ã�� ����' [, ã�� ��ġ�� ���۰�] [, ��])
    --ã�� ��ġ�� ���� ��(�⺻�� 1) : ��� - �տ������� �˻�, ���� - �ڿ������� �˻�
    --��(�⺻�� 1) : ã�� ���ڰ� ���� ���� ��� �� ��° ���ڸ� ã�� ������ ����
--'ABCDEFGHI' ���ڿ����� 'F'�� ��ġ ã�� : 6
SELECT INSTR('ABCDEFGHI', 'F') FROM DUAL;  
--ã�� ���ڰ� 1���� ���� ���� ���� ���� ������� ������ ��ġ�� : 6
SELECT INSTR('ABCDEFGHI', 'F', 1) FROM DUAL; 
--ã�� ���ڰ� 1���� ���� ���� ���� ���� ������� ������ ��ġ�� : 6
SELECT INSTR('ABCDEFGHI', 'F', -1) FROM DUAL;
--���� �տ� �ִ� 'F'�� ��ġ �� : 3
SELECT INSTR('ABFCDEFGHI', 'F', 1) FROM DUAL;
--�� �ڿ� �ִ� 'F'�� ��ġ �� : 7
SELECT INSTR('ABFCDEFGHI', 'F', -1) FROM DUAL; 
--�տ������� ù ��° ��ġ�� 'F'�� ��ġ �� : 3
SELECT INSTR('ABFCDEFGHI', 'F', 1,1) FROM DUAL;
--�տ������� �� ��° ��ġ�� 'F'�� ��ġ �� : 7
SELECT INSTR('ABFCDEFGHI', 'F', 1,2) FROM DUAL;
--EX)
SELECT INSTR('ABABBBAABBA', 'A') FROM DUAL; --1
SELECT INSTR('ABABBBAABBA', 'A', 1) FROM DUAL; --1
SELECT INSTR('ABABBBAABBA', 'A', -1) FROM DUAL; --11
SELECT INSTR('ABABBBAABBA', 'A', 1, 1) FROM DUAL; --1
SELECT INSTR('ABABBBAABBA', 'A', 1, 2) FROM DUAL; --3
SELECT INSTR('ABABBBAABBA', 'A', 1, 3) FROM DUAL; --7
SELECT INSTR('ABABBBAABBA', 'A', 1, 4) FROM DUAL; --8
SELECT INSTR('ABABBBAABBA', 'A', 1, 5) FROM DUAL; --11
--���� ���̺��� EMAIL���� '@'�� ��ġ ��ȯ
SELECT EMAIL, INSTR(EMAIL,'@') FROM EMPLOYEE; --�̸����� '@' ��ġ
SELECT EMAIL, INSTR(EMAIL,'@')-1 AS ���̵���� FROM EMPLOYEE;

--LPAD/RPAD : �־��� �÷� ���ڿ��� ������ ���ڿ��� ���ٿ� ���� N�� ���ڿ��� ��ȯ�ϴ� �Լ�
    --LPAD('���ڿ�' | �÷� ��, ��ȯ�� �� ���ڿ� ���� [, ���ٿ��� ����])
    --padding
SELECT LPAD(EMAIL, 20, '#') FROM EMPLOYEE;
SELECT LPAD(EMAIL, 20) FROM EMPLOYEE;
SELECT RPAD(EMAIL, 20, '#') FROM EMPLOYEE;
SELECT RPAD(EMAIL, 20) FROM EMPLOYEE;

--LTRIM / RTRIM : �־��� �÷��̳� ���ڿ� ����/�����ʿ��� ������ ���� Ȥ�� ���ڿ��� ������ �������� ��ȯ
    --LTRIM('���ڿ�' | �÷� �� [, ������ ����])
    --������ ���ڸ� �����ϸ� ���� ����
SELECT LTRIM('     KH     ') FROM DUAL;
SELECT TRIM(LEADING FROM '     KH     ') FROM DUAL; --LTRIM�� ����
SELECT RTRIM('     KH     ') FROM DUAL;
SELECT TRIM(TRAILING FROM '     KH     ') FROM DUAL; --RTRIM�� ����
SELECT LTRIM('KHKH1234KHKH', 'KH') FROM DUAL;
SELECT RTRIM('KHKH1234KHKH', 'KH') FROM DUAL;
--���� ���� ��� ����
SELECT TRIM(BOTH FROM '     KH     ') FROM DUAL;
SELECT RTRIM(LTRIM('     KH     ')) FROM DUAL;
--TRIM�� ���Ϲ��ڸ� ó���� �� ����. ���ڿ� ������ LTRIM, RTRIM ����ؾ���
SELECT TRIM(BOTH 'K' FROM 'KHKH1234KHKH') FROM DUAL;
SELECT TRIM(BOTH 'K' FROM 'KKK1234KKK') FROM DUAL;

--SUBSTR : �÷��̳� ���ڿ����� ������ ��ġ�κ��� ������ ������ ���ڿ��� �߶� ����
    --SUBSTR(���ڿ�, ���� ��ġ, ����)
SELECT SUBSTR('SHOWMETHEMONEY', 5, 2) FROM DUAL; --ME : 5��°���� 2����
SELECT SUBSTR('SHOWMETHEMONEY', 7) FROM DUAL; --THEMONEY : 7��°���� ������
SELECT SUBSTR('SHOWMETHEMONEY', -8, 3) FROM DUAL; --THE : ������ 8��°���� 3����
--�������̺��� �̸��� �ֹι�ȣ 8��°�ڸ��� ���
SELECT EMP_NAME, SUBSTR(EMP_NO, 8, 1) FROM EMPLOYEE;

--LOWER / UPPER / INITCAP : ��ҹ��� ����
SELECT LOWER('Welcome To My World') FROM DUAL; --��� �ҹ��ڷ� ��ȯ
SELECT UPPER('Welcome To My World') FROM DUAL; --��� ��ҹ��ڷ� ��ȯ
SELECT INITCAP('welcome to my world') FROM DUAL; --�ܾ��� ù ���ڸ� �빮�ڷ� ��ȯ
        --���� �Ǵ� Ư�����ڸ� �������� �빮�� ��ȯ

--CONCAT : ���ڿ� Ȥ�� �÷��� �Է¹޾� �ϳ��� ��ģ �� ����
SELECT CONCAT('�����ٶ�', 'ABCD') FROM DUAL;
SELECT '�����ٶ�'||'ABCD' FROM DUAL;

--REPLACE 
SELECT REPLACE('WELCOME TO ORACLE', 'ORACLE', 'MYSQL') FROM DUAL;
SELECT EMP_NAME, EMAIL, REPLACE(EMAIL, 'kh', 'iei') AS "����� ����" FROM EMPLOYEE;

--�������̺��� �ֹι�ȣ�� ��ȸ�ؼ� ����, ����, ������ ���� �и��Ͽ� ��ȸ
SELECT EMP_NAME �����, SUBSTR(EMP_NO,1,2) ����, SUBSTR(EMP_NO,3,2)����, 
    SUBSTR(EMP_NO,5,2) ���� FROM EMPLOYEE;

--���������� ��� �÷� ���� ��ȸ
SELECT * FROM EMPLOYEE WHERE SUBSTR(EMP_NO, 8,1)=2;

--�Լ� ��ø ��� : �Լ� �ȿ��� �Ǵٸ� �Լ��� ����� �� ����
--���� ���̺��� ��� ��, �ֹι�ȣ ��ȸ
    --��, �ֹι�ȣ�� ������ϸ� ���̰� �ϰ�, '-'���� ���� '*'�� ����
SELECT EMP_NAME �����, RPAD(SUBSTR(EMP_NO, 1, 7),14,'*')�ֹι�ȣ FROM EMPLOYEE;


-------------------------------------------------------------------------------
--����ó�� �Լ�
    --ABS, MOD, ROUND, FLOOR, TRUNC, CELL
-------------------------------------------------------------------------------
--ABS :  ���� ���� ���Ͽ� �����ϴ� �Լ�
    --ABS(���� | ���ڷ� �� �÷���)
SELECT ABS(-10) FROM DUAL; --10
SELECT ABS(10) FROM DUAL;  --10

--MOD : �������� ���ϴ� �Լ�(%)
    --MOR(���������� ��, ���� ��)
SELECT MOD(10,5) FROM DUAL; --0
SELECT MOD(10,3) FROM DUAL; --1

--ROUND : �ݿø��Ͽ� �����ϴ� �Լ�
    --ROUND(���� [, ��ġ])
SELECT ROUND(123.456) FROM DUAL; --123
SELECT ROUND(123.656) FROM DUAL; --124
SELECT ROUND(123.456, 1) FROM DUAL; --123.5
SELECT ROUND(123.456, 2) FROM DUAL; --123.46
SELECT ROUND(123.456, -2) FROM DUAL; --100
SELECT ROUND(568.456, -1) FROM DUAL; --570

--FLOOR : �Ҽ����� �������� �����Ͽ� �����ϴ� �Լ�
    --FLOOR(����)
SELECT FLOOR(123.456) FROM DUAL; --123
SELECT FLOOR(123.656) FROM DUAL; --123

--TRUNC : �����Ͽ� �����ϴ� �Լ�
    --TRUNC(����, [, ��ġ])
SELECT TRUNC(123.456) FROM DUAL; --123
SELECT TRUNC(123.656) FROM DUAL; --123
SELECT TRUNC(123.456, 1) FROM DUAL; --123.4
SELECT TRUNC(123.456, 2) FROM DUAL; --123.45
SELECT TRUNC(123.456, -2) FROM DUAL; --100
SELECT TRUNC(568.456, -1) FROM DUAL; --560

--CEIL : �ø��Ͽ� �����ϴ� �Լ�
    --CEIL(����)
SELECT CEIL(123.456) FROM DUAL; --124
SELECT CEIL(123.656) FROM DUAL; --124


-------------------------------------------------------------------------------
--��¥ ó�� �Լ�
    --SYSDATE, MONTHS_BETWEEN, ADD_MONTH, NEXT_DAY, LAST_DAY, EXTRACT
-------------------------------------------------------------------------------
--SYSDATE : �ý��ۿ� ����Ǿ� �ִ� ��¥�� ��ȯ�ϴ� �Լ�
SELECT SYSDATE FROM DUAL;

--MONTHS_BETWEEN(��¥, ��¥) : ���� ���� ���̸� ���ڷ� ��ȯ�ϴ� �Լ�
SELECT EMP_NAME, HIRE_DATE, 
    CEIL(MONTHS_BETWEEN(SYSDATE, HIRE_DATE))"���� ��" FROM EMPLOYEE;
    
--ADD_MONTHS(��¥, ����) : ��¥�� ���ڸ�ŭ ���� ���� ���Ͽ� ��¥�� ��ȯ�ϴ� �Լ�
SELECT ADD_MONTHS(SYSDATE, 5) FROM DUAL;

    --�������̺��� ����� �̸�, �Ի���, �Ի� �� 6������ �� ��¥�� ��ȸ
    SELECT EMP_NAME, HIRE_DATE, ADD_MONTHS(HIRE_DATE, 6) �Ի�6���� FROM EMPLOYEE;

--NEXT_DAY : ���� ��¥���� ���Ϸ��� ������ ���� ����� ��¥�� ��ȯ�ϴ� �Լ�
    --NEXT_DAY(���� ��¥, ����)
        --���� : ����, ����
SELECT SYSDATE, NEXT_DAY(SYSDATE,'�����') FROM DUAL;
SELECT SYSDATE, NEXT_DAY(SYSDATE, 5) FROM DUAL;  --�Ͽ��Ϻ��� 1�� ó��
SELECT SYSDATE, NEXT_DAY(SYSDATE,'��') FROM DUAL;
    --���ڼ� ����
    ALTER SESSION SET NLS_LANGUAGE = AMERICAN;
SELECT SYSDATE, NEXT_DAY(SYSDATE,'FRIDAY') FROM DUAL;
    ALTER SESSION SET NLS_LANGUAGE = KOREAN;
SELECT SYSDATE, NEXT_DAY(SYSDATE,'�ݿ���') FROM DUAL;

--LAST_DAY(��¥) : �ش� ���� ������ ��¥�� ���Ͽ� ��ȯ���ִ� �Լ�
    --�̹� �� ������ �� ���ϱ�
SELECT SYSDATE, LAST_DAY(SYSDATE) FROM DUAL;
    --���� �� ������ �� ���ϱ�
SELECT SYSDATE, LAST_DAY(ADD_MONTHS(SYSDATE,1)) FROM DUAL;

--�������̺��� �ٹ������� 10�� �̻��� ���� ��ȸ
SELECT * FROM EMPLOYEE WHERE MONTHS_BETWEEN(SYSDATE, HIRE_DATE)>=120;
SELECT MONTHS_BETWEEN(SYSDATE, HIRE_DATE), ABS(MONTHS_BETWEEN(HIRE_DATE, SYSDATE)) FROM EMPLOYEE;

--�������̺��� �����, �Ի���, �Ի��� ���� �ٹ��ϼ��� ��ȸ
SELECT EMP_NAME, HIRE_DATE, LAST_DAY(HIRE_DATE)-HIRE_DATE "�Ի�� �ٹ��ϼ�" FROM EMPLOYEE;

--EXTRACT : ��, ��, �� ������ �����Ͽ� ��ȯ�ϴ� �Լ�
    --EXTRACT(YEAR FROM ��¥) : �⵵�� ��ȯ
    --EXTRACT(MONTH FROM ��¥) : ���� ��ȯ
    --EXTRACT(DAY FROM ��¥) : ���� ��ȯ
SELECT EXTRACT (YEAR FROM SYSDATE) �⵵, EXTRACT (MONTH FROM SYSDATE) ��, 
    EXTRACT (DAY FROM SYSDATE) �� FROM DUAL;


-------------------------------------------------------------------------------
--����ȯ �Լ�
    --TO_CHAR, TO_DATE, TO_NUMBER
-------------------------------------------------------------------------------
--TO_CHAR(��¥ [, ����]) : ��¥�� �����͸� ������ �����ͷ� ��ȯ
SELECT SYSDATE FROM DUAL;   --��ȯx ��¥��
SELECT TO_CHAR(SYSDATE) FROM DUAL;
SELECT TO_CHAR(SYSDATE, 'YYYY-MM-DD') FROM DUAL; -- 2020-11-19
SELECT TO_CHAR(SYSDATE, 'YY-MM-DD') FROM DUAL; -- 20-11-19
SELECT TO_CHAR(SYSDATE, 'PM HH:MI:SS') FROM DUAL; -- ���� 03:28:10
SELECT TO_CHAR(SYSDATE, 'PM HH24:MI:SS') FROM DUAL; -- ���� 15:28:05
SELECT TO_CHAR(SYSDATE, 'AM HH:MI:SS') FROM DUAL; -- 2020-11-19 03:27:41
SELECT TO_CHAR(SYSDATE, 'YYYY-MM-DD HH:MI:SS') FROM DUAL; -- 2020-11-19 03:27:41
    --�⵵�� ���� ���� ���ڴ� 'Y', 'R' 
        --'RRRR' ���ڸ� �⵵�� ���ڸ��� �ٲܶ� 50�� �̸��̸� 2000���� ����, 50�� �̸��̸� 1900�� ����
        --90/12/30 -> 90+1900=1900
        --20/11/30 -> 20+2000=2020
        SELECT EMP_NAME, HIRE_DATE, TO_CHAR(HIRE_DATE, 'YYYY'), TO_CHAR(HIRE_DATE, 'RRRR') FROM EMPLOYEE;
--TO_CHAR(���� [, ����]) : ������ �����͸� ������ �����ͷ� ��ȯ
SELECT TO_CHAR(1234) FROM DUAL; --1234
    --�տ� 0�� ä����� 0, �ڸ����� ������� 9
SELECT TO_CHAR(1234, '99999999') FROM DUAL; --     1234
SELECT TO_CHAR(1234, '00000000') FROM DUAL; --00001234
SELECT TO_CHAR(1234, 'L99999999') FROM DUAL; --            ��1234
SELECT TO_CHAR(1234, '$99999999') FROM DUAL; --     $1234
SELECT TO_CHAR(1234, '99,999,999') FROM DUAL; --      1,234
SELECT TO_CHAR(1234, '00,000,000') FROM DUAL; --00,001,234
SELECT TO_CHAR(1234, '9.9EEEE') FROM DUAL; --  1.2E+03 ��������
SELECT TO_CHAR(1234, '9999') FROM DUAL; --1234
SELECT TO_CHAR(12345, '9999') FROM DUAL; --#####

--TO_DATE(���� [, ����]) : ������ �����͸� ��¥�� ��ȯ�Ͽ� ��ȯ
SELECT TO_DATE('20201119') FROM DUAL;   --20/11/19
SELECT TO_CHAR(TO_DATE('20150512'),'YYYY-MM-DD') FROM DUAL;   --2015-05-12
SELECT TO_CHAR(TO_DATE('14/5/20'),'YYYY-MM-DD') FROM DUAL;    --2014-05-20
SELECT TO_CHAR(TO_DATE('80/3/2'), 'YYYY-MM-DD') FROM DUAL;     --1980-03-02
SELECT TO_CHAR(TO_DATE('20140520'), 'YYYY') FROM DUAL; --2014

--TO_DATE(���� [, ����]) : ������ �����͸� ��¥�� ��ȯ�Ͽ� ��ȯ
SELECT TO_DATE(20150512) FROM DUAL;
SELECT TO_CHAR(TO_DATE(20150512), 'YYYY"��" MM"��" DD"��"') FROM DUAL;

--TO_NUMBER(���� [, ����]) : ���ڵ����͸� ���ڷ� ��ȯ�Ͽ� ��ȯ
SELECT '10'+'20' FROM DUAL; --�ڵ�����ȯ
SELECT TO_NUMBER('1234') FROM DUAL; --��������ȯ(���������� ���鸸)


-------------------------------------------------------------------------------
--NULL ó�� �Լ�
    --NVL
-------------------------------------------------------------------------------
--NVL(NULL���� �˻��� ��, NULL�϶� �ٲ� ��)
    --�������̺��� ���ʽ��� NULL�϶� 0���� �����Ͽ� �� �޿��� ���
SELECT EMP_NAME, SALARY, NVL(BONUS,0), SALARY*NVL(BONUS,0) AS ���ʽ��ݾ�, 
    SALARY+(SALARY*NVL(BONUS,0)) AS "�� �޿�" FROM EMPLOYEE;
    --���� ���̺��� DEPT_CODE�� NULL�϶� �μ��������� ����
SELECT EMP_NAME, NVL(DEPT_CODE,'�μ� ����') FROM EMPLOYEE;

--NVL2(NULL���� �˻��� ��, NULL�ƴҶ� �ٲ� ��1, NULL�϶� �ٲ� ��)
SELECT EMP_NAME, NVL2(DEPT_CODE,'�μ�����','�μ�����') FROM EMPLOYEE;


-------------------------------------------------------------------------------
--���� �Լ�
    --���� ���� ��쿡 ������ �� �ִ� ����� ����
    --JAVA�� SWITCH�� �����
    --DECODE(���ǽ� | �÷���, ���ǰ�1, ���ð�1, ���ǰ�2, ���ð�2, ... [, ����Ʈ])
    --���ǽ��� ��� ���� ��ġ�ϴ� ���ǰ��� ã�Ƽ� �ٷ� ���� ���� ���� ���
-------------------------------------------------------------------------------
--DECODE
SELECT DECODE('1','1','1�Դϴ�','2','2�Դϴ�','�� ���Դϴ�')FROM DUAL; --1�Դϴ�
SELECT DECODE(2,1,'1�Դϴ�',2,'2�Դϴ�','�� ���Դϴ�')FROM DUAL; --2�Դϴ�
SELECT DECODE(3,1,'1�Դϴ�',2,'2�Դϴ�','�� ���Դϴ�')FROM DUAL; --�� ���Դϴ�
SELECT EMP_NAME, EMP_ID, DECODE(SUBSTR(EMP_NO, 8,1), '1', '����', '2', '����') AS ���� FROM EMPLOYEE;

/* CASE WHEN ���ǽ� THEN �����
        WHEN ���ǽ� THEN �����
        ELSE ��� ��
        END */
--JOB_CODE�� J7�̸� �޿� 1.1 �λ�, J6�̸� 1.15 �λ�, �� �ܿ��� 1.0 �λ�
SELECT EMP_NAME, JOB_CODE, SALARY,
    CASE WHEN JOB_CODE = 'J7' THEN SALARY*1.1
        WHEN JOB_CODE = 'J6' THEN SALARY*1.15
        ELSE SALARY*1.0
        END AS �λ�޿�
        FROM EMPLOYEE;
        

-------------------------------------------------------------------------------
--�׷��Լ�
    --SUM, AVG, MAX, MIN, COUNT
-------------------------------------------------------------------------------
--SUM(���ڰ� ��ϵ� �÷���) : �հ踦 ���Ͽ� ��ȯ
SELECT SUM(SALARY) FROM EMPLOYEE;

--AVG(���ڰ� ��ϵ� �÷���) : ����� ���ؼ� ��ȯ
SELECT AVG(SALARY) FROM EMPLOYEE;

--MIN(�÷���) : �÷����� ���� ���� ���� ��ȯ
    --����ϸ� �ڷ����� ANY TYPE
SELECT MIN(SALARY) FROM EMPLOYEE;
SELECT MIN(HIRE_DATE) FROM EMPLOYEE;
SELECT MIN(EMAIL) FROM EMPLOYEE;

--MAX(�÷���) : �÷����� ���� ū ���� ��ȯ
    --����ϸ� �ڷ����� ANY TYPE
SELECT MAX(SALARY) FROM EMPLOYEE;
SELECT MAX(HIRE_DATE) FROM EMPLOYEE;
SELECT MAX(EMAIL) FROM EMPLOYEE;

--COUNT(* | �÷� ��) : ���� ������ ��Ʒ��� ��ȯ
    --COUNT(�÷� ��) : NULL�� ������ ���� ���� ��ϵ� �� ������ ��ȯ
    --COUNT(*) : NULL�� ������ ��ü �� ������ ��ȯ
    --COUNT(DISTINCT �÷���) : �ߺ��� ������ �� ������ ��ȯ
SELECT COUNT(*) FROM EMPLOYEE;  --23 : NULL�� ������ ��ü �� ����
SELECT COUNT(EMP_NAME) FROM EMPLOYEE;   --23 : NULL ���� �� ����
SELECT COUNT(BONUS) FROM EMPLOYEE;  --9 : NULL ���� �� ����
SELECT COUNT(DEPT_CODE) FROM EMPLOYEE;  --21 : NULL ���� �� ����
SELECT COUNT(DISTINCT DEPT_CODE) FROM EMPLOYEE; --6 : �ߺ����� �� ����