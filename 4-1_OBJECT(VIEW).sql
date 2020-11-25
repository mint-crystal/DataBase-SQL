--------------------------------------------------------------------------------
/*
    VIEW
    SELECT 쿼리의 실행 결과를 화면에 저장한 논리적 가상 테이블
    실제 테이블과는 다르게 실질적으로 데이터를 저장하고 있진 않지만 
    사용자는 테이블을 사용하는 것과 동일하게 사용 가능
    
    표현식 : CREATE [OR REPLACE] VIEW 뷰이름 AS SELECT문
*/
--------------------------------------------------------------------------------
--현재 계정의 권한 확인
SELECT * FROM SESSION_PRIVS;
    --RESOURCE ROLE에는 CREATE VIEW에 대한 권한이 포함되어 있지 않음
    --VIEW를 생성하기 위해서는 별도의 권한을 추가해줘야함
--KH계정에 VIEW를 생성할 수 있는 CREATE VIEW 권한 추가 (관리자 계정으로 실행해야함!!!!)
GRANT CREATE VIEW TO KH;

--다시 KH 계정으로 돌아와서 진행
SELECT * FROM SESSION_PRIVS;

--직원테이블에서 사번, 이름, 부서만 별도의 VIEW로 생성
    --사번, 이름, 부서 조회
SELECT EMP_ID, EMP_NAME, DEPT_CODE FROM EMPLOYEE;
    --VIEW 생성
CREATE VIEW V_EMP AS SELECT EMP_ID, EMP_NAME, DEPT_CODE FROM EMPLOYEE;

--현재 계정의 뷰에 대한 정보를 확인하는 데이터 사전
SELECT * FROM USER_VIEWS;

--뷰 사용
--일반 테이블과 동일하게 사용
    --구조 확인
DESC V_EMP;
    --뷰 데이터 조회
SELECT * FROM V_EMP;

--여러 테이블을 이용해 VIEW를 생성
--직원의 사번, 이름, 부서명, 근무지역이 들어간 VIEW 생성
CREATE VIEW V_EMPLOYEE  AS 
    SELECT EMP_ID, EMP_NAME, DEPT_TITLE, LOCAL_NAME FROM EMPLOYEE 
        LEFT JOIN DEPARTMENT ON (DEPT_CODE=DEPT_ID)
        LEFT JOIN LOCATION ON (LOCATION_ID=LOCAL_CODE);
SELECT * FROM USER_VIEWS;
SELECT * FROM V_EMPLOYEE;

--현재 작업까지 완료
COMMIT;

--VIEW에 베이스가 되는 테이블의 정보가 변경되면 VIEW의 정보도 같이 변경
UPDATE EMPLOYEE SET EMP_NAME = '송중기' WHERE EMP_ID=201;
SELECT * FROM EMPLOYEE WHERE EMP_ID=201;
SELECT * FROM V_EMPLOYEE WHERE EMP_ID=201; --송중기로 변경됨

ROLLBACK;

--뷰 삭제
    --DROP VIEW <뷰 이름>;
DROP VIEW V_EMPLOYEE;
SELECT * FROM USER_VIEWS;

--뷰의 컬럼에 별칭 부여
CREATE VIEW V_EMPLOYEE AS
SELECT EMP_ID 사번, EMP_NAME 이름, DEPT_TITLE 부서, NATIONAL_NAME 지역 FROM EMPLOYEE
    LEFT JOIN DEPARTMENT ON (DEPT_CODE=DEPT_ID)
    LEFT JOIN LOCATION ON (LOCATION_ID = LOCAL_CODE)
    LEFT JOIN NATIONAL USING (NATIONAL_CODE);
    
SELECT * FROM V_EMPLOYEE;
DROP VIEW V_EMPLOYEE;
    --방법2 : 모든 컬럼에 별칭을 부여해주어야 함
