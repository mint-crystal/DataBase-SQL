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