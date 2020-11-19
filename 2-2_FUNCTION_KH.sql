/*
    함수(FUNCITION)
    특정 기능을 가진 도구
    컬럼의 값을 읽어서 기능을 수행하고 결과 값을 리턴해줌
    - 단일행(SINGLE ROW)함수 : 컬럼에 기록된 N개의 값을 읽어서 N개의 결과를 리턴
    - 그룹(GROUP)함수 : 컬럼에 기록된 N개의 값을 읽어서 M개의 결과를 리턴
    
    SQL문에서 함수를 사용할 수 있는 위치 : 
        SELECT 절, WHERE 절, GROUP BY 절, HAVING 절, ORDER BY 절
        - SELECT 절에 단일행 함수와 그룹 함수를 함께 사용하지 못함 : 결과 행의 갯수가 다르기 때문에
    
    사용법 : 함수명(입력 값)
*/

/*   DUAL TABLE
    오라클 기본 테이블
    모든 사용자가 사용 가능한 임시 테이블
    SYS 소유의 테이블이기 떄문에 테이블 리스트에는 포함되지 않음
    
    용도
        SELECT만으로 데이터를 조회하고 싶을때
        내장함수 출력하고 싶을 때
        계산식 출력해보고 싶을 때
        임시 데이터를 만들 때
*/
SELECT * FROM DUAL;

-------------------------------------------------------------------------------
--단일행 함수
    --문자열 처리 함수
    --숫자 처리 함수
    --날짜 함수
    --형 변환 함수
    --NULL처리 함수
-------------------------------------------------------------------------------

-------------------------------------------------------------------------------
--문자 처리 함수
    --LENGTH, LENGTHB, SUBSTR, UPPER, LOWER, INSRT ...
-------------------------------------------------------------------------------
--LENGTH(컬럼명 | '문자열 값') : 글자의 갯수를 리턴
SELECT LENGTH('HELLO') FROM DUAL;   --'HELLO' 문자열의 길이 : 5
SELECT LENGTH('원격수업은....') FROM DUAL;
SELECT * FROM EMPLOYEE;
SELECT EMP_NAME, LENGTH(EMAIL) FROM EMPLOYEE; --직원테이블의 이메일 길이

--LENGTHB(컬럼명 | '문자열 값') : 글자의 바이트 수를 리턴
SELECT LENGTHB('HELLO') FROM DUAL;  --'HELLO' 문자열의 길이 : 5
SELECT LENGTHB('원격수업은....') FROM DUAL; --'원격수업은....' 문자열의 길이 : 19
                                         --한글은 3BYTE로 '.'은 1BYTE로 처리

--INSTR : 지정한 위치부터 지정한 숫자 번째로 나타나는 문자의 시작 위치 반환
    --특정 문자열에서 원하는 문자를 찾아서 위치를 반환
    --시작 위치 번호는 1부터 시작(자바는 0부터)
    --INSTR('문자열'|컬럼명, '찾을 문자' [, 찾을 위치의 시작값] [, 빈도])
    --찾을 위치의 시작 값(기본값 1) : 양수 - 앞에서부터 검색, 음수 - 뒤에서부터 검색
    --빈도(기본값 1) : 찾을 문자가 여러 개인 경우 몇 번째 문자를 찾을 것인지 지정
