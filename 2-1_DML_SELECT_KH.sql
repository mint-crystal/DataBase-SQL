/*
    SELECT
    데이터를 조회하기 위한 SQL문
    조회한 결과를 테이블 형태로 반환해줌 - RESULT SET
    표현법 : SELECT 컬럼명 [, 컬럼명, ...] FROM <테이블명> [WHERE 조건식];
        -컬럼 명은 원하는 컬럼을 원하는 순서대로 (,)로 구분해서 나열
*/
--테이블 목록 조회
SELECT * FROM TABS;

--테이블 구조 : 컬럼 정보 확인
DESC EMPLOYEE;

--직원 테이블(EMPLOYEE)에서 아이디(EMP_ID), 이름(EMP_NAME), 전화번호(PHONE)를 조회
SELECT EMP_ID, EMP_NAME, PHONE FROM EMPLOYEE;

--직원 테이블(EMPLOYEE)에서 모든 정보를 조회
    -- * : 모든 컬럼
SELECT * FROM EMPLOYEE;

--직원 테이블(EMPLOYEE)에서 이름, 전화번호, 이메일 순서대로 조회
SELECT EMP_NAME, PHONE, EMAIL FROM EMPLOYEE;

--직원 테이블(EMPLOYEE)에서 이름이 '유재식'인 레코드(행)를 조회
SELECT * FROM EMPLOYEE WHERE EMP_NAME='유재식';

--직원 테이블(EMPLOYEE)에서 직급코드(JOB_CODE)가 'J3'인 레코드를 조회
SELECT * FROM EMPLOYEE WHERE JOB_CODE='J3';

--컬럼 값 산술 연산 : 컬럼 값에 대해 산술 연산한 결과 값 조회 가능
SELECT EMP_NAME, SALARY FROM EMPLOYEE;  --이름과 급여 조회
SELECT EMP_NAME, SALARY*5 FROM EMPLOYEE;    --급여 컬럼에 연산 후 결과 값 조회
SELECT EMP_NAME, SALARY, SALARY*BONUS, SALARY+(SALARY*BONUS) FROM EMPLOYEE;

--컬럼 별칭 : 조회된 컬럼명에 별칭 지정해 줄 수 있음
    --표현법1 : 컬럼명 AS 별칭
    --표현법2 : 컬럼명 별칭
    SELECT EMP_NAME AS 이름, SALARY 급여, SALARY*BONUS 보너스,  --AS 생략 가능(공백으로 구분)
    SALARY+(SALARY*BONUS) AS "총 급여(원)" FROM EMPLOYEE;
    --숫자, 특수문자, 띄어쓰기가 포함되는 경우 " " 사용
    
--리터럴 : 임의로 지정한 문자열을 SELECT 절에서 사용하면 테이블에 존재하는 데이터처럼 활용 가능
    -- 문자나 날짜 리터럴은 ' ' 사용
    -- 리터럴은 RESULT SET의 모든 행에 반복 표시 됨
SELECT EMP_NAME, SALARY, '원' AS 단위 FROM EMPLOYEE;
SELECT EMP_NAME, SALARY+10 FROM EMPLOYEE;   --10도 리터럴

--중복제거 : DISTINCT
    --컬럼에 포함된 데이터 중 중복 값을 제외하고 한 번씩만 조회하고자 할 때 사용
    --하나의 SELECT 절에서 1개만 사용 가능
SELECT JOB_CODE FROM EMPLOYEE;  --중복 값 모두 조회
SELECT DISTINCT JOB_CODE FROM EMPLOYEE; --중복 값 제외 조회
SELECT DISTINCT JOB_CODE, DISTINCT DEPT_CODE FROM EMPLOYEE; --오류 발생
SELECT DISTINCT JOB_CODE, DEPT_CODE FROM EMPLOYEE;  --여러 컬럼을 묶어서 중복 값 제외
    --JOB_CODE와 DEPT_CODE가 모두 동일한 값을 중복으로 처리

