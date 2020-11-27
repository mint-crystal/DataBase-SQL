--------------------------------------------------------------------------------
/*
    PL/SQL(PROCEDURAL LANGUAGE EXTENSION TO SQL)
     오라클 자체에 내장된 절차적 언어
     SQL의 단점을 보완하여 SQL문장 내에서
     변수의 정의, 조건처리, 반복처리, 예외처리 등을 지원
     
    PL/SQL의 유형
    1. 익명블록(Anonymous Block)
        이름없는 블록이라 불리며 간단한 block 수행시 사용됨
    2. 프로시져(Procedure)
        지정된 특정 처리를 실행하는 서브 프로그램의 한 유형으로, 
        단독으로 실행되거나 다른 프로시져나, 다른 툴(oracle developer, sqlplus,..)등에 
        호출되어 실행됨
    3. 함수(Function)
        프로시져와 수행되는 결과가 유사하나 값 반환 여부에 따라 차이가 있음
        함수는 반환값이 있음
    
    PL/SQL 블록 문법
        DECLARE
            선언부;
        BEGIN
            실행부;
        EXCEPTION
            예외처리부;
        END;
        /
    
    PL/SQL 구조
        선언부, 실행부, 예외처리부로 구성
        DECLARE SECETION (선언부) - 선택
        -> 변수나 상수를 선언하는 부분
        -> DECLARE 로 시작함
        
        EXCUTABLE SECTION (실행부) - 필수
        -> SQL문, 제어문, 반복문, 함수 정의 등 로직 작성
        -> BEGIN 으로 시작함
        
        EXCEPTION SECITION (예외 처리부) - 선택
        -> 예외 사항 발생 시 해결하기 위한 문장 작성
        -> EXCEPTION 으로 시작함
        
        END (종료부) - 필수
        -> 하나의 블록이 끝났음을 명시하는 부분
        -> END; 로 종료
        
        / - 필수
        -> PL/SQL 종료 및 실행
        -> 쿼리문 종결을 나타내는 기호
        -> 행에 '/' 가 있으면 종결된 것으로 간주
        
    PL/SQL 프로그램 작성 방법
        - PL/SQL 블록 내에서는 한 문장을 종료할 때마다 세미콜론(;) 을 사용함
        - END 뒤에 세미콜론(;)을 사용하여 하나의 블록이 끝났다는 것을 명시
        - PL/SQL 블록의 작성은 메모장과 같은 편집기를 통해서 SQL파일로 저장할 수도 있고,
            SQL*PLUS 프롬프트에서 바로 작성할 수도 있음
        - SQL*PLUS 환경에서는 DECLARE나 BEGIN 이라는 키워드로 PL/SQL 블록이 시작함을 알수 있음
        - 쿼리문을 수행하기 위해서 /가 입력이 되어야 하며, PL/SQL블록은 행에 /가 있으면 종결된 것으로 간주함
*/
--------------------------------------------------------------------------------
--PL/SQL 기본 테스트
    --SEVEROUTPUT : 프로시저를 사용하여 출력하는 내용을 화면에 보여주도록 설절하는 환경변수
                    -- 기본값이 OFF여서 ON으로 변경해줘야 함
--현재 세션에서 출력하도록 설정
SET SERVEROUTPUT ON;
    --PUT_LINE : DAMS_OUTPUT 패키지에 속해있는 프로시저 - 화면에 출력해주는 기능
BEGIN   --실행부 시작
    DBMS_OUTPUT.PUT_LINE('HELLO WORLD');
END;    --블록 종료
/       --PL/SQL 끝과 동시에 실행

BEGIN
    SELECT * FROM EMPLOYEE;
END;
/


--------------------------------------------------------------------------------
/*
    변수
    DECLARE(선언부)안에 선언해줘야 함
    
    표현식 : 
        <변수명> [CONSTANT] DATATYPE [NOT NULL] [:= <초기값> | DEFAULT <초기값>]
            CONSTANT    상수로 지정(초기값을 반드시 할당해야 함)
            DATATYPE    자료형
            NOT NULL    값을 반드시 포함(NULL 허용 안 함)
            <초기값>     리터럴, 다른 변수, 연산자나 함수를 포함하는 표현식
    
    - 기본자료형
        문자형 : VARCHAR2(크기), BLOB, CLOB
        숫자형 : NUMBER
        날짜형 : DATE
        논리형 : BOOLEAN := TRUE, FALSE, NULL
    - 복합자료형
        레코드(RECORD)
        컬렉션(COLLECTION)
        
    변수 종류
        일반 변수(스칼라 변수), 상수, %TYPE, %ROWTYPE, 레코드(RECORD)등이 있음
*/
--------------------------------------------------------------------------------