--'ABCDEFGHI' 문자열에서 'F'의 위치 찾기 : 6
SELECT INSTR('ABCDEFGHI', 'F') FROM DUAL;  
--찾을 문자가 1개만 있을 때는 시작 값에 상관없이 동일한 위치값 : 6
SELECT INSTR('ABCDEFGHI', 'F', 1) FROM DUAL; 
--찾을 문자가 1개만 있을 때는 시작 값에 상관없이 동일한 위치값 : 6
SELECT INSTR('ABCDEFGHI', 'F', -1) FROM DUAL;
--가장 앞에 있는 'F'의 위치 값 : 3
SELECT INSTR('ABFCDEFGHI', 'F', 1) FROM DUAL;
--맨 뒤에 있는 'F'의 위치 값 : 7
SELECT INSTR('ABFCDEFGHI', 'F', -1) FROM DUAL; 
--앞에서부터 첫 번째 위치한 'F'의 위치 값 : 3
SELECT INSTR('ABFCDEFGHI', 'F', 1,1) FROM DUAL;
--앞에서부터 두 번째 위치한 'F'의 위치 값 : 7
SELECT INSTR('ABFCDEFGHI', 'F', 1,2) FROM DUAL;
--EX)
SELECT INSTR('ABABBBAABBA', 'A') FROM DUAL; --1
SELECT INSTR('ABABBBAABBA', 'A', 1) FROM DUAL; --1
SELECT INSTR('ABABBBAABBA', 'A', -1) FROM DUAL; --11
SELECT INSTR('ABABBBAABBA', 'A', 1, 1) FROM DUAL; --1
SELECT INSTR('ABABBBAABBA', 'A', 1, 2) FROM DUAL; --3
SELECT INSTR('ABABBBAABBA', 'A', 1, 3) FROM DUAL; --7
SELECT INSTR('ABABBBAABBA', 'A', 1, 4) FROM DUAL; --8
SELECT INSTR('ABABBBAABBA', 'A', 1, 5) FROM DUAL; --11
--직원 테이블의 EMAIL에서 '@'의 위치 반환
SELECT EMAIL, INSTR(EMAIL,'@') FROM EMPLOYEE; --이메일의 '@' 위치
SELECT EMAIL, INSTR(EMAIL,'@')-1 AS 아이디길이 FROM EMPLOYEE;

--LPAD/RPAD : 주어진 컬럼 문자열에 임의의 문자열을 덧붙여 길이 N의 문자열을 반환하는 함수
    --LPAD('문자열' | 컬럼 명, 반환할 총 문자열 길이 [, 덧붙여줄 문자])
    --padding
SELECT LPAD(EMAIL, 20, '#') FROM EMPLOYEE;
SELECT LPAD(EMAIL, 20) FROM EMPLOYEE;
SELECT RPAD(EMAIL, 20, '#') FROM EMPLOYEE;
SELECT RPAD(EMAIL, 20) FROM EMPLOYEE;

--LTRIM / RTRIM : 주어진 컬럼이나 문자열 왼쪽/오른쪽에서 지정한 문자 혹은 문자열을 제거한 나머지를 반환
    --LTRIM('문자열' | 컬럼 명 [, 제거할 문자])
    --제거할 문자를 생략하면 공백 제거
SELECT LTRIM('     KH     ') FROM DUAL;
SELECT TRIM(LEADING FROM '     KH     ') FROM DUAL; --LTRIM과 동일
SELECT RTRIM('     KH     ') FROM DUAL;
SELECT TRIM(TRAILING FROM '     KH     ') FROM DUAL; --RTRIM과 동일
SELECT LTRIM('KHKH1234KHKH', 'KH') FROM DUAL;
SELECT RTRIM('KHKH1234KHKH', 'KH') FROM DUAL;
--양쪽 문자 모두 제거
SELECT TRIM(BOTH FROM '     KH     ') FROM DUAL;
SELECT RTRIM(LTRIM('     KH     ')) FROM DUAL;
--TRIM은 단일문자만 처리할 수 있음. 문자열 삭제는 LTRIM, RTRIM 사용해야함
SELECT TRIM(BOTH 'K' FROM 'KHKH1234KHKH') FROM DUAL;
SELECT TRIM(BOTH 'K' FROM 'KKK1234KKK') FROM DUAL;

--SUBSTR : 컬럼이나 문자열에서 지정한 위치로부터 지정한 개수의 문자열을 잘라서 리턴
    --SUBSTR(문자열, 시작 위치, 개수)
SELECT SUBSTR('SHOWMETHEMONEY', 5, 2) FROM DUAL; --ME : 5번째부터 2글자
SELECT SUBSTR('SHOWMETHEMONEY', 7) FROM DUAL; --THEMONEY : 7번째부터 끝까지
SELECT SUBSTR('SHOWMETHEMONEY', -8, 3) FROM DUAL; --THE : 끝에서 8번째부터 3글자
--직원테이블에서 이름과 주민번호 8번째자리만 출력
SELECT EMP_NAME, SUBSTR(EMP_NO, 8, 1) FROM EMPLOYEE;

