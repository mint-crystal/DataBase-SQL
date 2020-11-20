-------------------------------------------------------
/*  JOIN
    ★★★★★두 개 이상의 테이블에서 연관성을 가지고 있는 데이터들을 따로 구분하여
                새로운 가상의 테이블을 이용하여 데이터를 출력하는 구문
    두 개 이상의 테이블을 하나로 합쳐서 결과를 조회
    두 개 이상의 테이블의 컬럼들을 조합해서 새로운 형태의 테이블로 조회
*/
-------------------------------------------------------
-- 직원 테이블에서 사번, 이름, 부서코드를 조회
SELECT EMP_ID, EMP_NAME, DEPT_CODE FROM EMPLOYEE;

-- 부서 테이블에서 부서코드, 부서명을 조회
SELECT DEPT_ID, DEPT_TITLE FROM DEPARTMENT;

-- 오라클 전용 구문(암시적 조인)
    -- JOIN 키워드를 사용하지 않고, 기존 SELECT 문을 이용해서 JOIN과 동일한 결과를 조회
    -- FROM절에 콤마(,)로 구분하여 합치고 싶은 테이블명을 추가로 기술 가능
    -- 두 테이블의 컬럼명이 다른 경우
    SELECT EMP_ID, EMP_NAME, DEPT_CODE, DEPT_ID, DEPT_TITLE 
        FROM EMPLOYEE,DEPARTMENT WHERE DEPT_CODE = DEPT_ID;
    -- 두 테이블의 컬럼명이 같은 경우
    SELECT EMP_ID, EMP_NAME, EMPLOYEE.JOB_CODE, JOB.JOB_CODE, JOB_NAME
        FROM EMPLOYEE,JOB WHERE EMPLOYEE.JOB_CODE = JOB.JOB_CODE;
        -- 테이블 이름에 별칭 지정
    SELECT EMP_ID, EMP_NAME, E.JOB_CODE, J.JOB_CODE, JOB_NAME
        FROM EMPLOYEE E,JOB J WHERE E.JOB_CODE = J.JOB_CODE;
    DESC JOB;
    SELECT * FROM JOB;    
    DESC EMPLOYEE;
-- ANSI 표준구분(명시적 조인)
    -- 두 테이블의 컬럼명이 다른 경우
    SELECT EMP_ID, EMP_NAME, DEPT_CODE, DEPT_ID, DEPT_TITLE FROM EMPLOYEE
        JOIN DEPARTMENT ON (DEPT_CODE = DEPT_ID);
    -- 두 테이블의 컬럼명이 같은 경우
    SELECT EMP_ID, EMP_NAME, E.JOB_CODE, J.JOB_CODE, JOB_NAME FROM EMPLOYEE E
        JOIN JOB J ON (E.JOB_CODE = J.JOB_CODE);
        -- 또는
    SELECT EMP_ID, EMP_NAME, JOB_CODE, JOB_NAME FROM EMPLOYEE
        JOIN JOB USING(JOB_CODE);
        
/*
    기본적으로 JOIN은 INNER JOIN
    1. INNER JOIN : 두 개 이상의 테이블을 조인할 때 일치하는 값이 없는 행은 조인에서 제외됨
    2. OUTER JOIN : 두 테이블의 지정하는 컬럼값이 일치하지 않는 행도 조인에 포함을 시킴
                      반드시 OUTER JOIN임을 명시해야 한다.
-- 2-1. LEFT OUTER JOIN : 합치기에 사용한 두 테이블 중 왼편에 기술된 테이블의
--                      컬럼 수를 기준으로 JOIN
-- 2-2. RIGHT OUTER JOIN : 합치기에 사용한 두 테이블 중 오른편에 기술된 테이블의
--                       컬럼 수를 기준으로 JOIN
-- 2-3. FULL OUTER JOIN : 합치기에 사용한 두 테이블이 가진 모든 행을 결과에 포함    
*/

-- INNER JOIN
SELECT EMP_NAME, DEPT_TITLE, DEPT_CODE, DEPT_ID FROM EMPLOYEE
    JOIN DEPARTMENT ON (DEPT_CODE = DEPT_ID);
SELECT * FROM DEPARTMENT;

-- LEFT OUTER JOIN
-- ANSI 표준
SELECT EMP_NAME, DEPT_TITLE, DEPT_CODE, DEPT_ID FROM EMPLOYEE
    LEFT OUTER JOIN DEPARTMENT ON (DEPT_CODE = DEPT_ID);
-- 오라클 전용 구문
SELECT EMP_NAME, DEPT_TITLE, E.DEPT_CODE, D.DEPT_ID FROM EMPLOYEE E , DEPARTMENT D
    WHERE E.DEPT_CODE = D.DEPT_ID(+);
    -- 아우터 조인을 할 대상 컬럼에 "(+)" 기호를 붙여서 조인
    
