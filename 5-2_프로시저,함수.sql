--------------------------------------------------------------------------------
/*
    저장 프로시저(STORED PROCEDURE)
    PL/SQL문을 저장하는 객체
    일련의 작업 절차를 미리 정리해서 저장해 둔 것
    여러 SQL문을 묶어서 미리 정의해두고 하나의 요청으로 실행할 수 있음
    자주 사용되는 복잡한 작업들을 간단하게 미리 만들어두면 쉽게 사용이 가능함
    
    프로시저 작성 방법
    - 매개변수의 데이터형의 크기는 지정하면 안 됨(테이블.컬럼%TYPE은 가능)
    - SELECT 사용시 INTO를 통해 변수의 값을 저장해서 사용해야 함(SELECT 자체만으로는 출력 안 됨)
    
    정의 방법
        CREATE PROCEDURE <프로시저명> (<매개변수> [MODE] DATATYPE [, ...])
        IS
            지역변수 선언;
        BEGIN
            실행할 내용;
        END;
        /
    
        [MODE]
            IN : 데이터를 입력받을 때(기본 값)
            OUT : 데이터를 반환할 때
            INOUT : 두 가지 목적 모두에 사용(실제로는 사용되지 않음)
    
    실행 방법
        EXECUTE <프로시저명>[<전달값>[, ...]];
*/
--------------------------------------------------------------------------------
--기본 프로시저 정의
CREATE OR REPLACE PROCEDURE TEST_PRO
IS
BEGIN
    DBMS_OUTPUT.PUT_LINE('프로시저 실행1');
END;
/
--프로시저 확인
SELECT * FROM ALL_PROCEDURES; --모든 프로시져 확인
SELECT * FROM USER_PROCEDURES; --현재 사용자가 생성한 프로시져 목록 확인
SELECT * FROM USER_SOURCE; --현재 사용자가 생성한 프로시져 상세 코드 확인
SELECT * FROM USER_SOURCE WHERE NAME = 'TEST_PRO'; --특정 프로시저의 상세 코드 확인

--프로시져 실행
EXECUTE TEST_PRO;
EXEC TEST_PRO; --줄여서 사용가능

--매개변수있는 프로시져
CREATE OR REPLACE PROCEDURE TEST_PRO2 (NUM NUMBER)
IS
BEGIN
    DBMS_OUTPUT.PUT_LINE('입력 값 : '||NUM);
END;
/

EXEC TEST_PRO2(100);

CREATE OR REPLACE PROCEDURE TEST_PRO3 (NAME VARCHAR2) --매개변수 부분에 크기 지정X
IS
BEGIN
    DBMS_OUTPUT.PUT_LINE('입력 값 : '||NAME);
END;
/

EXEC TEST_PRO3('홍길동');
EXEC TEST_PRO3('김길동');

--이름을 입력받은 후 직원테이블에서 이름을 검색해서 이름, 전화번호, 급여 출력
CREATE OR REPLACE PROCEDURE TEST_PRO4 (NAME EMPLOYEE.EMP_NAME%TYPE) 
IS
    V_NAME EMPLOYEE.EMP_NAME%TYPE;
    TEL EMPLOYEE.PHONE%TYPE;
    SAL EMPLOYEE.SALARY%TYPE;
BEGIN
    SELECT EMP_NAME, PHONE, SALARY INTO V_NAME, TEL, SAL
        FROM EMPLOYEE WHERE EMP_NAME=NAME;
    DBMS_OUTPUT.PUT_LINE('이름 : '||V_NAME);
    DBMS_OUTPUT.PUT_LINE('번호 : '||TEL);
    DBMS_OUTPUT.PUT_LINE('급여 : '||SAL);
END;
/
EXEC TEST_PRO4('선동일');

--반환값이 있는 프로시저
CREATE OR REPLACE PROCEDURE TEST_PRO5(
    V_NAME OUT EMPLOYEE.EMP_NAME%TYPE,
    V_SAL OUT EMPLOYEE.SALARY%TYPE
    )
