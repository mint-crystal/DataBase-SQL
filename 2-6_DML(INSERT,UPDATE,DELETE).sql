--------------------------------------------------------------------------------
/*
    INSERT
    테이블에 새로운 행을 추가하여 테이블의 행 개수를 증가시키는 구문
    테이블에 데이터를 삽입(추가)
    
    - 테이블의 모든 컬럼에 대한 값을 INSERT 할 때 사용
    INSERT INTO <테이블명> VALUES(데이터1, 데이터2, ...);
        테이블의 컬럼이 만들어져있는 순서대로 데이터를 입력해 줘야함
    - 테이블의 특정 컬럼에 대한 값을 INSERT 할 때 사용
    INSERT INTO <테이블명(컬럼명1, 컬럼명2, ...)> VALUES(데이터1, 데이터2, ...);
        테이블명 뒤에 나열한 컬럼의 순서대로 데이터를 입력해 줘야함
*/
--------------------------------------------------------------------------------
DESC EMPLOYEE;
SELECT * FROM EMPLOYEE;

--모든 컬럼에 데이터 입력
INSERT INTO EMPLOYEE VALUES('900', '장채현', '901123-1080503', 'jang_ch@kh.or.kr',
    '01055569512','D1','J7','S3',4300000,0.2,'200',SYSDATE,NULL,DEFAULT);
    
--특정 컬럼에 데이터 입력
INSERT INTO EMPLOYEE (EMP_ID, EMP_NAME, EMP_NO, JOB_CODE, SAL_LEVEL) 
    VALUES('901','홍길동','981205-1587456','J5','S1');
    
--서브쿼리를 이용해 데이터 삽입
    --VALUES로 값을 직접 입력하는 대신 다른 테이블에서 조회한 데이터를 삽입
--테이블 생성
CREATE TABLE EMP_01(
    EMP_ID NUMBER,
    EMP_NAME VARCHAR2(30),
    DEPT_TITLE VARCHAR2(20)
);
SELECT * FROM EMP_01;
--EMPLOYEE 테이블에서 조회한 데이터를 EMP_01 테이블에 삽입
    --EMPLOYEE 테이블에서 DEPT_CODE가 NULL 인 값도 포함하기 위해 LEFT OUTER JOIN 사용
SELECT EMP_ID, EMP_NAME, DEPT_TITLE FROM EMPLOYEE LEFT JOIN DEPARTMENT ON (DEPT_CODE=DEPT_ID);
INSERT INTO EMP_01(
    SELECT EMP_ID, EMP_NAME, DEPT_TITLE FROM EMPLOYEE
        LEFT JOIN DEPARTMENT ON (DEPT_CODE=DEPT_ID)
);


--------------------------------------------------------------------------------
/*
    INSERT ALL
    - INSERT 시 사용되는 서브쿼리의 테이블이 같은 경우, 
        두개 이상의 테이블에 INSERT ALL을 이용하여 한 번에 삽입
*/
--------------------------------------------------------------------------------
--테이블 생성시 조회되는 다른 테이블의 컬럼(컬럼 명, 데이터타입)을 그대로 가져오는 방법
    --데이터없이 조회
SELECT EMP_ID, EMP_NAME, DEPT_CODE, HIRE_DATE FROM EMPLOYEE WHERE 1=0;
    --테이블 생성 시 컬럼 안의 데이터까지 모두 가져옴
CREATE TABLE EMP_DEPT_01 AS SELECT EMP_ID, EMP_NAME, DEPT_CODE, HIRE_DATE
    FROM EMPLOYEE;
    --데이터 생성 시 구조만 복사해서 가져옴 (데이터X) : 1=0
CREATE TABLE EMP_DEPT_01 AS SELECT EMP_ID, EMP_NAME, DEPT_CODE, HIRE_DATE
    FROM EMPLOYEE WHERE 1=0;
SELECT * FROM EMP_DEPT_01;

CREATE TABLE EMP_MANAGE AS SELECT EMP_ID, EMP_NAME, MANAGER_ID
    FROM EMPLOYEE WHERE 1=0;
SELECT * FROM EMP_MANAGE;

