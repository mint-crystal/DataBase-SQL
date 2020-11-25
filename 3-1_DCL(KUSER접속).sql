SHOW USER;

--테이블 생성
CREATE TABLE TEST_TB(
    NO NUMBER,
    NAME VARCHAR(20),
    AGE NUMBER
); --테이블 생성 권한이 없어서 오류

SELECT * FROM KH.EMPLOYEE; --권한이 없어서 오류
SELECT * FROM KH.EMPLOYEE; --오브젝트 SELECT 권한을 주어 조회 가능

    --현재 접속 계정 시스템 권한 확인
SELECT * FROM SESSION_PRIVS; --CREATE SESSION
    --현재 접속 계정 오브젝트 권환 확인
SELECT * FROM USER_TAB_PRIVS_RECD; --사용자에게 부여된 권한
SELECT * FROM USER_TAB_PRIVS_MADE; --사용자가 부여한 권한 
                                    --KUSER에서 부여한 권한 없어서 아무것도 안 뜸
                        
SELECT * FROM KH.EMPLOYEE; --관리자 계정에서 오브젝트 권한 제거로 오류



--------------------------------------------------------------------------------
--------------------------------------------------------------------------------
--2020년 11월 25일

SHOW USER;

SELECT * FROM KH.EMPLOYEE;

CREATE TABLE MEMBER (NO NUMBER, NAME VARCHAR(20), AGE NUMBER);

DESC MEMBER;
--테이블 조작
INSERT INTO MEMBER VALUES (1, '홍길동', 20);
SELECT * FROM MEMBER;
UPDATE MEMBER SET AGE=30 WHERE NO = 1;
DELETE FROM MEMBER;

SELECT * FROM USER_TAB_PRIVS;

--데이터 다시 삽입
INSERT INTO MEMBER VALUES (1, '홍길동', 20);
COMMIT;
--KH계정에서 조회할 수 있도록 권한 부여
GRANT SELECT ON MEMBER TO KH;

SELECT * FROM SESSION_PRIVS;
SELECT * FROM USER_TAB_PRIVS;
--KUSER2 계정에 CREATE SESSION 권한 부여
GRANT CREATE SESSION TO KUSER2;
--KUSER2 계정에 CREATE VIEW 권한 부여
    --KUSER 계정에 CREATE VIEW 권한이 없기 때문에 다른 사용자에게 부여하지 못함
GRANT CREATE VIEW TO KUSER2;

--KUSER2 계정에 KH.EMPLOYEE 테이블의 조회 권한 부여
GRANT SELECT ON KH.EMPLOYEE TO KUSER2;

