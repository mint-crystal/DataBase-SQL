--------------------------------------------------------------------------------
/*
    인덱스(INDEX)
    SQL명령문의 처리 속도를 향상시키기 위해서 컬럼에 대해 생성하는 
    오라클 객체로 내부 구조는 B*트리 형식으로 구성되어 있음
    
    장점
        검색 속도가 빨라짐
        시스템에 걸리는 부하를 줄여서 시스템 전체의 성능을 향상시킴
    
    단점
        인덱스를 위한 추가 저장 공간이 필요함
        인덱스를 생성하는데 시간이 걸림
        데이터의 변경작업(INSERT/UPDATE/DELETE)이 자주 일어나는 경우에는 오히려 성능이 저하됨
        
     인덱스 종류
     1. 고유인덱스(UNIQUE INDEX)
        중복 값이 포함될 수 없음
        PRIMARY KEY 제약조건을 생성하면 자동으로 생성됨
     2. 비고유인덱스(NONUINQUE INDEX)
        빈번하게 사용되는 일반 컬럼을 대상으로 생성
        주로 성능 향상을 위한 목적으로 생성
     3. 단일인덱스(SINGLE INDEX)
        한 개의 컬럼으로 구성한 인덱스
     4. 결합인덱스(COMPOSITE INDEX)
        두 개 이상의 컬럼으로 구성한 인덱스
     5. 함수 기반 인덱스(FUNCTION-BASED INDEX)
        SELECT절이나 WHERE절에 산술 계산식/함수식이 사용된 경우
        계산식은 인덱스의 적용을 받지 않음
*/
--------------------------------------------------------------------------------
--인덱스를 관리하는 데이터 사전 조회
    --인덱스 조회
SELECT * FROM USER_IND_COLUMNS;
--특정 제약조건이 설정된 컬럼은 자동으로 인덱스를 생성하기도 함
    --PRIMARY KEY, UNIQUE
SELECT * FROM USER_CONSTRAINTS WHERE TABLE_NAME='USER_TBL';
SELECT * FROM USER_CONS_COLUMNS WHERE TABLE_NAME='USER_TBL';

--인덱스 ID 조회
    --ROWID : ROW(행)의 ID(IDENTIFY)
    --행과 행을 구분하는 식별자
    --디스크에 저장된 행의 물리적 위치를 나타내는 정보
SELECT ROWID, EMP_ID, EMP_NAME FROM EMPLOYEE;
/*
    인덱스 ID 구조
    AAAE7UAABAAALC5AAA
    AAAE7U : 데이터 오브젝트 번호
    AAB : 파일 번호
    AAALC5 : BLOCK 번호
    AAA : ROW 번호
*/


--------------------------------------------------------------------------------
/*
    인덱스 생성
    CREATE [UNIQUE] INDEX <인덱스명> ON <테이블명> (컬럼명[, ...]|함수명|함수 계산식);
*/
--------------------------------------------------------------------------------

--------------------------------------------------------------------------------
--고유 인덱스(UNIQUE INDEX)
    --UNIQUE INDEX로 생성된 컬럼에는 중복값이 포함될 수 없음(NULL은 허용)
    --오라클 PRIMARY KEY 제약조건을 생성하면 자동으로 해당 컬럼에 UNIQUE INDEX가 생성됨
    --PRIMARY KEY를 이용하여 ACCESS하는 경우 성능 향상에 효과가 있음
SELECT * FROM EMPLOYEE;
SELECT EMP_NO FROM EMPLOYEE;
SELECT * FROM EMPLOYEE WHERE EMP_NO = '1111';
CREATE UNIQUE INDEX IDX_EMPNO ON EMPLOYEE(EMP_NO);
SELECT * FROM EMPLOYEE WHERE EMP_NO > '000101-1111111';
SELECT * FROM USER_IND_COLUMNS;
    --중복값이 있는 컬럼은 UNIQUE INDEX 생성 못 함
CREATE UNIQUE INDEX IDX_DEPTCODE ON EMPLOYEE(DEPT_CODE); --에러

--------------------------------------------------------------------------------
--비고유 인덱스(NONUNIQUE INDEX)
    --빈번하게 사용되는 일반 컬럼을 대상으로 생성
    --주로 성능 향상을 위한 목적으로 생성함
    --중복값이 있는 컬럼에도 생성 가능
CREATE INDEX IDX_DEPTCODE ON EMPLOYEE(DEPT_CODE);
SELECT * FROM USER_IND_COLUMNS;

--------------------------------------------------------------------------------
--결합 인덱스(COMPOSITE INDEX)
    --두 개 이상의 컬럼을 같이 조건으로 지정해서 조회할 경우 활용
CREATE INDEX IDX_DEPT ON DEPARTMENT(DEPT_ID, DEPT_TITLE);
SELECT * FROM USER_IND_COLUMNS;
SELECT * FROM DEPARTMENT WHERE DEPT_ID>'0' AND DEPT_TITLE>'0';

