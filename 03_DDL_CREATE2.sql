--PRIMARY KEY 제약조건 1 : 컬럼 레벨 설정
CREATE TABLE USER_PRIMARYKEY1(
    USER_NO NUMBER PRIMARY KEY, --컬럼 레벨 설정
    USER_ID VARCHAR2(20) NOT NULL UNIQUE,
    USER_PWD VARCHAR2(30) NOT NULL,
    USER_NAME VARCHAR2(30),
    GENDER VARCHAR2(10),
    PHONE VARCHAR2(30),
    EMAIL VARCHAR2(50)
);
    --USER_NO 컬럼을 기본키로 설정
--데이터 삽입 : 정상 삽입
INSERT INTO USER_PRIMARYKEY1 VALUES(1,'USER1','PASS1','홍길동','남','010-1234-1234','hong@kh.or.kr');
--USER_NO 컬럼에 중복된 값 삽입 : UNIQUE 오류
INSERT INTO USER_PRIMARYKEY1 VALUES(1,'USER1','PASS1','홍길동','남','010-1234-1234','hong@kh.or.kr');
--USER_NO 컬럼에 NULL 값 삽입 : NOT NULL 오류
INSERT INTO USER_PRIMARYKEY1 VALUES(NULL,'USER1','PASS1','홍길동','남','010-1234-1234','hong@kh.or.kr');

--PRIMARY KEY 제약조건 2 : 테이블 레벨 설정
CREATE TABLE USER_PRIMARYKEY2(
    USER_NO NUMBER,
    USER_ID VARCHAR2(20) NOT NULL UNIQUE,
    USER_PWD VARCHAR2(30) NOT NULL,
    USER_NAME VARCHAR2(30),
    GENDER VARCHAR2(10),
    PHONE VARCHAR2(30),
    EMAIL VARCHAR2(50),
    PRIMARY KEY (USER_NO)   --테이블 레벨 설정
);
    --USER_NO 컬럼을 기본키로 설정
--데이터 삽입 : 정상 삽입
INSERT INTO USER_PRIMARYKEY2 VALUES(1,'USER1','PASS1','홍길동','남','010-1234-1234','hong@kh.or.kr');
--USER_NO 컬럼에 중복된 값 삽입 : UNIQUE 오류
INSERT INTO USER_PRIMARYKEY2 VALUES(1,'USER1','PASS1','홍길동','남','010-1234-1234','hong@kh.or.kr');
--USER_NO 컬럼에 NULL 값 삽입 : NOT NULL 오류
INSERT INTO USER_PRIMARYKEY2 VALUES(NULL,'USER1','PASS1','홍길동','남','010-1234-1234','hong@kh.or.kr');

--PRIMARY KEY 제약조건 3 : 테이블 레벨 설정 - 두 컬럼을 묶어서 하나의 PRIMARY KEY로 설정
CREATE TABLE USER_PRIMARYKEY3(
    USER_NO NUMBER,
    USER_ID VARCHAR2(20) NOT NULL UNIQUE,
    USER_PWD VARCHAR2(30) NOT NULL,
    USER_NAME VARCHAR2(30),
    GENDER VARCHAR2(10),
    PHONE VARCHAR2(30),
    EMAIL VARCHAR2(50),
    PRIMARY KEY (USER_NAME, PHONE)  --테이블 레벨 설정
);
    --USER_NAME과 PHONE을 합쳐서 하나의 PRIMARY KEY로 사용
--데이터 삽입 : 정상 삽입
INSERT INTO USER_PRIMARYKEY3 VALUES(1,'USER1','PASS1','홍길동','남','010-1234-1234','hong@kh.or.kr');
--USER_NAME이 동일하고, PHONE은 다른 데이터 삽입 : 정상 삽입
INSERT INTO USER_PRIMARYKEY3 VALUES(2,'USER2','PASS2','홍길동','남','010-1234-4321','hong@kh.or.kr');
--USER_NAME은 다르고, PHONE은 같은 데이터 삽입 : 정상 삽입
INSERT INTO USER_PRIMARYKEY3 VALUES(3,'USER3','PASS3','고길동','남','010-1234-4321','hong@kh.or.kr');
--USER_NAME과 PHONE 모두 같은 데이터 삽입 : 오류 발생
INSERT INTO USER_PRIMARYKEY3 VALUES(4,'USER4','PASS4','고길동','남','010-1234-4321','hong@kh.or.kr');
--USER_NAME이 NULL이고, PHONE은 정상 데이터 삽입 : 오류 발생
INSERT INTO USER_PRIMARYKEY3 VALUES(5,'USER5','PASS5',NULL,'남','010-1234-4321','hong@kh.or.kr');
--USER)NAME은 정상 데이터고, PHONE은 NULL값 삽입 : 오류 발생
INSERT INTO USER_PRIMARYKEY3 VALUES(6,'USER6','PASS6','고길동','남',NULL,'hong@kh.or.kr');

