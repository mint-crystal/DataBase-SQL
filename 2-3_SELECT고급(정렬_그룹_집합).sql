-----------------------------------------------------
/*  ORDER BY
    테이블 내 조회된 데이터를 지장된 컬럼을 기준으로 정렬
    SELECT 구문의 가장 마지막에 작성하며, 실행 순서 역시 가장 마지막에 수행됨
    
    표현식 : ORDER BY <컬럼명|별칭|컬럼순번> [정렬방식] [NULLS FIRST|LAST]
        정렬방식 : ASC(기본값) - 오름차순, DESC - 내림차순
        NULLS : NULL 값을 가장 작은 값으로 정렬할지, 가장 큰값으로 정렬할지 순서 지정
            FIRST : 가장 작은 값으로 인식
            LAST(기본값) : 가장 큰 값으로 인식
*/
-----------------------------------------------------
-- 그냥 조회 : 직원 테이블에서 사원번호,이름,부서코드,직급코드를 조회
SELECT EMP_ID, EMP_NAME, DEPT_CODE, JOB_CODE FROM EMPLOYEE;
-- 부서코드를 기준으로 정렬(기본 오름차순)
SELECT EMP_ID, EMP_NAME, DEPT_CODE, JOB_CODE FROM EMPLOYEE
    ORDER BY DEPT_CODE; -- ASC 생략 가능
-- 부서코드를 기준으로 내림차순 정렬
SELECT EMP_ID, EMP_NAME, DEPT_CODE, JOB_CODE FROM EMPLOYEE
    ORDER BY DEPT_CODE DESC;
-- 부서코드를 기준으로 정렬 후 직급코드를 기준으로 추가 정렬
SELECT EMP_ID, EMP_NAME, DEPT_CODE, JOB_CODE FROM EMPLOYEE
    ORDER BY DEPT_CODE,JOB_CODE;
-- 별칭으로 정렬
SELECT EMP_ID 사원번호, EMP_NAME 이름, DEPT_CODE 부서코드, JOB_CODE 직급코드
    FROM EMPLOYEE ORDER BY 이름;
-- 컬럼 순번으로 정렬
SELECT EMP_ID, EMP_NAME, DEPT_CODE, JOB_CODE FROM EMPLOYEE
    ORDER BY 3;
-- NULL 값을 가장 처음으로 정렬(기본값은 가장 마지막에 정렬 - LAST)
SELECT EMP_ID, EMP_NAME, DEPT_CODE, JOB_CODE FROM EMPLOYEE
    ORDER BY 3 NULLS FIRST;

-----------------------------------------------------
/*  GROUP BY
    지정된 컬럼을 기준으로 데이터를 그룹핑
    그룹함수는 단 한개의 결과 값만 산출하기 대문에 그룹이 여러 개인 경우 오류 발생
        여러 개의 결과 값을 산출하기 위해 그룹함수가 적용될 그룹의 기준을 GROUP BY절에 기술하여 사용
    여러개의 값을 묶어서 하나로 처리할 목적으로 사용함    
    표현식 : GROUP BY <그룹을 묶을 컬럼명>
*/
-----------------------------------------------------
SELECT * FROM EMPLOYEE;
-- 직원의 총 급여
SELECT SUM(SALARY) FROM EMPLOYEE;
-- 각 부서별 직원의 총 급여
    -- 부서 코드를 기준으로 그룹 묶어서 각 그룹의 급여 합계 조회
SELECT DEPT_CODE, SUM(SALARY) FROM EMPLOYEE;    -- 에러 발생
SELECT DEPT_CODE, SUM(SALARY) FROM EMPLOYEE 
    GROUP BY DEPT_CODE ORDER BY DEPT_CODE;
-- 부서별 총 급여와 평균 급여 조회
SELECT DEPT_CODE, SUM(SALARY) 총급여, AVG(SALARY) 평균급여 FROM EMPLOYEE 
    GROUP BY DEPT_CODE ORDER BY DEPT_CODE;

-- 부서별 사원수 조회
SELECT DEPT_CODE 부서코드, COUNT(*) 사원수 FROM EMPLOYEE 
    GROUP BY DEPT_CODE;
    