-- RIGHT OUTER JOIN
-- ANSI 표준
SELECT EMP_NAME, DEPT_TITLE, DEPT_CODE, DEPT_ID FROM EMPLOYEE
    RIGHT OUTER JOIN DEPARTMENT ON (DEPT_CODE = DEPT_ID);
-- 오라클 전용 구문
SELECT EMP_NAME, DEPT_TITLE, E.DEPT_CODE, D.DEPT_ID FROM EMPLOYEE E , DEPARTMENT D
    WHERE E.DEPT_CODE(+) = D.DEPT_ID;
    -- 아우터 조인을 할 대상 컬럼에 "(+)" 기호를 붙여서 조인
    
-- FULL OUTER JOIN
-- ANSI 표준
SELECT EMP_NAME, DEPT_TITLE, DEPT_CODE, DEPT_ID FROM EMPLOYEE
    FULL OUTER JOIN DEPARTMENT ON (DEPT_CODE = DEPT_ID);
-- 오라클 전용 구문
SELECT EMP_NAME, DEPT_TITLE, E.DEPT_CODE, D.DEPT_ID FROM EMPLOYEE E , DEPARTMENT D
    WHERE E.DEPT_CODE(+) = D.DEPT_ID(+);
    -- FULL OUTER JOIN 은 오라클 전용 구문으로 사용 불가능
    
-- CROSS JOIN : 카테시안곱(CARTESIAN PRODUCT)
    -- 조인되는 테이블의 각 행들이 모두 매핑된 데이터가 검색되는 방법
    -- 총 조회되는 레코드(ROW) 개수 : 앞 테이블 레코드(ROW) 개수 * 뒤 테이블 레코드(ROW) 개수
-- ANSI 표준
SELECT EMP_NAME, DEPT_TITLE, DEPT_CODE, DEPT_ID FROM EMPLOYEE
    CROSS JOIN DEPARTMENT;
-- 오라클 전용 구문
SELECT EMP_NAME, DEPT_TITLE, DEPT_CODE, DEPT_ID FROM EMPLOYEE,DEPARTMENT;

-- NON EQUAL JOIN(NON_EQU JOIN 이라고 함)
    -- 지정한 컬럼 값이 일치하는 경우가 아닌, 값의 범위에 포함되는 행들을 연결하는 방식
SELECT EMP_NAME, SALARY, E.SAL_LEVEL, S.SAL_LEVEL FROM EMPLOYEE E
    JOIN SAL_GRADE S ON(SALARY BETWEEN MIN_SAL AND MAX_SAL);
SELECT EMP_NAME, SALARY, E.SAL_LEVEL, S.SAL_LEVEL FROM EMPLOYEE E
    JOIN SAL_GRADE S ON(E.SAL_LEVEL = S.SAL_LEVEL);
    
-- SELF JOIN 
    -- 두 개 이상의 서로 다른 테이블을 연결하는 것이 아닌 같은 테이블을 조인하는 것
-- ANSI 표준
SELECT E.EMP_ID, E.EMP_NAME, E.DEPT_CODE, E.MANAGER_ID, M.EMP_NAME 
    FROM EMPLOYEE E
    JOIN EMPLOYEE M ON(E.MANAGER_ID = M.EMP_ID);
-- 오라클 전용
SELECT E.EMP_ID, E.EMP_NAME, E.DEPT_CODE, E.MANAGER_ID, M.EMP_NAME 
    FROM EMPLOYEE E, EMPLOYEE M
    WHERE E.MANAGER_ID = M.EMP_ID;
    
-- 다중 JOIN : N개의 테이블을 조회할 때 사용
-- ANSI 표준
SELECT * FROM EMPLOYEE;
SELECT EMP_NAME, DEPT_CODE, DEPT_TITLE, JOB_CODE, JOB_NAME FROM EMPLOYEE E
    LEFT OUTER JOIN DEPARTMENT ON (DEPT_CODE = DEPT_ID)
    LEFT OUTER JOIN JOB USING(JOB_CODE);
-- 오라클 전용
SELECT EMP_NAME, DEPT_CODE, DEPT_TITLE, E.JOB_CODE, JOB_NAME 
    FROM EMPLOYEE E, DEPARTMENT D, JOB J
    WHERE DEPT_CODE = DEPT_ID(+) AND E.JOB_CODE = J.JOB_CODE(+);
    
-- 다중 조인 사용 시 주의 사항
    -- 다중 조인의 경우 조인 순서가 중요!!
SELECT EMP_NAME, DEPT_CODE, DEPT_TITLE, LOCATION_ID, LOCAL_NAME
    FROM EMPLOYEE
    JOIN DEPARTMENT ON(DEPT_CODE = DEPT_ID)
    JOIN LOCATION ON(LOCATION_ID = LOCAL_CODE);
    
SELECT EMP_NAME, DEPT_CODE, DEPT_TITLE, LOCATION_ID, LOCAL_NAME
    FROM EMPLOYEE , DEPARTMENT , LOCATION
    WHERE DEPT_CODE = DEPT_ID AND LOCATION_ID = LOCAL_CODE;