CREATE VIEW V_EMPLOYEE(사번, 이름, 부서, 지역) AS
SELECT EMP_ID, EMP_NAME, DEPT_TITLE, NATIONAL_NAME FROM EMPLOYEE
    LEFT JOIN DEPARTMENT ON (DEPT_CODE=DEPT_ID)
    LEFT JOIN LOCATION ON (LOCATION_ID = LOCAL_CODE)
    LEFT JOIN NATIONAL USING (NATIONAL_CODE);
SELECT * FROM V_EMPLOYEE;

--VIEW SELECT문(서브쿼리) 안에 연산의 결과도 포함할 수 있음
CREATE VIEW V_EMP_JOB(사번, 이름, 직급, 성별, 근무년수) AS
SELECT EMP_ID, EMP_NAME, JOB_NAME, DECODE(SUBSTR(EMP_NO,8,1),1,'남',2,'여'),
    EXTRACT(YEAR FROM SYSDATE)-EXTRACT(YEAR FROM HIRE_DATE) FROM EMPLOYEE
    JOIN JOB USING(JOB_CODE);
SELECT* FROM V_EMP_JOB;

--생성된 뷰의 내용을 변경
    --생성된 뷰에서 DML구문(INSERT, UPDATE, DELETE, SELECT) 사용 가능
--뷰 생성
CREATE VIEW V_JOB AS SELECT JOB_CODE, JOB_NAME FROM JOB;
SELECT * FROM JOB;
SELECT * FROM V_JOB;

--뷰에 데이터 삽입
    --뷰를 통해 원본 테이블에 데이터 삽입
INSERT INTO V_JOB VALUES('J8', '인턴');
SELECT * FROM V_JOB; --뷰에 정상 삽입됨
SELECT * FROM JOB;  --원본 테이블에도 데이터가 정상 삽입됨

--뷰 데이터 수정
    --뷰를 통해 원본 테이블에 데이터를 수정
UPDATE V_JOB SET JOB_NAME = '알바' WHERE JOB_CODE='J8';
SELECT * FROM V_JOB;    --정상 변경됨
SELECT * FROM JOB; --원본 테이블에도 데이터가 정상 변경됨

--뷰 데이터 삭제
    --뷰를 통해 원본 테이블의 데이터를 삭제
DELETE FROM V_JOB WHERE JOB_CODE = 'J8';
SELECT * FROM V_JOB;
SELECT * FROM JOB;


/*
    DML명령어로 VIEW 조작이 불가능한 경우
    1. 뷰 정의에 포함되지 않은 컬럼을 조작하는 경우
    2. 뷰에 포함되지 않은 컬럼 중에 베이스가 되는 컬럼이 NOT NULL 제약조건이 지정된 경우
    3. 산술 표현식으로 정의된 경우
    4. 그룹함수나 GROUP BY절을 포함한 경우
    5. DISTINCT를 포함한 경우
    6. JOIN을 이용해 여러 테이블을 연결한 경우
*/
--뷰 정의에 포함되지 않은 컬럼의 조작하는 경우
    --SELECT, INSERT, UPDATE 조작불가, DELETE는 조작가능
CREATE VIEW V_JOB2 AS SELECT JOB_CODE FROM JOB;
SELECT * FROM V_JOB2;
--데이터 삽입
INSERT INTO V_JOB2 VALUES('J8','인턴'); --에러
INSERT INTO V_JOB2 VALUES('J8');    --정상 삽입
SELECT * FROM V_JOB2;
SELECT * FROM JOB; --뷰에 정의되지 않은 컬럼은 NULL 값 삽입됨
--데이터 수정
UPDATE V_JOB2 SET JOB_NAME='인턴' WHERE JOB_CODE='J7'; --에러
--데이터 삭제
    --정의되지 않은 컬럼이 있더라도 삭제는 가능함
DELETE FROM V_JOB2 WHERE JOB_CODE='J7'; --정상 삭제
SELECT * FROM JOB;
--데이터 조회
    --JOB_NAME이 정의되지 않아서 조회 불가능