--------------------------------------------------------------------------------
--함수 기반 인덱스
    --SELECT절이나 WHERE절에 산술계산식이나 함수식이 사용된 경우
    --계산식은 인덱스의 적용을 받지 않음
    --계산식으로 검색하는 경우가 많다면, 수식이나 함수식을 인덱스로 만들 수 있음
CREATE TABLE EMP_IDX01 AS SELECT * FROM EMPLOYEE;
CREATE INDEX IDX_EMP02_SALARY ON EMP_IDX01((SALARY+SALARY*NVL(BONUS,0))*12);
SELECT * FROM USER_IND_COLUMNS WHERE TABLE_NAME='EMP_IDX01';
SELECT EMP_ID, EMP_NAME, SALARY, ((SALARY+SALARY*NVL(BONUS,0))*12) 연봉 
    FROM EMP_IDX01 WHERE ((SALARY+SALARY*NVL(BONUS,0))*12) = 72000000;


--------------------------------------------------------------------------------
/*
    INDEX 재 생성
    DML작업(특히 DELETE)명령을 수행한 경우,
     해당 인덱스 내에서 엔드리가 논리적으로만 제거되고 실제 엔드리는 그냥 남아있게 된다.
     인덱스가 필요 없는 공간을 차지하고 있기 때문에 인덱스를 재 생성할 필요가 있다.
    ALTER INDEX 인덱스명 REBUILD;  
*/
--------------------------------------------------------------------------------
SELECT * FROM USER_IND_COLUMNS WHERE TABLE_NAME='EMPLOYEE';
ALTER INDEX IDX_EMPNO REBUILD;


--------------------------------------------------------------------------------
/*
    인덱스 삭제
    DROP INDEX<인덱스 명>;
*/
--------------------------------------------------------------------------------
SELECT * FROM USER_IND_COLUMNS;
DROP INDEX IDX_DEPTCODE;
DROP INDEX IDX_DEPT;


--------------------------------------------------------------------------------
/*
    인덱스 활용 테스트
    1. 인덱스 테스트 용 테이블 생성 후 데이터 삽입
    -> USER_MOCK_DATA@KH.sql 스크립트 파일 사용
    2. 인덱스 사용 여부 확인
    -> SQL 워크시트 상단 메뉴 중 실행 계획(F10) OR 자동 추적(F6)으로 확인
        실행 계획 : 실행하기 전 어떻게 실행할지 확인 - 단점 : 계획과 실제 실행이 다를 수 있음
        자동 추적 : 실행하고 나서 어떻게 실행했는지 결과 확인 - 단점 : 실행 내용에 따라 오래 걸릴 수도 있음
        OPTIONS : 인덱스 스캔 = BY INDEX ROWID..., 풀 스캔 = FULL SCAN
        CADINALITY : 집합의 크기
        COST : 비용
    -> 자동 추적은 사용하려면 권한이 있어야함 (권한 오류 뜰 경우 관리자 계정으로 권한 부여해주고 실행)
*/
--------------------------------------------------------------------------------
--자동 추적을 위한 권한 부여(관리자 계정)
GRANT SELECT ANY DICTIONARY TO KH;

--전체 데이터 확인
    --실행 계획 OR 자동 추적으로 확인해보기
SELECT * FROM USER_MOCK_DATA;

--현재 설정되어 있는 인덱스 조회
SELECT * FROM USER_IND_COLUMNS WHERE TABLE_NAME = 'USER_MOCK_DATA';

--인덱스 설정 전 실행 계획 확인
    --ID 컬럼 조건 검색
SELECT * FROM USER_MOCK_DATA WHERE ID = '22222';
    --EMAIL 컬럼 검색
SELECT * FROM USER_MOCK_DATA WHERE EMAIL = 'kbresland0@comsenz.com';
    --GENDER 컬럼 조건 검색
SELECT * FROM USER_MOCK_DATA WHERE GENDER = 'Male';
    --FIRST_NAME 컬럼 LIKE 연산
SELECT * FROM USER_MOCK_DATA WHERE FIRST_NAME LIKE 'R%';

--제약조건을 이용해서 인덱스 생성(PK)
ALTER TABLE USER_MOCK_DATA ADD CONSTRAINT PK_USERDATA_ID PRIMARY KEY (ID);
--제약조건을 이용해서 인덱스 생성(UQ)
ALTER TABLE USER_MOCK_DATA ADD CONSTRAINT UQ_USERDATA_EMAIL UNIQUE(EMAIL);
SELECT * FROM USER_IND_COLUMNS WHERE TABLE_NAME='USER_MOCK_DATA';

--인덱스 설정 후 실행 계획 확인
    --ID 컬럼 조건 검색
SELECT * FROM USER_MOCK_DATA WHERE ID = '22222';
    --EMAIL 컬럼 검색
SELECT * FROM USER_MOCK_DATA WHERE EMAIL = 'kbresland0@comsenz.com';
    --GENDER 컬럼 조건 검색
SELECT * FROM USER_MOCK_DATA WHERE GENDER = 'Male';
    --FIRST_NAME 컬럼 LIKE 연산
SELECT * FROM USER_MOCK_DATA WHERE FIRST_NAME LIKE 'R%';