--LOWER / UPPER / INITCAP : 대소문자 변경
SELECT LOWER('Welcome To My World') FROM DUAL; --모두 소문자로 변환
SELECT UPPER('Welcome To My World') FROM DUAL; --모두 대소문자로 변환
SELECT INITCAP('welcome to my world') FROM DUAL; --단어의 첫 글자를 대문자로 변환
        --공백 또는 특수문자를 기준으로 대문자 변환

--CONCAT : 문자열 혹은 컬럼을 입력받아 하나로 합친 후 리턴
SELECT CONCAT('가나다라', 'ABCD') FROM DUAL;
SELECT '가나다라'||'ABCD' FROM DUAL;

--REPLACE 
SELECT REPLACE('WELCOME TO ORACLE', 'ORACLE', 'MYSQL') FROM DUAL;
SELECT EMP_NAME, EMAIL, REPLACE(EMAIL, 'kh', 'iei') AS "변경된 메일" FROM EMPLOYEE;

--직원테이블에서 주민번호를 조회해서 생년, 생월, 생일을 각각 분리하여 조회
SELECT EMP_NAME 사원명, SUBSTR(EMP_NO,1,2) 생년, SUBSTR(EMP_NO,3,2)생월, 
    SUBSTR(EMP_NO,5,2) 생일 FROM EMPLOYEE;

--여직원들의 모든 컬럼 정보 조회
SELECT * FROM EMPLOYEE WHERE SUBSTR(EMP_NO, 8,1)=2;

--함수 중첩 사용 : 함수 안에서 또다른 함수를 사용할 수 있음
--직원 테이블에서 사원 명, 주민번호 조회
    --단, 주민번호는 생년월일만 보이게 하고, '-'다음 값은 '*'로 변경
SELECT EMP_NAME 사원명, RPAD(SUBSTR(EMP_NO, 1, 7),14,'*')주민번호 FROM EMPLOYEE;


-------------------------------------------------------------------------------
--숫자처리 함수
    --ABS, MOD, ROUND, FLOOR, TRUNC, CELL
-------------------------------------------------------------------------------
--ABS :  절대 값을 구하여 리턴하는 함수
    --ABS(숫자 | 숫자로 된 컬럼명)
SELECT ABS(-10) FROM DUAL; --10
SELECT ABS(10) FROM DUAL;  --10

--MOD : 나머지를 구하는 함수(%)
    --MOR(나누어지는 수, 나눌 수)
SELECT MOD(10,5) FROM DUAL; --0
SELECT MOD(10,3) FROM DUAL; --1

--ROUND : 반올림하여 리턴하는 함수
    --ROUND(숫자 [, 위치])
SELECT ROUND(123.456) FROM DUAL; --123
SELECT ROUND(123.656) FROM DUAL; --124
SELECT ROUND(123.456, 1) FROM DUAL; --123.5
SELECT ROUND(123.456, 2) FROM DUAL; --123.46
SELECT ROUND(123.456, -2) FROM DUAL; --100
SELECT ROUND(568.456, -1) FROM DUAL; --570

--FLOOR : 소수점을 기준으로 내림하여 리턴하는 함수
    --FLOOR(숫자)
SELECT FLOOR(123.456) FROM DUAL; --123
SELECT FLOOR(123.656) FROM DUAL; --123

--TRUNC : 내림하여 리턴하는 함수
    --TRUNC(숫자, [, 위치])
SELECT TRUNC(123.456) FROM DUAL; --123
SELECT TRUNC(123.656) FROM DUAL; --123
SELECT TRUNC(123.456, 1) FROM DUAL; --123.4
SELECT TRUNC(123.456, 2) FROM DUAL; --123.45
SELECT TRUNC(123.456, -2) FROM DUAL; --100
SELECT TRUNC(568.456, -1) FROM DUAL; --560

--CEIL : 올림하여 리턴하는 함수
    --CEIL(숫자)
SELECT CEIL(123.456) FROM DUAL; --124
SELECT CEIL(123.656) FROM DUAL; --124