--------------------------------------------------------------------------------
/*
    일반 변수(스칼라 변수)
    기존 SQL 자료형과 유사함
    표현법 : <변수명> DATATYPE [:=초기값]
*/
--------------------------------------------------------------------------------
--변수의 선언과 초기화, 변수값 출력 1
DECLARE 
    EMP_ID NUMBER;
    EMP_NAME VARCHAR2(30);
BEGIN
    DBMS_OUTPUT.PUT_LINE('변수 출력 테스트');
END;
/

DECLARE 
    EMP_ID NUMBER := 888;
    EMP_NAME VARCHAR2(30) := '홍길동';
BEGIN
    DBMS_OUTPUT.PUT_LINE('변수 출력 테스트');
    DBMS_OUTPUT.PUT_LINE('1_EMP_ID 값 : '||EMP_ID);  --|| : 문자열 연결
    DBMS_OUTPUT.PUT_LINE('1_EMP_NAME 값 : '||EMP_NAME);
END;
/

--변수의 선언과 초기화, 변수값 출력 2
DECLARE
    EMP_ID NUMBER DEFAULT 888;
    EMP_NAME VARCHAR2(20) DEFAULT '홍길동';
BEGIN
    DBMS_OUTPUT.PUT_LINE('변수 출력 테스트');
    DBMS_OUTPUT.PUT_LINE('2_EMP_ID 값 : '||EMP_ID);  --|| : 문자열 연결
    DBMS_OUTPUT.PUT_LINE('2_EMP_NAME 값 : '||EMP_NAME);
END;
/

--변수의 선언과 초기화, 변수값 출력 3 : 선언 후 실행부에서 값 대입
DECLARE 
    EMP_ID NUMBER;
    EMP_NAME VARCHAR2(20);
BEGIN
    EMP_ID := 888;
    EMP_NAME := '홍길동';
    
    DBMS_OUTPUT.PUT_LINE('변수 출력 테스트');
    DBMS_OUTPUT.PUT_LINE('3_EMP_ID 값 : '||EMP_ID);  --|| : 문자열 연결
    DBMS_OUTPUT.PUT_LINE('3_EMP_NAME 값 : '||EMP_NAME);
END;
/

--변수의 선언과 초기화, 변수값 출력 4 : 선언 후 실행부에서 값 대입
    --DEFAULT로는 실행부에서 값 대입 불가능
DECLARE 
    EMP_ID NUMBER;
    EMP_NAME VARCHAR2(20);
BEGIN
    EMP_ID DEFAULT 888; --오류
    EMP_NAME DEFAULT '홍길동'; --오류
    
    DBMS_OUTPUT.PUT_LINE('변수 출력 테스트');
    DBMS_OUTPUT.PUT_LINE('3_EMP_ID 값 : '||EMP_ID);  --|| : 문자열 연결
    DBMS_OUTPUT.PUT_LINE('3_EMP_NAME 값 : '||EMP_NAME);
END;
/

--SELECT문의 조회 결과를 변수에 저장
    --표현법 : SELECT <컬럼명, ...> INTO <변수명, ...> FROM <테이블명> WHERE <조건>;
    --조회되는 컬럼 개수와 변수의 개수, 자료형이 일치해야 함
    --결과로 조회되는 행이 하나만 나올 수 있도록 조건을 지정
--직원테이블에서 '선동일'이라는 직원의 EMP_ID 값을 추출하여 ID라는 변수, 이름은 NAME이라는 변수에 넣고 출력
DESC EMPLOYEE;
DECLARE 
    ID VARCHAR2(7);
    NAME VARCHAR(20);
BEGIN
    SELECT EMP_ID, EMP_NAME INTO ID, NAME
        FROM EMPLOYEE WHERE EMP_ID=200;
    DBMS_OUTPUT.PUT_LINE('아이디 : ' || ID);
    DBMS_OUTPUT.PUT_LINE('이름 : ' || NAME);
