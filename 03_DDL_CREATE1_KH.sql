--�ش� ������ �⺻ ���̺� �����̽� ��ȸ
    --��ü ���� �� ���̺� �����̽��� �������� �ʰ� �����ϸ� �ڵ����� ����� ���̺� �����̽�
    --������ DAFAULT TABLESPACE�� �������� ���� ��� SYSTEM TABLESPACE�� ������
SELECT USERNAME, DEFAULT_TABLESPACE FROM USER_USERS;

-- Ư�� ���̺� �����̽��� ���̺� ��ȸ
SELECT TABLESPACE_NAME, TABLE_NAME FROM USER_TABLES WHERE TABLESPACE_NAME = 'SYSTEM';

/*
    DDL(Data Definition Language) �ڡڡڡڡ�
    �����ͺ��̽��� ������ ����
    ��ü��(OBJECT) ����(CREATE), ����(ALTER), ����(DROP), �ʱ�ȭ(TRUNCATE)
    �ַ� DB������ �Ǵ� �����ڰ� ���
    ��ü(OBJECT) ���� : DATABASE, TABLESPACE, TABLE, VIEW, SEQUENCE, INDEX,
                    PACKAGE, PROCEDURL, FUNCTION, TRIGGER, SYNONYM, USER ��...
*/

/*
    CREATE�� �ڡڡڡڡ�
    �����ͺ��̽��� ��ü�� �����ϴ� ����
    �ַ� ���̺��� ������ �� ����ϸ�, �� �ܿ��� �پ��� ��ü���� ������ �� �����
    ������ ������ DROP������ ���ؼ� ������ �� ����
*/

--�⺻ ���̺� ����
CREATE TABLE MEMBER (
    MEMBER_ID VARCHAR2(20),
    MEMBER_PWD VARCHAR2(30),
    MEMBER_NAME VARCHAR(20)
);

--���̺� ��� Ȯ�� : ��� ������ ���̺� ��� ��ȸ
SELECT * FROM ALL_TABLES;

--���̺� ��� Ȯ�� : ���� ������ ���̺� ��� ��ȸ(3���� ���)
SELECT * FROM TAB;
SELECT * FROM TABS;
SELECT * FROM USER_TABLES;

--���̺� ���� Ȯ��
DESC MEMBER;

--���̺� �� ������ Ȯ��
SELECT * FROM MEMBER;

--�÷� �ּ�(����)
COMMENT ON COLUMN MEMBER.MEMBER_ID IS 'ȸ�����̵�';
COMMENT ON COLUMN MEMBER.MEMBER_PWD IS '��й�ȣ';
COMMENT ON COLUMN MEMBER.MEMBER_NAME IS 'ȸ���̸�';

--�������� �̸� Ȯ�� 
DESC USER_CONSTRAINTS;  
    --����Ŭ���� ��������ִ� �ý��� ���̺�
    --�������ǿ� ���� ������ �ڵ����� ����Ǵ� ���̺�
SELECT CONSTRAINT_NAME FROM USER_CONSTRAINTS;
SELECT * FROM USER_CONSTRAINTS;

--���������� �����ϴ� �÷� Ȯ��
DESC USER_CONS_COLUMNS;
SELECT COLUMN_NAME  FROM USER_CONS_COLUMNS;
SELECT * FROM USER_CONS_COLUMNS;

--NULL �������� ���̺� ����
CREATE TABLE USER_NOTNULL(
    USER_NO NUMBER NOT NULL,
    USER_ID VARCHAR2(20) NOT NULL,
    USER_PWD VARCHAR(30) NOT NULL,
    USER_NAME VARCHAR2(30),
    GENDER VARCHAR2(10),
    PHONE VARCHAR2(30),
    EMAIL VARCHAR2(50)
);

--�������� �̸� ��ȸ(�̸��� �������� ����)
SELECT * FROM USER_CONSTRAINTS; --NOT NULL�� �����ϰ�� �÷� �̸��� ��ȸ�� �� ����
--SELECT CONSTRAINT_NAME FROM USER_CONSTRAINTS; --���� ����� ���

--���������� ������ �÷� ��ȸ(�÷��� �������� ����)
SELECT * FROM USER_CONS_COLUMNS; --���������� ������ �÷��� ��� Ȯ���� �� ����

--������ ���� : ���� ����
INSERT INTO USER_NOTNULL VALUES(1,'USER1','PASS1','ȫ�浿','��','010-1234-1234','hong@kh.or.kr');
INSERT INTO USER_NOTNULL VALUES(2,'USER1','PASS1',NULL,NULL,NULL,NULL);
--NOT NULL �������� ������ �÷��� NULL ���� ���Ե� ��� ���� �߻�
INSERT INTO USER_NOTNULL VALUES(3,NULL,NULL,'ȫ�浿','��','010-1234-1234','hong@kh.or.kr');

--���̺� ���� Ȯ��
DESC USER_NOTNULL
--���̺� �� ������ ��ȸ
SELECT * FROM USER_NOTNULL;