-----------------------------------------------------
/*  HAVING
    그룹함수로 값을 구해올 그룹에 대해 조건을 설정 할 때 사용
    (WHERE 절은 SELECT에 대한 조건)
    표현법 : HAVING <컬럼명|그룹함수식> 비교연산자 비교값
*/
-----------------------------------------------------
-- 부서별 급여 합계 중 1000만원 이상인 부서만 조회
SELECT DEPT_CODE, SUM(SALARY) FROM EMPLOYEE 
    GROUP BY DEPT_CODE HAVING SUM(SALARY) >= 10000000;

/*  SELECT 문 수행 순서
    5 : SELECT 컬럼명
    1 : FROM 테이블명
    2 : WHERE 조건
    3 : GROUP BY 그룹 묶을 컬럼명
    4 : HAVING 그룹에 대한 조건
    6 : ORDER BY 정렬할 기준 컬럼명
*/

-----------------------------------------------------
/*  집계함수
    GROUP BY 절에서만 사용하는 함수
    그룹별 산출한 결과 값의 집계를 계산하는 함수
    -- ROLLUP 함수 : 그룹별로 중간 집계 처리를 하는 함수
        -- 그룹별로 묶여진 값에 대한 중간 집계와 총 집계를 구할 때 사용
        -- 그룹함수로 계산된 결과값들에 대한 총 집계가 자동으로 추가됨
    -- CUBE 함수 : 그룹별 산출한 결과를 집계하는 함수
        -- 인자로 지정된 그룹들로 가능한 모든 조합 별로 집계한 결과를 반환
*/
-----------------------------------------------------
-- 직급코드별로 급여 합계 금액을 조회
SELECT JOB_CODE, SUM(SALARY) FROM EMPLOYEE
    GROUP BY JOB_CODE ORDER BY 1;
    
-- 직급코드별로 급여 합계 금액을 조회하고 마지막에 총 합계 조회
SELECT JOB_CODE, SUM(SALARY) FROM EMPLOYEE
    GROUP BY ROLLUP(JOB_CODE) ORDER BY 1;
    
SELECT JOB_CODE, SUM(SALARY) FROM EMPLOYEE
    GROUP BY CUBE(JOB_CODE) ORDER BY 1;
    
SELECT SUM(SALARY) FROM EMPLOYEE;   -- 총 합계값 조회해보기

-- 직급코드별로 급여 평균 금액을 조회하고 마지막에 전체 평균 조회
SELECT JOB_CODE, AVG(SALARY) FROM EMPLOYEE
    GROUP BY ROLLUP(JOB_CODE) ORDER BY 1;
SELECT JOB_CODE, AVG(SALARY) FROM EMPLOYEE
    GROUP BY CUBE(JOB_CODE) ORDER BY 1;
    
SELECT AVG(SALARY) FROM EMPLOYEE;   -- 전체 평균 조회해보기

-- 각 부서 내 직급 별로 그룹 지정해서 급여 조회
SELECT DEPT_CODE, JOB_CODE, SUM(SALARY) FROM EMPLOYEE
    GROUP BY DEPT_CODE, JOB_CODE ORDER BY 1;
    
-- 각 부서 내 직급 별로 그룹 지정해서 급여 조회하고 부서의 총 급여, 전체 총 급여도 같이 조회
    -- 부서코드+직급코드에 대한 급여 합계 (GROUP BY)
    -- 부서코드에대한 급여 합계 (ROLLUP으로 자동 집계)
    -- 총 급여 합계 에 대한 집계 결과 반환 (ROLLUP으로 자동 집계)
SELECT DEPT_CODE, JOB_CODE, SUM(SALARY) FROM EMPLOYEE
    GROUP BY ROLLUP(DEPT_CODE, JOB_CODE) ORDER BY 1;
    
-- 인자로 지정된 그룹들로 가능한 모든 조합 별 집계 결과를 반환
    -- 부서코드+직급코드에 대한 급여 합계
    -- 부서코드에 대한 급여 합계
    -- 직급코드에 대한 급여 합계
    -- 총 급여 합계
SELECT DEPT_CODE, JOB_CODE, SUM(SALARY) FROM EMPLOYEE
    GROUP BY CUBE(DEPT_CODE, JOB_CODE) ORDER BY 1;
    