--데이트 조회
SELECT * FROM USER_PRIMARYKEY3;

--------------------------------------------------------------------------------

--FOREIGN KEY(외래 키)
--참조되는 테이블(부모 테이블)
CREATE TABLE USER_GRADE(
    GRADE_CODE NUMBER PRIMARY KEY,
    GRADE_NAME VARCHAR2(30) NOT NULL
);
INSERT INTO USER_GRADE VALUES(10,'일반회원');
INSERT INTO USER_GRADE VALUES(20,'우수회원');
INSERT INTO USER_GRADE VALUES(30,'특별회원');
SELECT * FROM USER_GRADE;
--참조하는 테이블(자식 테이블)
CREATE TABLE USER_FOREIGNKEY1(
    USER_NO NUMBER PRIMARY KEY,
    USER_ID VARCHAR2(20),
    USER_PWD VARCHAR2(30),
    G_CODE NUMBER,  --USER_GRADE 테이블의 GRADE_CODE 컬럼을 참조할 컬럼
    FOREIGN KEY(G_CODE) REFERENCES USER_GRADE(GRADE_CODE)
    --FOREIGN KEY(자식 컬럼) REFERENCES 부모 테이블(부모 컬럼)
);
    --G_CODE 컬럼에는 USER_GRADE 테이블의 GRADE_CODE 안에 있는 값만 삽입될 수 있음
--데이터 삽입 : GRADE_CODE 안에 있는 데이터 정상 삽입
INSERT INTO USER_FOREIGNKEY1 VALUES(1, 'TEST1', 'PASS1', 10);
INSERT INTO USER_FOREIGNKEY1 VALUES(2, 'TEST2', 'PASS2', 20);
INSERT INTO USER_FOREIGNKEY1 VALUES(3, 'TEST3', 'PASS3', 30);
--참조 값 중복 데이터 삽입 : 정상 삽입
INSERT INTO USER_FOREIGNKEY1 VALUES(4, 'TEST4', 'PASS4', 30);
--부모 컬럼에 없는 값 삽입 : 오류 발생
INSERT INTO USER_FOREIGNKEY1 VALUES(5, 'TEST5', 'PASS5', 50);
--NULL 값 삽입
INSERT INTO USER_FOREIGNKEY1 VALUES(6, 'TEST6', 'PASS6', NULL);

SELECT * FROM USER_FOREIGNKEY1;

--부모 테이블을 참조할 컬럼에 제약이 있는 경우
CREATE TABLE USER_FOREIGNKEY2(
    USER_NO NUMBER PRIMARY KEY,
    USER_ID VARCHAR2(20),
    USER_PWD VARCHAR2(30),
    G_CODE NUMBER NOT NULL UNIQUE,  --USER_GRADE 테이블의 GRADE_CODE 컬럼을 참조할 컬럼
    FOREIGN KEY (G_CODE) REFERENCES USER_GRADE(GRADE_CODE)
);
--데이터 삽입 : GRADE_CODE 안에 있는 데이터 정상 삽입
INSERT INTO USER_FOREIGNKEY2 VALUES(1,'TEST1','PASS1',10);
INSERT INTO USER_FOREIGNKEY2 VALUES(2,'TEST2','PASS2',20);
INSERT INTO USER_FOREIGNKEY2 VALUES(3,'TEST3','PASS3',30);
--참조 값 중복 데이터 삽입 : UNIQUE 제약 설정되어 있어서 오류 발생
INSERT INTO USER_FOREIGNKEY2 VALUES(4,'TEST4','PASS4',30);
--부모컬럼에 없는 값 삽입 : 오류 발생
INSERT INTO USER_FORSIGNKEY2 VALUES(5,'TEST5','PASS5',50);
--NULL 값 삽입 : NOT NULL 제약 설정이 되어 있어서 오류 발생
INSERT INTO USER_FOREIGNKEY2 VALUES(6,'TEST6','PASS6',NULL);

SELECT * FROM USER_FOREIGNKEY2;