--UNIQUE �������� 1 : �÷� ����
CREATE TABLE USER_UNIQUE1(
    USER_NO NUMBER,
    USER_ID VARCHAR2(20) UNIQUE,
    USER_PWD VARCHAR2(30) NOT NULL,
    UER_NAME VARCHAR2(30),
    GENDER VARCHAR(10),
    PHONE VARCHAR2(30),
    EMAIL VARCHAR2(50)
);

--������ ���� : ���� ����
INSERT INTO USER_UNIQUE1 VALUES(1,'USER1','PASS1','ȫ�浿','��','010-1234-1234','hong@kh.or.kr');
--USER_ID �÷�(�ι�° �÷�)�� �ߺ��� �� �������� ���� �߻�
INSERT INTO USER_UNIQUE1 VALUES(2,'USER1','PASS1','��浿','��','010-1234-1234','hong@kh.or.kr');
--NULL �� �ߺ��� ����
INSERT INTO USER_UNIQUE1 VALUES(2,NULL,'PASS1','��浿','��','010-1234-1234','hong@kh.or.kr');
INSERT INTO USER_UNIQUE1 VALUES(2,NULL,'PASS1','��浿','��','010-1234-1234','hong@kh.or.kr');

--���̺� �� ������ ��ȸ
SELECT * FROM USER_UNIQUE1;

--���̺� ���� Ȯ��
DESC user_unique1;  --UNIQUE �Ӽ��� ������ ����

--�������� �̸� ��ȸ
SELECT * FROM USER_CONSTRAINTS WHERE TABLE_NAME='USER_UNIQUE1';

--���������� ������ �÷� ��ȸ
SELECT * FROM USER_CONS_COLUMNS WHERE constraint_name='SYS_C007004';


--UNIQUE �������� : ���̺���
CREATE TABLE USER_UNIQUE2(
    USER_NO NUMBER,
    USER_ID VARCHAR2(20),
    USER_PWD VARCHAR2(30) NOT NULL,
    UER_NAME VARCHAR2(30),
    GENDER VARCHAR(10),
    PHONE VARCHAR2(30),
    EMAIL VARCHAR2(50),
    UNIQUE(USER_ID)
);

--������ ���� : ���� ����
INSERT INTO USER_UNIQUE2 VALUES(1,'USER1','PASS1','ȫ�浿','��','010-1234-1234','hong@kh.or.kr');
--USER_ID �÷�(�ι�° �÷�)�� �ߺ��� �� �������� ���� �߻�
INSERT INTO USER_UNIQUE2 VALUES(2,'USER1','PASS1','��浿','��','010-1234-1234','hong@kh.or.kr');
--NULL �� �ߺ��� ����
INSERT INTO USER_UNIQUE2 VALUES(2,NULL,'PASS1','��浿','��','010-1234-1234','hong@kh.or.kr');
INSERT INTO USER_UNIQUE2 VALUES(2,NULL,'PASS1','��浿','��','010-1234-1234','hong@kh.or.kr');

--���̺� �� ������ ��ȸ
SELECT * FROM USER_UNIQUE2;


--UNIQUE �������� : ���̺���2
CREATE TABLE USER_UNIQUE3(
    USER_NO NUMBER,
    USER_ID VARCHAR2(20),
    USER_PWD VARCHAR2(30) NOT NULL,
    UER_NAME VARCHAR2(30),
    GENDER VARCHAR(10),
    PHONE VARCHAR2(30),
    EMAIL VARCHAR2(50),
    UNIQUE(USER_NO, USER_ID)
);

--������ ���� : ���� ����
INSERT INTO USER_UNIQUE3 VALUES(1,'USER1','PASS1','ȫ�浿','��','010-1234-1234','hong@kh.or.kr');
INSERT INTO USER_UNIQUE3 VALUES(2,'USER1','PASS1','��浿','��','010-1234-1234','hong@kh.or.kr');
INSERT INTO USER_UNIQUE3 VALUES(2,'USER2','PASS1','��浿','��','010-1234-1234','hong@kh.or.kr');
--USER_NO(ù��° �÷�)�� USER_ID(�ι�° �÷�) ��� ���� ������ ���� �� ���� �߻�
INSERT INTO USER_UNIQUE3 VALUES(2,'USER2','PASS1','��浿','��','010-1234-1234','hong@kh.or.kr');
--�� �÷��̶� ���� �ִ� ��� ���� �߻�
INSERT INTO USER_UNIQUE3 VALUES(2,NULL,'PASS1','��浿','��','010-1234-1234','hong@kh.or.kr');
INSERT INTO USER_UNIQUE3 VALUES(NULL,'USER2','PASS1','��浿','��','010-1234-1234','hong@kh.or.kr');
--�ΰ� �÷� ��� NULL �� �ߺ��� ����
INSERT INTO USER_UNIQUE3 VALUES(NULL,NULL,'PASS1','��浿','��','010-1234-1234','hong@kh.or.kr');
INSERT INTO USER_UNIQUE3 VALUES(NULL,NULL,'PASS1','��浿','��','010-1234-1234','hong@kh.or.kr');

--���̺� �� ������ ��ȸ
SELECT * FROM USER_UNIQUE3;
