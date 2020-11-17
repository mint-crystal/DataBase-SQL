--PRIMARY KEY �������� 1 : �÷� ���� ����
CREATE TABLE USER_PRIMARYKEY1(
    USER_NO NUMBER PRIMARY KEY, --�÷� ���� ����
    USER_ID VARCHAR2(20) NOT NULL UNIQUE,
    USER_PWD VARCHAR2(30) NOT NULL,
    USER_NAME VARCHAR2(30),
    GENDER VARCHAR2(10),
    PHONE VARCHAR2(30),
    EMAIL VARCHAR2(50)
);
    --USER_NO �÷��� �⺻Ű�� ����
--������ ���� : ���� ����
INSERT INTO USER_PRIMARYKEY1 VALUES(1,'USER1','PASS1','ȫ�浿','��','010-1234-1234','hong@kh.or.kr');
--USER_NO �÷��� �ߺ��� �� ���� : UNIQUE ����
INSERT INTO USER_PRIMARYKEY1 VALUES(1,'USER1','PASS1','ȫ�浿','��','010-1234-1234','hong@kh.or.kr');
--USER_NO �÷��� NULL �� ���� : NOT NULL ����
INSERT INTO USER_PRIMARYKEY1 VALUES(NULL,'USER1','PASS1','ȫ�浿','��','010-1234-1234','hong@kh.or.kr');

--PRIMARY KEY �������� 2 : ���̺� ���� ����
CREATE TABLE USER_PRIMARYKEY2(
    USER_NO NUMBER,
    USER_ID VARCHAR2(20) NOT NULL UNIQUE,
    USER_PWD VARCHAR2(30) NOT NULL,
    USER_NAME VARCHAR2(30),
    GENDER VARCHAR2(10),
    PHONE VARCHAR2(30),
    EMAIL VARCHAR2(50),
    PRIMARY KEY (USER_NO)   --���̺� ���� ����
);
    --USER_NO �÷��� �⺻Ű�� ����
--������ ���� : ���� ����
INSERT INTO USER_PRIMARYKEY2 VALUES(1,'USER1','PASS1','ȫ�浿','��','010-1234-1234','hong@kh.or.kr');
--USER_NO �÷��� �ߺ��� �� ���� : UNIQUE ����
INSERT INTO USER_PRIMARYKEY2 VALUES(1,'USER1','PASS1','ȫ�浿','��','010-1234-1234','hong@kh.or.kr');
--USER_NO �÷��� NULL �� ���� : NOT NULL ����
INSERT INTO USER_PRIMARYKEY2 VALUES(NULL,'USER1','PASS1','ȫ�浿','��','010-1234-1234','hong@kh.or.kr');

--PRIMARY KEY �������� 3 : ���̺� ���� ���� - �� �÷��� ��� �ϳ��� PRIMARY KEY�� ����
CREATE TABLE USER_PRIMARYKEY3(
    USER_NO NUMBER,
    USER_ID VARCHAR2(20) NOT NULL UNIQUE,
    USER_PWD VARCHAR2(30) NOT NULL,
    USER_NAME VARCHAR2(30),
    GENDER VARCHAR2(10),
    PHONE VARCHAR2(30),
    EMAIL VARCHAR2(50),
    PRIMARY KEY (USER_NAME, PHONE)  --���̺� ���� ����
);
    --USER_NAME�� PHONE�� ���ļ� �ϳ��� PRIMARY KEY�� ���
--������ ���� : ���� ����
INSERT INTO USER_PRIMARYKEY3 VALUES(1,'USER1','PASS1','ȫ�浿','��','010-1234-1234','hong@kh.or.kr');
--USER_NAME�� �����ϰ�, PHONE�� �ٸ� ������ ���� : ���� ����
INSERT INTO USER_PRIMARYKEY3 VALUES(2,'USER2','PASS2','ȫ�浿','��','010-1234-4321','hong@kh.or.kr');
--USER_NAME�� �ٸ���, PHONE�� ���� ������ ���� : ���� ����
INSERT INTO USER_PRIMARYKEY3 VALUES(3,'USER3','PASS3','��浿','��','010-1234-4321','hong@kh.or.kr');
--USER_NAME�� PHONE ��� ���� ������ ���� : ���� �߻�
INSERT INTO USER_PRIMARYKEY3 VALUES(4,'USER4','PASS4','��浿','��','010-1234-4321','hong@kh.or.kr');
--USER_NAME�� NULL�̰�, PHONE�� ���� ������ ���� : ���� �߻�
INSERT INTO USER_PRIMARYKEY3 VALUES(5,'USER5','PASS5',NULL,'��','010-1234-4321','hong@kh.or.kr');
--USER)NAME�� ���� �����Ͱ�, PHONE�� NULL�� ���� : ���� �߻�
INSERT INTO USER_PRIMARYKEY3 VALUES(6,'USER6','PASS6','��浿','��',NULL,'hong@kh.or.kr');

