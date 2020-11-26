--------------------------------------------------------------------------------
/*
    동의어(SYNONYM)
    다른 데이터베이스(사용자)가 가진 객체에 대한 별명, 혹은 줄임말
    여러 사용자가 테이블을 공유할 경우, 
    다른 사용자의 객체를 참조할 때는 [사용자 ID].[객체명]으로 접근을 해야함
    이처럼 길게 표현되는 것을 동의어(SYNONYM)으로 설정 후 간단히 사용 가능
    
    비공개 동의어
        객체에 대한 접근 권한을 부여받은 사용자가 정의한 동의어로 해당 사용자만 사용 가능
    공개 동의어
        권한을 주는 사용자(DBA,관리자)가 정의한 동의어로 모든 사용자가 사용 가능(PUBLIC)
        EX) DUAL
*/
--------------------------------------------------------------------------------
SELECT * FROM DBA_SYS_PRIVS WHERE GRANTEE='KH';
SELECT * FROM DBA_ROLE_PRIVS WHERE GRANTEE='KH';
--KUSER 계정에 접속 권한 부여(관리자 계정)
GRANT CREATE SESSION TO KUSER;
--테스트를 위해 KUSER 계정에 KH.EMPLOYEE 테이블 조회 권한 부여(관리자 OR KH 계정)
GRANT SELECT ON KH.EMPLOYEE TO KUSER;

--테이블 조회 해보기(KUSER 계정)
SELECT * FROM KH.EMPLOYEE;

--------------------------------------------------------------------------------
/*
    동의어 생성
    CREATE [PUBLIC|PRIVATE] SYNONYM <줄임말> FOR [사용자명.]<객체명>;
*/
--------------------------------------------------------------------------------
--비공개 동의어 생성(KH계정)
    --CREATE SYNONYM 권한 없으면 오류 발생
CREATE /*PRIVATE*/ SYNONYM EMP FOR /*KH.*/ EMPLOYEE; --에러
SELECT * FROM SESSION_PRIVS;
    --KH계정에 CREATE SYNONYM 권한 부여(관리자 계정)
GRANT CREATE SYNONYM TO KH;
    --권한 부여 후 SYSNONYM 생성(KH계정)
CREATE SYNONYM EMP FOR EMPLOYEE; --정상 생성됨
    --현재 계정의 동의어 설정 조회(KH계정)
SELECT * FROM USER_SYNONYMS;
    --모든 동의어 설정 조회
SELECT * FROM ALL_SYNONYMS;
SELECT * FROM TAB; --원래는 SYS.TAB이지만 동의어 설정하여 TAB으로 조회가능
SELECT * FROM ALL_SYNONYMS WHERE TABLE_OWNER='KH';
    --설정 확인(KH계정)
SELECT * FROM EMPLOYEE;
SELECT * FROM EMP;
    --다른 계정에서 사용 시도(관리자, KUSER계정)
SELECT * FROM KH.EMPLOYEE;
SELECT * FROM EMP;  --관리자, KUSER 모두 EMP 동의어로 사용 불가능

--공개 동의어 생성(관리자 계정)
CREATE PUBLIC SYNONYM PUB_EMP FOR KH.EMPLOYEE;
    --동의어 설정 조회(관리자 계정)
SELECT * FROM USER_SYNONYMS;
SELECT * FROM ALL_SYNONYMS WHERE TABLE_OWNER = 'KH';
    --설정 확인(관리자, KH, KUSER 계정)
SELECT * FROM PUB_EMP;


--------------------------------------------------------------------------------
/*
    동의어 삭제
    DROP SYNONYM <동의어명>;
    PUBLIC 동의어를 제거할 때는 DROP PUBLIC SYNONYM 권한이 있어야 함
*/
--------------------------------------------------------------------------------
--비공개 동의어 삭제(KH 계정)
DROP SYNONYM EMP;
--공개 동의어 삭제(관리자 계정)
DROP PUBLIC SYNONYM PUB_EMP; --권한 없으면 오류(관리자 계정에서 삭제)