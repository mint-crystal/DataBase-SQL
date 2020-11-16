/*
    DATABASE
        Experess Edition�� �ϳ��� �����ͺ��̽��� ��� ����
        �����ͺ��̽� �̸� : xe
        Enterprise Edition�� 2���̻��� �����ͺ��̽� ��������
            �Ϲ������� dbca�� �̿��� �ڵ� ���� - dbca : �ڵ����� �����ͺ��̽� ������ִ� ���
            CREATE DATABASE ������ ���� ���� ����
*/

--DATABASE ���� ��ȸ
SELECT * FROM V$INSTANCE;

--DATABASE �̸� ��ȸ
SELECT NAME FROM V$DATABASE;

/*
    TABLESPACE
        �⺻ �����Ǿ��ִ� TABLESPACE�� ����
        �ʿ��ϸ� �߰��� �����ؼ� ��� ����
        CREATE TABLESPACE ���� �̿��ؼ� ��������
*/

--TABLESPACE ��ȸ
SELECT TABLESPACE_NAME FROM DBA_TABLESPACES;

--���� �α��ε� ������� ���̺� �����̽� ��ȸ
SELECT DISTINCT TABLESPACE_NAME FROM USER_TABLES;

--�ش� ������ �⺻ ���̺� �����̽� ��ȸ
    --��ü ���� �� ���̺� �����̽��� �������� �ʰ� �����ϸ� �ڵ����� ����� ���̺� �����̽�
SELECT USERNAME, DEFAULT_TABLESPACE FROM USER_USERS;

-- Ư�� ���̺� �����̽��� ���̺� ��ȸ
SELECT TABLESPACE_NAME, TABLE_NAME FROM USER_TABLES WHERE TABLESPACE_NAME = 'SYSTEM';