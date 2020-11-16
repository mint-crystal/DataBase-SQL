-- 한줄주석
/* 범위주석 */

--현재 접속 계정 조회
SHOW USER;

--전체 계정 조회
SELECT USERNAME FROM DBA_USERS;

--사용자 계정 생성
CREATE USER KH IDENTIFIED BY KH;

--권한 부여
GRANT CONNECT, RESOURCE TO KH
