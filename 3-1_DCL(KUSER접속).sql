SHOW USER;

--���̺� ����
CREATE TABLE TEST_TB(
    NO NUMBER,
    NAME VARCHAR(20),
    AGE NUMBER
); --���̺� ���� ������ ��� ����

SELECT * FROM KH.EMPLOYEE; --������ ��� ����
SELECT * FROM KH.EMPLOYEE; --������Ʈ SELECT ������ �־� ��ȸ ����

    --���� ���� ���� �ý��� ���� Ȯ��
SELECT * FROM SESSION_PRIVS; --CREATE SESSION
    --���� ���� ���� ������Ʈ ��ȯ Ȯ��
SELECT * FROM USER_TAB_PRIVS_RECD; --����ڿ��� �ο��� ����
SELECT * FROM USER_TAB_PRIVS_MADE; --����ڰ� �ο��� ���� 
                                    --KUSER���� �ο��� ���� ��� �ƹ��͵� �� ��
                        
SELECT * FROM KH.EMPLOYEE; --������ �������� ������Ʈ ���� ���ŷ� ����



--------------------------------------------------------------------------------
--------------------------------------------------------------------------------
--2020�� 11�� 25��

SHOW USER;

SELECT * FROM KH.EMPLOYEE;

CREATE TABLE MEMBER (NO NUMBER, NAME VARCHAR(20), AGE NUMBER);

DESC MEMBER;
--���̺� ����
INSERT INTO MEMBER VALUES (1, 'ȫ�浿', 20);
SELECT * FROM MEMBER;
UPDATE MEMBER SET AGE=30 WHERE NO = 1;
DELETE FROM MEMBER;

SELECT * FROM USER_TAB_PRIVS;

--������ �ٽ� ����
INSERT INTO MEMBER VALUES (1, 'ȫ�浿', 20);
COMMIT;
--KH�������� ��ȸ�� �� �ֵ��� ���� �ο�
GRANT SELECT ON MEMBER TO KH;

SELECT * FROM SESSION_PRIVS;
SELECT * FROM USER_TAB_PRIVS;
--KUSER2 ������ CREATE SESSION ���� �ο�
GRANT CREATE SESSION TO KUSER2;
--KUSER2 ������ CREATE VIEW ���� �ο�
    --KUSER ������ CREATE VIEW ������ ���� ������ �ٸ� ����ڿ��� �ο����� ����
GRANT CREATE VIEW TO KUSER2;

--KUSER2 ������ KH.EMPLOYEE ���̺��� ��ȸ ���� �ο�
GRANT SELECT ON KH.EMPLOYEE TO KUSER2;