IS
BEGIN
    SELECT EMP_NAME, SALARY INTO V_NAME, V_SAL FROM EMPLOYEE
        WHERE EMP_ID='201';
    DBMS_OUTPUT.PUT_LINE('프로시저5 실행');
    DBMS_OUTPUT.PUT_LINE('이름 : '||V_NAME);
    DBMS_OUTPUT.PUT_LINE('급여 : '||V_SAL);
END;
/
--바인드 변수
    --반환 값을 받아줄 변수
    -- VAR[IABLE] <변수명> DATATYPE;
    --바인드 변수와 매개변수의 자료형은 반드시 같아야함
VARIABLE VAR_NAME VARCHAR2(30);
VAR VAR_SAL NUMBER;
    --반환될 값을 저장해 줄 바인드 변수 지정
EXEC TEST_PRO5(:VAR_NAME, :VAR_SAL); 
--바인드 변수 값 확인
PRINT VAR_NAME;
PRINT VAR_SAL;
--프로시저 실행과 동시에 모든 바인딩 변수의 내용을 출력
SET AUTOPRINT ON;
EXEC TEST_PRO5(:VAR_NAME, :VAR_SAL);

--매개변수와 반환값이 모두 있는 프로시져
CREATE OR REPLACE PROCEDURE TEST_PRO6(
    V_ID IN EMPLOYEE.EMP_ID%TYPE,
    V_NAME OUT EMPLOYEE.EMP_NAME%TYPE,
    V_SAL OUT EMPLOYEE.SALARY%TYPE
    )
IS
BEGIN
    SELECT EMP_NAME, SALARY INTO V_NAME, V_SAL FROM EMPLOYEE
        WHERE EMP_ID=V_ID;
    DBMS_OUTPUT.PUT_LINE('프로시저6 실행');
    DBMS_OUTPUT.PUT_LINE('이름 : '||V_NAME);
    DBMS_OUTPUT.PUT_LINE('급여 : '||V_SAL);
END;
/
--바인드 변수
    --반환 값을 받아줄 변수
    -- VAR[IABLE] <변수명> DATATYPE;
    --바인드 변수와 매개변수의 자료형은 반드시 같아야함
VARIABLE VAR_NAME VARCHAR2(30);
VAR VAR_SAL NUMBER;
    --반환될 값을 저장해 줄 바인드 변수 지정
EXEC TEST_PRO6('&사번',:VAR_NAME, :VAR_SAL); 

SELECT * FROM USER_PROCEDURES;
SELECT * FROM USER_SOURCE;
SELECT * FROM USER_SOURCE WHERE NAME='TEST_PRO6';

/*
    프로시저 삭제
    DROP PROCEDURE <프로시져 명>;
*/
DROP PROCEDURE TEST_PRO4;
SELECT * FROM USER_PROCEDURES;


--------------------------------------------------------------------------------
/*
    STORED FUNCTION(저장 함수)
    프로시져와 사용 용도가 거의 비슷함
    실행 결과를 되돌려 받을 수 있음(RETURN 값이 존재하는 객체)
    
    함수 정의 방법
        CREATE [OR REPLACE] FUNCTION <함수명>(<매개변수명> DATATYPE [, ...])
        RETURN DATATYPE;
        IS
            지역변수 선언;
        BEGIN
            실행할 내용;
            RETURN 반환값;
        END;
        /
    함수 실행 방법
        1. EXEC <바인드변수명> := <함수명>(매개변수);
        2. 다른 SQL문 내부에서 <함수명>(매개변수)
*/
--------------------------------------------------------------------------------
--기본 함수 정의
CREATE OR REPLACE FUNCTION TEST_FUNC1
    RETURN NUMBER
IS
BEGIN
    DBMS_OUTPUT.PUT_LINE('함수1');
    RETURN 10;
END;
/
--함수 목록 확인
SELECT * FROM USER_PROCEDURES;
--함수 상세 코드 확인
SELECT * FROM USER_SOURCE;
--바인드 변수
VAR VAR_FUNC NUMBER;
--함수 실행1
EXEC :VAR_FUNC := TEST_FUNC1;
--함수 실행2 -프로시져는 사용 불가능
SELECT TEST_FUNC1 FROM DUAL;