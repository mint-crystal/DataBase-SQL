--------------------------------------------------------------------------------
/*
    ������(SEQUENCE)
    -- �ڵ� ��ȣ �߻��� ������ �ϴ� ��ü
    -- ���������� ���� ���� �ڵ����� ��������
    -- �ڵ����� ���������� �����ϴ� ������ ��ȯ�ϴ� �����ͺ��̽� ��ü
*/
--------------------------------------------------------------------------------

--------------------------------------------------------------------------------
/*
    ������ ����
    CREATE SQUENCE <�������̸�>
        [STRAT WITH <����>] -- ó�� �߻���ų ���۰� ����, �����ϸ� �ڵ� 1�� �⺻
        [INCREMENT BY <����>] -- ���� ���� ���� ����ġ, �����ϸ� �ڵ� 1�� �⺻
        [MAXVALUE <����> | NOMAXVALUE] -- �߻���ų �ִ밪 ���� (10�� 27��, -1) 
                                (�⺻�� 9999999999999999999999999999)
                               NOMAXVALUE : ����Ʈ�� ����, �����϶� 1027, �����϶� -1
                               MAXVALUE : �ִ밪 ����, ���ۼ��ڿ� ���ų� Ŀ���ϰ� MINVALUE���� Ŀ����
        [MINVALUE ���� | NOMINVALUE] -- �ּҰ� ���� (-10�� 26��) (�⺻�� 1)
                               NOMINVALUE : ����Ʈ�� ����, �����϶� 1, �����϶� -1028 
                               MINVALUE : �ּҰ� ����, ���ۼ��ڿ� ���ų� �۾ƾ��ϰ� MAXVALUE���� �۾ƾ���
        [CYCLE | NOCYCLE] -- �� ��ȯ ���� ����(�⺻�� NOCYCLE)
                            �������� �ִ밪���� ���� �Ϸ� �� CYCLE�� �ּҰ����� ���ư�
                            NOCYCLE�� ���� �߻�
        [CACHE <����Ʈũ��> | NOCACHE] -- �޸� �󿡼� ������ �� ����(�⺻�� CACHE 20)
                                    CACHE ������ �޸𸮿� ������ ���� �̸� �Ҵ��ϰ� 
                                    NOCACHE ������ ���������� �޸𸮿� �Ҵ����� ����
                                    ĳ���޸� �⺻���� 20����Ʈ, �ּҰ��� 2����Ʈ
                                    Cache�� ����ϸ� ���������� �׼��� ȿ���� Cache�� ������� �ʾ��������� ����
*/
--------------------------------------------------------------------------------
--������ ����
    --300���� �����ؼ� 5�� �����ϰ� �ִ� 310���� �����ϴٰ� 310�� �Ǹ� �׸� �����ϱ�(ĳ����� X)
CREATE SEQUENCE SEQ_EMPID
    START WITH 300
    INCREMENT BY 5
    MAXVALUE 310
    NOCYCLE     --�⺻���� NOCYCLE�̱� ������ ���� ����
    NOCACHE;

--������ ��ȸ
SELECT * FROM USER_SEQUENCES;

--������ ���� �� �ɼ��� ��� �⺻������ ����
CREATE SEQUENCE SEQ_TEST;
SELECT * FROM USER_SEQUENCES;


--------------------------------------------------------------------------------
/*
    ������ ���
    ��������.CURRVAL : ���� ������ �� Ȯ��
    ��������.NEXTVAL : ���������� ���� ���� �� ��������
*/
--------------------------------------------------------------------------------
--���� CURRVAL �ϱ� ���� NEXTVAL�� �� ���� ������ �Ǿ���
    --NEXTVAL�� �ѹ��� �ؾ� ������ ��ȣ ������
SELECT SEQ_EMPID.CURRVAL FROM DUAL; --����
--��ȣ ����
SELECT SEQ_EMPID.NEXTVAL FROM DUAL; --300
SELECT SEQ_EMPID.CURRVAL FROM DUAL; --300
SELECT * FROM USER_SEQUENCES;
SELECT SEQ_EMPID.NEXTVAL FROM DUAL; --305
SELECT SEQ_EMPID.NEXTVAL FROM DUAL; --310
    --���� ��ȣ�� 315�� �ž� ������ �ִ밪�� 310�̰� NOCYLCE�̱� ������ ���� �߻�
SELECT SEQ_EMPID.NEXTVAL FROM DUAL; --����
SELECT SEQ_EMPID.CURRVAL FROM DUAL;
SELECT * FROM USER_SEQUENCES;