END;
/

--------------------------------------------------------------------------------
/*
    대체 변수
    변수 값을 나타내는 글로벌 또는 애플리케이션 단위 자리 표시자
    변수를 미리 선언할 필요없이 일시적으로 값을 입력받아 저장해서 사용
    
    대체 변수를 사용할 수 있는 위치
        WHERE 조건
        ORDER BY 절
        COLUMN 표현식
        TABLE 이름
        SELECT 문 전체
    
    사용법 : <대체 변수 기호> <변수명>
*/
--------------------------------------------------------------------------------
--대체 변수 기호 확인
    --대체 변수 기본 기호 : &
SHOW DEFINE;
--대체 변수 사용안함(기본값은 사용함으로 되어 있음)
    --간혹 ' ' 문자열 처리 중 &를 사용하면 대체 변수로 인식해서 제대로 사용 안 되는 경우있음
    --대체 변수 설정 OFF 후 사용 가능
SET DEFINE OFF;
SHOW DEFINE;
--대체 변수 사용
SET DEFINE ON;
SHOW DEFINE;
--대체 변수 기호 변경
    --현재 세션에서만 유지
    --대체변수 설정을 껐다 키면 다시 &로 초기화됨
SET DEFINE $;
SHOW DEFINE;
--'&'기호를 대체변수에 사용하지만, 앞에 '\'를 사용하면 ESCAPE처리(문자 그대로 인식하도록 설정)
SET ESCAPE ON;

--대체 변수로 값을 입력받아서 SELECT문 조회
DECLARE 
    ID VARCHAR2(7);
    NAME VARCHAR(20);
BEGIN
    SELECT EMP_ID, EMP_NAME INTO ID, NAME
        FROM EMPLOYEE WHERE EMP_NAME='&TMP_NAME';
    DBMS_OUTPUT.PUT_LINE('아이디 : ' || ID);
    DBMS_OUTPUT.PUT_LINE('이름 : ' || NAME);
END;
/

--예외처리
    --만약 조회한 데이터가 없으면 '존재하지 않는 직원입니다.' 라는 문자열 출력
DECLARE 
    ID VARCHAR2(7);
    NAME VARCHAR(20);
BEGIN
    SELECT EMP_ID, EMP_NAME INTO ID, NAME
        FROM EMPLOYEE WHERE EMP_NAME='&TMP_NAME';
    DBMS_OUTPUT.PUT_LINE('아이디 : ' || ID);
    DBMS_OUTPUT.PUT_LINE('이름 : ' || NAME);
EXCEPTION
    WHEN NO_DATA_FOUND THEN 
        DBMS_OUTPUT.PUT_LINE('존재하지 않는 직원입니다.');
END;
/

    --예외처리부에서 대체 변수에 입력받은 데이터를 사용하고 싶은 경우
        --일반 변수에 저장 후 사용 가능
DECLARE 
    ID VARCHAR2(7);
    NAME VARCHAR(20);
BEGIN
    NAME := '&TMP_NAME';
    SELECT EMP_ID, EMP_NAME INTO ID, NAME
        FROM EMPLOYEE WHERE EMP_NAME=NAME;
    DBMS_OUTPUT.PUT_LINE('아이디 : ' || ID);
    DBMS_OUTPUT.PUT_LINE('이름 : ' || NAME);
EXCEPTION
    WHEN NO_DATA_FOUND THEN 
        DBMS_OUTPUT.PUT_LINE(NAME||'은 존재하지 않는 직원입니다.');
END;
/

--------------------------------------------------------------------------------
/*
    상수
    일반 변수와 유사하나 CONSTANT 키워드가 자료형 앞에 붙고, 선언 시 값을 할당해 주어야 함
    선언 이후에는 값 변경이 불가능
    
    표현법 : <변수명> CONSTANT DATATYPE := <초기값>;
*/
--------------------------------------------------------------------------------
DECLARE
    USER_NAME1 CONSTANT VARCHAR2(20) := '홍길동';
    USER_NAME2 VARCHAR2(20) := '김길동';