-------------------------------------------------------------------------------
--날짜 처리 함수
    --SYSDATE, MONTHS_BETWEEN, ADD_MONTH, NEXT_DAY, LAST_DAY, EXTRACT
-------------------------------------------------------------------------------
--SYSDATE : 시스템에 저장되어 있는 날짜를 반환하는 함수
SELECT SYSDATE FROM DUAL;

--MONTHS_BETWEEN(날짜, 날짜) : 개월 수의 차이를 숫자로 반환하는 함수
SELECT EMP_NAME, HIRE_DATE, 
    CEIL(MONTHS_BETWEEN(SYSDATE, HIRE_DATE))"개월 수" FROM EMPLOYEE;
    
--ADD_MONTHS(날짜, 숫자) : 날짜에 숫자만큼 개월 수를 더하여 날짜를 반환하는 함수
SELECT ADD_MONTHS(SYSDATE, 5) FROM DUAL;

    --직원테이블에서 사원의 이름, 입사일, 입사 후 6개월이 된 날짜를 조회
    SELECT EMP_NAME, HIRE_DATE, ADD_MONTHS(HIRE_DATE, 6) 입사6개월 FROM EMPLOYEE;

--NEXT_DAY : 기준 날짜에서 구하려는 요일의 가장 가까운 날짜를 반환하는 함수
    --NEXT_DAY(기준 날짜, 요일)
        --요일 : 문자, 숫자
SELECT SYSDATE, NEXT_DAY(SYSDATE,'목요일') FROM DUAL;
SELECT SYSDATE, NEXT_DAY(SYSDATE, 5) FROM DUAL;  --일요일부터 1로 처리
SELECT SYSDATE, NEXT_DAY(SYSDATE,'목') FROM DUAL;
    --문자셋 변경
    ALTER SESSION SET NLS_LANGUAGE = AMERICAN;
SELECT SYSDATE, NEXT_DAY(SYSDATE,'FRIDAY') FROM DUAL;
    ALTER SESSION SET NLS_LANGUAGE = KOREAN;
SELECT SYSDATE, NEXT_DAY(SYSDATE,'금요일') FROM DUAL;

--LAST_DAY(날짜) : 해당 월의 마지막 날짜를 구하여 반환해주는 함수
    --이번 달 마지막 날 구하기
SELECT SYSDATE, LAST_DAY(SYSDATE) FROM DUAL;
    --다음 달 마지막 날 구하기
SELECT SYSDATE, LAST_DAY(ADD_MONTHS(SYSDATE,1)) FROM DUAL;

--직원테이블에서 근무연수가 10년 이상인 직원 조회
SELECT * FROM EMPLOYEE WHERE MONTHS_BETWEEN(SYSDATE, HIRE_DATE)>=120;
SELECT MONTHS_BETWEEN(SYSDATE, HIRE_DATE), ABS(MONTHS_BETWEEN(HIRE_DATE, SYSDATE)) FROM EMPLOYEE;

--직원테이블에서 사원명, 입사일, 입사한 월의 근무일수를 조회
SELECT EMP_NAME, HIRE_DATE, LAST_DAY(HIRE_DATE)-HIRE_DATE "입사월 근무일수" FROM EMPLOYEE;

--EXTRACT : 년, 월, 일 정보를 추출하여 반환하는 함수
    --EXTRACT(YEAR FROM 날짜) : 년도를 반환
    --EXTRACT(MONTH FROM 날짜) : 월을 반환
    --EXTRACT(DAY FROM 날짜) : 일을 반환
SELECT EXTRACT (YEAR FROM SYSDATE) 년도, EXTRACT (MONTH FROM SYSDATE) 월, 
    EXTRACT (DAY FROM SYSDATE) 일 FROM DUAL;


-------------------------------------------------------------------------------
--형변환 함수
    --TO_CHAR, TO_DATE, TO_NUMBER
