--해당 계정의 기본 테이블 스페이스 조회
    --객체 생성 시 테이블 스페이스를 지정하지 않고 생성하면 자동으로 저장될 테이블 스페이스
    --계정에 DAFAULT TABLESPACE를 지정하지 않은 경우 SYSTEM TABLESPACE로 생성됨
SELECT USERNAME, DEFAULT_TABLESPACE FROM USER_USERS;

-- 특정 테이블 스페이스의 테이블 조회
SELECT TABLESPACE_NAME, TABLE_NAME FROM USER_TABLES WHERE TABLESPACE_NAME = 'SYSTEM';

/*
    DDL(Data Definition Language) ★★★★★
    데이터베이스의 구조를 정의
    객체를(OBJECT) 생성(CREATE), 수정(ALTER), 삭제(DROP), 초기화(TRUNCATE)
    주로 DB관리자 또는 설계자가 사용
    객체(OBJECT) 종류 : DATABASE, TABLESPACE, TABLE, VIEW, SEQUENCE, INDEX,
                    PACKAGE, PROCEDURL, FUNCTION, TRIGGER, SYNONYM, USER 등...
*/

/*
    CREATE문 ★★★★★
    데이터베이스의 객체를 생성하는 구문
    주로 테이블을 생성할 때 사용하며, 그 외에도 다양한 객체들을 생성할 때 사용함
    생성된 구문은 DROP구문을 통해서 제거할 수 있음
*/

--기본 테이블 생성
CREATE TABLE MEMBER (
    MEMBER_ID VARCHAR2(20),
    MEMBER_PWD VARCHAR2(30),
    MEMBER_NAME VARCHAR(20)
);

--테이블 목록 확인 : 모든 계정에 테이블 목록 조회
SELECT * FROM ALL_TABLES;

--테이블 목록 확인 : 현재 계정의 테이블 목록 조회(3가지 방법)
SELECT * FROM TAB;
SELECT * FROM TABS;
SELECT * FROM USER_TABLES;

--테이블 구조 확인
DESC MEMBER;

--테이블 내 데이터 확인
SELECT * FROM MEMBER;

--컬럼 주석(설명)
COMMENT ON COLUMN MEMBER.MEMBER_ID IS '회원아이디';
COMMENT ON COLUMN MEMBER.MEMBER_PWD IS '비밀번호';
COMMENT ON COLUMN MEMBER.MEMBER_NAME IS '회원이름';

--제약조건 이름 확인 
DESC USER_CONSTRAINTS;  
    --오라클에서 만들어져있는 시스템 테이블
    --제약조건에 대한 내용이 자동으로 저장되는 테이블
SELECT CONSTRAINT_NAME FROM USER_CONSTRAINTS;
SELECT * FROM USER_CONSTRAINTS;

--제약조건을 구성하는 컬럼 확인
DESC USER_CONS_COLUMNS;
SELECT COLUMN_NAME  FROM USER_CONS_COLUMNS;
SELECT * FROM USER_CONS_COLUMNS;

--NULL 제약조건 테이블 생성
CREATE TABLE USER_NOTNULL(
    USER_NO NUMBER NOT NULL,
    USER_ID VARCHAR2(20) NOT NULL,
    USER_PWD VARCHAR(30) NOT NULL,
    USER_NAME VARCHAR2(30),
    GENDER VARCHAR2(10),
    PHONE VARCHAR2(30),
    EMAIL VARCHAR2(50)
);

--제약조건 이름 조회(이름을 기준으로 저장)
SELECT * FROM USER_CONSTRAINTS; --NOT NULL을 제외하고는 컬럼 이름을 조회할 수 없음
--SELECT CONSTRAINT_NAME FROM USER_CONSTRAINTS; --위와 비슷한 방법

--제약조건이 설정된 컬럼 조회(컬럼을 기준으로 저장)
SELECT * FROM USER_CONS_COLUMNS; --제약조건이 설정된 컬럼을 모두 확인할 수 있음

--데이터 삽입 : 정상 삽입
INSERT INTO USER_NOTNULL VALUES(1,'USER1','PASS1','홍길동','남','010-1234-1234','hong@kh.or.kr');
INSERT INTO USER_NOTNULL VALUES(2,'USER1','PASS1',NULL,NULL,NULL,NULL);
--NOT NULL 제약조건 설정된 컬럼에 NULL 값이 삽입될 경우 오류 발생
INSERT INTO USER_NOTNULL VALUES(3,NULL,NULL,'홍길동','남','010-1234-1234','hong@kh.or.kr');

--테이블 구조 확인
DESC USER_NOTNULL
--테이블 내 데이터 조회
SELECT * FROM USER_NOTNULL;

--UNIQUE 제약조건 1 : 컬럼 레벨
CREATE TABLE USER_UNIQUE1(
    USER_NO NUMBER,
    USER_ID VARCHAR2(20) UNIQUE,
    USER_PWD VARCHAR2(30) NOT NULL,
    UER_NAME VARCHAR2(30),
    GENDER VARCHAR(10),
    PHONE VARCHAR2(30),
    EMAIL VARCHAR2(50)
);