BEGIN
    DBMS_OUTPUT.PUT_LINE('NAME1 : ' || USER_NAME1);
    DBMS_OUTPUT.PUT_LINE('NAME2 : ' || USER_NAME2);
    --USER_NAME1 := '홍말동'; --상수기 떄문에 값 변경 불가능
    USER_NAME2 := '김말동';
     DBMS_OUTPUT.PUT_LINE('NAME1 : ' || USER_NAME1);
     DBMS_OUTPUT.PUT_LINE('NAME2 : ' || USER_NAME2);
END;
/

--------------------------------------------------------------------------------
/*
    참조(REFERENCE) 변수
    이전에 선언된 다른 변수 또는 테이블의 컬럼의 자료형에 맞추어 변수를 선언하는 방법
    
    참조변수 종류
        %TYPE : 컬럼을 기준으로 데이터 타입 지정
        %ROWTYPE : 행을 기준으로 변수와 데이터 타입을 지정
*/
--------------------------------------------------------------------------------
/*
    %TYPE 속성을 사용한 참조 변수
    표현법 : <변수명> <테이블명>.<컬럼명>%TYPE
    
    사용 예) 
        ID EMPLOYEE.EMP_ID%TYPE
        EMPLOYEE테이블의 EMP_ID와 동일한 타입으로 ID라는 이름의 변수를 생성
*/
--직원테이블에서 사번을 기준으로 이름을 조회해서 NAME 변수에 저장
DECLARE
    NAME NUMBER;    --데이터 타입이 맞지 않아 오류 발생
BEGIN
    SELECT EMP_NAME 
        INTO NAME 
        FROM EMPLOYEE 
        WHERE EMP_ID='&사번';
END;
/
--%TYPE 참조변수를 이용해 변수 선언
DECLARE
    ID EMPLOYEE.EMP_ID%TYPE;
    NAME EMPLOYEE.EMP_NAME%TYPE;
BEGIN
    SELECT EMP_ID, EMP_NAME
        INTO ID, NAME
        FROM EMPLOYEE
        WHERE EMP_ID='&사번';
    DBMS_OUTPUT.PUT_LINE('사번 : '||ID);
    DBMS_OUTPUT.PUT_LINE('이름 : '||NAME);
EXCEPTION
    WHEN NO_DATA_FOUND THEN
        DBMS_OUTPUT.PUT_LINE('조회된 데이터가 없습니다.');
END;
/

/*
    %ROWTYPE 속성을 사용한 참조 변수
    %TYPE과 유사하게 참조할 데이터의 타입을 자동으로 가지고 옴
    1개의 컬럼이 아니라 여러 개의 컬럼을 자동으로 가져올 수 있음
    
    변수 정의 방법 : <변수명> <테이블명>%ROWTYPE;
    변수 사용 방법 : <변수명>.<컬럼명>;
    
    사용 예)
        USERINFO EMPLOYEE%ROWTYPE;
            EMPLOYEE 테이블의 모든 컬럼에 대한 정보를 가져와 USERINFO에 저장
        USERINFO.EMP_ID;
        USERINFO.EMP_NAME;
*/
DECLARE
    USERINFO EMPLOYEE%ROWTYPE;
BEGIN
    SELECT * INTO USERINFO FROM EMPLOYEE WHERE EMP_ID='&사번';
    DBMS_OUTPUT.PUT_LINE('사번 : ' || USERINFO.EMP_ID);
    DBMS_OUTPUT.PUT_LINE('이름 : ' || USERINFO.EMP_NAME);
    DBMS_OUTPUT.PUT_LINE('급여 : ' || USERINFO.SALARY);
    DBMS_OUTPUT.PUT_LINE('연락처 : ' || USERINFO.PHONE);
    DBMS_OUTPUT.PUT_LINE('이메일 : ' || USERINFO.EMAIL);
EXCEPTION
    WHEN NO_DATA_FOUND THEN
        DBMS_OUTPUT.PUT_LINE('직원 정보가 없습니다.');
END;
/