--EMP_DEPT_01 테아블에 EMPLOYEE 테아블에 있는 부서코드가 D1인 직원을 조회해서 삽입
    --(사번, 이름, 부서코드, 입사일)
--EMP_MANAGE 테이블에 EMPLOYEE 테이블에 있는 부서코드가 D1인 직원을 조화해서 삽입
    --(사번, 이름, 관리자사번)
--기존 방식대로 입력
INSERT INTO EMP_DEPT_01(
    SELECT EMP_ID, EMP_NAME, DEPT_CODE, HIRE_DATE FROM EMPLOYEE
        WHERE DEPT_CODE='D1'
);
INSERT INTO EMP_MANAGE(
    SELECT EMP_ID, EMP_NAME, MANAGER_ID
    FROM EMPLOYEE WHERE DEPT_CODE = 'D1'
);
    --일부 컬럼에만 값을 넣을 때
INSERT INTO EMP_DEPT_01(EMP_ID,EMP_NAME)(
    SELECT EMP_ID, EMP_NAME, DEPT_CODE, HIRE_DATE FROM EMPLOYEE
        WHERE DEPT_CODE='D1'
);
SELECT * FROM EMP_DEPT_01;
SELECT * FROM EMP_MANAGE;
DELETE FROM EMP_DEPT_01;
DELETE FROM EMP_MANAGE;
--INSERT ALL 사용
INSERT ALL INTO EMP_DEPT_01 VALUES(EMP_ID, EMP_NAME, DEPT_CODE, HIRE_DATE)
            INTO EMP_MANAGE VALUES(EMP_ID, EMP_NAME, MANAGER_ID)
    SELECT EMP_ID, EMP_NAME, DEPT_CODE, HIRE_DATE, MANAGER_ID FROM EMPLOYEE
        WHERE DEPT_CODE='D1';

--같은 테이블에서 조건을 다르게 해서 조회한 데이터를 각각의 다른 테이블에 삽입
--EMPLOYEE 테이블에서 입사일 기준으로 2010년 1월 1일 이전 입사한 사원의
    --사번, 이름, 입사일, 급여를 조회해서 EMP_OLD 테이블에 삽입
    --그 이후 입사한 사원의 정보는 EMP_NEW 테이블에 삽입
--테이블 생성
CREATE TABLE EMP_OLD AS 
    SELECT EMP_ID, EMP_NAME, HIRE_DATE, SALARY FROM EMPLOYEE WHERE 1=0;
CREATE TABLE EMP_NEW AS 
    SELECT EMP_ID, EMP_NAME, HIRE_DATE, SALARY FROM EMPLOYEE WHERE 1=0;
SELECT * FROM EMP_OLD;
SELECT * FROM EMP_NEW;
--데이터 삽입
INSERT ALL WHEN HIRE_DATE <'2010/01/01' THEN 
        INTO EMP_OLD VALUES (EMP_ID, EMP_NAME, HIRE_DATE, SALARY)
    WHEN HIRE_DATE >= '2010/01/01' THEN 
        INTO EMP_NEW VALUES (EMP_ID, EMP_NAME, HIRE_DATE, SALARY)
    SELECT EMP_ID, EMP_NAME, HIRE_DATE, SALARY FROM EMPLOYEE;


--------------------------------------------------------------------------------
/*
    UPDATE
    테이블에 기록된 컬럼 값을 수정하는 구문
    
    표현식 : UPDATE 테이블명 SET 컬럼명=바꿀값 [WHERE 조건];
    조건을 지정하지 않으면 테이블 내 해당 컬럼의 모든 행의 값을 변경
*/
--------------------------------------------------------------------------------
--부서 테이블 복사본 테이블 생성
CREATE TABLE DEPT_COPY AS SELECT * FROM DEPARTMENT;
SELECT * FROM DEPT_COPY;
--부서코드가 'D9'인 부서명을 '전략기획팀'으로 변경
UPDATE DEPT_COPY SET DEPT_TITLE = '전략기획팀' WHERE DEPT_ID='D9';
--조건을 안 주면 해당 컬럼의 저체 행 데이터가 변경굄
UPDATE DEPT_COPY SET DEPT_TITLE = '총무팀';
ROLLBACK;
--UPDATE 시에도 서브쿼리 사용 가능
    --UPDATE 테이블명 SET 컬럼명 = (서브쿼리) [WHERE 조건];
