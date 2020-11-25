--------------------------------------------------------------------------------
/*
    TCL(Transaction Control Language)
    트랜잭션 제어 언어
    COMMIT, ROLLBACK, SAVEPOINT, ROLLBACK TO
    DDL, DCL에는 적용되지 않음
        사용하게 되면 AUTO COMMIT(자동 완료)가 됨
    
    트랜잭션이란?
        한꺼번에 수행되어야 할 최소의 작업 단위(논리적 작업 단위)
        하나의 트랜잭션으로 이루어진 작업은 반드시 한꺼번에 완료가 되어야 하며,
        그렇지 않은 경우는 한꺼번에 취소되어야 함
        
    COMMIT : 트랜젝션 작업이 정상 완료되면 변경 내용을 영구히 저장
    ROLLBACK : 트랜젝션 작업을 취소하고 최근 COMMIT한 시점으로 이동
    SAVEPOINT 세이브포인트 명 : 현재 트렌젝션 작업 시점에 이름을 정해줌
                           하나의 트랜젝션 안에 구역을 나눔
    ROLLBACK TO 세이브포인트명 : 트랜젝션 작업을 취소하고 SAVEPOINT 시점으로 이동
*/
--------------------------------------------------------------------------------
--현재까지의 모든 작업 완료
    COMMIT;

--테스트 데이블 생성
CREATE TABLE USER_TBL(
    USERNO NUMBER UNIQUE,
    ID VARCHAR2(20) PRIMARY KEY,
    PASSWORD CHAR(20) NOT NULL
);

--KH계정, KUSER 계정에서 조회해보기 (오른쪽 상단에서 KUSER로 변경)
SELECT * FROM USER_TBL;
SELECT * FROM KH.USER_TBL;

--테스트를 위해 KUSER 계정에 KH.USER_TBL 테이블의 조회 권한 부여(KH계정)
GRANT SELECT ON KH.USER_TBL TO KUSER;

--데이터 삽입(KH계정)
INSERT INTO USER_TBL VALUES (1,'TEST1','PASS1');
INSERT INTO USER_TBL VALUES (2,'TEST2','PASS2');
INSERT INTO USER_TBL VALUES (3,'TEST3','PASS3');

--KH계정, KUSER 계정에서 조회해보기
    --KH계정에서는 삽입된 데이터 조회되지만, KUSER 계정에서는 조회 안됨 
        --이유 : 작업이 완료되지 않았기 때문에
SELECT * FROM USER_TBL; --KH계정
SELECT * FROM KH.USER_TBL; --KUSER 계정

--현재까지 작업 완료(KH계정)
COMMIT;

--KH계정, KUSER 계정에서 조회해보기
    --KH계정, KUSER계정 모두 데이터 조회됨
SELECT * FROM USER_TBL; --KH계정
SELECT * FROM KH.USER_TBL; --KUSER 계정

--데이터 삽입(KH계정)
INSERT INTO USER_TBL VALUES (4,'TEST4','PASS4');

--데이터 조회(KH계정) - 4번까지 정상 삽입됨
SELECT * FROM KH.USER_TBL;

--마지막 COMMIT 시점으로 되돌리기
ROLLBACK;

--데이터 조회(KH계정) - 3번까지 입력하고 COMMIT을 했기 때문에 이후 작업은 모두 없어짐
SELECT * FROM KH.USER_TBL;

--데이터 삽입(KH계정)
INSERT INTO USER_TBL VALUES (4,'TEST4','PASS4');

--임시 저장 위치 지정 (SAVEPOINT)
    --SAVEPOINT <SAVEPOINT 명>;
SAVEPOINT SP1;

--데이터 조회(KH계정)
SELECT * FROM KH.USER_TBL;

--데이터 삽입(KH계정)
INSERT INTO USER_TBL VALUES (5,'TEST5','PASS5');
SELECT * FROM KH.USER_TBL;

--임시 저장 위치로 돌아가기(ROLLBACK TO)
    --ROLLBACK TO <SAVEPOINT 명>;
ROLLBACK TO SP1;
SELECT * FROM KH.USER_TBL;

--데이터 삽입(KH계정)
INSERT INTO USER_TBL VALUES (5,'TEST5','PASS5');
SELECT * FROM KH.USER_TBL;

--SP1 임시 저장 위치로 돌아가기(ROLLBACK TO)
    --한 번 돌아간 이후에도 다시 돌아갈 수 있음
ROLLBACK TO SP1;
SELECT * FROM KH.USER_TBL;

--데이터 삽입(KH계정)
INSERT INTO USER_TBL VALUES (5,'TEST5','PASS5');
SELECT * FROM KH.USER_TBL;

--임시 저장 위치 지정
SAVEPOINT SP2;

--데이터 삽입(KH계정)
INSERT INTO USER_TBL VALUES (6,'TEST6','PASS6');
SELECT * FROM KH.USER_TBL;

--SP2로 돌아가기
ROLLBACK TO SP2;
SELECT * FROM KH.USER_TBL;

--데이터 삽입(KH계정)
INSERT INTO USER_TBL VALUES (6,'TEST6','PASS6');
SELECT * FROM KH.USER_TBL;

--SP1로 돌아가기
ROLLBACK TO SP1;
SELECT * FROM KH.USER_TBL;

--SP2로 돌아가기
    --SP1로 돌아가면서 SP2는 없어짐
ROLLBACK TO SP2;    --에러

--처음으로 돌아가기
    --마지막 COMMIT(작업 완료)한 시점으로 돌아가기
ROLLBACK;
SELECT * FROM KH.USER_TBL;