-------------------------------------------------------------------------------
--TO_CHAR(날짜 [, 포맷]) : 날짜형 데이터를 문자형 데이터로 변환
SELECT SYSDATE FROM DUAL;   --변환x 날짜형
SELECT TO_CHAR(SYSDATE) FROM DUAL;
SELECT TO_CHAR(SYSDATE, 'YYYY-MM-DD') FROM DUAL; -- 2020-11-19
SELECT TO_CHAR(SYSDATE, 'YY-MM-DD') FROM DUAL; -- 20-11-19
SELECT TO_CHAR(SYSDATE, 'PM HH:MI:SS') FROM DUAL; -- 오후 03:28:10
SELECT TO_CHAR(SYSDATE, 'PM HH24:MI:SS') FROM DUAL; -- 오후 15:28:05
SELECT TO_CHAR(SYSDATE, 'AM HH:MI:SS') FROM DUAL; -- 2020-11-19 03:27:41
SELECT TO_CHAR(SYSDATE, 'YYYY-MM-DD HH:MI:SS') FROM DUAL; -- 2020-11-19 03:27:41
    --년도에 대한 포맷 문자는 'Y', 'R' 
        --'RRRR' 두자리 년도를 네자리로 바꿀때 50년 미만이면 2000년을 적용, 50년 미만이면 1900년 적용
        --90/12/30 -> 90+1900=1900
        --20/11/30 -> 20+2000=2020
        SELECT EMP_NAME, HIRE_DATE, TO_CHAR(HIRE_DATE, 'YYYY'), TO_CHAR(HIRE_DATE, 'RRRR') FROM EMPLOYEE;
--TO_CHAR(숫자 [, 포맷]) : 숫자형 데이터를 문자형 데이터로 변환
SELECT TO_CHAR(1234) FROM DUAL; --1234
    --앞에 0을 채우려면 0, 자릿수를 만들려면 9
SELECT TO_CHAR(1234, '99999999') FROM DUAL; --     1234
SELECT TO_CHAR(1234, '00000000') FROM DUAL; --00001234
SELECT TO_CHAR(1234, 'L99999999') FROM DUAL; --            ￦1234
SELECT TO_CHAR(1234, '$99999999') FROM DUAL; --     $1234
SELECT TO_CHAR(1234, '99,999,999') FROM DUAL; --      1,234
SELECT TO_CHAR(1234, '00,000,000') FROM DUAL; --00,001,234
SELECT TO_CHAR(1234, '9.9EEEE') FROM DUAL; --  1.2E+03 지수형태
SELECT TO_CHAR(1234, '9999') FROM DUAL; --1234
SELECT TO_CHAR(12345, '9999') FROM DUAL; --#####

--TO_DATE(문자 [, 포맷]) : 문자형 데이터를 날짜로 변환하여 반환
SELECT TO_DATE('20201119') FROM DUAL;   --20/11/19
SELECT TO_CHAR(TO_DATE('20150512'),'YYYY-MM-DD') FROM DUAL;   --2015-05-12
SELECT TO_CHAR(TO_DATE('14/5/20'),'YYYY-MM-DD') FROM DUAL;    --2014-05-20
SELECT TO_CHAR(TO_DATE('80/3/2'), 'YYYY-MM-DD') FROM DUAL;     --1980-03-02
SELECT TO_CHAR(TO_DATE('20140520'), 'YYYY') FROM DUAL; --2014

--TO_DATE(숫자 [, 포맷]) : 숫자형 데이터를 날짜로 변환하여 반환
SELECT TO_DATE(20150512) FROM DUAL;
SELECT TO_CHAR(TO_DATE(20150512), 'YYYY"년" MM"월" DD"일"') FROM DUAL;

--TO_NUMBER(문자 [, 포맷]) : 문자데이터를 숫자로 변환하여 반환
SELECT '10'+'20' FROM DUAL; --자동형변환
SELECT TO_NUMBER('1234') FROM DUAL; --강제형변환(숫자형태의 값들만)


-------------------------------------------------------------------------------
--NULL 처리 함수
    --NVL
-------------------------------------------------------------------------------
--NVL(NULL인지 검사할 값, NULL일때 바꿀 값)
    --직원테이블에서 보너스가 NULL일때 0으로 변경하여 총 급여를 계산
SELECT EMP_NAME, SALARY, NVL(BONUS,0), SALARY*NVL(BONUS,0) AS 보너스금액, 
    SALARY+(SALARY*NVL(BONUS,0)) AS "총 급여" FROM EMPLOYEE;
    --직원 테이블에서 DEPT_CODE가 NULL일때 부서없음으로 변경