--------------------------------------------------------------------------------

/*
    WHERE 절 : 검색할 컬럼의 조건을 설정하여 행 결정
    테이블에서 조건을 만족하는 값을 가진 행을 골라냄
    여러 개의 조건을 만족하는 행을 골라낼 때는 AND 혹은 OR을 사용할 수 있음
*/

--부서코드가 'D9'인 직원의 이름, 부서코드 조회
SELECT EMP_NAME, DEPT_CODE FROM EMPLOYEE WHERE DEPT_CODE='D9';

--급여가 4000000보다 많은 직원 이름과 급여 조회
SELECT EMP_NAME, SALARY FROM EMPLOYEE WHERE SALARY>=4000000;

--------------------------------------------------------------------------------

/*
    논리 연산자
    여러 개의 제한 조건 결과를 하나의 논리 결과로 만들어 줌
    조건을 여러 개 지정해서 조회하고 싶은 경우 사용
        AND, OR
    조건과 반대의 결과를 조회하고 싶은 경우
        NOT
*/
-- 부서코드가 'D6'이고, 급여를 2000000 보다 많이 받는 직원의 이름, 부서코드, 급여 조회
SELECT EMP_NAME, DEPT_CODE, SALARY FROM EMPLOYEE
    WHERE DEPT_CODE = 'D6' AND SALARY >= 2000000;
---- 부서코드가 'D6'이거나, 급여를 2000000 보다 많이 받는 직원의 이름, 부서코드, 급여 조회
SELECT EMP_NAME, DEPT_CODE, SALARY FROM EMPLOYEE
    WHERE DEPT_CODE = 'D6' OR SALARY >= 2000000;
---- 부서코드가 'D6'이 아니고, 급여를 2000000 미만 받는 직원의 이름, 부서코드, 급여 조회
SELECT EMP_NAME, DEPT_CODE, SALARY FROM EMPLOYEE
    WHERE DEPT_CODE != 'D6' AND SALARY < 2000000;
    --또는
SELECT EMP_NAME, DEPT_CODE, SALARY FROM EMPLOYEE
    WHERE NOT DEPT_CODE = 'D6' AND NOT SALARY >= 2000000;
    --DEPT_CODE가 D6이 아니고, SALARY가 2000000 이상이 아닌 데이터
SELECT EMP_NAME, DEPT_CODE, SALARY FROM EMPLOYEE
    WHERE NOT (DEPT_CODE = 'D6' AND NOT SALARY >= 2000000);
    --DEPT_CODE가 D6이거나 SALARY가 2000000 이상이 아닌 데이터
SELECT EMP_NAME, DEPT_CODE, SALARY FROM EMPLOYEE
    WHERE NOT (DEPT_CODE = 'D6' OR SALARY >= 2000000);
    --DEPT_CODE가 D6이고 SALARY가 2000000 이상이 아닌 데이터
    
--------------------------------------------------------------------------------

/*
    연결 연산자
    여러 컬럼을 하나의 컬럼인 것처럼 연결하거나 컬럼과 리터럴을 연결함
    ORACLE : ||
    MYSQL : +
    MSSQL : (공백)
*/

--컬럼과 컬럼을 연결한 경우
SELECT EMP_NAME, EMP_ID || DEPT_CODE || JOB_CODE FROM EMPLOYEE;
SELECT EMP_NAME, EMP_ID || DEPT_CODE || JOB_CODE AS 사원식별번호 FROM EMPLOYEE;

--컬럼과 리터럴을 연결한 경우
SELECT EMP_NAME || '님의 월급은 ' || SALARY || '원 입니다' FROM EMPLOYEE;

--------------------------------------------------------------------------------

