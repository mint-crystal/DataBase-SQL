--------------------------------------------------------------------------------
/*
    TRIGGER(트리거)
    트리거의 사전적 의미 : 연쇄 반응
    테이블이나 뷰에서 특정 이벤트에 반응해 자동으로 실행되는 내용을 정의
    이벤트 : INSERT, UPDATE, DELETE
    시점 : BEFORE(이벤트 전), AFTER(이벤트 후)
    
    트리거 정의 방법
        CREATE [OR REPLACE] TRIGGER <트리거명> <시점> <이벤트> ON <테이블명|뷰명>
        [FOR EACH ROW]
        BEGIN
            실행할 내용;
        END;
        /
        
    트리거 유형
        문장 트리거 : FOR EACH ROW를 생략하면 문장 트리거가 됨
            이벤트 한 번 발생 시 실행할 내용이 테이블 혹은 뷰 단위로 한 번만 실행
            EX) 삭제 이벤트가 한 번 발생 시 5개 데이터가 삭제 된 경우 : 트리거 한 번만 실행됨
        행 트리거 : FOR EACH ROW를 정의하면 행 트리거가 됨
            이벤트 한 번 발생 시 실행할 내용이 행 단위로 실행
            EX) 삭제 이벤트가 한 번 발생 시 5개 데이터가 삭제 된 경우 : 트리거 5번 실행됨
*/
--------------------------------------------------------------------------------
--부서 테이블에 부서가 추가되면 '부서가 추가되었습니다.' 메시지 출력
SELECT * FROM DEPARTMENT;
CREATE OR REPLACE TRIGGER TEST_TRG1 AFTER INSERT ON DEPT_COPY
BEGIN
    DBMS_OUTPUT.PUT_LINE('부서가 추가되었습니다');
END;
/
--트리거 목록 확인
SELECT * FROM ALL_TRIGGERS; --모든 트리거 목록 조회
SELECT * FROM USER_TRIGGERS; --해당 사용자의 트리거 목록 조회
SELECT * FROM USER_SOURCE; --트리거 상세 조회
SELECT * FROM USER_SOURCE WHERE NAME='TEST_TRG1';

--트리거 실행
    --트리서는 별도로 실행시키는게 아니라 지정된 이벤트가 발생되면 자동으로 실행
INSERT INTO DEPT_COPY VALUES('D10','인사부','L3');
    --부서 테이블의 DEPT_ID ZMRLRK CHAR(2)라서 입력 안 될 경우
SELECT * FROM DEPT_COPY;
DESC DEPT_COPY;
ALTER TABLE DEPT_COPY MODIFY DEPT_ID CHAR(3);

--부서테이블 내용이 삭제될 때 'DEPT_TITLE가 삭제되었습니다.' 출력
--문장 트리거
CREATE OR REPLACE TRIGGER TEST_TRG2 BEFORE DELETE ON DEPT_COPY
BEGIN
    DBMS_OUTPUT.PUT_LINE('부서가 삭제되었습니다');
END;
/
SELECT * FROM DEPT_COPY;
DELETE FROM DEPT_COPY WHERE LOCATION_ID='L1';
ROLLBACK;

--행 트리거(트리거는 같은 시점, 이벤트, 테이블로 새롭게 생성이 안됨. 때문에 OR REPLACE로 덮어쓰기)
    --OLD 연산자 : 이벤트가 일어나기 전 데이터
    --NEW 연산자 : 이벤트가 일어나 후 데이터
    --INSERT(NEW), UPDATE(OLD,NEW), DELETE(OLD)
CREATE OR REPLACE TRIGGER TEST_TRG2 BEFORE DELETE ON DEPT_COPY
FOR EACH ROW
BEGIN
    DBMS_OUTPUT.PUT_LINE('부서가 삭제되었습니다');
END;
/
SELECT * FROM USER_SOURCE WHERE NAME='TEST_TRG2';
SELECT * FROM DEPT_COPY;
DELETE FROM DEPT_COPY WHERE LOCATION_ID='L1';
ROLLBACK;
    --출력 시 부서명 명시
CREATE OR REPLACE TRIGGER TEST_TRG2 BEFORE DELETE ON DEPT_COPY
FOR EACH ROW
BEGIN
    DBMS_OUTPUT.PUT_LINE(:OLD.DEPT_TITLE||'가 삭제되었습니다');
END;
/
SELECT * FROM USER_SOURCE WHERE NAME='TEST_TRG2';
SELECT * FROM DEPT_COPY;
DELETE FROM DEPT_COPY WHERE LOCATION_ID='L1';
ROLLBACK;
    --데이터 롤백 안 될 경우 테이블 삭제하고 다시 생성하기
DROP TABLE DEPT_COPY;
CREATE TABLE DAPT_COPY AS SELECT * FROM DEPARTMENT;

--트리거 삭제
DROP TRIGGER TEST_TRG1;