/*
    삭제 옵션1
    기본 삭제 옵션은 ON DELETE RESTRICTED : 자식이 참조 중인 부모 테이블 데이터 삭제 불가능
*/
DELETE FROM USER_GRADE WHERE GRADE_CODE=30; --오류 발생

/*
    삭제 옵션2
    ON DELETE SET NULL : 부모 테이블의 데이터 삭제 시 참조하고 있는 자식 테이블의 컬럼 값이 NULL로 변경됨
*/
--참조되는 테이블(부모 테이블)
CREATE TABLE USER_GRADE2(
    GRADE_CODE NUMBER PRIMARY KEY,
    GEADE_NAME VARCHAR2(30) NOT NULL
);
INSERT INTO USER_GRADE2 VALUES(10,'일반회원');
INSERT INTO USER_GRADE2 VALUES(20,'우수회원');
INSERT INTO USER_GRADE2 VALUES(30,'특별회원');
SELECT * FROM USER_GRADE2;
--참조하는 테이블(자식 테이블)
CREATE TABLE USER_FOREIGNKEY3(
    USER_NO NUMBER PRIMARY KEY,
    USER_ID VARCHAR2(20),
    USER_PWD VARCHAR2(30),
    G_CODE NUMBER,
    FOREIGN KEY(G_CODE) REFERENCES USER_GRADE2(GRADE_CODE) ON DELETE SET NULL
);
--데이터 삽입
INSERT INTO USER_FOREIGNKEY3 VALUES(1, 'TEST1', 'PASS1',10);
INSERT INTO USER_FOREIGNKEY3 VALUES(2, 'TEST2', 'PASS2',20);
INSERT INTO USER_FOREIGNKEY3 VALUES(3, 'TEST3', 'PASS3',30);
SELECT * FROM USER_FOREIGNKEY3;
--삭제
DELETE FROM USER_GRADE2 WHERE GRADE_CODE=30;
SELECT * FROM USER_GRADE2;

/*
    삭제 옵션3
    ON DELETE CASCADE : 부모 테이블의 데이터 삭제 시 참조하고 있는 자식 테이블의 컬럼 값이 존재하던 행 전체 삭제
*/
--부모 테이블 생성
CREATE TABLE USER_GRADE3(
    GRADE_CODE NUMBER PRIMARY KEY,
    GRADE_NAME VARCHAR2(30) NOT NULL
);
INSERT INTO USER_GRADE3 VALUES(10,'일반회원');
INSERT INTO USER_GRADE3 VALUES(20,'우수회원');
INSERT INTO USER_GRADE3 VALUES(30,'특별회원');
SELECT * FROM USER_GRADE3;
--자식 테이블 생성
CREATE TABLE USER_FOREIGNKEY4(
    USER_NO NUMBER PRIMARY KEY,
    USER_ID VARCHAR2(20),
    USER_PWD VARCHAR2(30),
    G_CODE NUMBER REFERENCES USER_GRADE3(GRADE_CODE) ON DELETE CASCADE
    --컬럼레벨 작성 : 컬럼명 데이터타입 REFERENCES 부모테이블(부모컬럼) ON DELETE CASCADE
);
INSERT INTO USER_FOREIGNKEY4 VALUES(1,'TEST1','PASS1',10);
INSERT INTO USER_FOREIGNKEY4 VALUES(2,'TEST2','PASS2',20);
INSERT INTO USER_FOREIGNKEY4 VALUES(3,'TEST3','PASS3',30);
SELECT *FROM USER_FOREIGNKEY4;
--부모테이블 데이터 삭제
DELETE FROM USER_GRADE3 WHERE GRADE_CODE=30;

--------------------------------------------------------------------------------

--CHECK 제약조건
CREATE TABLE USER_CHECK(
    USER_NO NUMBER PRIMARY KEY,
    USER_ID VARCHAR2(20) UNIQUE,
    USER_PWD VARCHAR2(30) NOT NULL,
    USER_NAME VARCHAR2(30),
    GENDER VARCHAR2(5) CHECK (GENDER IN ('남','여'))
);
--데이터 삽입 : CHECK 조건에 있는 데이터는 정상 삽입
INSERT INTO USER_CHECK VALUES (1, 'TEST1', 'PASS1', 'TEST1', '남');
INSERT INTO USER_CHECK VALUES (2, 'TEST2', 'PASS2', 'TEST2', '여');
--CHECK 조건에 없는 데이터 삽입 : 오류 발생
INSERT INTO USER_CHECK VALUES (3, 'TEST3', 'PASS3', 'TEST3', 'M');
SELECT * FROM USER_CHECK;