--데이터 삽입 : 정상 삽입
INSERT INTO USER_UNIQUE1 VALUES(1,'USER1','PASS1','홍길동','남','010-1234-1234','hong@kh.or.kr');
--USER_ID 컬럼(두번째 컬럼)에 중복된 값 삽입으로 오류 발생
INSERT INTO USER_UNIQUE1 VALUES(2,'USER1','PASS1','김길동','남','010-1234-1234','hong@kh.or.kr');
--NULL 값 중복은 가능
INSERT INTO USER_UNIQUE1 VALUES(2,NULL,'PASS1','김길동','남','010-1234-1234','hong@kh.or.kr');
INSERT INTO USER_UNIQUE1 VALUES(2,NULL,'PASS1','김길동','남','010-1234-1234','hong@kh.or.kr');

--테이블 내 데이터 조회
SELECT * FROM USER_UNIQUE1;

--테이블 구조 확인
DESC user_unique1;  --UNIQUE 속성은 나오지 않음

--제약조건 이름 조회
SELECT * FROM USER_CONSTRAINTS WHERE TABLE_NAME='USER_UNIQUE1';

--제약조건이 설정된 컬럼 조회
SELECT * FROM USER_CONS_COLUMNS WHERE constraint_name='SYS_C007004';


--UNIQUE 제약조건 : 테이블레벨
CREATE TABLE USER_UNIQUE2(
    USER_NO NUMBER,
    USER_ID VARCHAR2(20),
    USER_PWD VARCHAR2(30) NOT NULL,
    UER_NAME VARCHAR2(30),
    GENDER VARCHAR(10),
    PHONE VARCHAR2(30),
    EMAIL VARCHAR2(50),
    UNIQUE(USER_ID)
);

--데이터 삽입 : 정상 삽입
INSERT INTO USER_UNIQUE2 VALUES(1,'USER1','PASS1','홍길동','남','010-1234-1234','hong@kh.or.kr');
--USER_ID 컬럼(두번째 컬럼)에 중복된 값 삽입으로 오류 발생
INSERT INTO USER_UNIQUE2 VALUES(2,'USER1','PASS1','김길동','남','010-1234-1234','hong@kh.or.kr');
--NULL 값 중복은 가능
INSERT INTO USER_UNIQUE2 VALUES(2,NULL,'PASS1','김길동','남','010-1234-1234','hong@kh.or.kr');
INSERT INTO USER_UNIQUE2 VALUES(2,NULL,'PASS1','김길동','남','010-1234-1234','hong@kh.or.kr');

--테이블 내 데이터 조회
SELECT * FROM USER_UNIQUE2;


--UNIQUE 제약조건 : 테이블레벨2
CREATE TABLE USER_UNIQUE3(
    USER_NO NUMBER,
    USER_ID VARCHAR2(20),
    USER_PWD VARCHAR2(30) NOT NULL,
    UER_NAME VARCHAR2(30),
    GENDER VARCHAR(10),
    PHONE VARCHAR2(30),
    EMAIL VARCHAR2(50),
    UNIQUE(USER_NO, USER_ID)
);

--데이터 삽입 : 정상 삽입
INSERT INTO USER_UNIQUE3 VALUES(1,'USER1','PASS1','홍길동','남','010-1234-1234','hong@kh.or.kr');
INSERT INTO USER_UNIQUE3 VALUES(2,'USER1','PASS1','김길동','남','010-1234-1234','hong@kh.or.kr');
INSERT INTO USER_UNIQUE3 VALUES(2,'USER2','PASS1','김길동','남','010-1234-1234','hong@kh.or.kr');
--USER_NO(첫번째 컬럼)와 USER_ID(두번째 컬럼) 모두 같은 데이터 삽입 시 오류 발생
INSERT INTO USER_UNIQUE3 VALUES(2,'USER2','PASS1','김길동','남','010-1234-1234','hong@kh.or.kr');
--한 컬럼이라도 값이 있는 경우 오류 발생
INSERT INTO USER_UNIQUE3 VALUES(2,NULL,'PASS1','김길동','남','010-1234-1234','hong@kh.or.kr');
INSERT INTO USER_UNIQUE3 VALUES(NULL,'USER2','PASS1','김길동','남','010-1234-1234','hong@kh.or.kr');
--두개 컬럼 모두 NULL 값 중복은 가능
INSERT INTO USER_UNIQUE3 VALUES(NULL,NULL,'PASS1','김길동','남','010-1234-1234','hong@kh.or.kr');
INSERT INTO USER_UNIQUE3 VALUES(NULL,NULL,'PASS1','김길동','남','010-1234-1234','hong@kh.or.kr');

--테이블 내 데이터 조회
SELECT * FROM USER_UNIQUE3;