--����Ʈ ��ȸ
SELECT * FROM USER_PRIMARYKEY3;

--------------------------------------------------------------------------------

--FOREIGN KEY(�ܷ� Ű)
--�����Ǵ� ���̺�(�θ� ���̺�)
CREATE TABLE USER_GRADE(
    GRADE_CODE NUMBER PRIMARY KEY,
    GRADE_NAME VARCHAR2(30) NOT NULL
);
INSERT INTO USER_GRADE VALUES(10,'�Ϲ�ȸ��');
INSERT INTO USER_GRADE VALUES(20,'���ȸ��');
INSERT INTO USER_GRADE VALUES(30,'Ư��ȸ��');
SELECT * FROM USER_GRADE;
--�����ϴ� ���̺�(�ڽ� ���̺�)
CREATE TABLE USER_FOREIGNKEY1(
    USER_NO NUMBER PRIMARY KEY,
    USER_ID VARCHAR2(20),
    USER_PWD VARCHAR2(30),
    G_CODE NUMBER,  --USER_GRADE ���̺��� GRADE_CODE �÷��� ������ �÷�
    FOREIGN KEY(G_CODE) REFERENCES USER_GRADE(GRADE_CODE)
    --FOREIGN KEY(�ڽ� �÷�) REFERENCES �θ� ���̺�(�θ� �÷�)
);
    --G_CODE �÷����� USER_GRADE ���̺��� GRADE_CODE �ȿ� �ִ� ���� ���Ե� �� ����
--������ ���� : GRADE_CODE �ȿ� �ִ� ������ ���� ����
INSERT INTO USER_FOREIGNKEY1 VALUES(1, 'TEST1', 'PASS1', 10);
INSERT INTO USER_FOREIGNKEY1 VALUES(2, 'TEST2', 'PASS2', 20);
INSERT INTO USER_FOREIGNKEY1 VALUES(3, 'TEST3', 'PASS3', 30);
--���� �� �ߺ� ������ ���� : ���� ����
INSERT INTO USER_FOREIGNKEY1 VALUES(4, 'TEST4', 'PASS4', 30);
--�θ� �÷��� ���� �� ���� : ���� �߻�
INSERT INTO USER_FOREIGNKEY1 VALUES(5, 'TEST5', 'PASS5', 50);
--NULL �� ����
INSERT INTO USER_FOREIGNKEY1 VALUES(6, 'TEST6', 'PASS6', NULL);

SELECT * FROM USER_FOREIGNKEY1;

--�θ� ���̺��� ������ �÷��� ������ �ִ� ���
CREATE TABLE USER_FOREIGNKEY2(
    USER_NO NUMBER PRIMARY KEY,
    USER_ID VARCHAR2(20),
    USER_PWD VARCHAR2(30),
    G_CODE NUMBER NOT NULL UNIQUE,  --USER_GRADE ���̺��� GRADE_CODE �÷��� ������ �÷�
    FOREIGN KEY (G_CODE) REFERENCES USER_GRADE(GRADE_CODE)
);
--������ ���� : GRADE_CODE �ȿ� �ִ� ������ ���� ����
INSERT INTO USER_FOREIGNKEY2 VALUES(1,'TEST1','PASS1',10);
INSERT INTO USER_FOREIGNKEY2 VALUES(2,'TEST2','PASS2',20);
INSERT INTO USER_FOREIGNKEY2 VALUES(3,'TEST3','PASS3',30);
--���� �� �ߺ� ������ ���� : UNIQUE ���� �����Ǿ� �־ ���� �߻�
INSERT INTO USER_FOREIGNKEY2 VALUES(4,'TEST4','PASS4',30);
--�θ��÷��� ���� �� ���� : ���� �߻�
INSERT INTO USER_FORSIGNKEY2 VALUES(5,'TEST5','PASS5',50);
--NULL �� ���� : NOT NULL ���� ������ �Ǿ� �־ ���� �߻�
INSERT INTO USER_FOREIGNKEY2 VALUES(6,'TEST6','PASS6',NULL);

SELECT * FROM USER_FOREIGNKEY2;

/*
    ���� �ɼ�1
    �⺻ ���� �ɼ��� ON DELETE RESTRICTED : �ڽ��� ���� ���� �θ� ���̺� ������ ���� �Ұ���
*/
DELETE FROM USER_GRADE WHERE GRADE_CODE=30; --���� �߻�

