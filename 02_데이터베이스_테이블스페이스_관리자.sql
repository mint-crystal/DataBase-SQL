/*
    DATABASE
        Experess Edition은 하나의 데이터베이스만 사용 가능
        데이터베이스 이름 : xe
        Enterprise Edition은 2개이상의 데이터베이스 생성가능
            일반적으로 dbca를 이용해 자동 생성 - dbca : 자동으로 데이터베이스 만들어주는 기능
            CREATE DATABASE 문으로 수동 생성 가능
*/

--DATABASE 정보 조회
SELECT * FROM V$INSTANCE;

--DATABASE 이름 조회
SELECT NAME FROM V$DATABASE;

/*
    TABLESPACE
        기본 생성되어있는 TABLESPACE가 있음
        필요하면 추가로 생성해서 사용 가능
        CREATE TABLESPACE 문을 이용해서 수동생성
*/

--TABLESPACE 조회
SELECT TABLESPACE_NAME FROM DBA_TABLESPACES;

--현재 로그인된 사용자의 테이블 스페이스 조회
SELECT DISTINCT TABLESPACE_NAME FROM USER_TABLES;

--해당 계정의 기본 테이블 스페이스 조회
    --객체 생성 시 테이블 스페이스를 지정하지 않고 생성하면 자동으로 저장될 테이블 스페이스
SELECT USERNAME, DEFAULT_TABLESPACE FROM USER_USERS;

-- 특정 테이블 스페이스의 테이블 조회
SELECT TABLESPACE_NAME, TABLE_NAME FROM USER_TABLES WHERE TABLESPACE_NAME = 'SYSTEM';