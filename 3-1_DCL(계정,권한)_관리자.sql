--------------------------------------------------------------------------------
/*
    DCL (DATA CONTROL LANGUAGE)
    DB에 대한 보안, 무결성, 복구 등 DBMS를 제어하기 위한 언어
    사용자의 권한이나 관리자 설정 등을 처리
        GRANT(유저 권한 생성), REVOKE(유저 권한 삭제)
    트랜잭션에 관련된 언어(TCL)
        COMMIT(실행), ROLLBACK(복구)
*/
--------------------------------------------------------------------------------


--------------------------------------------------------------------------------
/*
    계정관리
    데이터 베이스를 사용하기 위한 계정
    데이터 베이스에 접근하기 위해서는 해당 사용자로 로그인해서 사용해야 함
    
    데이터베이스의 관리자 계정
        데이터베이스의 생성과 관리를 담당하는 계정
        모든 권환과 책임을 가지는 계정
    데이터베이스의 사용자 계정
        데이터베이스에 대하여 질의, 갱신, 보고서 작성 등의 작업을 수행할 수 있는 계정
        업무에 필요한 최소한의 권한만 가지는 것을 원칙으로 함
*/
--------------------------------------------------------------------------------
--데이터 베이스 내 생성된 계정 확인
SELECT * FROM DBA_USERS;
--현재 접속 계정 확인
SHOW USER;

--계정 생성
/*
    CREATE USER <USER_NAME>
    [
        IDENTIFIED BY <PASSWORD>
        DEFAULT TABLESPACE <TABLESPACE_NAME>
        TEMPORARY TABLESPACE <TEMP_TABLESPACE_NAME>
        QUOTA <SIZE | UNLIMITIED> ON <TABLESPACE_NAME>
        PROFILE <PROFILE | DEFAULT>
        PASSWORD EXPIRE
        ACCOUNT <LOCK | UNLOCK>
    ];
        
       --옵션--
        IDENTIFIED BY [PASSWORD] : 해당 유저의 비밀번호를 설정하는 옵션
        DEFAULT TABLESPACE [TABLESPACE_NAME] : 
                해당 유저로 세그먼트를 생성했을 경우 사용하는 기본 테이블스페이스 
        TEMPORARY TABLESPACE [TEMP_TABLESPACE_NAME] : 
                해당 유저로 접속하여 정렬 등의 작업 수행 시 사용하는 테이블스페이스
        QUOTA [SIZE / UNLIMITED] ON [TABLESPACE_NAME] :
                특정 테이블스페이스에 해당 유저가 사용할 수 있는 공간 용량을 설정하는 옵션
        PROFILE [PROFILE | DEFAULT] : user의 password나 resource에 대해 제한
        PASSWORD EXPIRE : 최초 접속 시 password 재설정
        ACCOUNT [LOCK | UNLOCK] : 계정에 대한 lock 상태
*/
--KUSER 라는 이름의 계정을 생성하면서 비밀번호를 KUSERPASS로 설정하고 계정 잠금 상태로 생성
CREATE USER KUSER IDENTIFIED BY KUSERPASS ACCOUNT LOCK;

--계정조회
SELECT * FROM DBA_USERS;

--접속테스트(GUI로 해도 됨) : 계정이 잠겨 있어서 접속 안 됨
CONNECT KUSER/KUSERPASS;


--계정 수정
/*
    ALTER USER <USERNAME>
    [
        IDENTIFIED BY <PASSWORD>
        DEFAULT TABLESPACE <TABLESPACE_NAME>
        TEMPORARY TABLESPACE <TEMP_TABLESPACE_NAME>
        QUOTA <SIZE | UNLIMITIED> ON <TABLESPACE_NAME>
        ACCOUNT <LOCK | UNLOCK>
    ];
*/
--계정 잠금 해제
ALTER USER KUSER ACCOUNT UNLOCK; --관리자계정이어서 비밀번호 없이도 잠금 해제 가능
SELECT * FROM DBA_USERS;
 
--접속 테스트 : LOCK은 풀렸지만 접속권한이 없어서 접속 안 됨
CONNECT KUSER/KUSERPASS;

--계정 비밀번호 변경
ALTER USER KUSER IDENTIFIED BY KPASS;

--접속 테스트 : 비밀번호 틀려서 접속 안 됨
CONNECT KUSER/KUSERPASS;
--접속 테스트 : 비밀번호는 맞지만 접속 권한이 없어서 접속 안 됨
CONNECT KUSER/KPASS;


