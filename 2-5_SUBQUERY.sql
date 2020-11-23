--------------------------------------------------------------------------------
/*
    SUBQUERY
    QUERY문 안에 포함된 또다른 QUERY문
    SUBQUERY 자체만으로 완성이 되어야 함
    반드시 소괄호()로 묶어줘야 함
    메인쿼리가 실행되기 전에 실행되며 한 번만 실행 됨
    
    SUBQUERY 사용 위치
        SELECT, FROM, WHERE, HAVING, GROUP BY, ORDER BY
        INSERT, UPDATE
        CREATE TABLE, CREATE VIEW
*/
--------------------------------------------------------------------------------
--직원 테이블에서 급여가 평균 급여 이상인 직원 사번, 이름, 직급코드, 급여 조회
SELECT AVG(SALARY) FROM EMPLOYEE; --평균 급여 구하기
SELECT EMP_ID, EMP_NAME, JOB_CODE, SALARY FROM EMPLOYEE
    WHERE SALARY >= (SELECT AVG(SALARY) FROM EMPLOYEE);


--------------------------------------------------------------------------------
/*
    SUBQUERY 유형
    1. 단일행 서브쿼리
        서브쿼리의 조회 결과 값의 개수가 1개인 서브쿼리
    2. 다중행 서브쿼리
        서브쿼리의 조회 결과 값의 행이 여러 개인 서브쿼리
    3. 다중열 서브쿼리
        서브쿼리의 조회 결과 컬럼의 개수가 여러 개인 서브쿼리
    4. 다중행 서브쿼리
        서브쿼리의 조회 결과 컬럼의 개수와 행의 개수가 여러 개인 서브쿼리
    5. 상(호연)관 서브쿼리
        서브쿼리가 만든 결과 값을 메인 쿼리가 비교 연산할 때 메인 쿼리
        테이블의 값이 변경되면 서브쿼리 결과 값도 바뀌는 서브쿼리
    6. 스칼라 서브쿼리
        상관쿼리이면서 결과 값이 한 개인 서브쿼리
        
    서브쿼리의 유형에 따라 서브쿼리 앞에 붙는 연산자가 다름
*/
--------------------------------------------------------------------------------
--단일행 서브쿼리
    --연산자 : <, >, <=, >=, =, !=|^=|<>
--노옹철 사원보다 급여를 많이 받는 직원 이름, 직급, 급여 조회
SELECT * FROM EMPLOYEE;
SELECT SALARY FROM EMPLOYEE WHERE EMP_NAME='노옹철';
SELECT EMP_NAME, DEPT_CODE, JOB_CODE, SALARY FROM EMPLOYEE
    WHERE SALARY>(SELECT SALARY FROM EMPLOYEE WHERE EMP_NAME='노옹철');
    
--다중행 서브쿼리
    --다중행 서브쿼리 앞에는 일반 비교연산자 사용 못 함
    --IN : 여러 개의 결과값 중에서 한 개라도 일치하는 값이 있다면 TRUE
    --NOT IN : 여러 개의 결과값 중에서 한 개라도 일치하는 값이 없다면 TRUE
    -- >ANY 혹은 <ANY : 여러 개의 결과값 중에 한 개라도 큰/작은 경우 TRUE (>=, <= 연산자도 사용가능)
        --가장 작은 값보다 큰지? 혹은 가장 큰 값보다 작은지?
    -- >ALL 혹은 <ALL : 모든 값보다 큰/작은 경우 TRUE (>=, <= 연산자도 사용가능)
        --가장 큰 값보다 큰지? 혹은 가장 작은 값보다 작은지?
    --EXISTS / NOT EXISTS : 값이 존재하는지? 존재하지 않는지?
--부서 별 최고 급여를 받는 직원의 이름, 직급, 부서, 급여 조회
SELECT DEPT_CODE,MAX(SALARY) FROM EMPLOYEE GROUP BY DEPT_CODE;
SELECT EMP_NAME, JOB_CODE, DEPT_CODE, SALARY FROM EMPLOYEE 
    WHERE SALARY IN (SELECT MAX(SALARY) FROM EMPLOYEE GROUP BY DEPT_CODE);
--대리 직급의 직원들 중에서 과장 직급의 최소 급여보다 많이 받는 직원의 사번, 이름, 직급, 급여 조회
SELECT EMP_ID, EMP_NAME, JOB_NAME, SALARY FROM EMPLOYEE
    JOIN JOB USING(JOB_CODE) WHERE JOB_NAME='대리';
SELECT SALARY FROM EMPLOYEE JOIN JOB USING(JOB_CODE) WHERE JOB_NAME='과장';
SELECT EMP_ID, EMP_NAME, JOB_NAME, SALARY FROM EMPLOYEE
    JOIN JOB USING(JOB_CODE) WHERE JOB_NAME='대리' 
    AND SALARY > ANY (SELECT SALARY FROM EMPLOYEE JOIN JOB USING(JOB_CODE) WHERE JOB_NAME='과장');