--------------------------------------------------------------------------------
/*
    레코드 변수
    가져올 컬럼을 직접 지정해서 사용
    %ROWTYPE은 참조할 테이블의 모든 컬럼을 자동으로 가져옴
    특정 컬럼만 가져와서 사용하고 싶은 경우 레코드 변수로 사용 가능
    가져올 컬럼들을 나열해서 미리 새로운 타입을 정의해놓고, 해당 타입으로 변수 선언해서 사용
    
    타입 정의 방법 : TYPE <레코드 타입명> IS RECORD(<변수명> <변수타입>[, ...]);
    변수 선언 방법 : <변수명> <레코드 타입명>;
*/
--------------------------------------------------------------------------------
--직원테이블에서 사번, 이름, 부서, 직급에 대한 정보를 가져와서 출력
DECLARE
    --레코드 타입 정의
    TYPE USERINFO_TYPE IS RECORD(
        ID EMPLOYEE.EMP_ID%TYPE,
        NAME EMPLOYEE.EMP_NAME%TYPE,
        DEPT_NAME DEPARTMENT.DEPT_TITLE%TYPE,
        JOB_NAME JOB.JOB_NAME%TYPE
    );
    --정의된 레코드 타입을 이용해서 변수 선언
    USER USERINFO_TYPE;
BEGIN
    SELECT EMP_ID,EMP_NAME,DEPT_TITLE,JOB_NAME
        INTO USER
        FROM EMPLOYEE
        LEFT JOIN DEPARTMENT ON (DEPT_CODE=DEPT_ID)
        LEFT JOIN JOB USING (JOB_CODE)
        WHERE EMP_NAME='&이름';
    DBMS_OUTPUT.PUT_LINE('사번 : ' || USER.ID);
    DBMS_OUTPUT.PUT_LINE('이름 : ' || USER.NAME);
    DBMS_OUTPUT.PUT_LINE('부서 : ' || USER.DEPT_NAME);
    DBMS_OUTPUT.PUT_LINE('직급 : ' || USER.JOB_NAME);
EXCEPTION
    WHEN NO_DATA_FOUND THEN
        DBMS_OUTPUT.PUT_LINE('직원 정보가 없습니다.');
END;
/


--------------------------------------------------------------------------------
/*
    조건문
    IF문 : 조건에 따라 실행할 내용을 결정
    사용법 : 
        IF <조건> THEN 
            조건을 만족할 경우 처리할 구문;
        END IF;
*/
--------------------------------------------------------------------------------
--사원번호를 입력받아서 사원의 사번, 이름, 급여, 보너스율을 출력
    --보너스율이 없으면 '보너스를 지급받지 않는 사원입니다.' 출력
DECLARE
    ID EMPLOYEE.EMP_ID%TYPE;
    NAME EMPLOYEE.EMP_NAME%TYPE;
    SALARY EMPLOYEE.SALARY%TYPE;
    BONUS EMPLOYEE.BONUS%TYPE;
BEGIN
    SELECT EMP_ID, EMP_NAME, SALARY, NVL(BONUS,0)
        INTO ID, NAME, SALARY, BONUS
        FROM EMPLOYEE WHERE EMP_ID='&사번';
    DBMS_OUTPUT.PUT_LINE('사번 : '||ID);
    DBMS_OUTPUT.PUT_LINE('이름 : '||NAME);
    DBMS_OUTPUT.PUT_LINE('급여 : '||SALARY);
    IF(BONUS=0) THEN 
        DBMS_OUTPUT.PUT_LINE('보너스를 지급받지 않는 사원입니다.');
    END IF;
    DBMS_OUTPUT.PUT_LINE('보너스율 : '||BONUS*100||'%');
EXCEPTION
    WHEN NO_DATA_FOUND THEN
        DBMS_OUTPUT.PUT_LINE('직원 정보를 찾을 수 없습니다.');
END;
/

/*
    IF~ELSE문
    사용법 : 
        IF <조건> THEN
            조건을 만족할 경우 처리할 구문;
        ELSE
            조건을 만족하지 못할 경우 처리할 구문;
        END IF;
*/
DECLARE
    ID EMPLOYEE.EMP_ID%TYPE;
    NAME EMPLOYEE.EMP_NAME%TYPE;
    SALARY EMPLOYEE.SALARY%TYPE;
    BONUS EMPLOYEE.BONUS%TYPE;
