--------------------------------------------------------------------------------
/*
    시퀀스(SEQUENCE)
    -- 자동 번호 발생기 역할을 하는 객체
    -- 순차적으로 정수 값을 자동으로 생성해줌
    -- 자동으로 순차적으로 증가하는 순번을 반환하는 데이터베이스 객체
*/
--------------------------------------------------------------------------------

--------------------------------------------------------------------------------
/*
    시퀀스 생성
    CREATE SQUENCE <시퀀스이름>
        [STRAT WITH <숫자>] -- 처음 발생시킬 시작값 지정, 생략하면 자동 1이 기본
        [INCREMENT BY <숫자>] -- 다음 값에 대한 증가치, 생략하면 자동 1이 기본
        [MAXVALUE <숫자> | NOMAXVALUE] -- 발생시킬 최대값 지정 (10의 27승, -1) 
                                (기본값 9999999999999999999999999999)
                               NOMAXVALUE : 디폴트값 설정, 증가일때 1027, 감소일때 -1
                               MAXVALUE : 최대값 설정, 시작숫자와 같거나 커야하고 MINVALUE보다 커야함
        [MINVALUE 숫자 | NOMINVALUE] -- 최소값 지정 (-10의 26승) (기본값 1)
                               NOMINVALUE : 디폴트값 설정, 증가일때 1, 감소일때 -1028 
                               MINVALUE : 최소값 설정, 시작숫자와 같거나 작아야하고 MAXVALUE보다 작아야함
        [CYCLE | NOCYCLE] -- 값 순환 여부 지정(기본값 NOCYCLE)
                            시퀀스가 최대값까지 증가 완료 시 CYCLE은 최소값으로 돌아감
                            NOCYCLE은 에러 발생
        [CACHE <바이트크기> | NOCACHE] -- 메모리 상에서 시퀀스 값 관리(기본값 CACHE 20)
                                    CACHE 설정시 메모리에 시퀀스 값을 미리 할당하고 
                                    NOCACHE 설정시 시퀀스값을 메모리에 할당하지 않음
                                    캐쉬메모리 기본값은 20바이트, 최소값은 2바이트
                                    Cache를 사용하면 시퀀스값의 액세스 효율이 Cache를 사용하지 않았을때보다 증가
*/
--------------------------------------------------------------------------------
--시퀀스 생성
    --300부터 시작해서 5씩 증가하고 최대 310까지 증가하다가 310이 되면 그만 생성하기(캐쉬사용 X)
CREATE SEQUENCE SEQ_EMPID
    START WITH 300
    INCREMENT BY 5
    MAXVALUE 310
    NOCYCLE     --기본값이 NOCYCLE이기 때문에 생략 가능
    NOCACHE;

--시퀀스 조회
SELECT * FROM USER_SEQUENCES;

--시퀀스 생성 시 옵션을 모두 기본값으로 설정
CREATE SEQUENCE SEQ_TEST;
SELECT * FROM USER_SEQUENCES;


--------------------------------------------------------------------------------
/*
    시퀀스 사용
    시퀀스명.CURRVAL : 현재 시퀀스 값 확인
    시퀀스명.NEXTVAL : 시퀀스에서 다음 순번 값 가져오기
*/
--------------------------------------------------------------------------------
--최초 CURRVAL 하기 전에 NEXTVAL이 한 번은 실행이 되야함
    --NEXTVAL을 한번은 해야 시퀀스 번호 생성됨
SELECT SEQ_EMPID.CURRVAL FROM DUAL; --에러
--번호 생성
SELECT SEQ_EMPID.NEXTVAL FROM DUAL; --300
SELECT SEQ_EMPID.CURRVAL FROM DUAL; --300
SELECT * FROM USER_SEQUENCES;
SELECT SEQ_EMPID.NEXTVAL FROM DUAL; --305
SELECT SEQ_EMPID.NEXTVAL FROM DUAL; --310
    --다음 번호는 315가 돼야 하지만 최대값이 310이고 NOCYLCE이기 때문에 오류 발생
SELECT SEQ_EMPID.NEXTVAL FROM DUAL; --에러
SELECT SEQ_EMPID.CURRVAL FROM DUAL;
SELECT * FROM USER_SEQUENCES;