--차장 직급 급여의 가장 큰 값보다 많이 받는 과장 직급의 직원 조회
SELECT EMP_ID, EMP_NAME, JOB_NAME, SALARY FROM EMPLOYEE
    JOIN JOB USING(JOB_CODE) WHERE JOB_NAME='과장';
SELECT SALARY FROM EMPLOYEE JOIN JOB USING (JOB_CODE) WHERE JOB_NAME='차장';
SELECT EMP_ID, EMP_NAME, JOB_NAME, SALARY FROM EMPLOYEE
    JOIN JOB USING(JOB_CODE) WHERE JOB_NAME='과장' AND 
    SALARY > ALL(SELECT SALARY FROM EMPLOYEE JOIN JOB USING (JOB_CODE) WHERE JOB_NAME='차장');

--다중열 서브쿼리
--퇴사한 여직원과 같은 부서, 같은 직급에 해당하는 사원의 이름, 직급, 부서, 입사일 조회
    --퇴사한 여직원의 부서, 직급코드를 조회
SELECT DEPT_CODE, JOB_CODE FROM EMPLOYEE 
    WHERE SUBSTR(EMP_NO,8,1)='2' AND ENT_YN='Y';
    --사원의 이름, 직급, 부서, 입사일 조회
SELECT EMP_NAME, JOB_CODE, DEPT_CODE, HIRE_DATE FROM EMPLOYEE;    
    --단일열/단일행으로 조회
SELECT EMP_NAME, JOB_CODE, DEPT_CODE, HIRE_DATE FROM EMPLOYEE
    WHERE DEPT_CODE = (SELECT DEPT_CODE FROM EMPLOYEE 
        WHERE SUBSTR(EMP_NO,8,1)='2' AND ENT_YN='Y')
    AND JOB_CODE = (SELECT JOB_CODE FROM EMPLOYEE 
        WHERE SUBSTR(EMP_NO,8,1)='2' AND ENT_YN='Y')
    AND EMP_NAME <> (SELECT EMP_NAME FROM EMPLOYEE 
        WHERE SUBSTR(EMP_NO,8,1)='2' AND ENT_YN='Y');
    --다중열로 조회
SELECT EMP_NAME, JOB_CODE, DEPT_CODE, HIRE_DATE FROM EMPLOYEE
    WHERE (DEPT_CODE, JOB_CODE) IN (SELECT DEPT_CODE, JOB_CODE FROM EMPLOYEE 
        WHERE SUBSTR(EMP_NO,8,1)='2' AND ENT_YN='Y')
     AND EMP_NAME <> (SELECT EMP_NAME FROM EMPLOYEE 
        WHERE SUBSTR(EMP_NO,8,1)='2' AND ENT_YN='Y');

--다중열/다중행 서브쿼리
--직급별 최소 급여를 받는 직원의 사번, 이름, 직급, 급여 조회
SELECT JOB_CODE, MIN(SALARY) FROM EMPLOYEE GROUP BY JOB_CODE;
SELECT EMP_ID, EMP_NAME, JOB_CODE, SALARY FROM EMPLOYEE
    WHERE (JOB_CODE, SALARY) IN (SELECT JOB_CODE, MIN(SALARY) FROM EMPLOYEE GROUP BY JOB_CODE);
    
--인라인 뷰(INLINE VIEW) : 서브쿼리가 만든 결과 집합(RESULT SET)에 대한 추가 조회
    --FROM 절에서 서브쿼리를 사용 : 테이블 대신 사용
    --ROWNUM : 행 번호를 의미함
    --ROWNUM 자체가 FROM 절에서 붙여짐
    --ORDER BY 한 다음에 ROWRUM이 붙으려면 서브쿼리(인라인뷰)를 이용해야 함
SELECT * FROM EMPLOYEE ORDER BY SALARY DESC;
--ROWNUM을 이용해서 행 번호 조회
SELECT ROWNUM, EMP_NAME, EMP_NO FROM EMPLOYEE;
--행 번호를 이용해 순서대로 데이터 잘라오기
SELECT ROWNUM, EMP_NAME, EMP_NO FROM EMPLOYEE WHERE ROWNUM <= 5;
--주민번호 순으로 정렬
SELECT ROWNUM, EMP_NAME, EMP_NO FROM EMPLOYEE ORDER BY EMP_NO;
--주민번호 순으로 정렬해서 주민번호가 빠른 순서대로 5개 자르고 싶지만 안 됨
SELECT ROWNUM, EMP_NAME, EMP_NO FROM EMPLOYEE WHERE ROWNUM <= 5 ORDER BY EMP_NO;
--서브쿼리로 정렬된 데이터 넘겨줌
SELECT ROWNUM, EMP_NAME, EMP_NO FROM (SELECT * FROM EMPLOYEE ORDER BY EMP_NO);
--정렬된 데이터를 주민번호가 빠른 순서대로 5개 자르기
SELECT ROWNUM, EMP_NAME, EMP_NO FROM (SELECT * FROM EMPLOYEE ORDER BY EMP_NO)
    WHERE ROWNUM<=5;