BEGIN
    SELECT EMP_ID, EMP_NAME, SALARY, NVL(BONUS,0)
        INTO ID, NAME, SALARY, BONUS
        FROM EMPLOYEE WHERE EMP_ID='&사번';
    DBMS_OUTPUT.PUT_LINE('사번 : '||ID);
    DBMS_OUTPUT.PUT_LINE('이름 : '||NAME);
    DBMS_OUTPUT.PUT_LINE('급여 : '||SALARY);
    IF(BONUS=0) THEN 
        DBMS_OUTPUT.PUT_LINE('보너스를 지급받지 않는 사원입니다.');
    ELSE
        DBMS_OUTPUT.PUT_LINE('보너스율 : '||BONUS*100||'%');
    END IF;
EXCEPTION
    WHEN NO_DATA_FOUND THEN
        DBMS_OUTPUT.PUT_LINE('직원 정보를 찾을 수 없습니다.');
END;
/

/*
    IF~ELSIF~ELSE 문
    사용법 : 
        IF <조건1> THEN
            조건1을 만족할 경우 처리할 구문;
        ELSIF <조건2> THEN
            조건2를 만족할 경우 처리할 구문;
        ELSIF <조건3> THEN
            조건3을 만족할 경우 처리할 구문;
        ELSE
            모든 조건을 만족하지 못할 경우 처리할 구문;
        END IF;
*/
--사번을 입력받아서 사번, 이름, 급여, 급여 등급 출력
    /*  급여 등급
        500만원 이상 A, 
        400만원 이상 B, 
        300만원 이상 C, 
        200만원 이상 D, 
        100만원 이상 E, 
        100만원 미만 F  */
DECLARE
    ID EMPLOYEE.EMP_ID%TYPE;
    NAME EMPLOYEE.EMP_NAME%TYPE;
    SALARY EMPLOYEE.SALARY%TYPE;
    SALGRADE VARCHAR(1);
BEGIN
    SELECT EMP_ID, EMP_NAME, SALARY 
        INTO ID, NAME, SALARY
        FROM EMPLOYEE 
        WHERE EMP_ID='&사번';
    DBMS_OUTPUT.PUT_LINE('사번 : ' || ID);
    DBMS_OUTPUT.PUT_LINE('이름 : ' || NAME);
    DBMS_OUTPUT.PUT_LINE('급여 : ' || SALARY);
    
    IF(SALARY >= 5000000) THEN
        SALGRADE := 'A';
    ELSIF (SALARY >= 4000000) THEN
        SALGRADE := 'B';
    ELSIF (SALARY >= 3000000) THEN
        SALGRADE := 'C';
    ELSIF (SALARY >= 2000000) THEN
        SALGRADE := 'D';
    ELSIF (SALARY >= 1000000) THEN
        SALGRADE := 'E';
    ELSE
        SALGRADE := 'F';
    END IF;
    DBMS_OUTPUT.PUT_LINE('급여등급 : '||SALGRADE);
EXCEPTION
    WHEN NO_DATA_FOUND THEN
        DBMS_OUTPUT.PUT_LINE('직원 정보가 없습니다.');
END;
/

--------------------------------------------------------------------------------
/*
    선택문 - CASE문
    자바의 SWITCH문과 동일
    
    사용법 : 
        CASE <변수명>
            WHEN 조건값1 THEN 조건값1 일때 실행문;
            WHEN 조건값2 THEN 조건값2 일때 실행문;
            ELSE 모든 조건이 아닐때 실행문;
            END CASE;
*/
--------------------------------------------------------------------------------
--1~3까지의 수를 입력받고 
    --1을 입력받으면 '1입력', 2를 입력받으면 '2입력', 3을 입력받으면 '3입력,
    --그 외에는 다른 '다른 입력'
DECLARE
    INPUTVALUE NUMBER;
BEGIN
    INPUTVALUE := &숫자입력;
    CASE INPUTVALUE
        WHEN 1 THEN DBMS_OUTPUT.PUT_LINE('1입력');
        WHEN 2 THEN DBMS_OUTPUT.PUT_LINE('2입력');
        WHEN 3 THEN DBMS_OUTPUT.PUT_LINE('3입력');
        ELSE DBMS_OUTPUT.PUT_LINE('다른 입력 : ' || INPUTVALUE);
        END CASE;
END;
/