/*
    비교 연산자
    표현식 사이의 관계를 비교하기 위해 사용
    비교 결과는 논리 결(TRUE/FALSE/NULL) 중 하나가 됨
    단, 비교하는 두 값은 동일한 데이터 타입이어야 함
    주요 비교 연산자 : = , > , < , >= , <= , <> ,!= , ^= .
                    BETWEEN AND, LIKE, NOT LIKE, IS NOT NULL, IN, NOT IN 
*/

--'같지 않다' 비교 방법 3가지
SELECT EMP_ID, EMP_NAME, DEPT_CODE FROM EMPLOYEE WHERE DEPT_CODE != 'D9';
SELECT EMP_ID, EMP_NAME, DEPT_CODE FROM EMPLOYEE WHERE DEPT_CODE ^= 'D9';
SELECT EMP_ID, EMP_NAME, DEPT_CODE FROM EMPLOYEE WHERE DEPT_CODE <> 'D9';

--BETWEEN AND : 비교하려는 값이 지정한 범위에 포함되면 TRUE를 리턴
        --연산자 상한값과 하한값의 경계도 포함됨( >= , <= )
    --급여를 350만보다 많이 받고 600만보다 적게 받는 직원의 이름과 급여 조회
SELECT EMP_NAME, SALARY FROM EMPLOYEE WHERE SALARY>=3500000 AND SALARY<=6000000;
    --또는
SELECT EMP_NAME, SALARY FROM EMPLOYEE WHERE SALSRY BETWEEN 3500000 AND 6000000;
    --급여를 350만 미만, 또는 600만을 초과하는 직원의 이름과 급여 조회
SELECT EMP_NAME, SALARY FROM EMPLOYEE WHERE SALARY<3500000 OR SALARY>6000000;
    --또는
    SELECT EMP_NAME, SALARY FROM EMPLOYEE WHERE SALARY NOT BETWEEN 3500000 AND 6000000;
    --NOT 연산자는 컬럼명 앞에 붙여도 되고 BETWEEN 앞에 붙여도 됨;

--LIKE : 비교하려는 값이 지정한 특정 패턴을 만족하면 TRUE 리턴
    --표현식 :  컬럼명 LIKE '문자패턴'
SELECT EMP_NAME, SALARY FROM EMPLOYEE WHERE EMP_NAME LIKE '송은희'; --이름이 '송은희'인 직원 조회
SELECT EMP_NAME, SALARY FROM EMPLOYEE WHERE EMP_NAME LIKE '송'; --이름이 '송'으로 시작하는 직원 조회
        --'송'과 정확하게 일치하는 데이터만 찾기 때문에 아무것도 조회 안됨
    --와일드카드문자 사용
        --  % : 글자 수 상관없이 모든 문자를 의미
        --  _ : 한 자리의 모든 문자를 의미
SELECT EMP_NAME, SALARY FROM EMPLOYEE WHERE EMP_NAME LIKE '송%'; --이름이 '송'으로 시작하는 직원 조회
SELECT EMP_NAME, SALARY FROM EMPLOYEE WHERE EMP_NAME LIKE '송__'; --이름이 '송'으로 시작하는 직원 조회
                                                        --  _ 2개
--주민등록번호 8번째 자리가 1인 직원 조회(남직원만 조회)
SELECT EMP_NAME, EMP_NO FROM EMPLOYEE WHERE EMP_NO LIKE '_______1%'; 

/*
    와일드카드 문자와 찾고자하는 패턴의 문자가 동일한 경우,
    어떤 것을 패턴으로 결정하는지 구분이 안 됨(%, _문자를 찾고 싶을 때)
    데이터로 처리할 와일드 카드 문자 앞에 임의의 특수문자를 사용하고 ESCAPE OPTION으로 등록해서 처리
*/
--EMAIL의 4번째 자리에 _ 문자가 오는 직원 이름, 이메일 조회
     --4번째 _를 문자가 아닌 와일드카드로 인식하여 모든 데이터 조회
SELECT EMP_NAME, EMAIL FROM EMPLOYEE WHERE EMAIL LIKE '____%'; 
    --# 뒤에 오는 와일드카드는 문자 그대로 인식해서 조회(@나 $같은 다른 특수문자도 가능)
