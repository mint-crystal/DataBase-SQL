/*
    테스트 테이블 생성
*/
CREATE TABLE KH_MEMBER(
    NO NUMBER PRIMARY KEY,
    NAME CHAR(15),
    ID VARCHAR2(20) UNIQUE,
    PASSWORD VARCHAR2(50) DEFAULT '1234',
    REG_DATE DATE NOT NULL
);
--데이터 삽입
INSERT INTO KH_MEMBER VALUES(1,'홍길동','master','P@ssw0rd', SYSDATE);
INSERT INTO KH_MEMBER VALUES(2,'이길동','taster','1234qwer',SYSDATE);

/*
    ALTER(객체 수정)
*/
--컬럼 추가(ADD)
--ALTER TABLE 테이블명 ADD <컬럼명> <데이터타입> [옵션] [제약조건];
ALTER TABLE KH_MEMBER ADD AGE NUMBER;
ALTER TABLE KH_MEMBER ADD COUNTRY VARCHAR2(30) DEFAULT '한국';

--컬럼 수정(MODIFY)
--데이터에 미리 NULL이 들어가 있는 경우 NOT NULL 제약조건 설정하면 오류 발생함;
INSERT INTO KH_MEMBER VALUES(3,NULL,'taster2','1234qwer',SYSDATE,20,'미국');
ALTER TABLE KH_MAMBER MODIFY NAME VARCHAR2(15) NOT NULL;
--NULL에 들어간 데이터 삭제
DELETE FROM KH_MEMBER WHERE NO=3;
--ALTER TABLE <테이블명> MODIFY <컬럼명> <데이터타입> [옵션] [제약조건];
ALTER TABLE KH_MEMBER MODIFY NAME VARCHAR2(15) NOT NULL;
ALTER TABLE KH_MEMBER MODIFY PASSWORD VARCHAR2(50) DEFAULT 'qwer1234';

DESC KH_MEMBER;

--컬럼 삭제(DROP COLUMN)
--ALTER TABLE <테이블명> DROP COLUMN <컬럼명>;
ALTER TABLE KH_MEMBER DROP COLUMN NO;
ALTER TABLE KH_MEMBER DROP COLUMN AGE;

SELECT * FROM KH_MEMBER;

--DEFAULT 옵션 확인
INSERT INTO KH_MEMBER VALUES('고길동','TEST1',NULL,SYSDATE,NULL);
INSERT INTO KH_MEMBER (NAME, REG_DATE) VALUES('최길동',SYSDATE);

--컬럼 이름 변경(RENAME COLUMN)
--ALTER TABLE <테이블명> RENAME COLUMN <기존 컬럼명> TO <변경할 컬럼명>;
ALTER TABLE KH_MEMBER RENAME COLUMN ID TO U_ID;
ALTER TABLE KH_MEMBER RENAME COLUMN PASSWORD TO U_PASS;