--계정 삭제
/*
    DROP USER <USERNAME> [CASCADE];
    CASCADE : 계정과 관련된 모든 데이터베이스 스키마가 데이터 사전으로부터 삭제되고
            모든 스키마 객체도 물리적으로 삭제
*/
--KUSER 계정을 삭제
DROP USER KUSER CASCADE;
--삭제 확인
SELECT * FROM DBA_USERS;


--------------------------------------------------------------------------------
/*
    권한 관리
*/
--------------------------------------------------------------------------------
--권한 실습을 위한 계정 생성
CREATE USER KUSER IDENTIFIED BY KUSER;

--계정 조회
SELECT * FROM DBA_USERS;

--접속 시도 : 접속 권한 없음
CONNECT KUSER/KUSER;

--시스템 권한 부여
    --GRANT <권한, ...> TO USER<USERNAME>;
GRANT CREATE SESSION TO KUSER;
    --접속 시도 : 접속됨
    CONNECT KUSER/KUSER;
    
--KUSER 계정으로 KH.EMPLOYEE 조회 시도 : 안 됨
--SELECT * FROM KH.EMPLOYEE;

--오브젝트 권한 부여
    --GRANT <권한, ...> ON <OBJECT_NAME> TO <USERNAME>;
GRANT SELECT ON KH.EMPLOYEE TO KUSER;
--KUSER 계정으로 KH.EMPLOYEE 조회 시도 : 조회 가능
--SELECT * FROM KH.EMPLOYEE;

/* 권환 확인 */
--사용자에게 부여된 시스템 권한 확인 (관리자)
SELECT * FROM DBA_SYS_PRIVS WHERE GRANTEE = 'KUSER';
--사용자에게 부여되 오브젝트 권환 확인 (관리자)
SELECT * FROM DBA_TAB_PRIVS WHERE GRANTEE = 'KUSER';
--현재 접속 계정 시스템 권한 확인
SELECT * FROM SESSION_PRIVS;
--현재 접속 계정 오브젝트 권환 확인
SELECT * FROM USER_TAB_PRIVS_RECD; --사용자에게 부여된 권한

--오브젝트 권한 제거
    --REVOKE <권한, ...> ON <OBJECT_NAME> FROM <USERNAME>;
REVOKE SELECT ON KH.EMPLOYEE FROM KUSER;

--시스템 권한 제거
    --REVOKE <권한, ...> FROM <USERNAME>;
REVOKE CREATE SESSION FROM KUSER;
CONNECT KUSER/KUSER; --권한 제거로 오류

--------------------------------------------------------------------------------
--2020년 11월 25일

--KUSER 권한 확인
SELECT * FROM DBA_SYS_PRIVS WHERE GRANTEE = 'KUSER';
SELECT * FROM DBA_TAB_PRIVS WHERE GRANTEE = 'KUSER';
SELECT * FROM DBA_ROLE_PRIVS WHERE GRANTEE = 'KUSER';
--KUSER 접속 테스트
CONNECT KUSER/KUSER;
--KUSER 접속 권한, 테이블 생성 권한 부여(시스템 권한)
GRANT CREATE SESSION, CREATE TABLE TO KUSER;
--KUSER 계정에 KH계정이 만든 EMPLOYEE 테이블을 조회할 수 있는 권한 부여(오브젝트 권한)
GRANT SELECT ON KH.EMPLOYEE TO KUSER;
--KUSER 권한 조회
SELECT * FROM DBA_SYS_PRIVS WHERE GRANTEE = 'KUSER';
SELECT * FROM DBA_TAB_PRIVS WHERE GRANTEE = 'KUSER';
--DEFAULT 테이블 스페이스가 SYSTEM인 경우 테이블 생성 불가능
    --테이블 스페이스에 대한 권한을 부여해줘야함
GRANT UNLIMITED TABLESPACE TO KUSER;

--새로운 계정 생성
SELECT * FROM SESSION_PRIVS;
CREATE USER KUSER2 IDENTIFIED BY KUSER2;

--KUSER 계정에 WITH ADMIN OPTION 적용 : 다른 사용자에게 시스템 권한 부여 허가
GRANT CREATE SESSION, CREATE TABLE, UNLIMITED TABLESPACE TO KUSER WITH ADMIN OPTION;
SELECT * FROM DBA_SYS_PRIVS WHERE GRANTEE = 'KUSER';
SELECT * FROM KUSER.MEMBER;

--KUSER계정에 WITH GRANT OPTION 적용 : 다른 사용자에게 오브젝드 권한 부여 허가
GRANT SELECT ON KH.EMPLOYEE TO KUSER WITH GRANT OPTION;