--사번을 입력받아서 사번, 이름, 급여, 급여 등급 출력
    /*  급여 등급
        500만원 이상 A, 
        400만원 이상 B, 
        300만원 이상 C, 
        200만원 이상 D, 
        100만원 이상 E, 
        100만원 미만 F  */
DECLARE
    ID EMPLOYEE.EMP_ID%TYPE;
    NAME EMPLOYEE.EMP_NAME%TYPE;
    SALARY EMPLOYEE.SALARY%TYPE;
    SALGRADE VARCHAR(1);
BEGIN
    SELECT EMP_ID, EMP_NAME, SALARY 
        INTO ID, NAME, SALARY
        FROM EMPLOYEE 
        WHERE EMP_ID='&사번';
    DBMS_OUTPUT.PUT_LINE('사번 : ' || ID);
    DBMS_OUTPUT.PUT_LINE('이름 : ' || NAME);
    DBMS_OUTPUT.PUT_LINE('급여 : ' || SALARY);
    
    CASE SALARY / 1000000 
        WHEN 0 THEN SALGRADE := 'F';
        WHEN 1 THEN SALGRADE := 'E';
        WHEN 2 THEN SALGRADE := 'D';
        WHEN 3 THEN SALGRADE := 'C';
        WHEN 4 THEN SALGRADE := 'B';
        ELSE SALGRADE := 'A';
    END CASE;
    DBMS_OUTPUT.PUT_LINE('급여등급 : '||SALGRADE);
EXCEPTION
    WHEN NO_DATA_FOUND THEN
        DBMS_OUTPUT.PUT_LINE('직원 정보가 없습니다.');
END;
/

--------------------------------------------------------------------------------
/*
    반복문
    1. BASIC LOOP : 조건없이 무한 반복
        LOOP
            반복할 내용;
        END LOOP;
    2. FOR LOOP : 카운트용 변수를 이용해 원하는 횟수만큼 반복
        FOR <카운트용 변수명> IN [REVERSE] <시작수>..<종료값> LOOP
            반복할 내용;
        END LOOP;
*/
--------------------------------------------------------------------------------
--LOOP문 사용
DECLARE
    N NUMBER := 1;  --초기값 지정
BEGIN
    LOOP
        DBMS_OUTPUT.PUT_LINE('HELLO');
        N := N+1;
        IF N>5 THEN EXIT;
        END IF;
    END LOOP;
END;
/

--FOR LOOP문
    --FOR LOOP문에서 사용되는 카운트용 변수는 자동으로 선언됨 - DECLARE에서 선언 안 해줘도 됨
    --카운트 값은 자동으로 1씩 증가함
BEGIN 
    FOR N IN 1..5 LOOP
        DBMS_OUTPUT.PUT_LINE(N);
    END LOOP;
END;
/

--FOR LOOP REVERSE
    --종료값부터 시작값까지 1씩 감소
BEGIN 
    FOR N IN REVERSE 1..5 LOOP
        DBMS_OUTPUT.PUT_LINE(N);
    END LOOP;
END;
/

SELECT COUNT(*) FROM EMPLOYEE;
--직원테이블의 모든 직원 정보를 출력
DECLARE
    TYPE USERINFO_TYPE IS RECORD (
        NO NUMBER,
        ID EMPLOYEE.EMP_ID%TYPE,
        NAME EMPLOYEE.EMP_NAME%TYPE,
        TEL EMPLOYEE.PHONE%TYPE,
        HIREDATE EMPLOYEE.HIRE_DATE%TYPE
    );
    USERINFO USERINFO_TYPE;
    CNT NUMBER;
    N NUMBER := 1;
BEGIN
    DBMS_OUTPUT.PUT_LINE('--------------- 직원목록 ---------------');
    DBMS_OUTPUT.PUT_LINE('사번    이름     연락처          입사일');
    --직원 테이블의 행 개수를 알아와서 CNT변수에 저장
    SELECT COUNT(*) INTO CNT FROM EMPLOYEE;
    LOOP
        SELECT * INTO USERINFO FROM
            (SELECT ROWNUM AS NUM, EMP_ID, EMP_NAME, PHONE, HIRE_DATE FROM EMPLOYEE)
            WHERE NUM = N;
        DBMS_OUTPUT.PUT_LINE(USERINFO.ID||'    '||
                            USERINFO.NAME||'    '||
                            USERINFO.TEL||'   '||
                            USERINFO.HIREDATE);
        N := N+1;
        IF N > CNT THEN EXIT;
        END IF;
    END LOOP;