CREATE TABLE EMP_SALARY AS SELECT EMP_ID, EMP_NAME, DEPT_CODE, SALARY, BONUS FROM EMPLOYEE;
SELECT * FROM EMP_SALARY;
--유재식의 급여와 보너스를 조회해와서 방명수의 급여와 보너스에 삽입
UPDATE EMP_SALARY SET 
    SALARY = (SELECT SALARY FROM EMPLOYEE WHERE EMP_NAME='유재식'),
    BONUS = (SELECT BONUS FROM EMPLOYEE WHERE EMP_NAME='유재식')
    WHERE EMP_NAME='방명수';
--다중 행, 다중 열 서브쿼리를 이용한 UPDATE문
UPDATE EMP_SALARY SET 
    (SALARY, BONUS) = (SELECT SALARY, BONUS FROM EMPLOYEE WHERE EMP_NAME='유재식')
    WHERE EMP_NAME IN ('노옹철','전형돈','정중하','하동운');
SELECT * FROM EMP_SALARY WHERE EMP_NAME IN ('유재식','방명수','노옹철','전형돈','정중하','하동운');
--EMP_SALARY 테이블에서 아시아 지역에 근무하는 직원의 보너스를 0.5로 변경
SELECT EMP_ID, LOCAL_NAME FROM EMPLOYEE JOIN DEPARTMENT ON (DEPT_CODE=DEPT_ID)
    JOIN LOCATION ON (LOCATION_ID=LOCAL_CODE)
    WHERE LOCAL_NAME LIKE 'ASIA%';
UPDATE EMP_SALARY SET BONUS = 0.5
    WHERE EMP_ID IN (SELECT EMP_ID FROM EMPLOYEE 
                    JOIN DEPARTMENT ON (DEPT_CODE=DEPT_ID)
                    JOIN LOCATION ON (LOCATION_ID=LOCAL_CODE)
                    WHERE LOCAL_NAME LIKE 'ASIA%');

--UADATE시 변경할 값은 해당 컬럼의 제약조건에 위배되지 않아야 함!!
UPDATE EMPLOYEE SET EMP_NAME = NULL WHERE EMP_ID = 200; --NOT NULL 오류


--------------------------------------------------------------------------------
/*
    DELETE 
    테이블의 행을 삭제하는 구문
    표현식 : DELE FROM 테이블명 [WHERE 조건];
    만약 WHERE 조건을 설정하지 않으면 모든 행이 다 삭제됨
*/
--------------------------------------------------------------------------------
COMMIT;
SELECT * FROM EMPLOYEE;
DELETE FROM EMPLOYEE WHERE EMP_NAME='장채현';
DELETE FROM EMPLOYEE; --모든 행 삭제
ROLLBACK;

--FOREIGN KEY(외래키) 제약조건이 설정되어 있는 경우 삭제
    --제약조건 확인
SELECT * FROM USER_CONSTRAINTS WHERE TABLE_NAME = 'EMPLOYEE';
SELECT * FROM USER_CONS_COLUMNS WHERE TABLE_NAME = 'EMPLOYEE';
    --EMPLOYEE 테이블의 DEPT_CODE 컬럼에 외래키 설정 (부모 : DEPARTMENT 테이블 DEPT_ID)
ALTER TABLE EMPLOYEE ADD /* CONSTRAINT '제약조건 명' */ 
    FOREIGN KEY (DEPT_CODE) REFERENCES DEPARTMENT/* (참조컬럼명) */;
    --외래키로 참조 되고 있는 값에 대해서는 삭제 불가능
DELETE FROM DEPARTMENT WHERE DEPT_ID='D1'; --오류
    --외래키 설정되어 있더라도 현재 참조되고 있지 않은 값에 대해서는 삭제 가능
DELETE FROM DEPARTMENT WHERE DEPT_ID='D3';
ROLLBACK;
    --삭제 시 외래키 제약조건으로 삭제가 불가능한 경우 임시로 임시로 제약조건을 비활성화 할 수 있음