--KUSER 계정에 부여된 권한 제거
REVOKE CREATE SESSION, CREATE TABLE, UNLIMITED TABLESPACE FROM KUSER;
REVOKE SELECT ON KH.EMPLOYEE FROM KUSER;

SELECT * FROM DBA_SYS_PRIVS WHERE GRANTEE = 'KUSER';
SELECT * FROM DBA_TAB_PRIVS WHERE GRANTEE = 'KUSER';

--------------------------------------------------------------------------------
/*  ROLE
    사용자에게 허가 할 수 있는 권한들의 집합
    ROLE을 이용하면 권한 부여와 회수에 용이함
    
    -- 설명
    사용자마다 일일히 권한을 부여하는 것은 번거롭기 때문에 
        간편하게 권한을 부여할 수 있는 방법으로 ROLE을 제공
    사용자에게 보다 간편하게 부여할 수 있도록 여러개의 권한을 묶어놓은 것
     => 사용자 권한 관리를 보다 간편하고 효율적으로 할 수 있게 함
       다수의 사용자에게 공통적으로 필요한 권한들을 하나의 롤로 묶고,
       사용자에게는 특정 롤에 대한 권한을 부여할 수 있도록 함.
       사용자에게 부여한 권한을 수정하고자 할 때에도,
       롤만 수정하면 그 롤에 대한 권한을 부여받은 사용자들의 권한이 자동으로 수정된다.
       롤을 활성화하거나 비활성화하여 일시적으로 권한을 부여하고 철회할 수 있음
       
    롤의 종류
    1. 사전 정의된 롤 : 오라클 설치시 시스템에서 기본적으로 제공됨
        CONNECT, RESOURDCE, DBA 등...
        CONNECT ROLE
            사용자가 데이터 베이스에 접속 가능하도록 하기위한 권한이 있는 ROLE
            CONNECT ROLE 이 부여되지 않으면 계정이 존재하더라도 해당 계정으로 접속을 할 수 없음
            -- CREATE SESSION
        RESOURCE ROLE
            CREATE 구문을 통해 객체를 생성할 수 있는 권한을 모아 놓은 ROLE
            -- CREATE TRIGGER, CREATE SEQUENCE, CREATE TYPE, CREATE PROCEDURE, 
            -- CREATE CLUSTER, CREATE OPERATOR, CREATE INDEXTYPE, CREATE TABLE
        DBA ROLE
            대부분의 시스템 권한 및 기타 여러가지 ROLE
            
    2. 사용자가 정의하는 롤 : CREAET ROLE 명령으로 롤을 생성함
        롤 생성은 반드시 DBA권한이 있는 사용자만 할 수 있음
         CREATE ROLE 롤이름;  -- 1. 롤 생성
         GRANT 권한종류 TO 롤이름;   -- 2. 생성된 롤에 권한 추가
         GRANT 롤이름 TO 사용자이름; -- 3. 사용자에게 롤 부여        
         DROP ROLE 롤이름;  -- 4. 롤 제거
*/
--------------------------------------------------------------------------------
--ROLE에 부여된 권한 확인
    --SELECT * FROM DBA_SYS_PRIVS WHERE GRANTEE = 'ROLE 이름';
SELECT * FROM DBA_SYS_PRIVS WHERE GRANTEE = 'CONNECT';
SELECT * FROM DBA_SYS_PRIVS WHERE GRANTEE = 'RESOURCE';
SELECT * FROM DBA_SYS_PRIVS WHERE GRANTEE = 'DBA';

SELECT * FROM DBA_SYS_PRIVS;

--계정에 ROLE 부여
    --GRENT <ROLE, ...> TO <계정 명>;
GRANT CONNECT, RESOURCE TO KUSER;

SELECT * FROM DBA_SYS_PRIVS WHERE GRANTEE = 'KUSER';

--계정에 부여된 ROLE 확인
    --SELECT * FROM DBA_ROLE_PRIVS WHERE GRANTEE='계정 명';
SELECT * FROM DBA_ROLE_PRIVS WHERE GRANTEE = 'KUSER';

--계정에 부여된 ROLE 제거
    --REVOKE <ROLE,...> FROM <계정명>;
REVOKE CONNECT, RESOURCE FROM KUSER;

SELECT * FROM DBA_SYS_PRIVS WHERE GRANTEE = 'KUSER';
SELECT * FROM DBA_ROLE_PRIVS WHERE GRANTEE = 'KUSER';