/*
    ���� �ɼ�2
    ON DELETE SET NULL : �θ� ���̺��� ������ ���� �� �����ϰ� �ִ� �ڽ� ���̺��� �÷� ���� NULL�� �����
*/
--�����Ǵ� ���̺�(�θ� ���̺�)
CREATE TABLE USER_GRADE2(
    GRADE_CODE NUMBER PRIMARY KEY,
    GEADE_NAME VARCHAR2(30) NOT NULL
);
INSERT INTO USER_GRADE2 VALUES(10,'�Ϲ�ȸ��');
INSERT INTO USER_GRADE2 VALUES(20,'���ȸ��');
INSERT INTO USER_GRADE2 VALUES(30,'Ư��ȸ��');
SELECT * FROM USER_GRADE2;
--�����ϴ� ���̺�(�ڽ� ���̺�)
CREATE TABLE USER_FOREIGNKEY3(
    USER_NO NUMBER PRIMARY KEY,
    USER_ID VARCHAR2(20),
    USER_PWD VARCHAR2(30),
    G_CODE NUMBER,
    FOREIGN KEY(G_CODE) REFERENCES USER_GRADE2(GRADE_CODE) ON DELETE SET NULL
);
--������ ����
INSERT INTO USER_FOREIGNKEY3 VALUES(1, 'TEST1', 'PASS1',10);
INSERT INTO USER_FOREIGNKEY3 VALUES(2, 'TEST2', 'PASS2',20);
INSERT INTO USER_FOREIGNKEY3 VALUES(3, 'TEST3', 'PASS3',30);
SELECT * FROM USER_FOREIGNKEY3;
--����
DELETE FROM USER_GRADE2 WHERE GRADE_CODE=30;
SELECT * FROM USER_GRADE2;

/*
    ���� �ɼ�3
    ON DELETE CASCADE : �θ� ���̺��� ������ ���� �� �����ϰ� �ִ� �ڽ� ���̺��� �÷� ���� �����ϴ� �� ��ü ����
*/
--�θ� ���̺� ����
CREATE TABLE USER_GRADE3(
    GRADE_CODE NUMBER PRIMARY KEY,
    GRADE_NAME VARCHAR2(30) NOT NULL
);
INSERT INTO USER_GRADE3 VALUES(10,'�Ϲ�ȸ��');
INSERT INTO USER_GRADE3 VALUES(20,'���ȸ��');
INSERT INTO USER_GRADE3 VALUES(30,'Ư��ȸ��');
SELECT * FROM USER_GRADE3;
--�ڽ� ���̺� ����
CREATE TABLE USER_FOREIGNKEY4(
    USER_NO NUMBER PRIMARY KEY,
    USER_ID VARCHAR2(20),
    USER_PWD VARCHAR2(30),
    G_CODE NUMBER REFERENCES USER_GRADE3(GRADE_CODE) ON DELETE CASCADE
    --�÷����� �ۼ� : �÷��� ������Ÿ�� REFERENCES �θ����̺�(�θ��÷�) ON DELETE CASCADE
);
INSERT INTO USER_FOREIGNKEY4 VALUES(1,'TEST1','PASS1',10);
INSERT INTO USER_FOREIGNKEY4 VALUES(2,'TEST2','PASS2',20);
INSERT INTO USER_FOREIGNKEY4 VALUES(3,'TEST3','PASS3',30);
SELECT *FROM USER_FOREIGNKEY4;
--�θ����̺� ������ ����
DELETE FROM USER_GRADE3 WHERE GRADE_CODE=30;

--------------------------------------------------------------------------------

--CHECK ��������
CREATE TABLE USER_CHECK(
    USER_NO NUMBER PRIMARY KEY,
    USER_ID VARCHAR2(20) UNIQUE,
    USER_PWD VARCHAR2(30) NOT NULL,
    USER_NAME VARCHAR2(30),
    GENDER VARCHAR2(5) CHECK (GENDER IN ('��','��'))
);
--������ ���� : CHECK ���ǿ� �ִ� �����ʹ� ���� ����
INSERT INTO USER_CHECK VALUES (1, 'TEST1', 'PASS1', 'TEST1', '��');
INSERT INTO USER_CHECK VALUES (2, 'TEST2', 'PASS2', 'TEST2', '��');
--CHECK ���ǿ� ���� ������ ���� : ���� �߻�
INSERT INTO USER_CHECK VALUES (3, 'TEST3', 'PASS3', 'TEST3', 'M');
SELECT * FROM USER_CHECK;