SELECT JOB_NAME, JOB_CODE FROM V_JOB2;

ROLLBACK;

--뷰에 포함되지 않은 컬럼 중에 베이스가 되는 컬럼이 NOT NULL 제약조건이 지정된 경우
CREATE VIEW V_JOB3 AS SELECT JOB_NAME FROM JOB;
SELECT * FROM V_JOB3;
--데이터 삽입
INSERT INTO V_JOB VALUES('인턴'); --에러
DESC JOB; --원본테이블인 JOB테이블의 JOB_CODE는 NOT NULL 제약조건이 지정되어 있음
--데이터 수정
UPDATE V_JOB3 SET JOB_NAME='인턴' WHERE JOB_NAME='사원'; --가능
SELECT * FROM JOB;
--데이터 삭제
DELETE FROM V_JOB3 WHERE JOB_NAME = '인턴'; --가능
SELECT * FROM JOB;

ROLLBACK;

--산술 표현식으로 정의된 경우
CREATE VIEW EMP_SAL AS 
    SELECT EMP_ID, EMP_NAME, SALARY, (SALARY+(SALARY*NVL(BONUS,0)))*12 연봉
    FROM EMPLOYEE;
SELECT * FROM EMP_SAL;
--데이터 삽입
    --연봉은 실제 원본테이블에 저장된 컬럼이 없음
INSERT INTO EMP_SAL VALUES(800, '정진훈', 3000000, 4000000); --에러
--데이터 수정
UPDATE EMP_SAL SET 연봉 = 8000000 WHERE EMP_ID=200; --에러
--데이터 삭제
DELETE FROM EMP_SAL WHERE 연봉 = 72000000; --가능
    --송종기 삭제됨
SELECT * FROM EMP_SAL;
SELECT*FROM EMPLOYEE;

ROLLBACK;

--JOIN을 이용해 여러 테이블을 연결한 경우
CREATE VIEW V_JOINEMP AS
    SELECT EMP_ID, EMP_NAME, DEPT_TITLE FROM EMPLOYEE
        JOIN DEPARTMENT ON (DEPT_CODE=DEPT_ID);
SELECT * FROM V_JOINEMP;
--데이터 삽입
INSERT INTO V_JOINEMP VALUES (888,'조세오','인사관리부'); --에러
--데이터 수정
UPDATE V_JOINEMP SET DEPT_TITLE = '인사관리부' WHERE EMP_ID=200; --에러
UPDATE V_JOINEMP SET EMP_NAME = '선동이' WHERE EMP_ID=200; --가능
UPDATE V_JOINEMP SET EMP_NAME = '총총이' WHERE DEPT_TITLE = '총무부'; --가능
SELECT * FROM V_JOINEMP;
--데이터 삭제
DELETE FROM V_JOINEMP WHERE EMP_ID=200; --가능
SELECT * FROM V_JOINEMP;    --삭제 됨
SELECT * FROM EMPLOYEE;     --삭제 됨
SELECT * FROM DEPARTMENT;   --삭제 안 됨

ROLLBACK;

--DISTINCT를 포함한 경우
    --DISTINCTF를 사용한 경우 INSERT/UPDATE/DELETE 시 에러 발생
CREATE VIEW V_DTEMP AS SELECT DISTINCT JOB_CODE FROM EMPLOYEE;
SELECT * FROM V_DTEMP;
--데이터 삽입
INSERT INTO V_DTEMP VALUES ('J9'); --에러
--데이터 수정
UPDATE V_DTEMP SET JOB_CODE='J9' WHERE JOB_CODE = 'J7'; --에러
--데이터 삭제
DELETE FROM V_DTEMP WHERE JOB_CODE='J1'; --에러

ROLLBACK;

--그룹함수나 GROUP BY절을 포함한 경우
    --INSERT/UPDATE/DELETE 시 모두 에러 발생
CREATE VIEW V_GROUPDEPT AS
    SELECT DEPT_CODE, SUM(SALARY) 합계, AVG(SALARY) 평균 FROM EMPLOYEE
    GROUP BY DEPT_CODE;