--------------------------------------------------------------------------------
/*
    시퀀스 수정
    ALTER SQUENCE <시퀀스이름>
        [INCREMENT BY 숫자] -- 다음 값에 대한 증가치, 생략하면 자동 1이 기본
        [MAXVALUE 숫자 | NOMAXVALUE] -- 발생시킬 최대값 지정 (10의 27승, -1)
        [MINVALUE 숫자 | NOMINVALUE] -- 최소값 지정 (-10의 26승)
        [CYCLE | NOCYCLE] -- 값 순환 여부 지정
        [CACHE 바이트크기 | NOCACHE] -- 메모리 상에서 시퀀스 값 관리
    START WITH값은 변경 불가능 - 변경하려면 시퀀스 삭제 후 다시 생성해야 함
    최소값(MINVALUE)는 현재 사용중인 시퀀스 번호보다 높게 설정 불가능
    최대값(MAXVALUE)는 현재 사용중인 시퀀스 번호보다 낮게 설정 불가능
*/
--------------------------------------------------------------------------------
--SEQ_EMPID 시퀀스의 증가치를 10으로 변경하고 최대값을 400으로 변경
ALTER SEQUENCE SEQ_EMPID
    INCREMENT BY 10
    MAXVALUE 400;
    
SELECT * FROM USER_SEQUENCES; --LAST_NUMBER가 320으로 변경
SELECT SEQ_EMPID.CURRVAL FROM DUAL; --310
SELECT SEQ_EMPID.NEXTVAL FROM DUAL; --320
SELECT SEQ_EMPID.NEXTVAL FROM DUAL; --330


--------------------------------------------------------------------------------
/*
    시퀀스 삭제
    DROP SEQUENCE <시퀀스 명>;
*/
--------------------------------------------------------------------------------
SELECT * FROM USER_SEQUENCES;
DROP SEQUENCE SEQ_EMPID;
DROP SEQUENCE SEQ_TEST;
SELECT * FROM USER_SEQUENCES;


--------------------------------------------------------------------------------
/*
    시퀀스 활용
    사용 가능
     SELECT문에서 사용 가능
     INSERT문에서 SELECT문에서 사용가능
     INSERT문에서 VALUES절에서 사용 가능
     UPDATE문에서 SET절에서 사용 가능
    
    사용 불가
     VIEW의 SELECT절에서 사용 불가
     DISTINCT 키워드가 있는 SELECT문에서 사용 불가
     GROUP BY, HAVING절이 있는 SELECT문에서 사용 불가
     ORDER BY절에서 사용 불가
     SELECT, DELETE, UPDATE의 서브 쿼리
     CREATE TABLE, ALTER TABLE명령의 DEFAULT값으로 사용 불가
*/
--------------------------------------------------------------------------------
--EMPLOYEE라는 직원 테이블에서 직원을 등록할때 마다 사원번호가 자동으로 생성돼서 저장되도록 설정
CREATE SEQUENCE SEQ_EID
    START WITH 2020001
    -- INCREMENT BY 1   --생략하면 기본값이 1
    MAXVALUE 2020999    --2021년의 사번이 되면 안 되기 때문에
    NOCACHE;
SELECT * FROM USER_SEQUENCES;

DESC EMPLOYEE;
--시퀀스 자동 생성 번호를 넣기 위해 데이터 크기 변경
ALTER TABLE EMPLOYEE MODIFY EMP_ID VARCHAR2(7);

SELECT * FROM EMPLOYEE;
INSERT INTO EMPLOYEE VALUES (SEQ_EID.NEXTVAL, '김길동', '888888-1045678', 'kim_gd@kh.or.kr',
    '01012341234', 'D2', 'J7', 'S1', 5000000, 0.1, 200, SYSDATE, NULL, DEFAULT);
SELECT * FROM EMPLOYEE;


--------------------------------------------------------------------------------
/*
    시퀀스 번호 초기화
    오라클 시퀀스는 번호를 초기화하는 별도의 기능을 제공하지 않음
    (참고)MYSQL : AUTO_INCREMENT
    현재 시퀀스 번호를 조회해서 해당 번호만큼 빼고 다시 번호를 생성해서 사용
*/
--------------------------------------------------------------------------------
SELECT * FROM USER_SEQUENCES;
SELECT SEQ_EID.NEXTVAL FROM DUAL; --2020005
--다음 번호는 2020006이 되는데 2020002번부터 다시 사용하고 싶음
    --1. 현재 시퀀스 번호 조회
SELECT SEQ_EID.CURRVAL FROM DUAL;
    --2. 증가치를 시퀀스 번호가 원하는 값이 되도록 증가/감소 설정
        --주의!! 증감 후의 값이 최소값보다 작거나 최대값보다 크면 안 됨!!
ALTER SEQUENCE SEQ_EID INCREMENT BY -4;
    --3. 변경된 증가치가 사용될 수 있도록 시퀀스 번호 생성
SELECT SEQ_EID.NEXTVAL FROM DUAL; --2020001
    --4. 증가치를 원래대로 수정
ALTER SEQUENCE SEQ_EID INCREMENT BY 1;