-- GROUPING 함수
    -- 각 레코드(ROW)가 결과 집합에 의해 조회된 데이터인지,
    -- ROLLUP이나 CUBE에 의해서 산출된 데이터인지 구분하는 함수
    -- 인자로 전달받은 컬럼의 집계 산출물이면 1, 아니면 0을 반환
SELECT DEPT_CODE, JOB_CODE, SUM(SALARY), 
    GROUPING(DEPT_CODE) 부서별묶인상태, 
    GROUPING(JOB_CODE) 직급별묶인상태
    FROM EMPLOYEE
    GROUP BY CUBE(DEPT_CODE, JOB_CODE) ORDER BY 1;

SELECT DEPT_CODE, JOB_CODE, SUM(SALARY),
    CASE WHEN GROUPING(DEPT_CODE) = 0 AND GROUPING(JOB_CODE) = 1
        THEN '부서별 총합'
        WHEN GROUPING(DEPT_CODE) = 1 AND GROUPING(JOB_CODE) = 0
        THEN '직급별 총합'
        WHEN GROUPING(DEPT_CODE) = 0 AND GROUPING(JOB_CODE) = 0
        THEN '그룹별 총합'
        ELSE '총합계'
    END AS 구분 FROM EMPLOYEE GROUP BY CUBE(DEPT_CODE, JOB_CODE) ORDER BY 1;


SELECT CASE WHEN GROUPING(DEPT_CODE) = 0 AND GROUPING(JOB_CODE) = 1
        THEN DEPT_CODE
        WHEN GROUPING(DEPT_CODE) = 1 AND GROUPING(JOB_CODE) = 0
        THEN '직급별 총합'
        WHEN GROUPING(DEPT_CODE) = 0 AND GROUPING(JOB_CODE) = 0
        THEN DEPT_CODE
        ELSE '총합계'
    END AS 부서코드,
    CASE WHEN GROUPING(DEPT_CODE) = 0 AND GROUPING(JOB_CODE) = 1
        THEN '부서별 총합'
        WHEN GROUPING(DEPT_CODE) = 1 AND GROUPING(JOB_CODE) = 0
        THEN JOB_CODE
        WHEN GROUPING(DEPT_CODE) = 0 AND GROUPING(JOB_CODE) = 0
        THEN JOB_CODE
        ELSE '총합계'
    END AS 직급코드,
    SUM(SALARY) 
    FROM EMPLOYEE GROUP BY CUBE(DEPT_CODE, JOB_CODE) ORDER BY 1;
    
-----------------------------------------------------
/*  집합연산자(SET OPERATOR)
    여러 개의 SELECT 결과물을 하나의 쿼리로 만드는 연산자
    UNION : 여러 개의 쿼리 결과를 합치는 연산자로 중복된 영역은 제외하여 합침(합집합)
    UNION ALL : 여러 개의 쿼리 결과를 합치는 연산자로 중복된 영역 모두 포함하여 합침
    INTERSECT : 여러 개의 쿼리 결과에서 공통된 부분만 결과로 추출(교집합)
    MINUS : 선행 SELECT 결과에서 다음 SELECT 결과와 겹치는 부분을 제외한 나머지 부분 추출(차집합)

    조건 : 
    1. 선행 SELECT에서 조회할 컬럼 개수와 
            다음 SELECT에서 조회할 컬럼 개수가 반드시 일치해야 함
    2. 선행 SELECT에서 조회할 컬럼 데이터 타입과 
            다음 SELECT에서 조회할 컬럼 데이터 타입이 반드시 일치해야 함
*/
-----------------------------------------------------
DESC EMPLOYEE;
-- UNION 
-- 직원테이블 조회된 결과 아래부분에 두번째 SELECT 문에서 조회한 결과 같이 조회 됨
SELECT EMP_ID, EMP_NAME, DEPT_CODE, SALARY FROM EMPLOYEE
UNION
SELECT 'A','B','C',10 FROM DUAL;

-- 직원테이블에서 조회된 결과와 중복된 값은 제외 됨
SELECT EMP_ID, EMP_NAME, DEPT_CODE, SALARY FROM EMPLOYEE
UNION
SELECT '200','선동일','D9',8000000 FROM DUAL;

