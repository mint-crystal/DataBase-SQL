--------------------------------------------------------------------------------
/*
    TRIGGER(Ʈ����)
    Ʈ������ ������ �ǹ� : ���� ����
    ���̺��̳� �信�� Ư�� �̺�Ʈ�� ������ �ڵ����� ����Ǵ� ������ ����
    �̺�Ʈ : INSERT, UPDATE, DELETE
    ���� : BEFORE(�̺�Ʈ ��), AFTER(�̺�Ʈ ��)
    
    Ʈ���� ���� ���
        CREATE [OR REPLACE] TRIGGER <Ʈ���Ÿ�> <����> <�̺�Ʈ> ON <���̺��|���>
        [FOR EACH ROW]
        BEGIN
            ������ ����;
        END;
        /
        
    Ʈ���� ����
        ���� Ʈ���� : FOR EACH ROW�� �����ϸ� ���� Ʈ���Ű� ��
            �̺�Ʈ �� �� �߻� �� ������ ������ ���̺� Ȥ�� �� ������ �� ���� ����
            EX) ���� �̺�Ʈ�� �� �� �߻� �� 5�� �����Ͱ� ���� �� ��� : Ʈ���� �� ���� �����
        �� Ʈ���� : FOR EACH ROW�� �����ϸ� �� Ʈ���Ű� ��
            �̺�Ʈ �� �� �߻� �� ������ ������ �� ������ ����
            EX) ���� �̺�Ʈ�� �� �� �߻� �� 5�� �����Ͱ� ���� �� ��� : Ʈ���� 5�� �����
*/
--------------------------------------------------------------------------------
--�μ� ���̺� �μ��� �߰��Ǹ� '�μ��� �߰��Ǿ����ϴ�.' �޽��� ���
SELECT * FROM DEPARTMENT;
CREATE OR REPLACE TRIGGER TEST_TRG1 AFTER INSERT ON DEPT_COPY
BEGIN
    DBMS_OUTPUT.PUT_LINE('�μ��� �߰��Ǿ����ϴ�');
END;
/
--Ʈ���� ��� Ȯ��
SELECT * FROM ALL_TRIGGERS; --��� Ʈ���� ��� ��ȸ
SELECT * FROM USER_TRIGGERS; --�ش� ������� Ʈ���� ��� ��ȸ
SELECT * FROM USER_SOURCE; --Ʈ���� �� ��ȸ
SELECT * FROM USER_SOURCE WHERE NAME='TEST_TRG1';

--Ʈ���� ����
    --Ʈ������ ������ �����Ű�°� �ƴ϶� ������ �̺�Ʈ�� �߻��Ǹ� �ڵ����� ����
INSERT INTO DEPT_COPY VALUES('D10','�λ��','L3');
    --�μ� ���̺��� DEPT_ID ZMRLRK CHAR(2)�� �Է� �� �� ���
SELECT * FROM DEPT_COPY;
DESC DEPT_COPY;
ALTER TABLE DEPT_COPY MODIFY DEPT_ID CHAR(3);

--�μ����̺� ������ ������ �� 'DEPT_TITLE�� �����Ǿ����ϴ�.' ���
--���� Ʈ����
CREATE OR REPLACE TRIGGER TEST_TRG2 BEFORE DELETE ON DEPT_COPY
BEGIN
    DBMS_OUTPUT.PUT_LINE('�μ��� �����Ǿ����ϴ�');
END;
/
SELECT * FROM DEPT_COPY;
DELETE FROM DEPT_COPY WHERE LOCATION_ID='L1';
ROLLBACK;

--�� Ʈ����(Ʈ���Ŵ� ���� ����, �̺�Ʈ, ���̺�� ���Ӱ� ������ �ȵ�. ������ OR REPLACE�� �����)
    --OLD ������ : �̺�Ʈ�� �Ͼ�� �� ������
    --NEW ������ : �̺�Ʈ�� �Ͼ �� ������
    --INSERT(NEW), UPDATE(OLD,NEW), DELETE(OLD)
CREATE OR REPLACE TRIGGER TEST_TRG2 BEFORE DELETE ON DEPT_COPY
FOR EACH ROW
BEGIN
    DBMS_OUTPUT.PUT_LINE('�μ��� �����Ǿ����ϴ�');
END;
/
SELECT * FROM USER_SOURCE WHERE NAME='TEST_TRG2';
SELECT * FROM DEPT_COPY;
DELETE FROM DEPT_COPY WHERE LOCATION_ID='L1';
ROLLBACK;
    --��� �� �μ��� ���
CREATE OR REPLACE TRIGGER TEST_TRG2 BEFORE DELETE ON DEPT_COPY
FOR EACH ROW
BEGIN
    DBMS_OUTPUT.PUT_LINE(:OLD.DEPT_TITLE||'�� �����Ǿ����ϴ�');
END;
/
SELECT * FROM USER_SOURCE WHERE NAME='TEST_TRG2';
SELECT * FROM DEPT_COPY;
DELETE FROM DEPT_COPY WHERE LOCATION_ID='L1';
ROLLBACK;
    --������ �ѹ� �� �� ��� ���̺� �����ϰ� �ٽ� �����ϱ�
DROP TABLE DEPT_COPY;
CREATE TABLE DAPT_COPY AS SELECT * FROM DEPARTMENT;

--Ʈ���� ����
DROP TRIGGER TEST_TRG1;