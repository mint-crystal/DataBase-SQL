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