SELECT EMP_NAME, EMAIL FROM EMPLOYEE WHERE EMAIL LIKE '___#_%' ESCAPE '#';

--NOT LIKE
    --'이'씨 성이 아닌 직원 이름, 이메일 조회
SELECT EMP_NAME, EMAIL FROM EMPLOYEE WHERE EMP_NAME NOT LIKE '이%';

--IS NULL, IS NOT NULL : NULL 여부를 비교하는 연산자
    --NULL 값 조회 : 보너스가 없는 직원
SELECT EMP_ID, EMP_NAME, SALARY, BONUS FROM EMPLOYEE WHERE BONUS IS NULL;
    --NULL이 아닌 값 조회 : 보너스가 있는 직원
SELECT EMP_ID, EMP_NAME, SALARY, BONUS FROM EMPLOYEE WHERE BONUS IS NOT NULL;
    --관리자도 없고, 부서배치도 받지 않은 직원 조회
SELECT EMP_NAME, SALARY, BONUS, MANAGER_ID, DEPT_CODE FROM EMPLOYEE 
    WHERE MANAGER_ID IS NULL AND DEPT_CODE IS NULL;
    --부서 배치를 받지 않았지만 보서스를 지급받는 직원 조회
SELECT EMP_NAME, SALARY, BONUS, DEPT_CODE FROM EMPLOYEE 
    WHERE DEPT_CODE IS NULL AND BONUS IS NOT NULL;
    
-- IN : 비교하려는 값 목록에 일치하는 값이 있으면 TRUE를 반환
    --D6 부서와 D8 부서원들의 이름, 부서코드, 급여 조회
SELECT EMP_NAME, DEPT_CODE, SALARY FROM EMPLOYEE WHERE DEPT_CODE = 'D6' OR DEPT_CODE = 'D8';
    --또는
SELECT EMP_NAME, DEPT_CODE, SALARY FROM EMPLOYEE WHERE DEPT_CODE IN ('D6', 'D8');
--NOT IN : 목록에 포함되지 않는 데이터 조회
     --D6 부서와 D8 부서원들을 제외한 부서원들의 이름, 부서코드, 급여 조회
SELECT EMP_NAME, DEPT_CODE, SALARY FROM EMPLOYEE WHERE DEPT_CODE NOT IN ('D6', 'D8');

/*
    연산자 우선 순위
    조건에 여러 개의 연산자가 올 경우 먼저 연상될 기준  
    1. 산술 연산자
    2. 연결 연산자
    3. 비교 연산자
    4. IS NULL / IS NOT NULL , LIKE , IN / NOT IN
    5. BETWEEN AND / NOT BETWEEN AND
    6. 논리 연산자 ? NOT
    7. 논리 연산자 ? AND
    8. 논리연산자 ? OR
*/

--------------------------------------------------------------------------------

--'J2' 또는 'J7' 직급 코드 중 급여를 200만 보다 많이 받는 직원 이름, 급여, 직급코드 조회
    --연산자 우선순위에 의해 AND 먼저 연산되어 200만 이하 직원도 조회
SELECT EMP_NAME, SALARY, JOB_CODE FROM EMPLOYEE 
    WHERE JOB_CODE = 'J4' OR JOB_CODE = 'J7' AND SALARY>=2000000; 
    --OR 연산자 먼저 처리될 수 있도록 ( )사용
SELECT EMP_NAME, SALARY, JOB_CODE FROM EMPLOYEE 
    WHERE (JOB_CODE = 'J4' OR JOB_CODE = 'J7') AND SALARY>=2000000; 
    --IN 연산자를 사용해 조회
SELECT EMP_NAME, SALARY, JOB_CODE FROM EMPLOYEE 
    WHERE JOB_CODE IN ('J4', 'J7') AND SALARY>=2000000;