ALTER TABLE EMPLOYEE DISABLE CONSTRAINT SYS_C007123 CASCADE;
DELETE FROM DEPARTMENT WHERE DEPT_ID='D1';
SELECT * FROM DEPARTMENT;
ROLLBACK;
ALTER TABLE EMPLOYEE ENABLE CONSTRAINT SYS_C007123;


--------------------------------------------------------------------------------
/*
    MERGE
    구조가 같은 두 개의 테이블을 하나의 테이블로 합치는 기능 제공
    두 테이블에서 지정하는 조간의 값이 존재하면 UPDATE되고, 조건값이 없으면 INSERT 됨
*/
--------------------------------------------------------------------------------
CREATE TABLE EMP_M01 AS SELECT * FROM EMPLOYEE;
CREATE TABLE EMP_M02 AS SELECT * FROM EMPLOYEE WHERE JOB_CODE = 'J4';
SELECT * FROM EMP_M01;
SELECT * FROM EMP_M02;

INSERT INTO EMP_M02 VALUES('999','곽두원','561016-1234567','kwack_dw@kh.or.kr', 
    '01011112222', 'D9','J4','S1',9000000,0.5,NULL,SYSDATE,NULL,DEFAULT);
UPDATE EMP_M02 SET SALARY = 0;

MERGE INTO EMP_M01 USING EMP_M02 ON (EMP_M01.EMP_ID = EMP_M02.EMP_ID)
    WHEN MATCHED THEN UPDATE SET 
                        EMP_M01.EMP_NAME = EMP_M02.EMP_NAME,
                        EMP_M01.EMP_NO = EMP_M02.EMP_NO,
                        EMP_M01.EMAIL = EMP_M02.EMAIL,
                        EMP_M01.PHONE = EMP_M02.PHONE,
                        EMP_M01.DEPT_CODE = EMP_M02.DEPT_CODE,
                        EMP_M01.JOB_CODE = EMP_M02.JOB_CODE,
                        EMP_M01.SAL_LEVEL = EMP_M02.SAL_LEVEL,
                        EMP_M01.SALARY = EMP_M02.SALARY,
                        EMP_M01.BONUS = EMP_M02.BONUS,
                        EMP_M01.MANAGER_ID = EMP_M02.MANAGER_ID,
                        EMP_M01.HIRE_DATE = EMP_M02.HIRE_DATE,
                        EMP_M01.ENT_DATE = EMP_M02.ENT_DATE,
                        EMP_M01.ENT_YN = EMP_M02.ENT_YN
    WHEN NOT MATCHED THEN 
    INSERT VALUES(EMP_M02.EMP_ID, EMP_M02.EMP_NAME, EMP_M02.EMP_NO, EMP_M02.EMAIL, EMP_M02.PHONE,
        EMP_M02.DEPT_CODE, EMP_M02.JOB_CODE, EMP_M02.SAL_LEVEL, EMP_M02.SALARY, EMP_M02.BONUS, EMP_M02.MANAGER_ID,
        EMP_M02.HIRE_DATE, EMP_M02.ENT_DATE, EMP_M02.ENT_YN);
SELECT * FROM EMP_M02;
SELECT * FROM EMP_M01; --EMP_M02의 데이터를 EMP_M01에 추가(곽도원), 수정(SALARY=0)


--------------------------------------------------------------------------------
/*
    DDL - TRUNCATE(초기화)
    테이블 전체 행 삭제 시 사용하며 DELETE보다 수행속도가 빠름
    테이블을 완전히 삭제했다가 다시 생성
    DDL이기 때문에 ROLLBACK으로 복구 불가능(DROP도 복구 불가)
*/
--------------------------------------------------------------------------------
SELECT * FROM EMP_SALARY;
COMMIT;
DELETE FROM EMP_SALARY; --모든 데이터 삭제
SELECT * FROM EMP_SALARY; --데이터 없음
ROLLBACK;
SELECT * FROM EMP_SALARY; --데이터 원복됨

TRUNCATE TABLE EMP_SALARY; --테이블 초기화
SELECT * FROM EMP_SALARY; --데이터 없음
ROLLBACK;
SELECT * FROM EMP_SALARY; --데이터 없음