-- UNION ALL
-- 직원테이블 조회된 결과 아래부분에 두번째 SELECT 문에서 조회한 결과 같이 조회 됨
Select Emp_Id, Emp_Name, Dept_Code, Salary From Employee
Union All
Select 'A','B','C',10 From Dual;

-- 직원테이블에서 조회된 결과와 중복된 값도 같이 조회 됨
Select Emp_Id, Emp_Name, Dept_Code, Salary From Employee
Union All
Select '200','선동일','D9',8000000 From Dual;

-- INTERSECT : 여러개의 SELECT 한 결과에서 공통 부분만 결과로 추출(교집합)
-- 직원테이블 조회된 결과 아래부분에 두번째 SELECT 문에서 조회한 결과 같이 조회 됨
Select Emp_Id, Emp_Name, Dept_Code, Salary From Employee
INTERSECT
Select 'A','B','C',10 From Dual;

-- 직원테이블에서 조회된 결과와 중복된 값도 같이 조회 됨
Select Emp_Id, Emp_Name, Dept_Code, Salary From Employee
INTERSECT
Select '200','선동일','D9',8000000 From Dual;

-- MINUS : 선행 SELECT 결과에서 다음 SELECT 결과와 겹치는 부분을 제외한 나머지만 추출(차집합)
-- 직원테이블 조회된 결과 아래부분에 두번째 SELECT 문에서 조회한 결과 같이 조회 됨
Select Emp_Id, Emp_Name, Dept_Code, Salary From Employee
MINUS
Select 'A','B','C',10 From Dual;

-- 직원테이블에서 조회된 결과와 중복된 값도 같이 조회 됨
Select Emp_Id, Emp_Name, Dept_Code, Salary From Employee
MINUS
Select '200','선동일','D9',8000000 From Dual;

-- 직원 테이블에서 부서코드가 'D5'인 사원들의 사번, 이름, 부서코드, 급여 조회
SELECT EMP_ID, EMP_NAME, DEPT_CODE, SALARY FROM EMPLOYEE
    WHERE DEPT_CODE = 'D5'
UNION
-- 직원 테이블에서 급여가 3000000 초과인 사원의 사번, 이름, 부서코드, 급여 조회
SELECT EMP_ID, EMP_NAME, DEPT_CODE, SALARY FROM EMPLOYEE
    WHERE SALARY > 3000000;
    
-- 직원 테이블에서 부서코드가 'D5'인 사원들의 사번, 이름, 부서코드, 급여 조회
SELECT EMP_ID, EMP_NAME, DEPT_CODE, SALARY FROM EMPLOYEE
    WHERE DEPT_CODE = 'D5'
UNION ALL
-- 직원 테이블에서 급여가 3000000 초과인 사원의 사번, 이름, 부서코드, 급여 조회
SELECT EMP_ID, EMP_NAME, DEPT_CODE, SALARY FROM EMPLOYEE
    WHERE SALARY > 3000000;
    
-- 직원 테이블에서 부서코드가 'D5'인 사원들의 사번, 이름, 부서코드, 급여 조회
SELECT EMP_ID, EMP_NAME, DEPT_CODE, SALARY FROM EMPLOYEE
    WHERE DEPT_CODE = 'D5'
INTERSECT
-- 직원 테이블에서 급여가 3000000 초과인 사원의 사번, 이름, 부서코드, 급여 조회
SELECT EMP_ID, EMP_NAME, DEPT_CODE, SALARY FROM EMPLOYEE
    WHERE SALARY > 3000000;
    
-- 직원 테이블에서 부서코드가 'D5'인 사원들의 사번, 이름, 부서코드, 급여 조회
SELECT EMP_ID, EMP_NAME, DEPT_CODE, SALARY FROM EMPLOYEE
    WHERE DEPT_CODE = 'D5'
MINUS
-- 직원 테이블에서 급여가 3000000 초과인 사원의 사번, 이름, 부서코드, 급여 조회
SELECT EMP_ID, EMP_NAME, DEPT_CODE, SALARY FROM EMPLOYEE
    WHERE SALARY > 3000000;