--------------------------------------------------------------------------------
/*
    ������ ����
    ALTER SQUENCE <�������̸�>
        [INCREMENT BY ����] -- ���� ���� ���� ����ġ, �����ϸ� �ڵ� 1�� �⺻
        [MAXVALUE ���� | NOMAXVALUE] -- �߻���ų �ִ밪 ���� (10�� 27��, -1)
        [MINVALUE ���� | NOMINVALUE] -- �ּҰ� ���� (-10�� 26��)
        [CYCLE | NOCYCLE] -- �� ��ȯ ���� ����
        [CACHE ����Ʈũ�� | NOCACHE] -- �޸� �󿡼� ������ �� ����
    START WITH���� ���� �Ұ��� - �����Ϸ��� ������ ���� �� �ٽ� �����ؾ� ��
    �ּҰ�(MINVALUE)�� ���� ������� ������ ��ȣ���� ���� ���� �Ұ���
    �ִ밪(MAXVALUE)�� ���� ������� ������ ��ȣ���� ���� ���� �Ұ���
*/
--------------------------------------------------------------------------------
--SEQ_EMPID �������� ����ġ�� 10���� �����ϰ� �ִ밪�� 400���� ����
ALTER SEQUENCE SEQ_EMPID
    INCREMENT BY 10
    MAXVALUE 400;
    
SELECT * FROM USER_SEQUENCES; --LAST_NUMBER�� 320���� ����
SELECT SEQ_EMPID.CURRVAL FROM DUAL; --310
SELECT SEQ_EMPID.NEXTVAL FROM DUAL; --320
SELECT SEQ_EMPID.NEXTVAL FROM DUAL; --330


--------------------------------------------------------------------------------
/*
    ������ ����
    DROP SEQUENCE <������ ��>;
*/
--------------------------------------------------------------------------------
SELECT * FROM USER_SEQUENCES;
DROP SEQUENCE SEQ_EMPID;
DROP SEQUENCE SEQ_TEST;
SELECT * FROM USER_SEQUENCES;


--------------------------------------------------------------------------------
/*
    ������ Ȱ��
    ��� ����
     SELECT������ ��� ����
     INSERT������ SELECT������ ��밡��
     INSERT������ VALUES������ ��� ����
     UPDATE������ SET������ ��� ����
    
    ��� �Ұ�
     VIEW�� SELECT������ ��� �Ұ�
     DISTINCT Ű���尡 �ִ� SELECT������ ��� �Ұ�
     GROUP BY, HAVING���� �ִ� SELECT������ ��� �Ұ�
     ORDER BY������ ��� �Ұ�
     SELECT, DELETE, UPDATE�� ���� ����
     CREATE TABLE, ALTER TABLE����� DEFAULT������ ��� �Ұ�
*/
--------------------------------------------------------------------------------
--EMPLOYEE��� ���� ���̺��� ������ ����Ҷ� ���� �����ȣ�� �ڵ����� �����ż� ����ǵ��� ����
CREATE SEQUENCE SEQ_EID
    START WITH 2020001
    -- INCREMENT BY 1   --�����ϸ� �⺻���� 1
    MAXVALUE 2020999    --2021���� ����� �Ǹ� �� �Ǳ� ������
    NOCACHE;
SELECT * FROM USER_SEQUENCES;

DESC EMPLOYEE;
--������ �ڵ� ���� ��ȣ�� �ֱ� ���� ������ ũ�� ����
ALTER TABLE EMPLOYEE MODIFY EMP_ID VARCHAR2(7);

SELECT * FROM EMPLOYEE;
INSERT INTO EMPLOYEE VALUES (SEQ_EID.NEXTVAL, '��浿', '888888-1045678', 'kim_gd@kh.or.kr',
    '01012341234', 'D2', 'J7', 'S1', 5000000, 0.1, 200, SYSDATE, NULL, DEFAULT);
SELECT * FROM EMPLOYEE;


--------------------------------------------------------------------------------
/*
    ������ ��ȣ �ʱ�ȭ
    ����Ŭ �������� ��ȣ�� �ʱ�ȭ�ϴ� ������ ����� �������� ����
    (����)MYSQL : AUTO_INCREMENT
    ���� ������ ��ȣ�� ��ȸ�ؼ� �ش� ��ȣ��ŭ ���� �ٽ� ��ȣ�� �����ؼ� ���
*/
--------------------------------------------------------------------------------
SELECT * FROM USER_SEQUENCES;
SELECT SEQ_EID.NEXTVAL FROM DUAL; --2020005
--���� ��ȣ�� 2020006�� �Ǵµ� 2020002������ �ٽ� ����ϰ� ����
    --1. ���� ������ ��ȣ ��ȸ
SELECT SEQ_EID.CURRVAL FROM DUAL;
    --2. ����ġ�� ������ ��ȣ�� ���ϴ� ���� �ǵ��� ����/���� ����
        --����!! ���� ���� ���� �ּҰ����� �۰ų� �ִ밪���� ũ�� �� ��!!
ALTER SEQUENCE SEQ_EID INCREMENT BY -4;
    --3. ����� ����ġ�� ���� �� �ֵ��� ������ ��ȣ ����
SELECT SEQ_EID.NEXTVAL FROM DUAL; --2020001
    --4. ����ġ�� ������� ����
ALTER SEQUENCE SEQ_EID INCREMENT BY 1;