SELECT * FROM V_GROUPDEPT;
--데이터 삽입
INSERT INTO V_GROUPDEPT VALUES ('D10', 6000000, 4000000); --에러
--데이터 수정
UPDATE V_GROUPDEPT SET DEPT_CODE = 'D10' WHERE DEPT_CODE = 'D1'; --에러
--데이터 삭제
DELETE FROM V_GROUPDEPT WHERE DEPT_CODE = 'D1'; --에러


/* VIEW 옵션 */
--OR REPLACE : 기존에 동일한 뷰 이름이 존재하는 경우 덮어쓰고, 존재하지 않으면 새로 생성
    --VIEW 생성
CREATE VIEW V_OPT1 AS SELECT EMP_ID, EMP_NAME FROM EMPLOYEE;
SELECT * FROM V_OPT1;
    --동일한 이름으로 VIEW 생성하면 오류 발생
CREATE VIEW V_OPT1 AS SELECT EMP_ID, EMP_NAME, PHONE, EMAIL FROM EMPLOYEE;
SELECT * FROM V_OPT1;
    --OR REPLACE 옵션 사용시 수정
CREATE OR REPLACE VIEW V_OPT1 AS SELECT EMP_ID, EMP_NAME, PHONE, EMAIL FROM EMPLOYEE;
SELECT * FROM V_OPT1;

--NOFORCE 옵션 : 서브쿼리에서 사용된 테이블이 존재해야만 뷰 생성함(기본값)
CREATE OR REPLACE /*NOFORCE*/ VIEW V_OPT2 AS SELECT TCODE, TNAME, TCONNECT FROM TT;

--FORCE 옵션 : 서브쿼리에서 사용된 테이블이 존재하지 않아도 뷰 생성됨
    --구조가 정의만 된 상태. 미완성 뷰. DML 사용 못 함
CREATE OR REPLACE FORCE VIEW V_OPT2 AS SELECT TCODE, TNAME, TCONNECT FROM TT;
SELECT * FROM USER_VIEWS;
SELECT * FROM V_OPT2; --TT테이블 생성 후 조회 가능 / 생성 전엔 오류
    --TT테이블 생성
CREATE TABLE TT(
    TCODE NUMBER,
    TNAME VARCHAR2(20),
    TCONNECT VARCHAR2(50),
    TSUBJECT VARCHAR2 (30)
    );

--WITH CHECK OPTION : 옵션을 설정한 컬럼의 값을 수정하지 못 하게 함
    --WHERE절에 WITH CHECK OPTION을 기술
    --조건(WHERE절)에 사용되어진 컬럼은 조건에 위배되면 INSERT/UPDATE 불가
CREATE OR REPLACE VIEW V_OPT3 AS SELECT * FROM JOB WHERE JOB_CODE='J4' WITH CHECK OPTION;
SELECT * FROM V_OPT3;
SELECT * FROM JOB;
--데이터 삽입
INSERT INTO V_OPT3 VALUES ('J8', '인턴'); --에러
--데이터 수정
UPDATE V_OPT2 SET JOB_CODE='J8' WHERE JOB_CODE='J4'; --에러
--데이터 삭제
DELETE FROM V_OPT3; --가능
SELECT * FROM JOB;

ROLLBACK;

--WITH READ ONLY 옵션 : DML(INSERT/UPDATE/DELETE) 수행 불가능
CREATE OR REPLACE VIEW V_OPT4 AS SELECT * FROM DEPARTMENT WITH READ ONLY;
SELECT * FROM V_OPT4;
--데이터 삽입
INSERT INTO V_OPT4 VALUES ('D10','기술부','L1'); --에러
--데이터 수정
UPDATE V_OPT4 SET LOCATION_ID='L5' WHERE DEPT_ID='D1'; --에러;
--데이터 삭제
DELETE FROM V_OPT4; --에러