SELECT EMP_NAME, NVL(DEPT_CODE,'부서 없음') FROM EMPLOYEE;

--NVL2(NULL인지 검사할 값, NULL아닐때 바꿀 값1, NULL일때 바꿀 값)
SELECT EMP_NAME, NVL2(DEPT_CODE,'부서있음','부서없음') FROM EMPLOYEE;


-------------------------------------------------------------------------------
--선택 함수
    --여러 가지 경우에 선택할 수 있는 기능을 제공
    --JAVA의 SWITCH와 비슷함
    --DECODE(조건식 | 컬럼명, 조건값1, 선택값1, 조건값2, 선택값2, ... [, 디폴트])
    --조건식의 결과 값과 일치하는 조건값을 찾아서 바로 뒤의 선택 값을 사용
-------------------------------------------------------------------------------
--DECODE
SELECT DECODE('1','1','1입니다','2','2입니다','그 외입니다')FROM DUAL; --1입니다
SELECT DECODE(2,1,'1입니다',2,'2입니다','그 외입니다')FROM DUAL; --2입니다
SELECT DECODE(3,1,'1입니다',2,'2입니다','그 외입니다')FROM DUAL; --그 외입니다
SELECT EMP_NAME, EMP_ID, DECODE(SUBSTR(EMP_NO, 8,1), '1', '남자', '2', '여자') AS 성별 FROM EMPLOYEE;

/* CASE WHEN 조건식 THEN 결과값
        WHEN 조건식 THEN 결과값
        ELSE 결과 값
        END */
--JOB_CODE가 J7이면 급여 1.1 인상, J6이면 1.15 인상, 그 외에는 1.0 인상
SELECT EMP_NAME, JOB_CODE, SALARY,
    CASE WHEN JOB_CODE = 'J7' THEN SALARY*1.1
        WHEN JOB_CODE = 'J6' THEN SALARY*1.15
        ELSE SALARY*1.0
        END AS 인상급여
        FROM EMPLOYEE;
        

-------------------------------------------------------------------------------
--그룹함수
    --SUM, AVG, MAX, MIN, COUNT
-------------------------------------------------------------------------------
--SUM(숫자가 기록된 컬럼명) : 합계를 구하여 반환
SELECT SUM(SALARY) FROM EMPLOYEE;

--AVG(숫자가 기록된 컬럼명) : 평균을 구해서 반환
SELECT AVG(SALARY) FROM EMPLOYEE;

--MIN(컬럼명) : 컬럼에서 가장 작은 값을 반환
    --취급하면 자료현은 ANY TYPE
SELECT MIN(SALARY) FROM EMPLOYEE;
SELECT MIN(HIRE_DATE) FROM EMPLOYEE;
SELECT MIN(EMAIL) FROM EMPLOYEE;

--MAX(컬럼명) : 컬럼에서 가장 큰 값을 반환
    --취급하면 자료현은 ANY TYPE
SELECT MAX(SALARY) FROM EMPLOYEE;
SELECT MAX(HIRE_DATE) FROM EMPLOYEE;
SELECT MAX(EMAIL) FROM EMPLOYEE;

--COUNT(* | 컬럼 명) : 행의 갯수를 헤아려서 반환
    --COUNT(컬럼 명) : NULL을 제외한 실제 값이 기록된 행 갯수를 반환
    --COUNT(*) : NULL을 포함한 전체 행 갯수를 반환
    --COUNT(DISTINCT 컬럼명) : 중복을 제거한 행 갯수를 반환
SELECT COUNT(*) FROM EMPLOYEE;  --23 : NULL을 포함한 전체 행 갯수
SELECT COUNT(EMP_NAME) FROM EMPLOYEE;   --23 : NULL 제외 행 갯수
SELECT COUNT(BONUS) FROM EMPLOYEE;  --9 : NULL 제외 행 갯수
SELECT COUNT(DEPT_CODE) FROM EMPLOYEE;  --21 : NULL 제외 행 갯수
SELECT COUNT(DISTINCT DEPT_CODE) FROM EMPLOYEE; --6 : 중복제거 행 갯수