END;
/
--전체 데이터 조회 후 행번호(ROWNUM) 부여
SELECT ROWNUM, EMP_NO, EMP_NAME, PHONE, HIRE_DATE FROM EMPLOYEE;
--특정 데이터 조회 후 순서대로 행번호(ROWNUM) 부여
SELECT ROWNUM, EMP_NO, EMP_NAME, PHONE, HIRE_DATE FROM EMPLOYEE WHERE EMP_NAME LIKE '이%';
--특정 위치의 데이터만 조회하기
    --전체 데이터에 순서대로 행번호(ROWNUM)를 붙여서 가상 테이블 생성 후 행 번호로 조건을 지정해서 조회
SELECT * FROM 
    (SELECT ROWNUM AS NUM, EMP_ID, EMP_NAME, PHONE, HIRE_DATE FROM EMPLOYEE)
    WHERE NUM = 2;
--순서대로 특정 개수의 데이터만 조회
SELECT ROWNUM, EMP_NO, EMP_NAME, PHONE, HIRE_DATE FROM EMPLOYEE WHERE ROWNUM<=3;
--정렬 후 데이터에 순서번호 매기기
SELECT ROWNUM, EMP_ID, EMP_NAME, PHONE, HIRE_DATE FROM (SELECT * FROM EMPLOYEE ORDER BY EMP_NAME);

--직원테이블의 모든 직원 정보를 출력(FOR LOOP)
DECLARE
    TYPE USERINFO_TYPE IS RECORD (
        NO NUMBER,
        ID EMPLOYEE.EMP_ID%TYPE,
        NAME EMPLOYEE.EMP_NAME%TYPE,
        TEL EMPLOYEE.PHONE%TYPE,
        HIREDATE EMPLOYEE.HIRE_DATE%TYPE
    );
    USERINFO USERINFO_TYPE;
    CNT NUMBER;
BEGIN
    DBMS_OUTPUT.PUT_LINE('--------------- 직원목록 ---------------');
    DBMS_OUTPUT.PUT_LINE('사번    이름     연락처          입사일');
    --직원 테이블의 행 개수를 알아와서 CNT변수에 저장
    SELECT COUNT(*) INTO CNT FROM EMPLOYEE;
    FOR N IN 1..CNT LOOP
        SELECT * INTO USERINFO FROM
            (SELECT ROWNUM AS NUM, EMP_ID, EMP_NAME, PHONE, HIRE_DATE FROM EMPLOYEE)
            WHERE NUM = N;
        DBMS_OUTPUT.PUT_LINE(USERINFO.ID||'    '||
                            USERINFO.NAME||'    '||
                            USERINFO.TEL||'   '||
                            USERINFO.HIREDATE);
    END LOOP;
END;
/

--직원테이블의 모든 직원 정보를 출력(LOOP 방법2)
DECLARE
    TYPE USERINFO_TYPE IS RECORD (
        NO NUMBER,
        ID EMPLOYEE.EMP_ID%TYPE,
        NAME EMPLOYEE.EMP_NAME%TYPE,
        TEL EMPLOYEE.PHONE%TYPE,
        HIREDATE EMPLOYEE.HIRE_DATE%TYPE
    );
    USERINFO USERINFO_TYPE;
    N NUMBER := 1;
BEGIN
    DBMS_OUTPUT.PUT_LINE('--------------- 직원목록 ---------------');
    DBMS_OUTPUT.PUT_LINE('사번    이름     연락처          입사일');
    LOOP
        SELECT * INTO USERINFO FROM
            (SELECT ROWNUM AS NUM, EMP_ID, EMP_NAME, PHONE, HIRE_DATE FROM EMPLOYEE)
            WHERE NUM = N;
        DBMS_OUTPUT.PUT_LINE(USERINFO.ID||'    '||
                            USERINFO.NAME||'    '||
                            USERINFO.TEL||'   '||
                            USERINFO.HIREDATE);
        N := N+1;
    END LOOP;
EXCEPTION
    WHEN NO_DATA_FOUND THEN
        DBMS_OUTPUT.PUT_LINE('--------------------------------------------');
END;
/